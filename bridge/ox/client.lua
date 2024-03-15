local file = ('imports/%s.lua'):format('client')
local import = LoadResourceFile('ox_core', file)
local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))

chunk()

local Groups = {}

RegisterNetEvent('ox:setGroup', function(name, grade)
    Groups[name] = grade
    TriggerEvent('sleepless_interact:updateGroups', Groups)
end)

AddEventHandler('ox:playerLoaded', function()
    local player = Ox.GetPlayer() --[[@as OxPlayerClient]]
    if player then
        Groups = player:getGroups()
    end
    TriggerEvent('sleepless_interact:updateGroups', Groups)
    TriggerEvent('sleepless_interact:LoadDui')
    MainLoop()
end)

AddEventHandler('ox:playerLogout', function()
    table.wipe(Groups)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(500)
        local player = Ox.GetPlayer() --[[@as OxPlayerClient]]
        if player then
            Groups = player:getGroups()
        end
        TriggerEvent('sleepless_interact:updateGroups', Groups)
        MainLoop()
    end
end)

return Groups
