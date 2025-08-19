# Hammerspoon Multi-App Dropdown Configuration

A macOS configuration that transforms rarely-used media keys into instant app launchers, inspired by the Guake terminal and Quake 3's console dropdown.

<img width="578" height="146" alt="image" src="https://github.com/user-attachments/assets/2218eb3e-0120-4c92-ae4f-3f42a5bac730" />

## Overview

This setup allows you to:
- Repurpose media keys (Exposé, Spotlight, Voice Control, Sleep) for launching your favorite apps
- Open apps instantly in full window mode with a single keypress
- Switch seamlessly between full-screen apps

## Prerequisites

You'll need two applications:
1. **Karabiner-Elements** - Remaps your keyboard keys
2. **Hammerspoon** - Handles app launching and window management

## Installation & Setup

### Step 1: Configure Karabiner-Elements

First, remap your media keys to function keys that macOS doesn't typically use (F13-F20).

#### Function Keys Settings
Map the following media keys to higher function keys:
- `F3` (Mission Control) → `F13`
- `F4` (Launchpad) → `F14`
- `F5` (Keyboard Brightness Down) → `F15`
- `F6` (Keyboard Brightness Up) → `F16`

<img width="1212" height="844" alt="image" src="https://github.com/user-attachments/assets/f38afc3f-e60d-4688-b9a1-83ed02cef16a" />

*Note: You can still access the original F3-F6 functions by holding the Fn key as usual.*

#### Additional Modifications (ISO Keyboards)
If you have an ISO keyboard with the paragraph sign key (§):
- `non_us_backslash` → `F20`
<img width="1212" height="844" alt="image" src="https://github.com/user-attachments/assets/af84c981-06e7-4d5e-9e3c-8ae49c6b0854" />

This remaps the rarely-used paragraph sign key to quickly open your terminal.

### Step 2: Configure Hammerspoon

After setting up Karabiner-Elements:
1. Install Hammerspoon
2. Add `init.lua` contents to `~/.hammerspoon/init.lua` to map your newly created F-keys to specific applications by name
3. Customize which apps launch with which keys

## How It Works

When you press one of your configured keys:
- **Windowed apps**: Open at 100% height and width
- **Full-screen apps**: Your Mac switches directly to that app's screen

This creates a seamless, instant-access workflow for your most-used applications.
Avoid frustration when trying to alt-tab in the app that you need.
