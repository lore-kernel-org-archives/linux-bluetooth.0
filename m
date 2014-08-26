Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Aug 2014 16:10:28 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>
Subject: linux-firmware: Updated firmware patch for Intel Bluetooth 7265
Message-ID: <20140826161028.77b7b819@han1-desk-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch file for Intel Bluetooth 7265

- Fix HFP issue on EHCI

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   2 +-
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 18017 -> 21775 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index bd65d8c..1e703b5 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2311,7 +2311,7 @@ Version: WP_1345_01_patch_0.0.10.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: STP2_C0_1339_02_patch_27.1
+Version: STP2_C0_1339_02_patch_31.1
 
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index 1241f5334a04bad765b28a20bc94d42bdd8ff36c..03888a853670a315db2deeeccbdb68ff04efc134 100644
GIT binary patch
delta 8996
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

delta 5271
zcmZu#4_H%ImOt<14=;g`0QrMJ;06-puS5kzK?ulJM6^)ptm8T^c5O#jw*;*=wbg`(
zmUb1<YdehVbfCjj>>}Df+YjgK?gq!!Kf^ahi%w9n&sHr~{TiLDbzP?Jc`q_NcFXr2
z?tSO{?z!ijd*3<dW%v8cwVe!M+Q!tt00(k*swR<*mLmg@9sz&_LM?mj1#X@hOR73L
zmehK5;B($R@EPy&Q~^w9s#}wAgaEwX=(l<-?`Ir?BWVf(yZ!QAyU*pI%#LK;^_>5w
z@f9B1t^{YZ2llYR9e#c*@3Nw-Gv|=A#{@y%t!T}_XEq1{K}K-?wyHDdb9E>C!k!al
zZi!(b(J+9#ZG?EVz<Fgwh#oi@woPsEq{snu|84F_F~X(75{ax5=K!ml1rPFtxpA8l
z?7h)pJ#Wjb^PfsPuKldP8M&!i_E?zzp{ysGdYJ^qL4U<8T(b@rUOPFKboR!-eGiu-
zf@g;GYkQH$GGxbGl@279jxs_BE4tWzgG=v{CsxQI0b!!mPPsg!zw9(0?*yZVY`-~}
z{=^FT^jN2v?Y8LYbXM<v4K*K)2j)fd@#b+C!@x>;rVPxrf*WQSX}Gv7@{cOspt^j{
zCmhjB$R9tfr8pNX7TjL`WX^p&mQ;`P%gGgSAEd<V&aMZ$u+Als$AHbfU8^nE2^-2t
zY(s-YScM8!NuDKcUttBe1%NJp+-Baj8o~S3M?xjZtj>w^W}TcTrgwe)I47o#4P66s
znr12*jPLn)*QdyH81Hf!^?jLbR+p;pr*enUCom0PsTvIG;clEi9#(1?9u5~Mz|euu
zV7RC{fTK@8#|dBF+H`AU!pl0i<@^|VtDAQG<ro(OnhjZpJLy4LihCb&8(;nV$R#ou
ziGWkio~C(YHKynXN0HwNcq?&)fIP_XT9=ATfzumh!GaO8JO33R6TaT`%g|ST_ahHq
zB`EwMHPFnz5(=Nt8JUAXK;0A({P4ctWC&&lY7q0g$i_#!TdNE3ZU#vg0A%i@tK_y>
zoyqllg0sRW8|ER#W0Ujp-(WCWQC`m<><=rgO6fj!;usA7s|g+)gzp|t>uIOFJeLhJ
zRI9Khzm8T9;{CsZv|9m?qy*4L0qjG1H;OJ+tWb4M1?WNg9X+g=Pai5W3={rT=o#1x
zC6V(1=xk*Y{h6}dJ){6`6zO9na3vAIxsYl&;G$UI{5aODf%74?YJkf@-eRPDd@ncQ
zsFwk^8p(xp2PsPqT&)f`JPIy=bSf6OB0X?&1Im$j6L9^A>5K!eVG3{;<>2Om$mk}(
z^;&>iZUwF-1r=xDqD)+zhnu2tl}IIal;h|^dLQW&J_n}*M`i+d`0BME7~oxUy*z&n
z@i2{+G9bhkaqW1j<TxLNgiILnXj!7~9yl)dDK;~-HzKzxj?*hlhh)3NGa$96&pH9t
zjKvOzpF2-=`N)o0G0hOC(ksrVu;Lp7#Ck@+HAryuPZ8^5Cc^z_6k`M-x`4~KMTah9
z%Ia*BGY@f;rZ9a_6J4vbMDNj==|@}{+pnb|uG*r*n^#R7M6f|l_TQGMy@H`ewTo5B
zB%7;)0iTEGNi(8+&gY^WjEU2MTFgTJV)|=Ut($jMr-Ks`z1FDVwdRUWr`dZ1Ko2$P
zu$L!Z3`fRhVH=htY>v9L*6jTe#Kl*`h`v|5d?iMYPBjWU3XIK9lE;fL6KS0Nc%(v{
zWn|OKT|TN+6N@1-g;lBQz^twXm1++d)a_7Xfo8#QApVsaTB|nD<LV+tL;pve85zUP
zgNVp;n8H*vFEX=K;{FLdd<dO5f6M75zgG)p$q08I&q(x{S73#4Gk&4ojq^g(7kSbm
zQPGc=T`&-@wvyj^&v)%J^99&Wd!lNlR22jFIQNIghC=Xsd-}1P!9M_oxk5D>6H`TP
znqsDfuGD1H1DYwE`J5)8xCEE!VND0Kls*-`P+H46@%@2ND%!=6mL`?|P*ZrG!ya-9
z)+&k1$-4%zkS0Zg-HzzL9RnD*`U)qQCah4B(Z-)#j2%Ah3_o>lSmFl{d@0lI0SD1B
zn8&{P&RwkiB4+WB?8C;zv`K4r-x-Csm`@^h$@{on%!r~-8IT2GgbnO>&ePQCO3$(X
z8FB|#GQ7^Ex{M0GZhSR6lCt;LhTQj8mi_#mn(-LY%j3#Fh}g~CkRRf9AKBut>MeQJ
z2%F-N`b(L(<<GQ|pzc!%-Y(JS48=C;UF&kr0g02baUP<)<gn~zjIN>vwHN>;DQdhu
zDoBj38L2@2z?HW^99V??m=7Y5FYbt=bWg=yY(@II`eZ>CN2CAErqk=g;T&S<f6R-g
z&bZiV;ix(=sy(G(kH@I?mVte{1MKa1u2~pehc#(>_@=B<(|6*MR(5Xq#y>b54y?qR
zR?K-2>fCU{55uJAx?ccb<|_=3m4(;-A7{i*dPe-yday)qo!G^%riuD)vx1b+KL(hq
zeM9VF$u6%&3cJuN`cd<PTWmm7PO7{TgfmJ+Tr-TC9iV?jc`1L3!{&&SAXZ^!Mjbbe
z)7TCTHJUun3cd<{zn}s8KOiB({yb9DlQ;~Sz}|q*E0LIMw^bLIAyZWF{F<Sy@4OJv
zCLFz@O|rq#XmNwvrt21mmfu=(t}+HxONe7z*MJ07gW*9lg7KrXdNJ-qD|A_4mmnNi
z8X#mxrUhx$Q()h{rHC27?#p#loA612K4#+9gL5p2!_G9^osK1)Its%XSg9pC^Rdj}
zu8$IW+3PX1CvlFM?>}yPPS@XXsXy|d1ek%f2!W3id)T2^dMK&X{MvBjj?Vtb_wu+p
zY4S?K;)FoCc_-T&NB5eSnT1nfNqehyG{-2>sKd&JKvlAxt<=-v<WHvF>6^HJ5};82
zAT;i$&OqZ+uA0Xm9~$_r66`|}OXJ9>xuGZKTi9;kJmC1P1aZeGZX0hIovI|Ooe*eB
zVcQ?vlOTjLJF(v#6RpU+X_!Hp^CXy|cu~vTtbOddDfEl1WqF1yjign0bPDS;rbxmJ
zvxzK;Hh72($3tQU!XjNrmuFv0`?|m5yhQ1z3Bnr8ZTDI6g#vC>A$>My4vWK{oCdbO
zkp4NR(vam;TP3TGCW@xi<W7sNFMRs^?AT@)I2L}*aNW*aA}sIAZ8Hp#)Ym2Jx|76p
zb<=`|95btvNIJ}-<R^JS0}z!ocsr9t$=}(%?7l+!r9Gc*EvAO)Ik~OHFa<kRJZS~l
zCk>_t+Ytx}UoGP&)}BINoc@)eg0KO}o-bhwgSX-N8AaNoWa0{sHKx(t8Rm$jKf$o_
zU=sDuurYD;!Hlv3J{Ihs%E8_<2=)`-D#&=M2WQs>Zo7IEuAXj^=wFTP5$fMRvxe=r
z(9xOe>Dv5!X|u6BRRsJx-$$JVlO(liqNKav8TO?@`mmsqU0zH}3)AVw!b!MF?7nb|
zLxqH0ZKZ!Ge1~qHH3?8;69Ij*eAHbuNs^N;N<J#`(U#ehBxI^6>7Q+7J;n6u?EUnO
zIr-8rQK8qHxUD3EW*0w0+lo7+g_OfyFkG*7nG>-MG%|q$m>|Mglia{|$?oBglc++k
z@A0telE7CI|BLQGOcHC~?tA)4mhar49Krf^<H(jo&62qAm6nk^C%@zBJk?VjL>8=`
z3WWZ)L}&J%)EhnR8txfb*{^l!li79{@t$lm88<o7FVOQPS&WhXrDU4)9L7XjY4%(@
z^DbRJH&tZ=Yq;>!j=3`tKRDNh|L@N&m97eAiD9yr=Ao>iG>87Gw33n2uS)YGmO0sg
z!#9)0mzkw2u4juY3d#znEpviT%k2Ti$Kdx&xvx<z>t;UF1erkVC|Jv9=Dz_}$INZV
z@_WE%exANpmh29*Jjhy_?u!rGCnMw(_H}<<(2Ua4*kpO($K_s>S6hI@1Ra?kqIbRP
z9LHTh)5!Tf4oe-$v&^^NP@V4r>AMohaSOKh-2)?Ic_W}5iBqj$+l<ZayNurUNOc8l
zcCx|E8|5~iKF<<CvLmlrzzCK!E`<fX(tgWX-K1WhwZUPP7pQHZ*ufEy>m%$Kh98lp
ztHz}taH%c-zQuMAeWIT`OpKRab>zB_iH)O@5NsO8-@z-5o1Gb(_ODOapiT#i+UBs}
z4-b~NRKEdrs?V~`BzZ3fa|KsS4`imZg!$&KyBh0L>c%5m&fZuBYWT;$hJ>8@uhALl
zjx;%1^EJn`^bYC&siT24&G(Y@)-P0E59@hyU!A|#vhBh`M!dl?(tXCDi6NdFgSOPS
z7hf5)vGm-ZnVV;~{!29b7V}L^beiF=`=9BB^1mso!_P)&kK<Ob+x^kHw?U($5EJRO
zy_w#eR-Fb!9{gUlqLZ~X8`v~on#2p=H1RT3R-~677@aZIgJwG9xm>yYP3P(VYX|<A
zA=;77QuTcYsU>+N!m839*GERrO9S6q)K@Wut<0mBD<*vmeT?67m|YglTS`Bfcc56Z
zc@KWcK}h)h;?wzH-?tj<?w^A_Qy`q{*MQxR4b6D^9kNqL)mD18sz&-Y9KbI@)SkGY
zHf^T_JT`qIT|8`jo!2q=p1sV|wgm-rXu%{6?K4CTq&kT?M(0+~VtVPu>UrjznG+g<
zjlc9mYuA8>|B6io7}-m2R+mXVX~Az%2&p&TbSeAvPrAAK0x$n28woq_!VUwsf`Pze
zF%QXzd>>u75HI1vDyb)~e9?~dnqK;K%_PaX0#TB^D1+TuOrKrkVC$#TUo3La(M6MR
z4TU1kzPOj(T|7xrKTDJpJl#uQdD=>iwN~lQRYjt7PHiv!zIM{OlG&o9tge@i)lHJv
k=ZKQZXL>2KL@HTt#bbbVbitB!bYMv)llal?C06Et0i_?q@c;k-

-- 
1.9.1

