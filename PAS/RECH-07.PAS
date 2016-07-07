PROGRAM taschenrechner;
USES crt, graph, grafik, SH, mathe, maus;
TYPE tswitch                = (up, down);
VAR  mx, my                 : Integer;
     taste, tastealt        : Integer;
     Xpos, Ypos, Xco, Yco   : Integer;
     dezimale               : Integer;
     del                    : Boolean;
     fix                    : Boolean;
     ende                   : Boolean;
     help                   : Boolean;
     grad                   : Boolean;
     komma                  : Boolean;
     enter                  : Boolean;
     change                 : Boolean;
     notation               : Boolean;
     switched               : Boolean;
     gerechnet              : Boolean;
     scientific             : Boolean;
     Xreg, Yreg, Zreg, Treg : Real;
     kommastelle            : Real;
     ausgabe_real           : Real;
     ausgabe_str            : String;


{Initialisierung und Oberfl„che}

PROCEDURE draw_calc;
VAR a,b, X1,Y1,X2,Y2: integer;
BEGIN
 SetColor(0);
 rectangle(50,50,360,100);
 rectangle(50,50,360,230);
 rectangle(50,50,100,100);
 SetFillStyle(SolidFill,8);
 bar(60,60,90,90);
 rectangle(60,60,90,90);
 SetColor(15);
 OutTextXY(67,70,'OFF');
 SetColor(0);
 FOR a:= 0 TO 9 DO BEGIN
  FOR b:= 1 TO 4 DO BEGIN
   X1:= 60+30*a;
   Y1:= 80+30*b;
   X2:= 80+30*a;
   Y2:= 100+30*b;
   rectangle(X1,Y1,X2,Y2);
  END;
 END;
 SetFillStyle(SolidFill,8);
 bar(110,60,349,89);
END;

