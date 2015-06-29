#!/bin/bash

set -o errexit -o nounset

sudo apt-get -y install python-software-properties uudeview
sudo add-apt-repository -y ppa:landscape/15.01
sudo apt-get update
sudo apt-get -y install landscape-server-quickstart

cat > free-license.txt <<EOF
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

{"licenses": [{"license_key": "free_lds_license", "expires": "3000-01-01", "role": "BasicFeatures", "seats": 10000}, {"license_key": "free_vm_lds_license", "expires": "3000-01-01", "role": "VMFeatures", "seats": 10000}], "licensee": "standalone"}
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVkV37AAoJEMsdDiFHqi4Y1rsH/R1B3q+TObUVr2kvH111PL9s
EgdPCnoLw0v5VYSUIt8kmEPfjvHMxBbmtIEoyOfdcsXhBKo0ouSWF5oo3BldOsYp
b7RXKtKoPzaGd5vXO9oUnsdqhj2rFBR35VlcvlGWDx+Ej++g4g7BUvYaBD40Nqkb
/YA3pKsnjC7GmvkuSZYHBlGZiiULvzxtvt9rDVXf45OgTi5x43OCCG7bLSZN3zNl
kRzHlloJLybnq4WhiMd/Gfzh3jcGAkIKhdzzgugeQxNso0m9CjFDFtceniGr4xu7
PMcxvEJDS3ataSBkSbfOPTRmDxgdA53VV5allHaF1Nf+/AFeeO/AUMn514meZ1c=
=gdkQ
-----END PGP SIGNATURE-----
EOF


sudo cp free-license.txt /etc/landscape/license.txt


sudo sed -i s/35338392CC7AF15C581DA3DB72A66665C5C88EE6/77B3A8FB39CA839904037A63CB1D0E2147AA2E18/ /opt/canonical/landscape/canonical/landscape/model/main/tests/test_license.py

sudo sed -i s/35338392CC7AF15C581DA3DB72A66665C5C88EE6/77B3A8FB39CA839904037A63CB1D0E2147AA2E18/ /opt/canonical/landscape/canonical/landscape/model/main/license.py


uudeview -q -i +e .gpg $0

sudo cp pubring.gpg /var/lib/landscape-server/gnupg/pubring.gpg
sudo cp pubring.gpg /opt/canonical/landscape/canonical/landscape/testing/pubring.gpg

sudo cp secring.gpg /opt/canonical/landscape/canonical/landscape/testing/secring.gpg

sudo cp trustdb.gpg /var/lib/landscape-server/gnupg/trustdb.gpg
sudo cp trustdb.gpg /opt/canonical/landscape/canonical/landscape/testing/trustdb.gpg



cat > server.crt <<EOF
-----BEGIN CERTIFICATE-----
MIIBwDCCASmgAwIBAgIJANZZDI/2rBU6MA0GCSqGSIb3DQEBCwUAMA8xDTALBgNV
BAMTBHVibHMwHhcNMTUwNjAxMTU1MTI5WhcNMjUwNTI5MTU1MTI5WjAPMQ0wCwYD
VQQDEwR1YmxzMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCm/H3XvvQQFB5+
kIOMvd6+Ab4fg7Q3xw8fFFyQKSEDcFJL/zcCEfOcgJYt7PP1Axfw3wtMskf8eIQD
IhCGMghSJO7m7x2nyzvaOVjGMHnJrPwIGGvnnFQMAgvWxPVjBoSt3J0Z3ARogbjI
lpl3nlOUkQUEBt3XT1tRnXqP1yeYRwIDAQABoyQwIjAgBgNVHREEGTAXggR1Ymxz
gg8xOTIuMTY4LjEyMi4yMDcwDQYJKoZIhvcNAQELBQADgYEAAOKD1cG0n7aPX3OU
/zb0iuWJtviYYwo6J0SyT1tr3Fd7q7on49Z2bsHBnuKKXFuweClRjq6CKtq0Znmm
nJArADwRG4jUCAsp3jJMoXi7jOwYUAYtIg6K4ma/D5Sc90tNaSj08tQNajzxKpym
S8ub083sx1kmE74+w3tRvZ95agg=
-----END CERTIFICATE-----
EOF

sudo cp server.crt /etc/ssl/certs/landscape_server_ca.crt
sudo cp server.crt /etc/ssl/certs/landscape_server.pem


