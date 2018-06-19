M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
l = 0.3;
g = 9.8;
q = (I+m*l*l)*(M+m) - (m*l)^2;

s = tf('s');

P_pend = ((m*l*s^2)/q)/(s^4 + (b*(I+m*l*l)*s^3)/q - ((M+m)*m*g*l*s^2)/q - b*m*g*l*s/q);
P_cart = (((I+m*l*l)*s^2-m*g*l)/q)/(s^4 + (b*(I+m*l*l)*s^3)/q - ((M+m)*m*g*l*s^2)/q - b*m*g*l*s/q);

Kp = 150;
Ki = 1;
Kd = 30;
C = pid(Kp,Ki,Kd);
sys_tf1 = feedback(1,P_pend*C)*P_cart;
sys_tf2 = feedback(P_pend,C);

t = 0:0.05:5;

[AX,H1,H2] = plotyy(t,impulse(sys_tf1,t),t,impulse(sys_tf2,t),'plot');
set(get(AX(2),'Ylabel'),'String','cart position (m)')
set(get(AX(1),'Ylabel'),'String','pendulum angle (radians)')
axis([0 5 -0.2 0.2]);
title('Response of Cart Position to Impulse Input with PID Control: Kp = 150, Ki = 1, Kd = 30');