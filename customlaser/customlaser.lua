--[[
The Lua code below will allow customization of the player character's laser colors.

This code requires IPHLPAPI.dll and PAYDAY2BLT.

Author: makiftasova

This code is based on GoonMod's "WeaponLaser.lua" script
]]--

CloneClass( WeaponLaser )

local green = Color.green
local red = Color.red
local blue = Color.blue
local white = Color.white
local violet = Color('EE82EE')      -- Violet
local ablue = Color('f0f8ff')       -- Alice Blue
local aquam = Color('7fffd4')       -- Aquamarine
local bisque = Color('ffe4c4')      -- Bisque
local cyan = Color('00ffff')        -- Cyan
local goldr = Color('ffb90f')       -- Goldenrod
local dgreen = Color('006400')      -- Darkgreen
local gold = Color('ffd700')        -- Gold
local gray = Color('bebebe')        -- Gray
local lgreen = Color('32cd32')      -- Lime Green
local orange = Color('ffa500')      -- Orange
local orchid = Color('da70d6')      -- Orchid
local yellow = Color('ffff00')      -- Yellow

local PLAYER_LASER_COLOR = blue -- Your laser color
local LASER_ALPHA = 0.40

local PLAYER_LASER = {  
                        glow = PLAYER_LASER_COLOR / 5,
                        brush = PLAYER_LASER_COLOR:with_alpha(LASER_ALPHA),
                        light = PLAYER_LASER_COLOR * 10
                    }

Hooks:RegisterHook("WeaponLaserInit")
function WeaponLaser.init(self, unit)
    self.orig.init(self, unit)
    self._themes["custom_player_laser"] = PLAYER_LASER
    Hooks:Call("WeaponLaserInit", self, unit)
end

Hooks:RegisterHook("WeaponLaserUpdate")
function WeaponLaser.update(self, unit, t, dt)
    self.orig.update(self, unit, t, dt)
    if not self._is_npc then
        self:set_color_by_theme("custom_player_laser")
    end
    Hooks:Call("WeaponLaserUpdate", self, unit, t, dt)
end

Hooks:RegisterHook("WeaponLaserSetNPC")
function WeaponLaser.set_npc(self)
    self.orig.set_npc(self)
    Hooks:Call("WeaponLaserSetNPC", self)
end

Hooks:RegisterHook("WeaponLaserPostSetColorByTheme")
function WeaponLaser.set_color_by_theme(self, theme)
    self.orig.set_color_by_theme(self, theme)
    Hooks:Call("WeaponLaserPostSetColorByTheme", self, theme)
end

Hooks:RegisterHook("WeaponLaserSetOn")
Hooks:RegisterHook("WeaponLaserSetOff")
function WeaponLaser._check_state(self)
    self.orig._check_state(self)
    if self._on then
        Hooks:Call("WeaponLaserSetOn", self)
    else
        Hooks:Call("WeaponLaserSetOff", self)
    end
end