cat > server.key <<EOF
-----BEGIN PRIVATE KEY-----
MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKb8fde+9BAUHn6Q
g4y93r4Bvh+DtDfHDx8UXJApIQNwUkv/NwIR85yAli3s8/UDF/DfC0yyR/x4hAMi
EIYyCFIk7ubvHafLO9o5WMYwecms/AgYa+ecVAwCC9bE9WMGhK3cnRncBGiBuMiW
mXeeU5SRBQQG3ddPW1Gdeo/XJ5hHAgMBAAECgYAqJ1MdQ3cZF/sauCB9RvETxhzY
l8bGzdljXyB+w+MxmwkrZiHcw+tbdppyvX5YO4+vnp6bneXONh4dLFw/hCHVMjxp
0F8/EmTyn/26ip9TyvBxhz62mQuBgt4xv6gZRG0c6aXDyqnyjVZorzYFEOoiitdZ
VmWJVcCegpZ8D+FmAQJBANjDNJt0n+LYLOIOuPkKhybidVcmjqL96hUDW1Ko44sh
lTYakW6wqf6f/DWcvc7BBzpCwb6KcRkO9yqNEZqo5E8CQQDFNqa9fDokPfeKCcPN
kHXcsChsWLE9ovedUPPN/9tjhT3uRG3t23ZaWs9DTCIu52tX1/tC5XoXcawZ9+mW
p3aJAkBnC21P1YJIgYHcuSj/4xxaxN8JXiACpfiIor7gLb92HbHkNX8bgspdbEqm
ZevphOPds2yNGx0mz3F6ffN3dYCLAkAga8mhoQiV6LIHOW+9HaCitTsQBMyui1oV
vLc4CHXyuHbj8s/3qHqehAtKzvtXpqfY+yLNbphRvlhCtKTsJX+xAkB5ThEL+N0K
wtQmxd3MBuWXgboSUPW6ebgCXPnMHFOnn72AF32EzQnmvmT71l1cozyupBmdjwZD
ckuDMnz/fC4Y
-----END PRIVATE KEY-----
EOF

sudo cp server.key /etc/ssl/private/landscape_server.key


exit

