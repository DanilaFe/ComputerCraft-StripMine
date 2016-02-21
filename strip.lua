function tl (c)
  for i=1, c do
    turtle.turnLeft()
  end
end

function tr (c)
  for i=1, c do
    turtle.turnRight()
  end
end

function tun (len)
  for i=1,len do
    turtle.dig()
    while turtle.forward() == false do turtle.dig() end
    turtle.digUp()
  end
end

function gof (len)
  for i=1, len do
    while turtle.forward() == false do turtle.dig() end
  end
end

function fuel ()
  for i=1, 16 do
    turtle.select(i)
    if (turtle.getItemCount(i) ~= 0 and turtle.getItemDetail(i).name ~= "minecraft:chest" and turtle.refuel(1)) then return end
  end
end

function cobble()
  for i=1, 16 do
    if (turtle.getItemCount(i) ~= 0 and turtle.getItemDetail(i).name == "minecraft:cobblestone") then
      turtle.select(i)
      turtle.drop()
    end
  end
  turtle.select(1)
end

function dirt()
  for i=1, 16 do
    if (turtle.getItemCount(i) ~= 0 and turtle.getItemDetail(i).name == "minecraft:dirt") then
      turtle.select(i)
      turtle.drop()
    end
  end
  turtle.select(1)
end

function inv()
  total = 0
  for i=1, 16 do
    if turtle.getItemCount(i) ~= 0 then
      total=total+1
    end
  end
  return total
end

function chest()
  chestPlaced = false
  for i=1, 16 do
    if (turtle.getItemCount(i) ~= 0 and turtle.getItemDetail(i).name == "minecraft:chest") then
      turtle.digDown()
      turtle.select(i)
      turtle.placeDown()
      chestPlaced = true
    end
  end

  if chestPlaced then
    print("Placed Chest")
    for i=1, 16 do
      if (turtle.getItemCount(i) ~= 0 and turtle.getItemDetail(i).name ~= "minecraft:chest") then
        turtle.select(i)
        turtle.dropDown()
      end
    end
  end

  return chestPlaced
end

while true do
  -- Refuel, clear inventory
  fuel()
  cobble()
  dirt()

  -- Strip mining algorithm
  tun(3)
  tl(1)
  tun(7)
  tl(2)
  gof(7)
  tun(7)
  tl(2)
  gof(7)
  tr(1)

  -- Inventory Check
  if inv() == 16 then
    print("Invetory Full")
    if chest() == false then
      print("No Chests. Stopping.")
      break
    end
  end


end