PROCEDURE draw_keys;
BEGIN
 OutTextXY(338,205,'+');        (* 9.4 - plus                               *)
 OutTextXY(338,175,'-');        (* 9.3 - minus                              *)
 OutTextXY(338,145,'*');        (* 9.2 - mal                                *)
 OutTextXY(338,115,'/');        (* 9.1 - durch                              *)
 OutTextXY(306,204,'pi');       (* 8.4 - pi                                 *)
 OutTextXY(308,175,'3');        (* 8.3 - 3                                  *)
 OutTextXY(308,145,'6');        (* 8.2 - 6                                  *)
 OutTextXY(308,115,'9');        (* 8.1 - 9                                  *)
 OutTextXY(278,205,'.');        (* 7.4 - Komma                              *)
 OutTextXY(278,175,'2');        (* 7.3 - 2                                  *)
 OutTextXY(278,145,'5');        (* 7.2 - 5                                  *)
 OutTextXY(278,115,'8');        (* 7.1 - 8                                  *)
 OutTextXY(248,205,'0');        (* 6.4 - 0                                  *)
 OutTextXY(248,175,'1');        (* 6.3 - 1                                  *)
 OutTextXY(248,145,'4');        (* 6.2 - 4                                  *)
 OutTextXY(248,115,'7');        (* 6.1 - 7                                  *)
 SetFillStyle(SolidFill,7);     (* 5.4 - ENTER                              *)
 Bar(210,220,230,170);
 Rectangle(210,220,230,170);
 SetColor(1);
 OutTextXY(218,209,'R');
 OuttextXY(218,199,'E');
 OuttextXY(218,189,'T');
 OuttextXY(218,179,'N');
 OutTextXY(218,169,'E');
 SetColor(0);
 OutTextXY(214,145,'<');        (* 5.2 - Backspace                          *)
 OutTextXY(215,145,'<');
 OutTextXY(216,145,'-');
 OutTextXY(218,145,'-');
 OutTextXY(217,115,#241);       (* 5.1 - Plus/Minus                         *)
 SetColor(0);
 OutTextXY(182,200,'Fix');      (* 4.4 - Dezimale einstellen                *)
 SetColor(4);
 OutTextXY(187,209,IntToStr(dezimale));
 SetColor(0);
 SetColor(4);                   (* 4.3 - Gradmaá / Bogenmaá                 *)
 IF grad
 THEN OutTextXY(182,175,'Deg')
 ELSE OutTextXY(182,175,'Rad');
 SetColor(0);
 OutTextXY(185,144,'n');        (* 4.2 - Fakult„t                           *)
 SetTextStyle(DefaultFont,HorizDir,0);
 OutTextXY(191,147,'!');
 SetTextStyle(SmallFont,HorizDir,0);
 OutTextXY(183,109,'1');        (* 4.1 - 1 durch x                          *)
 OutTextXY(190,118,'x');
 OutTextXY(187,113,'/');
 OutTextXY(153,205,'SCI');      (* 3.4 - Scientific Notation                *)
 SetColor(red);
 line(151,201,169,219);
 line(151,219,169,201);
 SetColor(0);
 OutTextXY(153,175,'cot');      (* 3.3 - Cotangens                          *)
 OutTextXY(154,140,'x<');       (* 3.2 - X und Y tauschen                   *)
 OutTextXY(154,147,'>y');
 OutTextXY(155,117,'y');        (* 3.1 - y hoch x                           *)
 OutTextXY(163,109,'x');
 OutTextXY(093,205,'R');        (* 2.4 - Register abw„rts tauschen          *)
 SetTextStyle(SmallFont,VertDir,0);
 SetColor(6);
 OutTextXY(098,210,'>');
 OutTextXY(098,209,'>');
 OutTextXY(098,205,'>');
 OutTextXY(098,204,'>');
 SetColor(0);
 SetTextStyle(SmallFont,HorizDir,0);
 OutTextXY(122,175,'tan');      (* 2.3 - Tangens                            *)
 OutTextXY(125,145,'lg');       (* 2.2 - Logarithmus Basis 10               *)
 OutTextXY(123,117,'10');       (* 2.1 - 10 hoch x                          *)
 OutTextXY(133,109,'x');
 OutTextXY(123,205,'R');        (* 1.4 - Register aufw„rts tauschen         *)
 SetTextStyle(SmallFont,VertDir,0);
 SetColor(6);
 OutTextXY(128,210,'<');
 OutTextXY(128,209,'<');
 OutTextXY(128,205,'<');
 OutTextXY(128,204,'<');
 SetColor(0);
 SetTextStyle(SmallFont,HorizDir,0);
 OutTextXY(092,175,'cos');      (* 1.3 - Cosinus                            *)
 OutTextXY(95,145,'ln');        (* 1.2 - nat. Logarithmus                   *)
 OutTextXY(95,117,'e');         (* 1.1 - e hoch x                           *)
 OutTextXY(103,109,'x');
 OutTextXY(62,205,'DEL');       (* 0.4 - Delete                             *)
 OutTextXY(62,175,'sin');       (* 0.3 - Sinus                              *)
 OutTextXY(65,145,'x');         (* 0.2 - Quadrat                            *)
 OutTextXY(73,145,#253);
 Line(64,120,66,124);           (* 0.1 - Wurzel                             *)
 line(66,124,68,116);
 line(68,116,74,116);
 OutTextXY(71,116,'x');
END;


PROCEDURE draw_reg;
VAR i: Integer; a: ARRAY[1..4] OF String;
BEGIN
 a[1]:= 'T:';
 a[2]:= 'Z:';
 a[3]:= 'Y:';
 a[4]:= 'X:';
 rectangle(400,50,450,230);
 FOR i:= 1 TO 4 DO BEGIN
  OutTextXY(415,25+45*i,a[i]);
  rectangle(400,5+45*i,630,230);
 END;
END;

PROCEDURE initialize(mode: word);
BEGIN
 IF mode < 3
 THEN BEGIN
  change  := false;
  switched:= false;
 END;
 IF mode < 2
 THEN BEGIN
  ausgabe_real:= 0;
  ausgabe_str:= '';
  Xreg:= 0;
  Yreg:= 0;
  Zreg:= 0;
  Treg:= 0;
  dezimale:= 2;
  komma:= false;
  enter:= false;
 END;
 IF mode < 1
 THEN BEGIN
  grad:= false;
  scientific:= false;
  SetuserCharSize(1,1,1,1);
  SetColor(0);
  SetTextStyle(SmallFont, HorizDir, 0);
  SetFillStyle(Solidfill,7);
  {bar(0,0,640,480);}
  draw_reg;
  draw_calc;
  draw_keys;
  Showmaus;
 END;
END;

{Register verschieben}

PROCEDURE switch_reg(dir: tswitch);
VAR t: Real;
BEGIN
 IF dir = up THEN BEGIN
  t:= Treg;
  Treg:= Zreg;
  Zreg:= Yreg;
  Yreg:= Xreg;
  Xreg:= t;
 END ELSE BEGIN
  t:= Xreg;
  Xreg:= Yreg;
  Yreg:= Zreg;
  Zreg:= Treg;
  Treg:= t;
 END;
 enter:= false;
 switched:= True;
END;

{Tasten aufblinken lassen}

PROCEDURE flash(X1,Y1,X2,Y2, color: integer);
BEGIN
 HideMaus;
 SetColor(color);
 rectangle(X1,Y1,X2,Y2);
 Delay(66);
 SetColor(0);
 rectangle(X1,Y1,X2,Y2);
 ShowMaus;
END;

{Ausgabe}

PROCEDURE output;
VAR i: Integer; a: ARRAY[1..4] OF Real;  ueberlauf: Boolean;  temp: String;
BEGIN
 IF NOT ((enter) OR (change)) THEN beep;
 IF enter
 THEN BEGIN
  Treg:= Zreg;
  Zreg:= Yreg;
  Yreg:= Xreg;
  Xreg:= 0;
 END;
 IF ausgabe_real = -ausgabe_real THEN ausgabe_str:= '0';
 IF scientific
 THEN Str(ausgabe_real,ausgabe_str)
 ELSE
  IF (enter OR gerechnet OR notation)
  THEN
   Str(ausgabe_real:20:dezimale,ausgabe_str)
  ELSE BEGIN
   ausgabe_str:= RealToStr(ausgabe_real);
   WHILE ausgabe_str[length(ausgabe_str)] = '0' DO BEGIN
    Delete(ausgabe_str,length(ausgabe_str),1);
   END;
  END;
 notation:= false;
 IF switched = false THEN Xreg:= ausgabe_real ELSE ausgabe_real:= Xreg;
 ueberlauf:= false;
 SetFillStyle(SolidFill,7);
 SetColor(8);
 a[1]:= Treg;
 a[2]:= Zreg;
 a[3]:= Yreg;
 a[4]:= Xreg;
 SetReal(10,9);
 FOR i:= 1 TO 4 DO BEGIN
  bar(460,7+45*i,629,45+45*i);
  OutTextXY(495,25+45*i,RealToStr(a[i]));
 END;
 SetFillStyle(SolidFill,8);
 bar(110,60,349,89);
 SetColor(15);
 SetUserCharSize(5,4,5,4);
 OuttextXY(339-TextWidth(ausgabe_str),57+19-Round(TextHeight(ausgabe_str)/2),ausgabe_str);
 SetUserCharSize(1,1,1,1);
 SetColor(0);
 Showmaus;
END;

{Eingabe von Ziffern & Komma}

PROCEDURE input(c: Char; r: real);
BEGIN
 IF enter OR del
 THEN BEGIN
  Xreg:= 0;
  ausgabe_real:= 0;
  ausgabe_str:= '';
  komma:= false;
  enter:= false;
  del:= false;
 END;
 IF r <> 0
 THEN BEGIN
  IF ((Xreg <> 0) AND ((enter) OR gerechnet)) THEN switch_reg(up);
  ausgabe_real:= r;
  ausgabe_str:= RealToStr(r);
  Xreg:= r;
 END ELSE BEGIN
  IF length(ausgabe_str) < 100 THEN BEGIN
   IF Xreg = pi
   THEN BEGIN
    Xreg:= 0;
    ausgabe_real:= 0;
    ausgabe_str:= '';
   END;
   IF c = '.'
   THEN BEGIN
    komma:= True; kommastelle:= 1;
    ausgabe_str:= ausgabe_str + c;
   END ELSE BEGIN
    IF gerechnet
    THEN BEGIN
     Treg:= Zreg;
     Zreg:= Yreg;
     Yreg:= Xreg;
     Xreg:= 0;
     ausgabe_real:= 0;
     ausgabe_str:= '';
     gerechnet:= false;
    END;
    IF komma
    THEN BEGIN
     kommastelle:= kommastelle * 0.1;
     ausgabe_str:= ausgabe_str + c;
     ausgabe_real:= ausgabe_real + (StrToInt(c)*kommastelle);
    END ELSE BEGIN
     ausgabe_real:= 10*ausgabe_real + StrToReal(c);
     ausgabe_str:= RealToStr(ausgabe_real);
     Delete(ausgabe_str,Pos('.',ausgabe_str)-1,length(ausgabe_str));
    END;
   END;
  END;
 END;
END;

{Grundrechenarten}

PROCEDURE ausrechnen(n: shortint);
BEGIN
 komma:= false;
 CASE n OF
  4: ausgabe_real:= Yreg+Xreg;
  3: ausgabe_real:= Yreg-Xreg;
  2: ausgabe_real:= Yreg*Xreg;
  1: ausgabe_real:= Yreg/Xreg;
 END;
 Xreg:= Yreg;
 Yreg:= Zreg;
 Zreg:= Treg;
 Treg:= 0;
 gerechnet:= True;
 enter:= false;
END;

{Trigonometrische & Arcus-Funktionen}

PROCEDURE trig(func: shortint);
BEGIN
 IF ((grad) AND (func > 0))
 THEN ausgabe_real:= (ausgabe_real/180)*pi;
 CASE func OF
  -1 : ausgabe_real:= arcsin(ausgabe_real);
  -2 : ausgabe_real:= arccos(ausgabe_real);
  -3 : ausgabe_real:= arctan(ausgabe_real);
  -4 : ausgabe_real:= arccot(ausgabe_real);
   1 : ausgabe_real:= sin(ausgabe_real);
   2 : ausgabe_real:= cos(ausgabe_real);
   3 : ausgabe_real:= tan(ausgabe_real);
   4 : ausgabe_real:= cot(ausgabe_real)
 END;
 IF ((grad) AND (func < 0))
 THEN ausgabe_real:= (ausgabe_real/pi)*180;
 gerechnet:= true;
END;

{Tasten und Maus interpretieren}

PROCEDURE analyse_mouse_1;
VAR a,b, vorkomma_hilf, nachkomma_hilf: Integer; temp: real;
BEGIN
 IF del THEN enter:= true;
 IF ((Xco >= 60) AND (Xco <= 90) AND (Yco >= 60) AND (Yco <= 90))
 THEN BEGIN
  flash(60,60,90,90,15);
  ende:= True
 END ELSE
 IF ((Xco >= 210) AND (Xco <= 230) AND (Yco >= 170) AND (Yco <= 220))
 THEN BEGIN
  flash(210,170,230,220,15);
  enter:= True;
 END ELSE BEGIN
  FOR a:= 0 TO 9 DO BEGIN
   FOR b:= 1 TO 4 DO BEGIN
    IF ((Xco >= 60+30*a) AND (Xco <= 80+30*a) AND (Yco >= 80+30*b) AND (Yco <= 100+30*b))
    THEN BEGIN
     Xpos:= a; Ypos:= b;
     change:= true;
    END;
   END;
  END;
 END;
 IF change THEN BEGIN
  flash(60+30*Xpos,80+30*Ypos,80+30*Xpos,100+30*Ypos,15);
  CASE Xpos OF
   0 : CASE Ypos OF
        1 : BEGIN
             gerechnet:= true;
             enter:= false;
             ausgabe_real:= wurzel(ausgabe_real)
            END;
        2 : BEGIN
             gerechnet:= true;
             enter:= false;
             ausgabe_real:= ausgabe_real*ausgabe_real;
            END;
        3 : BEGIN
             enter:= false;
             trig(1);
            END;
        4 : initialize(1);
       END;
   1 : CASE Ypos OF
        1 : BEGIN
             gerechnet:= true;
             enter:= false;
             ausgabe_real:= exp(ausgabe_real);
            END;
        2 : BEGIN
             gerechnet:= true;
             enter:= false;
             ausgabe_real:= ln(ausgabe_real);
            END;
        3 : BEGIN
             enter:= false;
             trig(2);
            END;
        4 : switch_reg(up);
       END;
   2 : CASE Ypos OF
        1 : BEGIN
             gerechnet:= true;
             enter:= false;
             ausgabe_real:= potenz(10,ausgabe_real);
            END;
        2 : BEGIN
             gerechnet:= true;
             enter:= false;
             ausgabe_real:= lg(ausgabe_real);
            END;
        3 : BEGIN
             enter:= false;
             trig(3);
            END;
        4 : switch_reg(down);
       END;
   3 : CASE Ypos OF
        1 : BEGIN
             ausgabe_real:= potenz(Yreg,Xreg);
             gerechnet:= true;
            END;
        2 : BEGIN
             temp:= Yreg;
             Yreg:= ausgabe_real;
             ausgabe_real:= temp;
             gerechnet:= true;
            END;
        3 : BEGIN
             enter:= false;
             trig(4);
            END;
        4 : BEGIN
             HideMaus;
             scientific:= not scientific;
             IF scientific = false
             THEN BEGIN
              SetColor(red);
              line(151,201,169,219);
              line(151,219,169,201);
              SetColor(0);
             END ELSE BEGIN
              SetFillStyle(SolidFill,7);
              bar(151,201,169,219);
              OutTextXY(153,205,'SCI');
             END;
             IF enter THEN BEGIN enter:= false; del:= true END;
             notation:= true;
             ShowMaus;
            END;
       END;
   4 : CASE Ypos OF
        1 : BEGIN
             enter:= false;
             ausgabe_real:= 1/ausgabe_real;
             gerechnet:= true;
            END;
        2 : BEGIN
             IF ((komma = false) AND (ausgabe_real < 22))
             THEN BEGIN
              gerechnet:= true;
              enter:= false;
              ausgabe_real:= fakultaet(Trunc(ausgabe_real))
             END ELSE beep;
            END;
        3 : BEGIN
             HideMaus;
             grad:= not grad;
             SetColor(4);
             SetFillStyle(SolidFill,7);
             bar(181,171,199,189);
             IF grad
             THEN OutTextXY(182,175,'Deg')
             ELSE OutTextXY(182,175,'Rad');
             SetColor(0);
             ShowMaus;
            END;
        4 : BEGIN
             IF dezimale < 9
             THEN Inc(dezimale)
             ELSE dezimale:= 0;
             notation:= true;
             output;
             HideMaus;
             SetFillStyle(SolidFill,7);
             bar(181,212,199,219);
             SetColor(4);
             OutTextXY(187,209,IntToStr(dezimale));
             SetColor(0);
             ShowMaus;
            END;
       END;
   5 : CASE Ypos OF
        1 : ausgabe_real:= -ausgabe_real;
        2 : IF NOT enter
            THEN BEGIN
             IF komma
             THEN BEGIN
              kommastelle:= kommastelle * 10;
              IF kommastelle = 1 THEN komma:= false;
             END;
             IF length(RealToStr(ausgabe_real)) > 1
             THEN BEGIN
              GetReal(vorkomma_hilf,nachkomma_hilf);
              SetReal(12,dezimale);
              ausgabe_str:= RealToStr(ausgabe_real);
              WHILE ausgabe_str[length(ausgabe_str)] = '0' DO BEGIN
               Delete(ausgabe_str,length(ausgabe_str),1);
              END;
              WHILE ausgabe_str[1] = ' ' DO BEGIN
               Delete(ausgabe_str,1,1);
              END;
              IF ausgabe_str[length(ausgabe_str)] = '.'
              THEN BEGIN
               Delete(ausgabe_str,length(ausgabe_str)-1,1);
               ausgabe_str:= ausgabe_str+'0';
              END ELSE BEGIN
               Delete(ausgabe_str,length(ausgabe_str),1);
              END;
              ausgabe_real:= StrToReal(ausgabe_str);
              SetReal(vorkomma_hilf,nachkomma_hilf);
             END ELSE beep;
           END ELSE BEGIN
            beep;
            enter:= false;
            del:= true;
           END;
       END;
   6 : CASE Ypos OF
        1 : input('7',0);
        2 : input('4',0);
        3 : input('1',0);
        4 : input('0',0);
       END;
   7 : CASE Ypos OF
        1 : input('8',0);
        2 : input('5',0);
        3 : input('2',0);
        4 : IF ((komma = false) OR ((komma) AND (enter))) THEN input('.',0) ELSE beep;
       END;
   8 : CASE Ypos OF
        1 : input('9',0);
        2 : input('6',0);
        3 : input('3',0);
        4 : input(' ',pi);
       END;
   9 : ausrechnen(Ypos);
   END;
 END;
 Delay(111);
END;

PROCEDURE analyse_mouse_2;
VAR a,b: Integer;
BEGIN
 change:= false;
 IF ((Xco >= 180) AND (Xco <= 200) AND (Yco >= 200) AND (Yco <= 220))
 THEN BEGIN
  IF dezimale > 0
  THEN Dec(dezimale)
  ELSE dezimale:= 9;
  change:= true;
  fix:= true;
  output;
  HideMaus;
  SetFillStyle(SolidFill,7);
  bar(181,212,199,219);
  SetColor(4);
  OutTextXY(187,209,IntToStr(dezimale));
  SetColor(0);
  flash(180,200,200,220,14);
  ShowMaus;
 END ELSE BEGIN
  FOR a:= 0 TO 3 DO BEGIN
   IF ((Xco >= 60+30*a) AND (Xco <= 80+30*a) AND (Yco >= 170) AND (Yco <= 190))
   THEN Xpos:= a;
  END;
  IF Xpos IN [0..3]
  THEN BEGIN
   trig(-(Xpos+1));
   change:= true;
   flash(60+30*Xpos,170,80+30*Xpos,190,14)
  END ELSE change:= false;
 END;
 Delay(111);
END;

PROCEDURE analyse_key;
VAR key: char; shift: Boolean;
BEGIN
 change:= true;
 shift:= false;
 key:= Readkey;
 CASE Ord(key) OF
  0  : BEGIN
        CASE Ord(Readkey) OF
         59 : help:= true;   (* Hilfe                                       *)
         83 : initialize(1)  (* Delete                                      *)
        END;
       END;
  8  : BEGIN                 (* Backspace                                   *)
        Xpos:= 5; Ypos:= 2;
       END;
  13 : BEGIN                 (* Enter                                       *)
        enter:= true;
        Xpos:= -12; Ypos:= -12;
        flash(210,170,230,220,15);
       END;
  27 : BEGIN                 (* Ende                                        *)
        ende:= true;
        Xpos:= -12; Ypos:= -12;
        flash(60,60,90,90,15);
       END;
  42 : BEGIN                 (* mal                                         *)
        Xpos:= 9; Ypos:= 2;
       END;
  43 : BEGIN                 (* plus                                        *)
        Xpos:= 9; Ypos:= 4;
       END;
  45 : BEGIN                 (* minus                                       *)
        Xpos:= 9; Ypos:= 3;
       END;
  46 : BEGIN                 (* Komma                                       *)
        Xpos:= 7; Ypos:= 4;
       END;
  47 : BEGIN                 (* geteilt                                     *)
        Xpos:= 9; Ypos:= 1;
       END;
  48 : BEGIN                 (* Ziffer 0                                    *)
        Xpos:= 6; Ypos:= 4;
       END;
  49 : BEGIN                 (* Ziffer 1                                    *)
        Xpos:= 6; Ypos:= 3;
       END;
  50 : BEGIN                 (* Ziffer 2                                    *)
        Xpos:= 7; Ypos:= 3;
       END;
  51 : BEGIN                 (* Ziffer 3                                    *)
        Xpos:= 8; Ypos:= 3;
       END;
  52 : BEGIN                 (* Ziffer 4                                    *)
        Xpos:= 6; Ypos:= 2;
       END;
  53 : BEGIN                 (* Ziffer 5                                    *)
        Xpos:= 7; Ypos:= 2;
       END;
  54 : BEGIN                 (* Ziffer 6                                    *)
        Xpos:= 8; Ypos:= 2;
       END;
  55 : BEGIN                 (* Ziffer 7                                    *)
        Xpos:= 6; Ypos:= 1;
       END;
  56 : BEGIN                 (* Ziffer 8                                    *)
        Xpos:= 7; Ypos:= 1;
       END;
  57 : BEGIN                 (* Ziffer 9                                    *)
        Xpos:= 8; Ypos:= 1;
       END;
  67 : BEGIN                 (* Arcus Cosinus                               *)
        Xpos:= 1; Ypos:= 3;
        Shift:= true;
       END;
  80 : BEGIN                 (* Pi                                          *)
        Xpos:= 8; Ypos:= 1;
       END;
  81 : BEGIN                 (* Quadrat                                     *)
        Xpos:= 0; Ypos:= 2;
       END;
  83 : BEGIN                 (* Arcus Sinus                                 *)
        Xpos:= 0; Ypos:= 3;
        Shift:= true;
       END;
  84 : BEGIN                 (* Arcus Tangens                               *)
        Xpos:= 2; Ypos:= 3;
        Shift:= true;
       END;
  87 : BEGIN                 (* Wurzel                                      *)
        Xpos:= 0; Ypos:= 1;
       END;
  99 : BEGIN                 (* Cosinus                                     *)
        Xpos:= 1; Ypos:= 3;
       END;
  112: BEGIN                 (* Pi                                          *)
        Xpos:= 8; Ypos:= 4;
       END;
  113: BEGIN                 (* Quadrat                                     *)
        Xpos:= 0; Ypos:= 2;
       END;
  115: BEGIN                 (* Sinus                                       *)
        Xpos:= 0; Ypos:= 3;
       END;
  116: BEGIN                 (* Tangens                                     *)
        Xpos:= 2; Ypos:= 3;
       END;
  119: BEGIN                 (* Wurzel                                      *)
        Xpos:= 0; Ypos:= 1;
       END;
  ELSE BEGIN
        beep;
        change:= false;
       END;
 END;
 Xco:= 0; Yco:= 0;
 IF shift
 THEN analyse_mouse_2
 ELSE analyse_mouse_1;
END;

{Intro}

PROCEDURE intro;
VAR play, click: Boolean;
BEGIN
 opengraph;
 initmouse;
 play:= false; click:= false;
 HideMaus;
 SetColor(white);
 bar(0,0,640,480);
 SetColor(06);
 SetTextStyle(TriplexFont, HorizDir, 0);
 SetUserCharSize(3,1,3,1);
 OutTextXY(65,100,'TaRech 7.0');
 SetTextStyle(SansSerifFont, HorizDir, 0);
 SetUserCharSize(1,1,1,1);
 SetColor(red);
 OutTextXY(394,210,'professional');
 SetFillStyle(SolidFill,blue);
 bar(085,400,185,441);
 bar(455,400,555,441);
 bar(270,400,370,441);
 SetTextStyle(SmallFont, HorizDir, 0);
 SetUserCharSize(3,2,3,2);
 SetColor(white);
 OutTextXY(Round(085+(100-TextWidth('Play Intro'))/2),Round(400+(41-TextHeight('Play Intro'))/2),'Play Intro');
 OutTextXY(Round(270+(100-TextWidth('Quit'))/2),Round(400+(41-TextHeight('Quit'))/2),'Quit');
 OutTextXY(Round(455+(100-TextWidth('Run TaRech'))/2),Round(400+(41-TextHeight('Run TaRech'))/2),'Run TaRech');
 SetColor(black);
 SetTextStyle(SansSerifFont,VertDir,0);
 SetUserCharSize(1,2,1,2);
 OutTextXY(604,300,' (c)  StefanH');
 Circle(617,447,7);
 ShowMaus;
 REPEAT
  REPEAT
   mauspos(mx,my,taste);
  UNTIL taste = 1;
  IF ((mx > 085) AND (mx < 185) AND (my > 400) AND (my < 441))
  THEN BEGIN
   play:= true;
   click:= true;
  END ELSE BEGIN
   IF ((mx > 270) AND (mx < 370) AND (my > 400) AND (my < 441))
   THEN BEGIN
    play:= false;
    click:= true;
    ende:= true;
   END ELSE BEGIN
    IF ((mx > 455) AND (mx < 555) AND (my > 400) AND (my < 441))
    THEN BEGIN
     play:= false;
     click:= true;
    END;
   END;
  END;
  IF click = false THEN beep;
 UNTIL click;
 Hidemaus;
 IF play THEN BEGIN
  pixel(14);
  SetColor(red);
  SetTextStyle(GothicFont, HorizDir, 0);
  SetUserCharSize(3,1,3,1);
  OutTextXY(71,100,'StefanH');
  Delay(888);
  SetTextStyle(SmallFont, HorizDir, 0);
  SetUserCharSize(3,1,3,1);
  OutTextXY(180,300,'proudly presents');
  Delay(1500);
  SetUserCharSize(1,1,1,1);
  SetTextStyle(SmallFont, HorizDir, 0);
  pixel(15);
  Delay(111);
  SetBkColor(15);
  ClearDevice;
  SetColor(06);
  SetTextStyle(TriplexFont, HorizDir, 0);
  SetUserCharSize(3,1,3,1);
  OutTextXY(65,100,'TaRech 7.0');
  Delay(555);
  SetTextStyle(SansSerifFont, HorizDir, 0);
  SetUserCharSize(1,1,1,1);
  SetColor(red);
  OutTextXY(394,210,'professional');
  Delay(1500);
 END;
 ShowMaus;
END;

PROCEDURE extro;
VAR text: ARRAY[1..4] OF String[60];
BEGIN
 text[1]:= 'Thanks for using TaRech 7.0!';
 text[2]:= 'Visit our Website';
 text[3]:= 'https://personalnexus.wordpress.com';
 text[4]:= 'for further information.';
 HideMaus;
 pixel(15);
 SetFillStyle(SolidFill,white);
 bar(0,0,640,480);
 SetColor(black);
 SetTextStyle(SansSerifFont,VertDir,0);
 SetUserCharSize(1,2,1,2);
 OutTextXY(604,300,' (c)  StefanH');
 Circle(617,447,7);
 SetTextStyle(SansSerifFont,HorizDir,0);
 SetUserCharSize(1,1,1,1);
 SetColor(brown);
 OutTextXY(Round((640-TextWidth(text[1]))/2),150,text[1]);
 SetUserCharSize(1,2,1,2);
 SetColor(black);
 OutTextXY(Round((640-TextWidth(text[2]))/2),222,text[2]);
 SetUserCharSize(3,4,3,4);
 SetColor(Red);
 OutTextXY(Round((640-TextWidth(text[3]))/2),300,text[3]);
 SetUserCharSize(1,2,1,2);
 SetColor(black);
 OutTextXY(Round((640-TextWidth(text[4]))/2),388,text[4]);
 Delay(2555);
END;


BEGIN
 intro;
 IF ende = false THEN BEGIN
  HideMaus;
  pixel(7);
  SetBkColor(black);
  ShowMaus;
  initialize(0);
  REPEAT
   REPEAT
    mauspos(mx,my,taste);
   UNTIL ((taste = 1) OR (taste = 2) OR KeyPressed);
   initialize(2);
   Xco:= mx; Yco:= my;
   IF taste = 1  THEN analyse_mouse_1 ELSE
   IF taste = 2  THEN analyse_mouse_2 ELSE
   IF KeyPressed THEN analyse_key;
   IF NOT ende   THEN output;
   fix:= false;
  UNTIL ende;
 END;
 extro;
 CloseGraph;
END.