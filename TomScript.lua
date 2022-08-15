util.require_natives(1651208000)
util.require_no_lag('natives-1640181023')
slaxdom = require("lib/slaxdom")
slaxml = require("lib/slaxml")
handle_ptr = memory.alloc(13*8)

local response = false
local localVer = 0.2
async_http.init("raw.githubusercontent.com", "/TommyCocchi/TomScript/main/Version", function(output)
    currentVer = tonumber(output)
    response = true
    if localVer ~= currentVer then
        util.toast("A new TomScript release is available, update it now to access the newest features.")
        menu.action(menu.my_root(), "Update Lua", {}, "", function()
            async_http.init('raw.githubusercontent.com','/TommyCocchi/TomScript/main/TomScript.lua',function(a)
                local err = select(2,load(a))
                if err then
                    util.toast("Script failed to download. Please try again later. If this continues to happen then manually update via github.")
                return end
                local f = io.open(filesystem.scripts_dir()..SCRIPT_RELPATH, "wb")
                f:write(a)
                f:close()
                util.toast("Successfully updated TomScript, please reload the script.")
                util.stop_script()
            end)
            async_http.dispatch()
        end)
    end
end, function() response = true end)
async_http.dispatch()
repeat 
    util.yield()
until response

local response2 = false
local localGTA = 1.61
async_http.init("raw.githubusercontent.com", "/TommyCocchi/TomScript/main/GTAVersion", function(output)
    currentVer = tonumber(output)
    response = true
    if localVer ~= currentVer then
        util.toast("A new TomScript release is available, update it now to access the newest features.")
        menu.action(menu.my_root(), "Update Lua", {}, "", function()
            async_http.init('raw.githubusercontent.com','/TommyCocchi/TomScript/main/TomScript.lua',function(a)
                local err = select(2,load(a))
                if err then
                    util.toast("Script failed to download. Please try again later. If this continues to happen then manually update via github.")
                return end
                local f = io.open(filesystem.scripts_dir()..SCRIPT_RELPATH, "wb")
                f:write(a)
                f:close()
                util.toast("Successfully updated TomScript, please reload the script.")
                util.stop_script()
            end)
            async_http.dispatch()
        end)
    end
end, function() response = true end)
async_http.dispatch()
repeat 
    util.yield()
until response2




util.keep_running()


 colors = {
    green = 184,
    red = 6,
    yellow = 190,
    black = 2,
    white = 1,
    gray = 3,
    pink = 201,
    purple = 49,
    blue = 11
    }


coded_for = 1.61
online_version = tonumber(NETWORK._GET_ONLINE_VERSION())

if online_version > coded_for then
    util.toast("TomScript is outdated for this version of GTA Online. This version of the script was originally coded for ".. coded_for .." (Current version is ".. online_version ..")")
    else
        util.toast("TomScript is up to date! (Current version: ".. online_version ..", this script was coded for: ".. coded_for ..") ")

    
end


function show_custom_alert_until_enter(l1)
    poptime = os.time()
    while true do
        if PAD.IS_CONTROL_JUST_RELEASED(18, 18) then
            if os.time() - poptime > 0.1 then
                break
            end
        end
        native_invoker.begin_call()
        native_invoker.push_arg_string("ALERT")
        native_invoker.push_arg_string("JL_INVITE_ND")
        native_invoker.push_arg_int(2)
        native_invoker.push_arg_string("")
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(-1)
        native_invoker.push_arg_int(-1)
        -- line here
        native_invoker.push_arg_string(l1)
        -- optional second line here
        native_invoker.push_arg_int(0)
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(0)
        native_invoker.end_call("701919482C74B5AB")
        util.yield()
    end
end

local playerped = PLAYER.GET_PLAYER_PED(players.user())
menu_root = menu.my_root
self_root = menu.list(menu.my_root(), "Self", {}, "Options for you and your pedestrian.")
weapons_root = menu.list(menu.my_root(), "Weapons", {}, "Weapon options.")
fun_root = menu.list(menu.my_root(), "Fun", {}, "Fun options.")
game_root = menu.list(menu.my_root(), "Game", {}, "Game options.")
online_root = menu.list(menu.my_root(), "Online", {}, "Online options.")
alerts_root = menu.list(fun_root, "Fake Alerts", {}, "Custom and fake alerts." )


local coords_ptr = v3.new()
util.on_stop(function()
	memory.free(coords_ptr)
end)


