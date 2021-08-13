local function findPeripheral( periphType )
    for _, side in pairs( rs.getSides() ) do
        if peripheral.isPresent(side) and peripheral.getType(side) == periphType then
            return side
        end
    end

    error("Cannot find "..periphType.." attached to this computer", 0)
end

ENERGY_CELL = peripheral.wrap(findPeripheral("appliedenergistics2:energy_cell"))

LOWER_THRESHOLD = 100000
UPPER_THRESHOLD = 180000

while true do
    local energy_level = ENERGY_CELL.getNetworkEnergyStored()

    print("Energy level: ", energy_level)

   
    if redstone.getOutput("front") == true then
        -- We're not charging, check if energy level is below lower threshold
        if energy_level < LOWER_THRESHOLD then
            print("Energy levels lower than 100kAE, letting IC2 power through")
            redstone.setOutput("front", false)
        end
    else
        -- We are charging, check if upper threshold has been reached
        if energy_level >= UPPER_THRESHOLD then
            print("We've reached 180kAE, disabling power")
            redstone.setOutput("front", true)
        end
    end

    sleep(1)
end