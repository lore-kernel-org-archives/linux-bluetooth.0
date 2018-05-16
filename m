Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com,
        sukumar.ghorai@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 4/6] linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B3/B4)
Date: Wed, 16 May 2018 10:52:14 +0530
Message-Id: <1526448136-11511-4-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1526448136-11511-1-git-send-email-amit.k.bag@intel.com>
References: <1526448136-11511-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the firmware patch for Intel bluetooth 7260
also known as Intel WP2 B3 and WP1 B4.

Patch Version: 87

Release Version: 20.60.0.2

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 WHENCE                                  |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 25627 -> 25775 bytes
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 1f093eac2d4c..0e352a998a95 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2959,9 +2959,9 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: BT_WilkinsPeak_B3_REL_86_0001
+Version: BT_WilkinsPeak_B3_REL_87_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: BT_WilkinsPeak_B3_REL_86_0001
+Version: BT_WilkinsPeak_B3_REL_87_0001
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
 Version: BT_WilkinsPeak_B5_REL_39_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
index 9a930916a116d6a6d55978aeda76210b49bd3c80..c1b450f505b578915303c1614806064b3462a7b4 100644
GIT binary patch
delta 5019
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

delta 4746
zcmY*c4Ny~87QXK#zyksVArK(Iiv$RQ5c$y{5kf#f#rPL6{uY1Q($=o2eJXYsdDyCS
z#T7m5)@|t)D_X7E(k<IzTiXd8t;#qREIPre4OM3|yY33zbk{m;+4Ejxcwy#n@4Mgm
z&N=tod(XZ3_zLyTWh$Kd-FOJ02t(wwEUfl$cx=Kx`f<?L6C*)9tzfjIpWQ$Po$lTD
zs|dM#*qo4g7CZF8R+i=&?`g;7i2?j>9U#Lj%SRCAR8@N{`H!#v?csfMsGkmhRYYkH
zKRKe(1gMp$a-I+$?2)+$567s4usSrs%49Ce^{=tbaD_@pd;>?i)r5LE@#|)qxEpNv
z{f`|_LL(ksdvz&LbXJiifEso;v1fd?_Q-2qyR@y85KTR5IuqXSV|H}%TLim2vpupo
z!c)Fiw%4btfqFW<DL1eYQF8*hQ+M+Zik$K8&m8#ueUc^WlVr8>+BRZn5ZHuGvM95|
zwobG-eC)r=UnjM}Ilquw8l{Z&jSa+8x0J8AoBA$t$Qijbu3>t{HRa!!waYs1{hJwe
zH-v=^D(#4cd-&7<b@;(%2$!+cTF8;b&bx}^PWg$x{jrfdda&=7kz366jRS-~-skzE
zJCcx^hFw36@aGXLBa|yKs7`j=>27f1cQ3py%Pi=|-s`$TX4%us4&=veD3!}cFW~qk
z#d?<P?N*Y#V^ke|3|G?K;KuRWa8H&&$v+K~FQv-uwS+OQ#7%&Iqfc9doiIZv{c^$!
zB;QoWLj#(xv8n*Vn>)*+!l=$qLU4L4PmRD|0;a37W&NSo#^W8tH5^KKALR)=3@9lw
zMZP~EZ}}{O@X_d9bI_bbD-#cv;Qv=62~U17j-K8bGRi-=%F^L-+>`|6i5KG{UU)9h
zR?vm4HFF7n6x+_ICBw&WUU6&->x^o|u~r<bi<%fd-gm$e7*QA1k7La;b5t8V3XF|w
zM>PF^6T_bu6TY7<B`pzqCcX?hG|>UcK`F&8i1Nx0ZoF$Id?)tFM|&c2#`g3{qVNbA
z@tSpqa)tcN3?zKtrM_>3<vs;`PzLomd>C}7YMY!MKD}+LmGGg#GV<0xBVFoI;)=oS
z2&^HB@Xj1}!<5<L+n8Kp973NT->6XW%J)3OsN{lXCYkcUF(#|2Er>8%Xu@=1+Zjq2
zyMi$FVfY<R7!&qy<AEb66*9uSi1HPRLQa?%6c(jLMVNAI6)}WqKrzG-=AoJ}N3m7J
z<97mKT2YJvgvp;yn2p#Dq1;7Tn?#zJ$Jn6*39~eXFtyljMEMQMYbg6rj-Z@G$ugh;
zGoJoAgt=cxm`0Q*I8IE2$;RN@iV5Q=BMetbm~ND;D#C1DgtjG1Ez}^d0tc-~SdDTH
zt_A0Xcx)twau8<J28xiAX;?s{8^nXz!KGO#?lksxk#EN}f-5AM>V?N4nN&UKLP15b
zzn+vhyN!v$eRVa|7|KpN=Jc_uAwsc=GQtar6{^|sa!R5<fJsFCL4|`p#X?zFE&b<k
zcqc4PCXc4U85Uhc<;$Z<zF>!D&ks&obZL$`aSJeRqTMU^P{Tqk5p-ni?u1F5Xow15
z*W}W>8zx8e*;D=7lD-MI&!mn=C-kR_C3kHqvs17tXWb!_WBKXKcAqE7EP90%@#c30
z_E8xF0hE(>U)5?mWnSeWcobem>A@J0ivQO~BtF++G3zw5qL}sa5$Bk5cQBy`oqf&-
zW_`ejb9xA&h5lW{`Vr~#<&SMoo{Fy{2uns2H6Yw6lQByoIg86nyxlMo@d0ImH<c+=
zIh<3bsK#(g617f7O#1_6?=({lVR}OFlaQ|#V}HU1A4jIKBqe@8LTC>b2&9E~|HwAu
z!C>L%$Om(TG)a_N1T)?M*0$xe!<WIv;48i!YZrG?Agfn<Z4en{pz^^I^{$H9(c+L;
zXvDLK+rb-^MV$q0^iCS1c{@6H=D3Y8le68daPJnT!$$<Nr(%DrmCzk{bdml`^xK&2
zc2#Lc?<`*=6w6zLRSRSpHCs*$63%8k_Q?5FWufjvY0NoQXz)EE!R=TQ5SPW;sBW;w
zreolIY#yb6p4bu<GwhevYN2d+fl;?cOkl*qN()}GHo$RpjjCwSAf2pPDQbtsjcSBN
zkoe4x6c8WP3~}*yw1R>WWpd&YW&JeKOl-oa>fK&Xq6E=IiHJsnH4?@&397r{ep6RQ
zi?}v%RQ2-&@0Kv-DiKLb`jF~@!KC@B8RuB({(0=fGm|xx8mf{D=yoeKCEKVj7)q{G
zCF7Zu7<-5X60>4p&kAaHS&K@}*2hT{+_9oUfp)ZTSEOHrLs(OZw*d#0uMxuqY|rl^
z1}C--{GQ71xEgLvw}hMHg!^>NIdU;1m9#-o3LhzPa~X>>#_>f;H3rS-(!s3br%Ukj
zSh$HdCxRHVDu_YIRa*=(XkbvcDR^@8nZTO5hQ6NwXHw&(w!5*|qwR~S94t(0R!&vl
zE{zEEr*W_(eKze)g#GE3SZ^Zl?w9&LnkcGWOXt9*w_|NRr%#vKZ%q>MAw37HGW=%6
zCyU5%1_$eB_#qrCB6nwSuqo3Isn?3gy-W`3v+5`_T**q7dRvQE7S6_##lg!n`FKf=
zg!_tkC$q5@{xkC>*p}^Qyj&-ef6C@yXO16YOcjy;=5Wwx@I$iFL}c8+LGvs=N#c-A
z7Z4+^xa|dEaN)Bh5yEqyhkdy`ykrOsjMj_Hz&s8P<e38#@r<}?VK8s5bUsXms1%yd
zL0i6`<8dFNEa2ex1%Alr43VRn&B5EV{gC^aA`(A`gZJk6A+9VDNj7rOW%NU?&J+<{
zAqS@m{Sarih-A#=;G?;INKcN4WEXK^XPzU5$)p>>S@f!OcBk--fUA{f;-J^$XQ5-3
zh#2Q_@Z~&SdVt$<1?2jP?@kPzxN*W)to2Y`{49K3>}TSQJkf-uWGR&eP?C})!;&YI
zH2D(hY45&O{j}F(g$E^@B)h*MUu0LBIk;-hqPwi{#JpS@`<4Pxp}LfV!BSJ49jj*B
zG-7B+X^;~`2evFO>0(H;WJ-B;vqj!A3kNqXegWI?rG(k2ElZ-JVSCv;b<dos`{HaY
zv)#;w(}{d53*VRd5vz<MaZNb~?s9&bWDlC~(M7y!*f776ZYhKh=g)u#^G)<<A*57T
zq){2>iYA_|SWaKC!e1*`ddLb7D|EEi3ezg>QdM1%sQO|h2ahTpT7^j(<c6CP?`nMN
z;e@tUap0}u;a*h?>{_rDep#RiK8xuh0dk^;q=jpw)(Jifk+W+d2fr@V(H+I0TeMKy
zWzEs<XQQ=d-Szzz_BxR`@%jk67jYn~E{@YH4tjjc?5fy3A^b}9eW_t}bw-wi=P3~!
z2^E)di7IS$?dBT+2bE9hCiqizAr=@{H4DLu=h5yws9J26hI$)cw-{>6Vh+Nr`Egme
z+GHLv3oDPWasxg~+J&8fo~?OO-ax6yJ80!%1^0sU0CwO8xwHSNYb9hXNv4#rV95e0
z?}A0-9a+Ma3Qt}p__+AW3S<pxV=!S`<b=I|lX9VXVRD_=>M+Ek*e^$_17-3gHiCU=
ziPUy4zQl1ZZ!P6Ov&?UEoh=uUj%6HZm-``|^F`#?at_i~_#y2TB64yC2bs3|3@0x3
z)Q$H>rEt{=uN%o~v{Z_WGqzmXSqVSb%wVXA!KYAVO$xpSU#gie4Hkc;3&D2RM5D&V
znoRsZR+9$>wSJePV}YQh9VE?sFF6)G>e~l;_@;J|TCWK3kiAEG$qC=v%Aj^PT*ozo
zxhwVfOxm<^rPSZ%g`&UDS8`BdH{liBXfI2X1aHS*D8$RW!fQiA+)aAN)SK4<L-uE&
ze3f5zs;fnF7goI(qE{>&4E2P+8O6YY)qYCm#iG)c)f`yY=v8LiT*7A3VcTH}Wb?7j
zg#&BKq;ck3Mb5WtI9RdP&zgRTh<vw}1N%BZM6*;xT<bWvzb+bHS-(YUQMpV+@2uxw
z<1>Cd`En8Y@fi-Duk%A5`;foYaj<2BAM$X8$a%PdgIyb?$PTwq4jeGH@sCvPrw2Ca
GsQ&{)x&_(*

-- 
2.7.4

