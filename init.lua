-- Mod: Trap Plus
-- Created by ynong123

trapplus = {}

function trapplus.register_trap(name, source, def)
	minetest.register_node(name, {
		description = def.description,
		tiles = def.tiles,
		groups = def.groups,
		is_ground_content = false,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name())
			minetest.show_formspec(placer:get_player_name(), "trapplus:setup_formspec",
				"size[8,4]" ..
				"label[0,0;What do you want this trap block to do?]" ..
				"button_exit[0.5,1;2.5,1;btn_sudden_death;Sudden Death]" ..
				"button_exit[0.5,2;2.5,1;btn_empty_inventory;Empty Inventory]" ..
				"button_exit[0.5,3;3,1;btn_drop_from_sky;Drop Player From Sky]"
			)
			minetest.register_on_player_receive_fields(
				function(player, formname, fields)
					if not formname == "trapplus:setup_formspec" then return end
					if fields.btn_sudden_death then
						meta:set_string("function", "sudden_death")
					elseif fields.btn_empty_inventory then
						meta:set_string("function", "empty_inventory")
					elseif fields.btn_drop_from_sky then
						meta:set_string("function", "drop_from_sky")
					end
					minetest.register_globalstep(
						function(dtime)
							if meta:get_string("owner") == "" then return end
							for _, victim in ipairs(minetest.get_connected_players()) do
								local victim_pos = victim:getpos()
								if victim_pos.x >= pos.x - 0.5 and victim_pos.z >= pos.z - 0.5
									and victim_pos.x <= pos.x + 0.5 and victim_pos.z <= pos.z + 0.5
									and victim_pos.y == pos.y + 0.5 then
									if meta:get_string("function") == "sudden_death" then
										victim:set_hp(0)
										minetest.chat_send_player(victim:get_player_name(), "You have been killed for standing on a trap!")
										victim:setpos({x = math.random(pos.x + 1, pos.x + 6), y = math.random(pos.y + 1, pos.y + 3), z = math.random(pos.z + 1, pos.z + 6)})
									elseif meta:get_string("function") == "empty_inventory" then
										local inv = victim:get_inventory()
										for _, item in ipairs(inv:get_list("main")) do
											if item then
												inv:remove_item("main", item)
											end
										end
										minetest.chat_send_player(victim:get_player_name(), "Your inventory has been cleared because you stepped on a trap!")
										victim:setpos({x = math.random(pos.x + 1, pos.x + 6), y = math.random(pos.y + 1, pos.y + 3), z = math.random(pos.z + 1, pos.z + 6)})
									elseif meta:get_string("function") == "drop_from_sky" then
										victim:setpos({x = victim_pos.x, y = victim_pos.y + 200, z = victim_pos.z})
										minetest.chat_send_player(victim:get_player_name(), "You will fall from the sky because you stepped on a trap!")
									end
								end
							end
						end
					)
				end
			)
		end,
		on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			if player:get_player_name() == meta:get_string("owner") then
				minetest.show_formspec(player:get_player_name(), "trapplus:setup_formspec",
					"size[8,4]" ..
					"label[0,0;What do you want this trap block to do?]" ..
					"button_exit[0.5,1;2.5,1;btn_sudden_death;Sudden Death]" ..
					"button_exit[0.5,2;2.5,1;btn_empty_inventory;Empty Inventory]" ..
					"button_exit[0.5,3;3,1;btn_drop_from_sky;Drop Player From Sky]"
				)
				minetest.register_on_player_receive_fields(
					function(player, formname, fields)
						if not formname == "trapplus:setup_formspec" then return end
						if fields.btn_sudden_death then
							meta:set_string("function", "sudden_death")
						elseif fields.btn_empty_inventory then
							meta:set_string("function", "empty_inventory")
						elseif fields.btn_drop_from_sky then
							meta:set_string("function", "drop_from_sky")
						end
					end
				)
			end
		end,
		after_destruct = function(pos, oldnode)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", "")
		end
	})
	minetest.register_craft({
		output = name,
		recipe = {
			{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
			{"default:mese_crystal_fragment", source, "default:mese_crystal_fragment"},
			{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"}
		}
	})
end

dofile(minetest.get_modpath("trapplus") .. "/register.lua")