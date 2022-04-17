PrefabFiles = {
    "rocks_placer.lua"
}

local function OnRockDeploy(inst, pt, deployer)
    local rock = GLOBAL.SpawnPrefab("rocks")

    if rock then
        rock.Transform:SetPosition(pt:Get())
        inst.components.stackable:Get():Remove()

        if deployer and deployer.SoundEmitter then
            deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
        end
    end
end

AddPrefabPostInit("rocks", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = OnRockDeploy
    inst.components.deployable:SetDeployMode(GLOBAL.DEPLOYMODE.ANYWHERE)
end)