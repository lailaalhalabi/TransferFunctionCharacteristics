%% Written by Laila Alhalabi
% Given the num and den parameters of a transfer function, this code will:
% 1. Display the transfer function, the order of it and its stability.
% 2. Determines the natural frequecy, damping ratio, frequency of oscillation,
% peak and settling time and the overshoot.
% 3. Display the poles & zeros of the system.
% 4. Determines the position, velocity and acceleration errors.
% 5. Display the step, ramp and parabola inputs.
% 6. Display the gain value of the system.
%% Declaring num and den of the transfer functions and printing it
clc
disp('##################################################');
disp('#### Characteristics of the Transfer Function ####');
disp('##################################################');
num = [1]; den = [1 2 3]; % should be modified before running the program
disp('The transfer function is:');
transfer_function = tf(num,den)
%% Operations
syms s
sysOrder = order(transfer_function);
Wn = sqrt(den(3)); 
dampingRatio = den(2)/(2*Wn);
oscillationFrequency = Wn*sqrt(1-dampingRatio^2);
Tp = (pi) / (oscillationFrequency);
Ts = 4/(Wn*dampingRatio);
OS = exp(-((dampingRatio*pi)/sqrt(1-dampingRatio^2)))*100;
sys = poly2sym(num,s)/poly2sym(den,s);
Kp = limit(sys, s, 0);
Kv = limit(s*sys, s, 0);
Ka = limit(s*s*sys, s, 0);
[ze,po,k] = zpkdata(transfer_function,'v');
%% Printing characteristics of the system
disp('The order of the system is: ');
disp(sysOrder);
disp('The system is:');
if isstable(transfer_function)
    disp('   - stable');
else
    disp('   - not stable');
end
if dampingRatio < 1 && dampingRatio > 0
    disp('   - underdamped (oscillations die out and a final steady-state is reached)');
elseif dampingRatio > 1 
    disp('   - overdamped (no oscillations, more damping)');
elseif dampingRatio == 0 
    disp('   - undamped (oscillations do not die out)');
elseif dampingRatio == 1 
    disp('   - critically damped (no oscillations)');
end
disp(' ');
disp('The natural frequency Wn is:');
disp(Wn);
disp('The damping ratio is:');
disp(dampingRatio);
disp('The frequency of oscillation is:');
disp(oscillationFrequency);
disp('The peak time Tp is:');
disp(Tp);
disp('The settling time Ts is:');
disp(Ts);
disp('The overshoot OS% is:');
disp(OS);
disp('The system poles & zeros:');
poles = pole(transfer_function)
zeros = zero(transfer_function)
disp('Position error Kp:');
disp(Kp);
disp('Velocity error Kv:');
disp(Kv);
disp('Acceleration error Ka:');
disp(Ka);
disp('Step input:');
disp(1/(1+Kp));
disp('Ramp input:');
disp(1/Kv);
disp('Parabola input:');
disp(1/Ka);
disp('Gain K:');
disp(k);



    
