local p = {}
local app = "xCJShop_Boxdrops"
local Start = function()
    -- savenameeventbox = 'xCJShop_Boxdrops'
    -- ExecuteCommand("start "..savenameeventbox)
    StartResource(app)
    print("^2[Notown] ^7Start_Scripts: [^3" .. app .. "^7] SUCCESS!")
end
local Stop = function()
    -- ExecuteCommand("stop "..savenameeventbox)
    StopResource(app)
    print("^2[Notown] ^7Stop_Scripts: [^3" .. app .. "^7] SUCCESS!")
end

local Announce = function(args)
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent(
            "pNotify:SendNotification",
            playerId,
            {
                text = '<strong class="red-text">' .. args .. "</strong>",
                type = "info",
                timeout = 12000,
                layout = "centerLeft",
                queue = "global"
            }
        )
        TriggerClientEvent(
            "chat:addMessage",
            playerId,
            {
                template = '<div style="padding: 0.5vw; border-radius: 25px; margin: 0.5vw; background-color: rgba(255, 0, 0, .6);"> {0}: {1}</div>',
                color = {255,215,0},
                args = {"[NOTOWN] Eventbox", args}
            }
        )
    end
end
--------------------------------------------------ตั้งเวลา-----------------------------------------------------------------
table.insert(
    p,
    {["time"] = "09:10", ["scripts"] = Stop, ["message"] = "Event Box หมดเวลาแล้ว"}
)
table.insert(
    p,
    {["time"] = "15:10", ["scripts"] = Stop, ["message"] = "Event Box หมดเวลาแล้ว"}
)
table.insert(
    p,
    {["time"] = "20:10", ["scripts"] = Stop, ["message"] = "Event Box หมดเวลาแล้ว"}
)
table.insert(
    p,
    {["time"] = "03:10", ["scripts"] = Stop, ["message"] = "Event Box หมดเวลาแล้ว"}
)
--------------------------------------------------------------------------------------------------------------------------
CreateThread(
    function()
        while true do
            Wait(1000)
            local timestamp = os.time()
            local h = tonumber(os.date("%H", timestamp))
            local m = tonumber(os.date("%M", timestamp))
            if h <= 9 then
                h = "0" .. h
            end
            if m <= 9 then
                m = "0" .. m
            end

            for k, v in pairs(p) do
                if h .. ":" .. m == v.time then
                    if v.message ~= nil then
                        Announce(v.message)
                    end
                    Wait(300)
                    if v.scripts ~= nil then
                        v.scripts()
                    end
                    Wait(300)

                    print("^2[Notown] ^7SYSTEM_TIME: [^3" .. (v.time) .. "^7] SUCCESS!")
                    table.remove(p, k)
                end
            end
        end
    end
)
