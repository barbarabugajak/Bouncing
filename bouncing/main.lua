-- Settings
function love.conf(t)
    t.window.title = "Bouncing"
    t.version = "11.4"
end

-- BeginPlay()
function love.load()
    -- Screen's 
    screenWidth, screenHeight, flags = love.window.getMode( )
    -- Square's 
    x, y, width, height = screenWidth/2, screenHeight/2, 80, 80
    velocityX = 5
    velocityY = 5
    accelerationX = 0
    accelerationY = 0
    love.graphics.setColor(0, 0.6, 0.9)
end 

function rectsIntersect(a, b)
    return a.max_x >= b.min_x and a.min_x <= b.max_x
        and a.max_y >= b.min_y and a.min_y <= b.max_y
end     

function getExtremities(x,y,w,h)
    local extremities = {
    ["max_x"] = x+w,
     ["min_x"] = x,
     ["max_y"] =y+h,
     ["min_y"] = y}
    return extremities end

function collisionHappens(bRotY)
    if bRotY then 
        velocityY = velocityY * -1
    else 
        velocityX = velocityX * -1
    end

    love.graphics.setColor(math.random(0.2,0.99), math.random(0.2,0.99), math.random(0.2,0.99))
end

-- Tick()
function love.update(deltaTime)

    squareData = getExtremities(x, y, width, height)
    top = getExtremities(0, 0, screenWidth, 5)
    bottom = getExtremities(0, screenHeight-5, screenWidth, 5)
    right = getExtremities(screenWidth-5, 0, 10, screenHeight)
    left = getExtremities(0, 0, 5, screenHeight)

    -- Top
    if rectsIntersect(squareData, top) then
        collisionHappens(true)
        print("Collision at: ", "top")
    end
    -- Bottomlove
    if rectsIntersect(squareData, bottom) then
       collisionHappens(true)
       print("Collision at: ", "bottom")
    end
    -- -- Right
    if rectsIntersect(squareData, right) then
        collisionHappens(false)
        print("Collision at: ", "right")
    end
    -- -- Left 
    if rectsIntersect(squareData, left) then
        collisionHappens(false)
        print("Collision at: ", "left")
    end

     x = x + velocityX 
    y = y + velocityY
    velocityX = velocityX + accelerationY
    velocityY = velocityY + accelerationY
    accelerationX = 0
    accelerationY = 0

end

-- Draw
function love.draw()
    love.graphics.rectangle("fill", x,y, width, height)
    love.graphics.rectangle("fill", 0, 0, screenWidth, 5)
    love.graphics.rectangle("fill", 0, screenHeight-5, screenWidth, 5)
    love.graphics.rectangle("fill", screenWidth-5, 0, 10, screenHeight)
    love.graphics.rectangle("fill", 0, 0, 5, screenHeight)
end