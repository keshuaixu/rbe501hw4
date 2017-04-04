% joint angles
q = sym('q', [3 1]);

% joint velocities
q_dot = sym('q_dot', [3 1]);

% position of end of joints
p = sym('p', [3 3]);

% center of mass
pm = sym('pm', [4 3]);

% mass of joints [mA mB mC mL]'
m = sym('m', [4 1]);

% length of arms [A B C]'
len = sym('len', [3 1]);


%% 1
% theta, d, a, alpha
dh = horzcat(q, zeros(3,1), len, zeros(3,1))
T = sym(zeros(4,4,size(dh, 1)));
for joint=1:size(dh, 1)
    T(:,:,joint) = dh2mat(dh(joint,1),dh(joint,2),dh(joint,3),dh(joint,4));
end
% ans
T_0_3 = T(:,:,1)*T(:,:,2)*T(:,:,3)

%% 2

x_t = T_0_3 * [0;0;0;1];
x_t = x_t(1:3,:);
J_upper = jacobian(x_t, q);
J_lower = [0,0,0;
           0,0,0; % thetas contribute to rotation in z
           1,1,1];
% ans
J = vertcat(J_upper, J_lower)

%TODO:  You must clearly show the full equation and identify what each of the elements correspond to, not just provide the Jacobian matrix

%% 3

%% 4 

%% 5a
n_len = [0.8;0.4;0.2]; % m
n_m = [2;1;0.5;1.5]; % kg

pm = horzcat([len(1)*0.5*cos(q(1));len(1)*0.5*sin(q(1));0;1], T(:,:,1)*[len(2)*0.5;0;0;1], T(:,:,1)*T(:,:,2)*[len(3)*0.5;0;0;1], T(:,:,1)*T(:,:,2)*T(:,:,3)*[0;0;0;1])
J_pm = 
pm_dot = J * q_dot

%K = 