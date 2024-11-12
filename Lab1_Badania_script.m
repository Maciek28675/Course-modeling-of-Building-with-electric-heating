clear all;
close all;

%=========== I część (identyfikacja) =========
% wartości nominalne
TzewN = -20; % temperatura na zewnątrz - oC 
TwewN = 20; % temperatura wewnątrz - oC
TpN = 15; % temperatura na poddaszu - oC
Vw = 2.5 * 10 * 10; % m^3 kubatura pomieszczenia 
Vp = Vw / 4; % m^3 kubatura poddasza
PgN = 10000; % zapotrzebowanie budynku na ciepło - W
cpp = 1000; % ciepło właściwe powietrza - J(kg/K)
rop = 1.2; % gęstość powietrza w 20 stopniach - kg/m^3
a = 3; % założenie a) współczynnik 3 razy większy
%-----------
% identyfikacja parametrów statycznych
Kp = PgN / ((a + 1) * TwewN - a * TzewN - TpN); % Współczynnik straty ciepła przez sufit W/K
Kd = (Kp * (TwewN - TpN)) / (TpN - TzewN); % Współczynnik straty ciepła przez dach W/K
K1 = a * Kp; % Współczynnik straty ciepła przez ściany W/K
%-----------
% parametry "dynamiczne"
Cvw = cpp * rop * Vw; % Pojemność cieplna pomieszczenia
Cvp = cpp * rop * Vp; % Pojemność cieplna poddasza

%=========== II część (punkt pracy) ==========
% warunki początkowe
Tzew0 = TzewN + 0;
Pg0 = PgN * 1.0;
%-----------
% stan równowagi
Twew0 = (Pg0 * (Kp + Kd)) / (Kp * (a * Kp + (a + 1) * Kd)) + Tzew0;
Tp0 = (Kp * Twew0 + Kd * Tzew0) / (Kp + Kd);

%=========== III część (symulacja) ===========
%czas = 8000;
%czas_skoku = 500;
%dPg = 0;
%dTzew = 1;

%[out] = sim("Lab1_schema.slx", czas);

%subplot(2, 1, 1);
%plot(out.tout, out.Twew)
%grid on; 
%title("Reakcja Twew na skok Tzew");
%xlabel("czas [s]");
%ylabel("temperatura [oC]");

%subplot(2, 1, 2);
%plot(out.tout, out.Tp, 'r')
%grid on;
%title("Reakcja Tp na skok Tzew");
%xlabel("czas [s]");
%ylabel("temperatura [oC]");

%=========== IV część (Badania) ===========
czas = 8000;
czas_skoku = 500;
kolor = 'rgbcm';
legenda = {'Tzew0, Pg0', 'Tzew0 + 10, Pg0', 'Tzew0, 0.1 * Pg0'};
    
tab_Tzew = [Tzew0, Tzew0 + 10, Tzew0];
tab_Pg = [Pg0, Pg0, 0.1 * Pg0];

fig1 = figure(), grid on, hold on;
title("Reakcja Twew na skok Tzew");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend;

fig2 = figure(), grid on, hold on;
title("Reakcja Tp na skok Tzew");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend('Location', 'best');

fig3 = figure(), grid on, hold on;
title("Reakcja Twew na skok Tzew");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend('Location', 'best');

fig4 = figure(), grid on, hold on;
title("Reakcja Tp na skok Tzew");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend('Location', 'best');

fig5 = figure(), grid on, hold on;
title("Reakcja Twew na skok Pg");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend('Location', 'best');

fig6 = figure(), grid on, hold on;
title("Reakcja Tp na skok Pg");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend('Location', 'best');

fig7 = figure(), grid on, hold on;
title("Reakcja Twew na skok Pg");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend('Location', 'best');

fig8 = figure(), grid on, hold on;
title("Reakcja Tp na skok Pg");
xlabel("czas [s]");
ylabel("temperatura [oC]");
legend('Location', 'best');

powtorzenia = 3;

% skoki
czas = 8000;
czas_skoku = 500;
dPg = 0;
dTzew = 1;

for i = 1:powtorzenia
    
    Tzew0 = tab_Tzew(i);
    Pg0 = tab_Pg(i);
    
    Twew0 = (Pg0 * (Kp + Kd)) / (Kp * (a * Kp + (a + 1) * Kd)) + Tzew0;
    Tp0 = (Kp * Twew0 + Kd * Tzew0) / (Kp + Kd);

    [out] = sim("Lab1_schema.slx", czas);
    figure(fig1), plot(out.tout, out.Twew, kolor(i), 'DisplayName', legenda{i})
    figure(fig2), plot(out.tout, out.Tp, kolor(i), 'DisplayName', legenda{i})
   
end

for i = 1:powtorzenia
    
    Tzew0 = tab_Tzew(i);
    Pg0 = tab_Pg(i);
    
    Twew0 = (Pg0 * (Kp + Kd)) / (Kp * (a * Kp + (a + 1) * Kd)) + Tzew0;
    Tp0 = (Kp * Twew0 + Kd * Tzew0) / (Kp + Kd);
    
    [out] = sim("Lab1_schema.slx", czas);
    figure(fig3), plot(out.tout, out.Twew - Twew0, kolor(i), 'DisplayName', legenda{i})
    figure(fig4), plot(out.tout, out.Tp - Tp0, kolor(i), 'DisplayName', legenda{i})
   
end

% skoki
czas = 12000;
czas_skoku = 500;
dPg = 300;
dTzew = 0;

for i = 1:powtorzenia
    
    Tzew0 = tab_Tzew(i);
    Pg0 = tab_Pg(i);
    
    Twew0 = (Pg0 * (Kp + Kd)) / (Kp * (a * Kp + (a + 1) * Kd)) + Tzew0;
    Tp0 = (Kp * Twew0 + Kd * Tzew0) / (Kp + Kd);

    [out] = sim("Lab1_schema.slx", czas);
    figure(fig5), plot(out.tout, out.Twew, kolor(i), 'DisplayName', legenda{i})
    figure(fig6), plot(out.tout, out.Tp, kolor(i), 'DisplayName', legenda{i})
   
end

for i = 1:powtorzenia
    
    Tzew0 = tab_Tzew(i);
    Pg0 = tab_Pg(i);
    
    Twew0 = (Pg0 * (Kp + Kd)) / (Kp * (a * Kp + (a + 1) * Kd)) + Tzew0;
    Tp0 = (Kp * Twew0 + Kd * Tzew0) / (Kp + Kd);
    
    [out] = sim("Lab1_schema.slx", czas);
    figure(fig7), plot(out.tout, out.Twew - Twew0, kolor(i), 'DisplayName', legenda{i})
    figure(fig8), plot(out.tout, out.Tp - Tp0, kolor(i), 'DisplayName', legenda{i})
   
end