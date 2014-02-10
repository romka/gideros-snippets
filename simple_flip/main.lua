local width = 300
local height = 300

local texture = Texture.new("grid.png", true, {wrap = Texture.REPEAT})
local texture2 = Texture.new("grid2.png", true, {wrap = Texture.REPEAT})

--[[
local mesh = Mesh.new() 
mesh:setVertices(1, 0, 20, 2, width, 50, 3, width, height - 50, 4, 0, height - 20) 
mesh:setIndexArray(1, 2, 3, 1, 3, 4) 

mesh:setTexture(texture)
mesh:setTextureCoordinates(1, 0, 20, 2, width, 50, 3, width, height - 50, 4, 0, height - 20)

--mesh:setColorArray(0x0A2751, 1.0, 0x0A2751, 1.0, 0x2664BB, 1, 0x2664BB, 1) 

stage:addChild(mesh)
--]]

----------------------

local bitmap = Bitmap.new(texture)
local bitmap2 = Bitmap.new(texture2)
local sprite = Sprite.new()

sprite:addChild(bitmap)
stage:addChild(sprite)

sprite:setPosition(0, 350)

local default_width = 300
local default_height = 300

--[[
local step_y_to_x = 0.01
local x_to_y = -0.01
local step_x = 0.01
local step_y = -0.01
--]]

local step_y_to_x = 0.01
local step_x_to_y = 0.01
local step_x = -0.01
local step_y = -0.01


local y_to_x = 0
local x_to_y = 0
local x = 1
local y = 1


function onEnterFrame()
	--[[ 
		default transformation matrix:
			1 0 0
			0 1 350 (move sprite down on 350 pixels)
			0 0 1
	--]]
	local matrix = Matrix.new(x, y_to_x, x_to_y, y, 0, 350)
		
	y_to_x = y_to_x + step_y_to_x
	x_to_y = x_to_y + step_x_to_y
	--x = x + step_x
	--y = y + step_y
	x = 1 - y_to_x
	y = 1 - x_to_y
	
	if y_to_x > 1 or y_to_x < 0 then
		step_y_to_x = -step_y_to_x
	end

	if x_to_y > 1 or x_to_y < 0 then
		step_x_to_y = -step_x_to_y
	end

	if x > 1 or x < 0 then
		step_x = -step_x
	end

	if y > 1 or y < 0 then
		step_y = -step_y
		--print('x', sprite:getX(), 'y', sprite:getY(), 'width', sprite:getWidth(), 'height', sprite:getHeight())
		--sprite:setScaleX(1)
		--sprite:setScaleY(1)
		--sprite:setHeight(default_height)
	end
	
	--print("y_to_x", y_to_x)
	if math.floor(y_to_x * 1000) / 1000 == 0.5 then
		--print("a", y_to_x)
		if sprite:contains(bitmap) then
			--print('replace 1')
			sprite:removeChild(bitmap)
			sprite:addChild(bitmap2)
		else
			--print('replace 2')
			sprite:removeChild(bitmap2)
			sprite:addChild(bitmap)
		end
	end

	sprite:setMatrix(matrix)
	--print('width', sprite:getWidth(), 'height', sprite:getHeight())
	--print("y_to_x", y_to_x, "x_to_y", x_to_y, "x", x, "y", y)
	--print()
end

function onClick()
	if stage:hasEventListener(Event.ENTER_FRAME, onEnterFrame) then
		stage:removeEventListener(Event.ENTER_FRAME, onEnterFrame)
		print("y_to_x", y_to_x, "x_to_y", x_to_y, "x", x, "y", y)
	else
		stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)
	end
end

stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)
stage:addEventListener(Event.MOUSE_DOWN, onClick)