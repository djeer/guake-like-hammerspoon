
-- Configuration table for all dropdown apps
local dropdownApps = {
   {
    name = "Google Chrome",
    hotkey = "F13",
    height = 1,   -- 100% of screen height
    visible = false
  },
  {
    name = "GoLand",
    hotkey = "F14",
    height = 1,  -- 100% of screen height
    visible = false
  },
  {
    name = "Slack",
    hotkey = "F15", 
    height = 1,   -- 100% of screen height
    visible = false
  },
  {
    name = "Notion",
    hotkey = "F16",
    height = 1,   -- 100% of screen height
    visible = false
  },
  {
    name = "Warp",
    hotkey = "F20",
    height = 1,  -- 100% of screen height
    visible = false
  }
}

-- Animation duration (set to 0 for instant, 0.2 for smooth animation)
local animationDuration = 0.2

-- Get screen dimensions
local function getScreen()
  return hs.screen.mainScreen():frame()
end

-- Calculate dropdown frame for given height percentage
local function getDropdownFrame(heightPercent)
  local screen = getScreen()
  return {
    x = screen.x,
    y = screen.y,
    w = screen.w,
    h = screen.h * heightPercent
  }
end

-- Create hotkey binding for each app
for _, appConfig in ipairs(dropdownApps) do
  hs.hotkey.bind({}, appConfig.hotkey, function()
    local app = hs.application.get(appConfig.name)
    
    if not app then
      -- Launch app if not running
      hs.application.launchOrFocus(appConfig.name)
      
      -- Wait for app to launch then position it
      hs.timer.doAfter(0.5, function()
        app = hs.application.get(appConfig.name)
        if app then
          local win = app:mainWindow()
          if win then
            local frame = getDropdownFrame(appConfig.height)
            if animationDuration > 0 then
              win:setFrame(frame, animationDuration)
            else
              win:setFrame(frame)
            end
            appConfig.visible = true
          end
        end
      end)
    else
      -- Check if this app is currently the focused app
      local focusedApp = hs.application.frontmostApplication()
      
      if focusedApp and focusedApp:name() == appConfig.name then
        -- App is in foreground, hide it
        app:hide()
        appConfig.visible = false
      else
        -- App is in background, hidden, or minimized - bring to foreground
        local win = app:mainWindow()
        
        -- If no main window or window is minimized, try to get any window
        if not win or win:isMinimized() then
          local windows = app:allWindows()
          if #windows > 0 then
            win = windows[1]
          end
        end
        
        if win then
          -- Unminimize if needed
          if win:isMinimized() then
            win:unminimize()
          end
          
          -- Set frame and bring to front
          local frame = getDropdownFrame(appConfig.height)
          if animationDuration > 0 then
            win:setFrame(frame, animationDuration)
          else
            win:setFrame(frame)
          end
          app:activate()
          win:focus()
          appConfig.visible = true
        else
          -- No windows available, try to activate the app to create one
          app:activate()
        end
      end
    end
  end)
end

-- Show notification that config is loaded
hs.notify.new({
  title = "Hammerspoon",
  informativeText = "Dropdown hotkeys configured:\nF14→GoLand, F15→Slack, F16→Chrome, F20→Warp"
}):send()