menu.toggle_loop(weapons_root, "Explosive Hits", {}, "Exploding projectiles on impact.", function(on_tick)
	local player_ped = PLAYER.PLAYER_PED_ID()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(player_ped, coords_ptr) then
		local x, y, z = v3.get(coords_ptr)
		FIRE.ADD_OWNED_EXPLOSION(player_ped, x, y, z, explosion_type, 1, true, false, 0)
	end
	return true
end)


menu.toggle_loop(weapons_root, "Teleport Gun", {}, "Teleports you to the bullet's landing point.", function(on_tick)
	local player_ped = PLAYER.PLAYER_PED_ID()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(player_ped, coords_ptr) then
		local x, y, z = v3.get(coords_ptr)
		ENTITY.SET_ENTITY_COORDS(player_ped, x, y, z, 1, false, false, false)
        util.yield(500)
	end
	return true
end)

menu.toggle_loop(weapons_root, "Infinite Pistol Ammo", {}, "Infinite ammo on pistol.", function(on_tick)
	local player_ped = PLAYER.PLAYER_PED_ID()
	WEAPON.SET_PED_AMMO(player_ped, 0x1B06D571, 9999, b)
end)

local explosion_type const = 2

menu.toggle_loop(online_root, "1x Toilet Money", {}, "Spawns 1 toilet which gives money.", function(on_tick)
    local modelhash = 289396019
    request_model_load(modelhash)
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player, 0,0,10)
    c.x = c["x"]
    c.z = c["z"]
    c.y = c["y"]
    OBJECT.CREATE_MONEY_PICKUPS(c.x, c.y, c.z, 2000, 1, 0)
    util.toast("dropped money!")
    util.log("dropped money!")
    util.yield(1500)
end)

menu.toggle(self_root, "Godmode", {"godmod"},"shitty ah godmode", function() 

end)

menu.action(online_root, "TP to warehouse", {}, "Teleports to my warehouse", function() 
    util.toast("Teleporting to warehouse in 3 seconds!")
    HUD.SET_NEW_WAYPOINT(-245, 203)
    util.yield(3000)
    util.toast("Teleporting to warehouse!")
    ENTITY.SET_ENTITY_COORDS(playerped, -245, 203, 84, 1, false, false, false)
end)

menu.action(online_root, "TP to warehouse 2", {}, "Teleports to my warehouse", function() 
    util.toast("Teleporting to warehouse in 3 seconds!")
    HUD.SET_NEW_WAYPOINT(-245, 203)
    util.yield(3000)
    util.toast("Teleporting to warehouse!")
    ENTITY.SET_ENTITY_COORDS(playerped, 994, -3089, -39, 1, false, false, false)
end)


function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end



menu.action(alerts_root, "Custom Alert 1", {}, "Custom Alert 1", function()
    util.toast("Type what you want the alert to say.")
    menu.show_command_box("customalert ")
end, function(on_command)
    show_custom_alert_until_enter(on_command)
end)


local customalerttext = ""

function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end


function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function spawn_fat_guard()

    local modelhash = -1244692252
    request_model_load(modelhash)
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player, 0,5,0)
    coords.x = coords["x"]
    coords.y = coords["y"]
    coords.z = coords["z"]
    local guard = PED.CREATE_PED(28, modelhash, coords.x, coords.y, coords.z, 1, true, true)
    local group = PED.GET_PED_GROUP_INDEX(player)
    PED.SET_PED_AS_GROUP_MEMBER(guard, group)
    ENTITY.SET_ENTITY_INVINCIBLE(guard, true)
    TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(guard, 1000, 0)
    PED.SET_PED_FLEE_ATTRIBUTES(guard, 0, false)
    PED.SET_PED_COMBAT_ABILITY(guard, 46, true)
    WEAPON.GIVE_WEAPON_TO_PED(guard, 1119849093, 9999, false, true)
    WEAPON.SET_PED_AMMO(guard, 1119849093, 9999, true)
    PED.SET_PED_ACCURACY(guard, 100)
    local getinvehicle = PED.GET_VEHICLE_PED_IS_IN(player, true)
    if getinvehicle ~= 0 then
        if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(getinvehicle) then
            for i=0, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(getinvehicle) do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(getinvehicle, i) then
                    PED.SET_PED_INTO_VEHICLE(guard, getinvehicle, i)
                    break
                end
            end
        end
    end
