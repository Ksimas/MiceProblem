clear all;
close all;
clc;

a = 1000;               % 1000m 
VelA = 2;               % prêdkoœæ œlimaka A w km/tydz  2km/tydz = 0.1984m/min
VelB = 2;               % prêdkoœæ œlimaka B w km/tydz  
VelC = 2;               % prêdkoœæ œlimaka C w km/tydz  
VelD = 2;               % prêdkoœæ œlimaka D w km/tydz  
Wind_Horizontal = 0;    % prêdkoœæ wiatru poziomowego te¿ w km/tydz
Wind_Vertical = 0;      % prêdkoœæ wiatru pionowego w km/tydz
czas = 1/7/24;          % krok czasu co jaki sporz¹dzane s¹ obliczenia dotycz¹ce obecnej sytuacji, gdzie 1/7/24 = 1h
                        % zmniejszanie wartosci tego paramtetru zwieksza precyzjê otrzymywanych wyników

VelA2 = czas*VelA*1000;                      % droga przebyta przez œlimaka A w okreœlonym przez zmienn¹ 'czas' czasie
VelB2 = czas*VelB*1000;                      % droga przebyta przez œlimaka B w okreœlonym przez zmienn¹ 'czas' czasie
VelC2 = czas*VelC*1000;                      % droga przebyta przez œlimaka C w okreœlonym przez zmienn¹ 'czas' czasie
VelD2 = czas*VelD*1000;                      % droga przebyta przez œlimaka D w okreœlonym przez zmienn¹ 'czas' czasie
Wind_Horizontal = czas*Wind_Horizontal*1000; % droga przebyta przez wiatr w okreœlonym przez zmienn¹ 'czas' czasie
Wind_Vertical = czas*Wind_Vertical*1000;
Wind = [Wind_Horizontal, Wind_Vertical];

sA = 0;              % ca³kowita droga pokonana przez œlimaka A
sB = 0;              % ca³kowita droga pokonana przez œlimaka B
sC = 0;              % ca³kowita droga pokonana przez œlimaka C
sD = 0;              % ca³kowita droga pokonana przez œlimaka D

A = [0,a];          % po³o¿enie œlimaka A
B = [a,a];          % po³o¿enie œlimaka B
C = [a,0];          % po³o¿enie œliamka C
D = [0,0];          % po³o¿enie œlimaka D
 
 % dla lepszej czytelnoœci: 
XA = A(:,1);        % wspó³rzêdna X po³o¿enia œlimaka A
YA = A(:,2);        % wspó³rzêdna Y po³o¿enia œlimaka A
XB = B(:,1);        % wspó³rzêdna X po³o¿enia œlimaka B
YB = B(:,2);        % wspó³rzêdna Y po³o¿enia œlimaka B
XC = C(:,1);        % wspó³rzêdna X po³o¿enia œlimaka C
YC = C(:,2);        % wspó³rzêdna Y po³o¿enia œlimaka C
XD = D(:,1);        % wspó³rzêdna X po³o¿enia œlimaka D
YD = D(:,2);        % wspó³rzêdna Y po³o¿enia œlimaka D
 
figure(1);          % rysowanie na wykresie punktów oznaczaj¹cych obecne po³o¿enie œlimaków
scatter(XA,YA, 'b*');
text(0,a+50,'Œlimak A');
hold on;
scatter(XB,YB, 'y*');
text(a,a+50,'Œlimak B');
hold on;
scatter(XC,YC, 'r*');
text(a,0+50,'Œlimak C');
hold on;
scatter(XD,YD, 'g*');
text(0-150,0+50,'Œlimak D');
hold on;
 
DAB = a;            % dystans miêdzy œlimakami A i B
DBC = a;            % dystans miêdzy œlimakami B i C        
DCD = a;            % dystans miêdzy œlimakami C i D
DDA = a;            % dystans miêdzy œlimakami D i A
 
VA = [VelA2,0]-Wind;         % wektor œlimaka A
VB = [0,-VelB2]-Wind;        % wektor œlimaka B
VC = [-VelC2,0]-Wind;        % wektor œliamka C
VD = [0,VelD2]-Wind;         % wektor œlimaka D


