    if autoOffMod then
        local exactMatch, _ = checkModerators()
        if exactMatch then
            rest = true
            log("Moderator terdeteksi, bot akan disconnect...")
            bot.auto_reconnect = false
            bot.rotation.enabled = false
            bot:disconnect()
            while true do
                sleep(300000) -- Changed from 5000 to 300000 (5 minutes)
                local newExactMatch, _ = checkModerators()
                if not newExactMatch then
                    rest = false
                    bot.auto_reconnect = true
                    while bot.status ~= BotStatus.online do
                        sleep(1000)
                    end
                    bot.rotation.enabled = true
                    log("Moderator tidak lagi terdeteksi, reconnect...")
                    break
                end
            end
        end
    end 