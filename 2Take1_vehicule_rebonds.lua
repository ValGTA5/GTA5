local vehicle_rebonds = menu.add_feature("Vehicle Rebonds", "parent", 0)
local rebonds_vitesse_condition = menu.add_feature("Paramètre: Condition Vitesse : ", "action_value_f", vehicle_rebonds.id)
local rebonds_hauteur_multiplier = menu.add_feature("Paramètre: Hauteur Multiplier : ", "action_value_f", vehicle_rebonds.id)
rebonds_hauteur_multiplier.min = 0.0
rebonds_hauteur_multiplier.max = 100000.0
rebonds_hauteur_multiplier.mod = 1.0
rebonds_hauteur_multiplier.value = 0.0
rebonds_vitesse_condition.min = 0.0
rebonds_vitesse_condition.max = 100000.0
rebonds_vitesse_condition.mod = 1.0
rebonds_vitesse_condition.value = 0.0
menu.add_feature("Rebonds sur l'eau", "toggle", vehicle_rebonds.id, function(option_rebonds)
    while option_rebonds.on do
        local player_vehicle = player.player_vehicle()
		if player_vehicle then 
            if entity.is_entity_in_water(player_vehicle) then
                local velocite = entity.get_entity_velocity(player_vehicle)
                if velocite.z < 0.0 then
                    velocite.z = -velocite.z
                end
                if velocite.z > rebonds_vitesse_condition.value then
                    velocite.z = velocite.z + rebonds_hauteur_multiplier.value
			        entity.set_entity_velocity(player_vehicle, velocite)
                end
            end
        end
        system.yield()
    end
end)