while (DAB > VelA2  ) || (DBC > VelB2 ) || (DCD > VelC2 ) || (DDA > VelD2 ) 

    if sqrt((VA(:,1))^2+(VA(:,2))^2) >= DAB
        A = B;
        VA = [0,0];
    end
    if sqrt((VB(:,1))^2+(VB(:,2))^2) >= DBC
        B = C;
        VB = [0,0];
    end
    if sqrt((VC(:,1))^2+(VC(:,2))^2) >= DCD
        C = D;
        VC = [0,0];
    end
    if sqrt((VD(:,1))^2+(VD(:,2))^2) >= DDA
        D = A;
        VD = [0,0];
    end
    
    % aktualizacja po³o¿enia œlimaków     
    A = A + VA;        
    B = B + VB;
    C = C + VC;
    D = D + VD;
 
    XA = A(:,1);
    YA = A(:,2);
    XB = B(:,1);
    YB = B(:,2);
    XC = C(:,1);
    YC = C(:,2);
    XD = D(:,1);
    YD = D(:,2);

    scatter(XA,YA, 'b*');
    hold on;
    scatter(XB,YB, 'y*');
    hold on;
    scatter(XC,YC, 'r*');
    hold on;
    scatter(XD,YD, 'g*');
    hold on;

    Krok_A = sqrt((VA(:,1))^2+(VA(:,2))^2);
    sA = sA + Krok_A;
    Krok_B =  sqrt((VB(:,1))^2+(VB(:,2))^2);
    sB = sB + Krok_B;
    Krok_C =  sqrt((VC(:,1))^2+(VC(:,2))^2);
    sC = sC + Krok_C;
    Krok_D = sqrt((VD(:,1))^2+(VD(:,2))^2);
    sD = sD + Krok_D;

    % ró¿nice w po³o¿eniach poszczególnych œlimaków zapisane za pomoc¹ wektorów
    VAB = [XB-XA,YB-YA]; % wektor wskazuj¹cy z po³o¿enia œliamka A po³o¿enie œlimaka B
    VBC = [XC-XB,YC-YB];
    VCD = [XD-XC,YD-YC];
    VDA = [XA-XD,YA-YD];

    % liczenie dystansu miêdzy œlimakami
    % mo¿na te¿ u¿yc funkcji: pdist2(X,Y,'euclidean'); 
    DAB = sqrt((VAB(:,1))^2+(VAB(:,2))^2);
    DBC = sqrt((VBC(:,1))^2+(VBC(:,2))^2);
    DCD = sqrt((VCD(:,1))^2+(VCD(:,2))^2);
    DDA = sqrt((VDA(:,1))^2+(VDA(:,2))^2);

    if (VAB(:,1) == 0 && VAB(:,2) == 0)
        VA = [0,0];
    else 
        VA = (VelA2)/DAB*VAB - Wind;
    end
    if (VBC(:,1) == 0 && VBC(:,2) == 0)
        VB = [0,0];
    else 
        VB = (VelB2)/DBC*VBC - Wind;
    end
    if (VCD(:,1) == 0 && VCD(:,2) == 0)
        VC = [0,0];
    else
        VC = (VelC2)/DCD*VCD - Wind;
    end
    if (VDA(:,1) == 0 && VDA(:,2) == 0)
        VD = [0,0];
    else 
        VD = (VelD2)/DDA*VDA - Wind;
    end
end

Droga1 = ['Droga jak¹ pokona³ œlimak A jest równa: ', num2str(sA), 'm.'];
Droga2 = ['Droga jak¹ pokona³ œlimak B jest równa: ', num2str(sB), 'm.'];
Droga3 = ['Droga jak¹ pokona³ œlimak C jest równa: ', num2str(sC), 'm.'];
Droga4 = ['Droga jak¹ pokona³ œlimak D jest równa: ', num2str(sD), 'm.'];
disp(Droga1);                                                                                                          

disp(Droga2);
disp(Droga3);
disp(Droga4);

t = sA/(VelA2);  % jednostka zale¿y od wpisanej wartosci w parametrze 'czas' (linijka 10)  
                 % dla czasu = 1/7/24 jednostk¹ domyœln¹ jest 1godzina.  
Czas = ['Wszystkie œlimaki spotkaj¹ siê po ',num2str(t) , ' godzinach.'];
disp(Czas);

