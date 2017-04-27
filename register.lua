-- register.lua

trapplus.register_trap("trapplus:dirt", "default:dirt", {
	description = "Dirt (Trap)",
	tiles = {"trapplus_dirt.png"},
	groups = {crumbly = 3, soil = 1}
})

trapplus.register_trap("trapplus:cobble", "default:cobble", {
	description = "Cobblestone (Trap)",
	tiles = {"trapplus_cobble.png"},
	groups = {cracky = 3, stone = 2}
})

trapplus.register_trap("trapplus:desert_cobble", "default:desert_cobble", {
	description = "Desert Cobblestone (Trap)",
	tiles = {"trapplus_desert_cobble.png"},
	groups = {cracky = 3, stone = 2}
})

trapplus.register_trap("trapplus:sand", "default:sand", {
	description = "Sand (Trap)",
	tiles = {"trapplus_sand.png"},
	groups = {crumbly = 1, falling_node = 1, sand = 1}
})

trapplus.register_trap("trapplus:desert_sand", "default:desert_sand", {
	description = "Desert Sand (Trap)",
	tiles = {"trapplus_desert_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1}
})