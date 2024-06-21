clear;
clc;
L(1) = Link('revolute', 'd', 0.216, 'a', 0 ,'alpha', pi/2);
L(2) = Link('revolute', 'd', 0, 'a', 0.5, 'alpha', 0, 'offset', pi/2);
L(3) = Link('revolute', 'd', 0, 'a', sqrt(0.145^2+0.42746^2), 'alpha', 0, 'offset', -atan(427.46/145));
L(4) = Link('revolute', 'd', 0, 'a', 0, 'alpha', pi/2, 'offset', atan(427.46/145));
L(5) = Link('revolute', 'd', 0.258, 'a', 0, 'alpha', 0);

Five_dof = SerialLink(L, 'name', '5-dof');

Five_dof.base = transl(0, 0, 0.28);

L(1).qlim = [-150, 150]/180*pi; 
L(2).qlim = [-100, 90]/180*pi;
L(3).qlim = [-90, 90]/180*pi;
L(4).qlim = [-100, 100]/180*pi;
L(5).qlim = [-180, 180]/180*pi;

num = 30000;

P = zeros(num, 3);

for i = 1:num

    q1 = L(1).qlim(1) + rand * ( L(1).qlim(2) - L(1).qlim(1) ) ;
    q2 = L(2).qlim(1) + rand *  ( L(2).qlim(2) - L(2).qlim(1) ) ;
    q3 = L(3).qlim(1) + rand * ( L(3).qlim(2) - L(3).qlim(1) ) ;
    q4 = L(4).qlim(1) + rand * ( L(4).qlim(2) - L(4).qlim(1) ) ;
    q5 = L(5).qlim(1) + rand * ( L(5).qlim(2) - L(5).qlim(1) ) ;

    q = [q1 q2 q3 q4 q5] ;

    T = Five_dof.fkine(q) ;

    P(i, :) = transl(T) ;

end

plot3(P(:,1),P(:,2),P(:,3),'b.','markersize',1);%三维空间绘制

%axis([-1.5 1.5 -1.5 -0.5 1.5]);

hold on %保留机械臂

grid on

daspect([1 1 1]);

view([45 45]);

Five_dof.plot([0 0 0 0 0]);

%% test
