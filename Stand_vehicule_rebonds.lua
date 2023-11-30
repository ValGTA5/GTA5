require("natives-1676318796")
local vehicle_rebonds = menu.list(menu.my_root(), "Vehicle Rebonds", {}, "")
local rebonds_vitesse_condition = 0
local rebonds_hauteur_multiplier = 0
menu.click_slider_float(vehicle_rebonds, "Paramètre: Condition Vitesse : ", {}, "", 0, 10000, 0, 100, function(value)
	rebonds_vitesse_condition = value / 100
end)
menu.slider_float(vehicle_rebonds, "Paramètre: Hauteur Multiplier : ", {}, "", -10000, 10000, 0, 100, function(value)
	rebonds_hauteur_multiplier = value / 100
end)
menu.toggle_loop(vehicle_rebonds, "Rebonds sur l'eau", {}, "", function(on_tick)	
	local player_vehicle = entities.get_user_vehicle_as_handle()
	if ENTITY.IS_AN_ENTITY(player_vehicle) then 
        if ENTITY.IS_ENTITY_IN_WATER(player_vehicle) then
            local velocite = ENTITY.GET_ENTITY_VELOCITY(player_vehicle)
            if velocite.z < 0.0 then
                velocite.z = -velocite.z
            end
            if velocite.z > rebonds_vitesse_condition then
				velocite.z = velocite.z + rebonds_hauteur_multiplier
		        ENTITY.SET_ENTITY_VELOCITY(player_vehicle, velocite.x, velocite.y, velocite.z)
            end
        end
    end
	util.yield()
end)