Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Mar 2014 13:52:58 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: dwmw2@infradead.org, ben@decadent.org.uk
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	Fry@vger.kernel.org, Don Fry <don.fry@intel.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: linux-firmware: Add firmware patch file for Intel Bluetooth Device
 (7265)
Message-ID: <20140314135258.37e32ecc@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds Bluetooth firmware patch file for Intel Wireless 7265

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++++
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 0 -> 10612 bytes
 intel/ibt-hw-37.8.bseq                   | Bin 0 -> 96 bytes
 3 files changed, 4 insertions(+)
 create mode 100644 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
 create mode 100644 intel/ibt-hw-37.8.bseq

diff --git a/WHENCE b/WHENCE
index 7876548..5f8e303 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2257,6 +2257,10 @@ File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
 Version: auto.WP_1303_02_patch_0.1.54.1 (0x36) 
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
+File: intel/ibt-hw-37.8.bseq
+Version: 1339_02.00
+File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
+Version: STP2_C0_1339_02_patch_13.1 (0x0D)
 
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
new file mode 100644
index 0000000000000000000000000000000000000000..3177c2984b91dec69f61124cafada1e4fb29d491
GIT binary patch
literal 10612
zcmbta4R}*!mOl69Cb>!TbJL_hv}yY#{RLqu*qw)Um^D;ThUq9!Mi5a`sJnH>nWhRD
z6zxsvAIMKZoaJ$6v>hq5J0gs$^Q10nih#6(knm^P3I-4-V3i9NmUX*y&v$Rr1aO~c
zo@d+V<bL;j=ljlg-gCbH%WNFh0|Pv8Y@yM}nmA_TFd%&o01g;(&Bo{5ku;M8jb9nu
zlUv@<kjP6BFC`B10{)1X$LBtOzSkJaX(L2517FV!+h^|?wm0uNsBdNe>E*(pqnncq
zD5w2%%0>a7M@*ZBxhVfzQJBJK!`2j0*bq&UB3^5o)rYlvBemTJQ1jk&l<oec`yhSS
zJH#9gK=`k$Z8@pX|06riI}q{O@Cm7FJW%|W35uUK)3!}V-q}xv?ME-X_n$DJm3mLu
zepQJ)F0+(_43<&anXcl7Yy+OGeXWoxl7_Di7f^lz2tzUm!2hFaO0p-5-R`hyF4@9n
zAmB-7TVcSH9&4OZp~Q|?K^CD6%7WAGQ;U<7rboO*qYa`Bo;aH3-yOE+VR|6D)cU8K
zbm8bTP;7zx2D5pFK<iVHWOs3b>}-@Tx$RvjiM1f&orZa?lyf?FioS0NrbqfT#*3b7
zH|Jv79e7OlI=en~0j2}Cdpz*P#g!LVWIShlcEYYj$eUn}*z|p_e1pXFQwPLBI1*(r
z5)MVY7d>_4V|By^17%pC`h_Qw%2jZ>6*@g`e1|Y6F%h#@$LB!L3YGNtr^%+0RX`MA
zj<7BQVSSBOiqs0>NG*dTgaOOVMsjI7y4Q!&Ey>Uvno|ItA`dh`U%dceizwySn-)Ye
zJf#6uUj!^-J{RHM3`D#$vFw7#PQM~kV&2}hziam}-*+XTaJDhSBl@YIU7-eD3Cz)f
zsxB{X*q;f&7TD8-Z9j~0^*PceHAYf0z#mfp9!LdPng;N@On?JO|C|NjcVLrp0a^<I
zI*{H+Vu}Fn8xL?|BJw8z>_W<)jFtWfU>nj~NCQZ}n+^~{;(vm5BUK>1h-91ra2~1a
zL4Zq-0GJm81eXBZK$`g&K-v?iAL)`CJz5J8H{g4@;|^W^aMu}B2c?%kEVa?DjDK&b
zfDa%o=YW@x_9B0|8u-ug`8*4}K?D4Lq^(-)tvv8cbifzsfftf6&j`E+d$Cu*I+B5R
zrvkq^4byf^W1U{4{aL`b;B(iRvo{%tc&XPo8&~oa5t(Yoy+BAntL}#||LoBk4LPK7
z(s6<C3+Yo$%7&?b)Wkj97O0QtuhvDlq126a5zSS~XNZ5X^89ddTc9Q@UD%#tO1;0}
zh-Fs6M$7iBZPrjq0tiFY<RMe4reI?Zz-nGCKdbl<3hMJv?Oyba4Ky59eRE{wUNu#L
zF?YhA4zc{Dqxm=D`C>h}m!Cy21`_0skID^?jO5UIScLjG<}1zJ--YJjAhL9ed1wF!
zsn(4ga|54=gO*h?o8}6+rp-c*`4wSQY6_Jqf;EH=Z7Fc<&nHq?c?4jHd#`vw00+z=
zE<&|%<h8H$`C<+fzh_ARA&NeQAw^*Jw`ULN^Pwd|d}fxc+j{ok*DDqLOBPWHmfXKp
z@fc**<r(^Zl~vm6$*S9pp$%mPuq8t3P^Rd4MK<GkL;tU`>V81t)C-El+b^^QppRsg
z3Qi<fzAJ_DRm6MZR(>E^;UDg43oz$@?_T?BSa0NQjO#7muU*@fy5>%43(yqseie@6
zwM>vsOEKPI<Xs6+TQuZGbx9Duh;$@?@Hqw~48=^Ha?F;@@Ka854xf4V_am1#blEc8
zpyZY<nivd-6GLaiI{)HqukdL0G+}&jiTwK*{?5(zTIV4#;S7&b;>*(c+0$&!V0rcp
z>jIQ;1b>0~(5#E*1RuutoZv$IRZ9;eccEM|R*ssZA#P912$74tv@Vwi>oHdy7kxD2
z25{11{N2~3>Y~%ADzthWfyhfP4vI0nwles4$O-(&q?;otKLYVm4;=*<M#Q*hDyyFM
zFkU7Bgdp~I7^3rZ45|G_XUNt`o1-QtHirUqevCC{7#njXFagJmwbB1x(S3k6mLba>
zI*Gm+`YO5=j>mD~%9X&`1D|;S77jDvlp#|Pn#G7AY`JO(Eeyly&S$6whSb;Sf}J%=
zdLrBDQOx&xBHqIQ#de&bPhbld4g<v6AgUuTWrt>3Kvzy&YudWGA%f{o{Tatx>$pqG
zuWmpkSq6xO)qVOt*z1eI#!i{*p}zs=S~EZm%RZj~!hRg;U}*01=k@!<y%yjn7x0p0
z$Pk2n!wGluwq>r46Ue0_0%!nc6us1V<65M)4W|@Dd@o%_5Hl1zk&2OG4Ncd?!w)<K
zC*e%+J!&XRw$C;5^T56#34cG|b(h41?YnY<&{EJa&E4<Uv{NY!+4k$7RNd1x&3(Y{
z^a`u)Z!o{dHr%tc|9$AYzrE;LrKXl<O_Xh5BeayJfoo^N3P0Lz-(ZY7aiOFSF%h!X
z>^1XC!I{Nkr>nCnAbSwx1Q7f<zQYhKfnv7+#jTIV4GG?2$grKqwVJYC8@3<X1ARp}
ze=`^EHJ-HW_A2VhCcOj1>)#oDb&<p5oOtyb<Es!vIL*%!U$%gDu5Z0XrOot;=L6&q
zppu|}wkPdWzA<RYKm%v(SZiUmtdoH!yE1hRU^&KYvFg;|ct<PI`hn!lQ}5txsuIq|
zA~8sSWJEHRgya!{B}?SlK|?&A*-t=m3)&QOOsh8Tn4#*3m;l0CIKjaXztYeIeV?Fr
zs5%vKxrJ1VV2?TkA578B0}v;f89~+9lx9qe`1j>675wP8q@B5q7v=uXlGS|~&xwR5
zDbmzJ9DU&tMtSF=Df|{z)%eFI_Qn1Wl1#In9Z`*pu&3t>Vrv#IZDZxDw3_H6$P**I
z`E3H%D6HtsHwpXxbNdb^?8s&XAx!XhF-qj>p3G%;)L_aOHOP5ca-NXwvZ*AJT`JEE
z8nOtz9Rr|+PXr*~%kV%r0fbhZ;bG_=PtS8=Aup`WVOtE1MJw774o72CDx{V97EyC|
zO!W1PnVZzuik!*(Jn~4I*iy*9!cJ<;MX2Z+?-8s4n~lLI$m9OvG+&Fey-0c_r*vzq
z2ESHMn~yS+!UTVrFx4B&?a<ny^RZqBLZnEcktjtPm@wNeI%XN5lgcZBy=ZLktkT5|
zjaCn&*;ZzF`cJ_ZU=vAX$GIJfdk<Avc!B8AmIM&C;t~gjXm9mv>!bHP$4PS>uDfW#
z=lJCSr=MT(X)uM%S3xq6q^J`1el7Ydcj;Z$BnzRE%!SiNt|eE3WQP2MP9P5xxNBDP
z#!JnXQmt7(p9=^qG3w_5C+vgzOO|GR6tcm_WtZBVI}F+TY+8xz;P82F$KczFX|4n>
zmgwWgN!6X7Wq5X`C9i}quGV+5J0V#lih1cz(ew;{0ZdrY8kER`DyETk#?8^G1vEBm
zm`C|?2&95wMHlyY5<qCiHJ&m>vc$l*MQKIMg-_9_3JOBs=3|nx6x!-4Qq~B+`}#=T
zu7)k&9<5`^n%w^X_>W~x$wsXsX{O4xlL-ehaH%W>Ff~q!<r|Yy)XdqBbeyP{re(Oe
z*~`Ve1F2vywYhdeQz-$lmn;Rv@VN<w+mqsk4_D7#QPJ>+?h5M~fc})EdEjn%*J^?_
z-!5FkoLl(j2HiX@X?WPd>R*q-nImlj|5h{_vj(0tSfT+7Kqi`9^o;1_VR5o3`Xc&p
zZ(<~@#ziiIz|>^0Vql!8%91kI(Xh_^w<a8>?&9m<Wsk30iGb;^kp>7Tm6_Tg{HR<8
zF~+CpQ1h0x%lP?F;Wv9Nos*<LMi=T|)k1?(*1*3Rjio!ZzmHDGDRX+r$Ug(6zUe_`
zz};cJ1PxYR1XufvIz!!zc2&Evj%zoprCosyo8MEq2EkE3#D|h51&J7F&|Qpq8Dq1c
zOxS;2>0q(0<=4JE76%Pckh|4v2^z-nqADR0JO&Cvpxx1E@HwbrAJ;xwkvvM&VDGe|
zX_aY#mbK9*@vR|BLyAsxN?*;DXb&#O9voBMq2;1XxCZ+zE$zV4iX`pRM(Il&v5P99
z*nl*MX+@i2;veKOUPG#I;G*TP;+`!wxTPE8(J@s05OxdL1ZOf)@6SV1i8vYekPKO?
zK;H2<Y#PTu4lzFTG5tyo_p{O<h^lC7;_Og~TOAmx`=)2b#BW?_mX%<sBRTr{FqN*b
zv0A1tRv7wV90u^F6#j80maF6y{R}o`@vq;;o%u5e&%mt<Y|7+chY7(6p}USjGuiB_
zQ%dc5jMjAq3W9|p<oguv*2m=DzB@y5hI%We5}#}w%~O-A+7yHy!pr;i^y>x`-t<=>
z%VlG}I{K2)bX-V1dGbYQ_%fPu5;j;+mddDz<b$kIn=UMp0}~*fB}(^8h=fHZ3Id%@
zeuImh8l*6KCxFj)koF+Gi{wYzi?p4lZBYCj%EVTf;K@G;4Q<`^xMN=sQJUr+RP`CV
z_?50ep4Y<90A(SgCM`Eoq>Nym!0;JCmuS@01M3h$E18_4c?AEaxs&(>jPFC&!J-e#
z3m8j%*UNJM2Huv9rvkU=s2pqybRXzGsH_mwWbaWWX6PE>M6$em-pl0zk0(cFcy9p!
zjtz9tH!||#Wf*tMR=Nzg955sc?#+`0<us4QQIKM$CR?v0E}d87K~oHX;p*H|(8!z?
ziB8_?;@0*W8&;OVK)4e7XV9nFX%Dt`sO0q=<+&PNgfY}-q{Ck_76H3cfi2u>4Vl8a
zevmy(x6G!|67JE>^ZrYn3Lxam(pa8rq2kplbYcVz--~;Pj>AyA|B`xa8vvfRlY9ft
zNN0L#Sh-WEN%+M>?Fo_K!W};hX;6sii;F;5)BZ2$U-Yg<Cr^w(T1wCtef8;!Mn`kH
z^o;e_dLa(Xm(`u!YeVZk>-O;$0SuND5G)q3S*!p}JAGR*USiQQCl9M?`UmXQThU8Q
zAB;A!Y7m;#_!gI?9OE6Fhw>TWVX~fY#yY{yrho|j+-NLT4N@%(@%~bb1iXP&=WvG$
zWdF|}Dma!}c?wSJr34U4aAyERlGCM{BX48Wq;inCKpGn@B7DOyTk{J?DYx)s>Z|4`
z>wAa<3-oa**;8t==duZNp;5_IiHeDpgNpBI{%kt0<2r*vsz`PhaAR`nv3i8jROD@?
z`vCdenfj_Js+VUNAQ9i+Ww9v}v$zzh1BlycdQ~6IMxK3)H`m!bGB=+gd%DCfXl&^M
z(LM@G<sdXpr~z@7qg!P|UIGY3c<w_NOVoH*)2!T&bI&G=aDQ(1T~xR}dIsOtM5}6`
z5kw)OIuK+2guYpUhJf5Gp38<tb$2We)uQQ&T=Y2L!kms9>$_+Z6pc){GoS?YG!G4B
z8q#6h0@FSnMv6t+;pBLv4OVw__l7t;L+lL^pDWLLce4eLc}{<F%-tNQTlO&{)MNY!
zV6?MS&NuTIh0bRFqyMTf*=H7CXr7!u8y9U&;F_EOg54^2hh!)?$V@J1W(0fvl)pBY
z=G8MAEPBH&ct0?_$0XaiVppMd`L#lhu@!0=Jo;iZFdz0o3pkihp>z_<R=mIQ+yd4J
zu0qwb*K+G%!3*$$84BR1;AEVP3taM(rj`Gx@KdsZdmSgNr0DNMJsxFqts&$$7Cdr#
z?H11epp}2>(~+OUtGDnkAb$fwVYt{5`YAE05^L$fymh2ltpFZ5wJv`otzRm4bc@EJ
zhEVI;1P}xp1wof@6cQ^qEM?(dKt$2oa{^MPZZkap13B+VZMu-S;s<heNc+AXZOTw=
zaQoajK_2GR#68G-@epCOvG>YBy0WK{;vS^@*jwe`6G4-Wnc~><c(AoKPLYnsgOQHq
z()wIh+<5KbAkzYGC)<oujvLE`D#>@g{@T3Y!=E|#Kojkb-Mj!bMghu$2_SGO6oeh`
zbk?+X%*RojQd`G7RKwM&#>P@;>Z}n-l3r<?cpaLUK9S(QS8gnQkLOl?P2Xa9m0!pD
z{OZd^k|G~&y$AjOkn@K}2AkA&{%}E?*o(uS=_*)7vYwQRMc14`jn(L2TXe=}1bCY{
z{bOUYps|7@%c#OLD-essPS4b?-Y%*`LxLXW3)My3K81T~dY<Wgw!DxN6z!bU>FK~u
zm;k~J83bBvHjehgqy3Tg&nWiEnR_*)7-<nw`Ue`a_d^YtPM=8AG0o#V%vqtBM=~Jc
z6i_T6(Z0RH0L9CZRwH?l68remsqsEOT#e@wf5P*McjgoVXe3wR12DPp6Xs1b-bD1J
z6b6{dL@N|M>#qsdY^y2qSfn`xE{J@vub_^xBqj5IIbrLELPq84Wctosq)Yy8-r4|!
zWsjbFSKB+X|I|aZ^PNU;e)R1>b-(}U^NU|9FL<!Uel-DvK|BnHp-fXyaOKT}$$46)
zEDwCWj;G*{#_X14i9KKa!kd^X%Lnmrfm7tJGRR^2wGw@<!5rxKKl9NQ&c@^6hPH$*
zU%Ee07BDLEqi}p4KYQTp!5QO^0KeksONZPru&>LUdmo&BQapEn?1O`(8?PF=<%_ZS
z)Z3gE2kS&NC*f2G!#RQPUJ22m4-e_(O)*^+etBq9nsp_=0x&k_I9=ok9&d+m1#Ga0
zq@2G`WwLA}M$0DhfO(B|oK$F@FC>5v!P@{B8ectm)oV3M?^6+SNE_9A*404&sga5g
zcE4Eh(dAlN*}Z(JD#=_f9QkV2b^6}Jm#(29hO_;JAA2;X@z&_V?iYV-EVn8>UquE#
zxq_!kOxPwJ`D)p91{b$_PmeswQZ0|7mLAmdfvn~D6$oeIo`I9_+?klYzR0j@JiPC@
z+h`$|b;2HMo&`;NBxq=!>|lvb_lk3lLv+SkE%fj!=Qu@@E`7|$r5_9$gw3GSS@Y*O
zAU`Ji<)JcX0thG4DF|XKzp}TWf=pfcOGXbG?1wWyv*8A&cLgVvuGszJ(F^mDpMuR1
zFC5Ny{`SGo59hP541M?G6SiLiv8hzn05RAYa#E)f^&Vx#NX<MKrPpou@o~=LC^cpm
z|9IV^!a#bQ|DY^c2XW3!gs8KI>GzIM@N)VLb{D||`V-rpG#c+tAsyPB(iWp}zC~v&
zPvzzGmSmmrl{B54K4#S!kEiS9baIN$Xw67c<Wo^T(}3v&5Dtx_AQ+8X(y#)%5i_S4
zkEKsC9?wdaBHqj@DE<jjGscVUpP_gwrfpB*^7H{HK8)`sMM(xK$uTQRGP^I#ye`P;
zE%t+$w#eyYS%1NFvLc@o#IzODQ&;ZM{AJ{?re!t?%@=$QOW|~pg*Yl4$nV8dOvMFn
zgC4B6x!}9+65;+PT9sy&I%^crX?#*AR74l086?F~8a)1aM27lfHHA6>guNMZBw&$X
z@0)x`q>cI4JN$It9e#R_7ew9$L}T;G%ON@*FEg{PiuWwC_sUJBTU~_<i4~2cM%`=r
z_}a+G^%1J$qJQPpZ%p^u_N1AwZ^RAv20VsarBgxN@T$MTaB6a5^qi008efmz5sBra
z@pbWL0tkCDDF`&+{so)-BsMGF1r}j5?(71I_z&KuwDJz6OGcFjZ&DqdsAKBN`CRWv
z?~0=r=HT=8`o~>OtbcR#m%(@kNgA!|1G%oLEA?2OM#|?nEGuWuoXw2Gvw&nlN=C9G
z*^p9@QjyY-(vilMB!I9TuSj7iHkuzhN=I`QS^lXqs;4Jxk`CMBBehh$81LgVo})MN
z_dJ&-^~lQ`74dvhdcsB+_<L{Ws%;g@ZbU`Of_U!ZD9xoX{K9nHqDXUOI=`NLyy@C^
zvG=F%qDS>h#c!@nIX3k-C9B3SWlm?}qOF~uEB;+DUYogg;EIdPB{+5FeRf6rO&NjK
zhhaSQ7Ct427kUdFLhjW~mt#XVJrc^krL?;6A=~BJ1Q532-7s#YNkH{~p-BM>XfKZ5
z4bAn?o29mZ((Aa8;iP_-lAah!+Qo0s?dm?DK&l~L&)qnN)Z*ANo)V_%m@>x+mN~hi
zMS=NgAHFBg$%V1^vj>iPG^FJXyqq4OsjY7mjf;RwT$gW2KI#zx?*lU2s;UeEM?JXt
z&wCnEm0^+*0XwF+a60}%xCpQ1AiUY{8#fK;_b3rBz1!aU2JzYD3%gq`U)E<+5Ml!9
zqXMyaF7_@r3%9C$Md@z5^HZ7$A`^R;6}Wt}@g|eBmf>%tHm`$z%y9Mqt_x&SK%9%)
zcKI$#906!oZD=I_V=gVa>BDv52E}hhGhml8y#kp%Ln9sa>^gJ#Lugk3^Lk?Knr5MT
zRL!)8NbLjuTlFmYoAe|^0v@6v2!D&>nYSs9nRY7>#7AxePRWl+vwfTlBYI{zyn$yu
zew+6-H^IGZftR2U5#R(q-QyN`i++%=UR8vb#VB7x>zR&60_*+LQMXG@x#U*F^EUW5
zj^*z1zwLL8O8{Xxp&;C@yjWIVe1~$%SFb8olqWQHqAWl04tdH~ubMd4*om^y#SRb^
zW0m*U+#pLJFdk}<fS!yQCn&}w=$a<$ns$e-5}9A}gM9U>k~`X*078|6f<P-)ubMX2
z*u2{so9Hq1D)Pf}V;-4BTujU-B4Vz1=MQo!W*qfg{g`jI-;uXn&ZEbAac?$`$?v#B
ze#Z~UZ}e{(EAh5}cdQHoieraA4#N9OaLWYm(vTeUMgr<(GP-4VpiBAcRb>ho&p>e*
zkYpd!u2V-JU*}yq&CN>FmPKlve)KGU=|a%6>&Yx%q_&zQ(d9pG6aN2yaU=9tnM?jy
z5E7aAEyC?z5bDctX9#$i3w&HsCl^=YM;$TV<l(tv?VB`(8M$e`IWY1<6XW_mgXnn;
zuhwd{_~bPD?K=NqJqJu6$;QLa@nX%NR5|X@?v9F}mV>0ljg8!W|Gt`jk;9r%YVt5U
z!j1#RGK?&$%!1!Fx`$We*A!oD{GuN}w!+W6KHA@N<aqe>xxWrxxsLCH-%3}9uHX26
t_$IKNhS#h7NidO_YRh1NKnnvZU;t}V#ozFIF%?>fsQfJt+6?zF{4a%7319#K

literal 0
HcmV?d00001

diff --git a/intel/ibt-hw-37.8.bseq b/intel/ibt-hw-37.8.bseq
new file mode 100644
index 0000000000000000000000000000000000000000..9cf142aace9d38b8d18880e1cc6d5f63488455fa
GIT binary patch
literal 96
zcmZS7{}aFf1G<Kc|Nrs-yZyhqozdZ!lmZtA8wV>pJ3EkOVdGlDx#J8M3j^Z;ZV?U!
qUj{jb9o#9BC)Te>yui-Fz#Y}r#^SuW24oZyKTwtaAEy6Ik_-TFCl?L?

literal 0
HcmV?d00001

-- 
1.8.3.2