begin 644 secring.gpg
ME0.^!%615X<!"`"P^ODSUH`53B:'.KK6<\;`I#\PY_.T$%KTED.TEYMNJ]`M
M:<LL-$JMUH(H0SJH2^*C8I]!<6=S#FY2>XP3C0N6^4JIN+L(H<H5#C,&V_]]
MTG)AK"U)6%#&89^H1>)^9`[?QP%:@9*5F\!SJQ@@M!:^`%$*N/MY"4D61,P)
M8U\"!QAH1D,M;4F>[S?AW8C@X9@T].[F&K7')D9.L+L&.Z2<Y;Y'8*!Y1,BX
M^32OBH00W]W#/5V@Z`1UH7N0(DGTXMQ)JQZZ;V"4$!@35.%0::%__B6/.)!I
M-IE@E1[5)K[L*'=`%FE_N9`/:;4[:O14NO)E/[,^%M&>^`.KF)-Q#$`G`!$!
M``'^`P,"9H9P_<3>`"]@&75CJ(GI39-'WF]QZ'S>B12NIX6@`NF@4P_(U84(
MY.C5'CS*H*=HKT1$^WE/;\(%;.TLL5-8@0*0THV_2$``W*B(8/3G$(MT!]Y2
M!\.,3>G:Y3ECTPV.`(>)1O$*0'X"70=/S8V%.G/SSF0%;6&8P/Y97<_M$7H`
MV'Z,2[PZM!Z+``1)@NT0LE=ZYY(KY\,J*I1-8*(+S\J_,\'JY:B"*ZJEV)OR
MX?9[&DN#\Z>@JSN;(GS,W/_+[B=*("KB"UZZE55#V*JZJ@'`DE(T0UZD5K&;
M9?-64N6F._C2ZEC'!2U<&LO!QPF^&Y3)R4";V6T:>Y_"GI6@B4,2S<LY(-`$
M9I_*AEMK_J1265\671OQU!2"JGE2V`P].2[IEO9[-&@&E/2AI54!)GL]KJ,)
M.6('?.,C!/"F.[WMWUQ)KOD\XA00T'HK$7XCIZ77"Y$%>,PVVDZAC\U1$Z]$
M5\![;LR!/0BY7"S/(L]OJB\I-#J>_P42T$[.736DOBQ(*Q@F62GSD0'`UZ'G
M))&T=X"]3$`]BJ;>]H[:7U7DTMF^%8I4'F`/\(YYBB`HG>`@C61N)H*_@^97
ML*W!B)D$G[4<V^L?:243O!?@+6;IC/F:0V6K&/6%K[BZ]91*7SN#SX-K.ZD4
MJWQQR7_X"E;KM$4OO)VQ3'#.$%B;A5*3XS/5R@HJAA=QVJ+51_B6\@1+U-?(
M(3%#+K]],\\.(W.L185IFA-URZ-0/GPE[I-P?I%6!/LJ90)J>8Q%;?C/DTRI
M/_VUFH'__8CB]?":#;S4M^T+O(;_=P5PUICUF$VSF3G2<.J@:QSJ+U&^?42-
M]RL6T^B`Y[F8\B^1"SY!T'"UR2OU5G!C?=&]N]][$5`+WBT1YY9JP1IEUCH<
M@;NY9@PG;IR<A8P=+6"*T;051F%K92!,4R`\9F%K96QS0&YO;F4^B0$^!!,!
M`@`H!0)5D5>'`AL#!0D'A,X`!@L)"`<#`@85"`()"@L$%@(#`0(>`0(7@``*
M"1#+'0XA1ZHN&.&K!_]_2#M6#7\'[=(7VVP@U@)%V:4P8#^N?LI>/0/\=N'N
MT\#5!11!#)UGJ\?-PDQ^\_#V3-K)55-+34G9\H@QE+Y6=FFJ<IO9\X"S?R[D
M\5BI]0SG::J5'[1>SVWU@4,,*N#XE6J"0&/PM8^.EA;[EL$3=2`&V"^N\<"+
M/MY:<]<\L8*54WVQ<38^BG)Q-S.U'N&&F2AD"1M2#Q&7"BYP^=1S>$#>`1=<
M$R5F6!Q]E8TCIKT^FO&([?2@6N?U((2N=<>@`3.L_55:1RZ+8E%YKB(OWQWH
M?"QYJ->,@]YB`/H#P+!A09*DVA`];T1NL7V;Z%_<;37Y@0%C87LM&Y2SP^M5
ML`(``)T#O@15D5>'`0@`P9B+;GYQREJFB"OX?+'00)3<M:LJ*-<4[7E:]`_F
M-7"!M,\!).G3W[*%?)$M^$.K,M<AQ=HK,#Q3;YAUW=\<'C"TM#X/W;>6WE(2
MQP0A7Y#R([&B-7E?B<4/"/I:"4)==-&4JA=9O:8\15>H0;%'P,\JNX7!FHV)
M:%JP2*725T@**NW&-VFPXR)@<.4^.*J0V-0>2;Z.`AZ\31)$&5KT^2W>]%XV
M!27A"41XR*XH7JL@;GI:.3TL^$JJ%^YP2K;R2GO>U--S*8SB1KX`:)6H27$<
MI.P8`$NJQEB:9J!8X;!(9L?MX((83=L1((Q[(R@U:)N@#/,4W)I5Z]OY,QTE
MLP`1`0`!_@,#`F:&</W$W@`O8!H++J])G!0V&6"\6.[#8@%_T,:Z>F^YN(<>
M]4+\/0LFIAT_[^MD8+0"'G9[*8.8&6B&`?S?N3J-8/3BK3T'L.C:GDE(TB40
MIY1Z^$>.Z/Y>(EQ][RIBA]N'91X9?PHEYZWUO9IZK*ASJ991/Z@=V5(.]-'4
MC;T$V17T#ZO42W>[QJA@4Q):03*E(F>\QXM!DQ0VG+5$![C**H.%[UW+.8+#
M9;]/@5!9V?*"9&"!)9MM_?0PS6KV.;PLK,+<"S)-;*5)R@)L8$M?.*`:I@T#
M!F=1.VL[G01L!%"_;"?VU-Y4Y(VR)8_R.8"LQO$,Y;V1YVGB8_R[MO>O,;$6
M)C#]&".GW.+Z542R;9_Z]>LM+8QD8I/[(=9L/L^G=I-T>YNG5:?:.D"0MZSM
MQMZ/<][;_//JN0LEXTV:Y@,%'FA:=VP>H<IV[-.G8*IN($D6.C-P^1X4>R$9
M=3+UX0\YY-.;0Z_S=.NY..>H+O2/30@Y""];/DQM!S\286W:OH242`+)CI?\
M;D-K1)B3DH-ESUT"&UIND)58ZL3\]E@MAZ_!Z;W>,=7^_SC&;+A$8?N%>)`F
M1;_%4X#2\?M_'#K/&231#5K8%@!`A'@/<$QUEZ^QKEF(]&72IUU'P0(!;"C4
MAD/0(@(-GLYDE5F'>CN?$<01G$/?<LL]X<U>HDS*/Q4:9KND7.#+[2+E930L
M6.JT5TSZ0W`WE\]/X4H#AWR0`L!\]8+F5E%]P@X'"W(D%LZ/EM[B@,Z%<C&W
M_/42FA,$8`#\J@!5Q8KP%#40U3)(<=L\[B1CS;^`0!O(ZB:0BB@G/]4;R?:#
M@!=94AQ,7S3]]=G/Y[\^C3##H-B#GY"RQZ<*2"26B=I'K0FW2BV*KG*OT*'[
M'@-;8!-E*E9@>*4*V,X4NCR0B[V)`24$&`$"``\%`E615X<"&PP%"0>$S@``
M"@D0RQT.(4>J+AAD[0?^))E&#Y_<ZDUN54D@U+H!N-"*D27R;0351>2XUR:4
M!HA/C>6.68VSWWKZPYQS8\+H-T)RVE5G9%[(OZJ=Y;@XF"N?))X1R[E0R./7
M)*;/DC^7:(DVU8?G&"5`#M1OJ0C;:N=G!",#S)?*<F-'JA^9CDNQ!.49?K(V
MR1-?=@=S[8S]8@Z;WF`PJWQ;H"?N//$%:0#__]_6*F^WG(R*:*''N6!/&[GL
M3!7]5M7V2%I:M1I$68GQ!['G%C=G\O'5)JTNQWPK((1>-5LG51SQ-W;L)LXS
M4#(GA\"MF?N`6*\(!K_,!EY/ZXS.:=Y_."R-B',Q@?LK!$4H2"*C`03X(PQ?
%5[`"````
`
end
begin 644 trustdb.gpg
M`6=P9P,#`04!`@``59%9GET6)8<``````````````````````````0H`````
M```````````````````````````````````````````````*````````````
M````````````````````````````````````````"@``````````````````
M``````````````````````````````````H`````````````````````````
M```````````````````````````*````````````````````````````````
M````````````````````"@``````````````````````````````````````
M``````````````H`````````````````````````````````````````````
M```````*````````````````````````````````````````````````````
M"@````````````````````````````````````````````````````H`````
M```````````````````````````````````````````````*````````````
M````````````````````````````````````````"@``````````````````
M``````````````````````````````````H`````````````````````````
M```````````````````````````*````````````````(```````````````
M````````````````````"@``````````````````````````````````````
M``````````````H`````````````````````````````````````````````
M```````*````````````````````````````````````````````````````
M"@````````````````````````````````````````````````````H`````
M```````````````````````````````````````````````*````````````
M````````````````````````````````````````"@``````````````````
M``````````````````````````````````H`````````````````````````
M```````````````````````````*````````````````````````````````
M````````````````````"@```````````````!X`````````````````````
M``````````````H`````````````````````````````````````````````
M```````*````````````````````````````````````````````````````
M"@````````````````````````````````````````````````````H`````
M```````````````````````````````````````````````*````````````
M````````````````````````````````````````#`#1QW46W7!ZA)"GH\@/
M/F@7.VA(I``````````?``````````````T`#B>4>Y_`247'Y"%QK?U]`L9(
M4_(````````````````````````,`'>SJ/LYRH.9!`-Z8\L=#B%'JBX8!@``
M`````"$`````````````#0"\VAY$\G[)!?MSPP0$0.,G7MR%V08`````````
*````````````````
`
end
begin 644 pubring.gpg
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
AVLI7FQ,E@V%]I6&/H,^BP,]:J(H-'S<0%MXTK;>P`@`#
`
end


