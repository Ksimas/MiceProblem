clear all;
close all;
clc;

a = 1000;               % 1000m 
VelA = 2;               % pr�dko�� �limaka A w km/tydz  2km/tydz = 0.1984m/min
VelB = 2;               % pr�dko�� �limaka B w km/tydz  
VelC = 2;               % pr�dko�� �limaka C w km/tydz  
VelD = 2;               % pr�dko�� �limaka D w km/tydz  
Wind_Horizontal = 0;    % pr�dko�� wiatru poziomowego te� w km/tydz
Wind_Vertical = 0;      % pr�dko�� wiatru pionowego w km/tydz
czas = 1/7/24;          % krok czasu co jaki sporz�dzane s� obliczenia dotycz�ce obecnej sytuacji, gdzie 1/7/24 = 1h
                        % zmniejszanie wartosci tego paramtetru zwieksza precyzj� otrzymywanych wynik�w

VelA2 = czas*VelA*1000;                      % droga przebyta przez �limaka A w okre�lonym przez zmienn� 'czas' czasie
VelB2 = czas*VelB*1000;                      % droga przebyta przez �limaka B w okre�lonym przez zmienn� 'czas' czasie
VelC2 = czas*VelC*1000;                      % droga przebyta przez �limaka C w okre�lonym przez zmienn� 'czas' czasie
VelD2 = czas*VelD*1000;                      % droga przebyta przez �limaka D w okre�lonym przez zmienn� 'czas' czasie
Wind_Horizontal = czas*Wind_Horizontal*1000; % droga przebyta przez wiatr w okre�lonym przez zmienn� 'czas' czasie
Wind_Vertical = czas*Wind_Vertical*1000;
Wind = [Wind_Horizontal, Wind_Vertical];

sA = 0;              % ca�kowita droga pokonana przez �limaka A
sB = 0;              % ca�kowita droga pokonana przez �limaka B
sC = 0;              % ca�kowita droga pokonana przez �limaka C
sD = 0;              % ca�kowita droga pokonana przez �limaka D

A = [0,a];          % po�o�enie �limaka A
B = [a,a];          % po�o�enie �limaka B
C = [a,0];          % po�o�enie �liamka C
D = [0,0];          % po�o�enie �limaka D
 
 % dla lepszej czytelno�ci: 
XA = A(:,1);        % wsp�rz�dna X po�o�enia �limaka A
YA = A(:,2);        % wsp�rz�dna Y po�o�enia �limaka A
XB = B(:,1);        % wsp�rz�dna X po�o�enia �limaka B
YB = B(:,2);        % wsp�rz�dna Y po�o�enia �limaka B
XC = C(:,1);        % wsp�rz�dna X po�o�enia �limaka C
YC = C(:,2);        % wsp�rz�dna Y po�o�enia �limaka C
XD = D(:,1);        % wsp�rz�dna X po�o�enia �limaka D
YD = D(:,2);        % wsp�rz�dna Y po�o�enia �limaka D
 
figure(1);          % rysowanie na wykresie punkt�w oznaczaj�cych obecne po�o�enie �limak�w
scatter(XA,YA, 'b*');
text(0,a+50,'�limak A');
hold on;
scatter(XB,YB, 'y*');
text(a,a+50,'�limak B');
hold on;
scatter(XC,YC, 'r*');
text(a,0+50,'�limak C');
hold on;
scatter(XD,YD, 'g*');
text(0-150,0+50,'�limak D');
hold on;
 
DAB = a;            % dystans mi�dzy �limakami A i B
DBC = a;            % dystans mi�dzy �limakami B i C        
DCD = a;            % dystans mi�dzy �limakami C i D
DDA = a;            % dystans mi�dzy �limakami D i A
 
VA = [VelA2,0]-Wind;         % wektor �limaka A
VB = [0,-VelB2]-Wind;        % wektor �limaka B
VC = [-VelC2,0]-Wind;        % wektor �liamka C
VD = [0,VelD2]-Wind;         % wektor �limaka D


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
    
    % aktualizacja po�o�enia �limak�w     
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

    % r�nice w po�o�eniach poszczeg�lnych �limak�w zapisane za pomoc� wektor�w
    VAB = [XB-XA,YB-YA]; % wektor wskazuj�cy z po�o�enia �liamka A po�o�enie �limaka B
    VBC = [XC-XB,YC-YB];
    VCD = [XD-XC,YD-YC];
    VDA = [XA-XD,YA-YD];

    % liczenie dystansu mi�dzy �limakami
    % mo�na te� u�yc funkcji: pdist2(X,Y,'euclidean'); 
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

Droga1 = ['Droga jak� pokona� �limak A jest r�wna: ', num2str(sA), 'm.'];
Droga2 = ['Droga jak� pokona� �limak B jest r�wna: ', num2str(sB), 'm.'];
Droga3 = ['Droga jak� pokona� �limak C jest r�wna: ', num2str(sC), 'm.'];
Droga4 = ['Droga jak� pokona� �limak D jest r�wna: ', num2str(sD), 'm.'];
disp(Droga1);                                                                                                          

disp(Droga2);
disp(Droga3);
disp(Droga4);

t = sA/(VelA2);  % jednostka zale�y od wpisanej wartosci w parametrze 'czas' (linijka 10)  
                 % dla czasu = 1/7/24 jednostk� domy�ln� jest 1godzina.  
Czas = ['Wszystkie �limaki spotkaj� si� po ',num2str(t) , ' godzinach.'];
disp(Czas);

