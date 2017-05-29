function [ wake ] = floris_initwake( model,turbine,wake,turb_type )
% This function computes the coefficients that determine wake behaviour.
% The initial deflection and diameter of the wake are also computed

    % Calculate ke, the basic expansion coefficient
    wake.Ke = model.Ke + model.KeCorrCT*(turbine.Ct-model.baselineCT);

    % Calculate mU, the zone multiplier for different wake zones
    if model.useaUbU
        wake.mU = model.MU/cos(model.aU+model.bU*turbine.YawWF);
    else
        wake.mU = model.MU;
    end

    % Calculate initial wake deflection due to blade rotation etc.
    wake.zetaInit = 0.5*sin(turbine.YawWF)*turbine.Ct; % Eq. 8
    
    % Add an initial wakeangle to the zeta
    if model.useWakeAngle
        wake.zetaInit = wake.zetaInit + model.kd;
    end;

    % Calculate initial wake diameter
    if model.adjustInitialWakeDiamToYaw
        wake.wakeDiameterInit = turb_type.rotorDiameter*cos(turbine.YawWF);
    else
        wake.wakeDiameterInit = turb_type.rotorDiameter;
    end
end