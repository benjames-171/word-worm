local M = {}

M.STATE_SPLASH = 1
M.STATE_MENU = 2
M.STATE_CONTROLS = 3
M.STATE_CREDITS = 4
M.STATE_BESTWORDS = 5
M.STATE_HISCORES = 6
M.STATE_GETREADY = 7
M.STATE_PLAYING = 8
M.STATE_LEVELCLEAR = 9
M.STATE_GAMEOVER = 10

M.state = M.STATE_SPLASH

M.TILE_SIZE = 80
M.PIXEL_SIZE = 1

M.level = 1
M.maxlevel = 1

M.bestword = ""
M.score = 0

M.scrollpos = vmath.vector3(0,0,0)
M.actualpos = vmath.vector3(0,0,0)

M.bestwords = {}
M.hiscores = {}

M.APP_NAME = "wordworm"
M.SAVE_FILE_NAME = "savefile"
M.SETTINGS_FILE_NAME = "settings"

function M.loadgamefile()
	local file = sys.load(sys.get_save_file(M.APP_NAME, M.SAVE_FILE_NAME))
	M.bestwords[1] = file.bw1
	M.bestwords[2] = file.bw2
	M.bestwords[3] = file.bw3
	M.bestwords[4] = file.bw4
	M.bestwords[5] = file.bw5
	M.bestwords[6] = file.bw6
	M.bestwords[7] = file.bw7
	M.bestwords[8] = file.bw8
	M.bestwords[9] = file.bw9
	M.bestwords[10] = file.bw10

	M.hiscores[1] = file.hs1
	M.hiscores[2] = file.hs2
	M.hiscores[3] = file.hs3
	M.hiscores[4] = file.hs4
	M.hiscores[5] = file.hs5
	M.hiscores[6] = file.hs6
	M.hiscores[7] = file.hs7
	M.hiscores[8] = file.hs8
	M.hiscores[9] = file.hs9
	M.hiscores[10] = file.hs10
	
	for n = 1, 11 do
		if M.bestwords[n] == nil then M.bestwords[n] = "-" end
		if M.hiscores[n] == nil then M.hiscores[n] = 0 end
	end
end

function M.savegamefile()
	local file = {
		bw1 = M.bestwords[1],
		bw2 = M.bestwords[2],
		bw3 = M.bestwords[3],
		bw4 = M.bestwords[4],
		bw5 = M.bestwords[5],
		bw6 = M.bestwords[6],
		bw7 = M.bestwords[7],
		bw8 = M.bestwords[8],
		bw9 = M.bestwords[9],
		bw10 = M.bestwords[10],

		hs1 = M.hiscores[1],
		hs2 = M.hiscores[2],
		hs3 = M.hiscores[3],
		hs4 = M.hiscores[4],
		hs5 = M.hiscores[5],
		hs6 = M.hiscores[6],
		hs7 = M.hiscores[7],
		hs8 = M.hiscores[8],
		hs9 = M.hiscores[9],
		hs10 = M.hiscores[10],
	}

	sys.save(sys.get_save_file(M.APP_NAME, M.SAVE_FILE_NAME), file)
end

function M.getwordvalue(str)
	local v = string.len(str) - 3

	r = 10
	while v > 0 do
		r = r * 1.5
		v = v - 1
	end
	r = r - (r%5)
	
	return r
end

function M.world2tile(p)
	return vmath.vector3(math.floor((p.x + M.TILE_SIZE) / M.TILE_SIZE), math.floor((p.y + M.TILE_SIZE) / M.TILE_SIZE), p.z)
end

function M.tile2world(p)
	return vmath.vector3((p.x * M.TILE_SIZE) - (M.TILE_SIZE / 2), (p.y * M.TILE_SIZE) - (M.TILE_SIZE / 2), p.z)
end

function M.onscreen(p, m)
	if p.x > M.scrollpos.x - m and
	p.x < M.scrollpos.x + m + M.offset.x * 2 and
	p.y > M.scrollpos.y - m and
	p.y < M.scrollpos.y + m + M.offset.y * 2 then
		return true
	else
		return false
	end
end

return M