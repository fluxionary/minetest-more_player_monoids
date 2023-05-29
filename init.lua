more_player_monoids = fmod.create()

local and_ = function(a, b)
	return a and b
end
local or_ = function(a, b)
	return a or b
end
local add = function(a, b)
	return a + b
end
local mul = function(a, b)
	return a * b
end

local fold = {
	any = function(t)
		return futil.functional.iany(futil.iterators.values(t))
	end,
	all = function(t)
		return futil.functional.iall(futil.iterators.values(t))
	end,
	sum = function(t)
		return futil.math.isum(futil.iterators.values(t))
	end,
	prod = function(t)
		local prod = 1
		for _, v in pairs(t) do
			prod = prod * v
		end
		return prod
	end,
}

local function set_physics_override(key)
	return function(value, player)
		local override = player:get_physics_override()
		override[key] = value
		player:set_physics_override(override)
	end
end

more_player_monoids.sneak = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_physics_override("sneak"),
})

more_player_monoids.sneak_glitch = player_monoids.make_monoid({
	identity = false,
	combine = or_,
	fold = fold.any,
	apply = set_physics_override("sneak_glitch"),
})

more_player_monoids.new_move = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_physics_override("new_move"),
})

-- set_fov(fov, is_multiplier, transition_time)

local function set_hud_flags(key)
	return function(value, player)
		local flags = player:hud_get_flags()
		flags[key] = value
		player:hud_set_flags(flags)
	end
end

more_player_monoids.hud_hotbar = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("hotbar"),
})

more_player_monoids.hud_healthbar = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("healthbar"),
})

more_player_monoids.hud_crosshair = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("crosshair"),
})

more_player_monoids.hud_wielditem = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("wielditem"),
})

more_player_monoids.hud_breathbar = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("breathbar"),
})

more_player_monoids.hud_minimap = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("minimap"),
})

more_player_monoids.hud_minimap_radar = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("minimap_radar"),
})

more_player_monoids.hud_basic_debug = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("basic_debug"),
})

more_player_monoids.hud_chat = player_monoids.make_monoid({
	identity = true,
	combine = and_,
	fold = fold.all,
	apply = set_hud_flags("chat"),
})

--

local function set_lighting(key)
	return function(value, player)
		local lighting = player:get_lighting()
		lighting[key] = value
		player:set_lighting(lighting)
	end
end

more_player_monoids.saturation = player_monoids.make_monoid({
	identity = 1,
	combine = mul,
	fold = fold.prod,
	apply = set_lighting("saturation"),
})

--

more_player_monoids.day_night_ratio = player_monoids.make_monoid({
	identity = nil,
	combine = add,
	fold = fold.sum,
	apply = function(value, player)
		if value then
			value = (math.atan(value) + (math.pi / 2)) / math.pi
			if value == value then
				player:override_day_night_ratio(value)
			else
				player:override_day_night_ratio(nil)
			end
		else
			player:override_day_night_ratio(nil)
		end
	end,
})
