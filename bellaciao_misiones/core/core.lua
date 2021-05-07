ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Misiones.esxEvent, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    AddPeds()
    AddPed(Config.Misiones.Misiones.Helicopter.Posiciones.Ped.coords.x, Config.Misiones.Misiones.Helicopter.Posiciones.Ped.coords.y, Config.Misiones.Misiones.Helicopter.Posiciones.Ped.coords.z, Config.Misiones.Misiones.Helicopter.Posiciones.Ped.coords.w, Config.Misiones.Misiones.Helicopter.Posiciones.Ped.model)
end)

function AddPeds()
    --DeletePed(ped)

    local pedHash = Config.Misiones.Ped.Hash
	RequestModel(pedHash)
	while not HasModelLoaded(pedHash) do
        Wait(0)
    end
	
	local ped = CreatePed(4, pedHash, Config.Misiones.Ped.Position)
			SetEntityAsMissionEntity(ped)
			SetBlockingOfNonTemporaryEvents(ped, true)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
end

function AddPed(x, y, z, w, model)
    --DeletePed(ped)

    local pedHash = model
	RequestModel(pedHash)
	while not HasModelLoaded(pedHash) do
        Wait(0)
    end
	
	local ped = CreatePed(4, pedHash, x, y, z, w)
			SetEntityAsMissionEntity(ped)
			SetBlockingOfNonTemporaryEvents(ped, true)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
end

function AddBlip(x, y, z, sprite, color, name)
    blip = AddBlipForCoord(x, y, z)

        SetBlipSprite (blip, sprite)
        SetBlipScale  (blip, 0.75)
        SetBlipColour (blip, color)
        SetBlipAsShortRange(blip, false)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(name)
        EndTextCommandSetBlipName(blip)
end

function spawnVehicle(x, y, z, r, model)
    local vector = vector3(x, y, z)
    ESX.Game.SpawnVehicle(model, vector, r, function(veh)
    end)
end

function OpenMissionMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'misiones', {
		title    = Config.Misiones.Traducciones.MenuTitle,
		align    = 'bottom-right',
		elements = Config.Misiones.Misiones.Menu
	}, function(data, menu)
        local data = data.current.value

        if data == 'azar_mission' then
            local azar = math.random(1, 5)
            if azar == 1 then
                militar_mission()
            elseif azar == 2 then
                drive_mission()
            elseif azar == 3 then
                plane_mission()
            elseif azar == 4 then
                helicopter_mission()
            elseif azar == 5 then
                entregar_mission()
            end
        elseif data == 'militar_mission' then
            militar_mission()
        elseif data == 'drive_mission' then
            drive_mission()
        elseif data == 'plane_mission' then
            plane_mission()
        elseif data == 'helicopter_mission' then
            helicopter_mission()
        elseif data == 'entregar_mission' then
            entregar_mission()
        end

	end, function(data, menu)
		menu.close()
	end)
end

-- FUNCIONES / MISIONES
RegisterCommand('test', function()
    plane_mission()
end)