end

function spawn_custom_guard()

    local modelhash = customguardhash
    request_model_load(customguardhash)
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player, 0,5,0)
    coords.x = coords["x"]
    coords.y = coords["y"]
    coords.z = coords["z"]
    local guard = PED.CREATE_PED(28, modelhash, coords.x, coords.y, coords.z, 1, true, true)
    local group = PED.GET_PED_GROUP_INDEX(player)
    PED.SET_PED_AS_GROUP_MEMBER(guard, group)
    ENTITY.SET_ENTITY_INVINCIBLE(guard, true)
    TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(guard, 1000, 0)
    PED.SET_PED_FLEE_ATTRIBUTES(guard, 0, false)
    PED.SET_PED_COMBAT_ABILITY(guard, 46, true)
    WEAPON.GIVE_WEAPON_TO_PED(guard, 1119849093, 9999, false, true)
    WEAPON.SET_PED_AMMO(guard, 1119849093, 9999, true)
    PED.SET_PED_ACCURACY(guard, 100)
    local getinvehicle = PED.GET_VEHICLE_PED_IS_IN(player, true)
    if getinvehicle ~= 0 then
        if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(getinvehicle) then
            for i=0, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(getinvehicle) do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(getinvehicle, i) then
                    PED.SET_PED_INTO_VEHICLE(guard, getinvehicle, i)
                    break
                end
            end
        end
    end
end

customguardhash = ""

menu.action(weapons_root, "Spawn Fat Guard", {}, "spawns a custom guard to defend u", function()
    spawn_fat_guard()
    
end)

menu.action(weapons_root, "Spawn Custom Guard", {}, "spawns a custom guard to defend u", function()
    spawn_custom_guard()
    
end)

menu.text_input(weapons_root, "Custom Guard Hash", {"guardhash"}, "Hash for custom guard", function(input)
    customguardhash = input
end)

menu.action(weapons_root, "Give all weapons!", {}, "Gives all weapons with max ammo", function ()

    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1834847097, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1834847097, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1786099057, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1786099057, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -102323637, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -102323637, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 2067956739, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 2067956739, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1951375401, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1951375401, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 1141786504, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 1141786504, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 1317494643, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 1317494643, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -102973651, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -102973651, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -656458692, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -656458692, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1716189206, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1716189206, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -581044007, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -581044007, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -538741184, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -538741184, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 1737195953, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 1737195953, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 419712736, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 419712736, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -853065399, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -853065399, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1810795771, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1810795771, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 940833800, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 940833800, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 453432689, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 453432689, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1075685676, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1075685676, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 1593441988, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 1593441988, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 584646201, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 584646201, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 911657153, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 911657153, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1716589765, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1716589765, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1076751822, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1076751822, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -2009644972, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -2009644972, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -771403250, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -771403250, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 137902532, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 137902532, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 1198879012, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 1198879012, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -598887786, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -598887786, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1045183535, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1045183535, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -879347409, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -879347409, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1746263880, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1746263880, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1355376991, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1355376991, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 727643628, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 727643628, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -1853920116, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -1853920116, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 324215364, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 324215364, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 736523883, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 736523883, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 2024373456, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 2024373456, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -270015777, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -270015777, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, 171789620, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, 171789620, 9999, b)
    WEAPON.GIVE_WEAPON_TO_PED(playerped, -619010992, 1, false, false)
    WEAPON.SET_PED_AMMO(playerped, -619010992, 9999, b)
end)

util.get_weapons(weaponlist)

menu.text_input(alerts_root, "Custom Alert 2 Text", {"alerttxt"}, "", function(input)
    customalerttext = input
end)

menu.action(alerts_root, "Custom Alert 2 ", {}, "Custom Alert", function()
    show_custom_alert_until_enter(customalerttext)
end)

menu.action(alerts_root, "Fake Ban 1", {"fakeban"}, "Shows a fake ban message.", function(on_click)
    show_custom_alert_until_enter("You have been banned from Grand Theft Auto Online.~n~Return to Grand Theft Auto V.")
end)

menu.action(alerts_root, "Fake Ban 2", {"fakeban"}, "Shows a fake ban message.", function(on_click)
    show_custom_alert_until_enter("You have been banned from Grand Theft Auto Online permanently.~n~Return to Grand Theft Auto V.")
end)





