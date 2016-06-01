Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 1 Jun 2016 12:00:49 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7260
 (B5/B6)
Message-ID: <20160601120049.3b3c359e@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260
also known as Intel WP2 B5 and WP1 B6.

Patch Version: 38

Release Version: 19.01

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq  | Bin 21908 -> 22089 bytes
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 21727 -> 21908 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index b416c56..2cfb5d9 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2726,9 +2726,9 @@ Version: BT_WilkinsPeak_B3_REL_86_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: BT_WilkinsPeak_B3_REL_86_0001
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: BT_WilkinsPeak_B5_REL_37_0001
+Version: BT_WilkinsPeak_B5_REL_38_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
-Version: BT_WilkinsPeak_B5_REL_37_0001
+Version: BT_WilkinsPeak_B5_REL_38_0001
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
index ecbd44811f8627b9bda695184ab0269a5c4bd32b..d3c9edd3b68d1e845c893c0d226117141947472d 100644
GIT binary patch
delta 4047
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

delta 3988
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
Q9b53+$=H8k-(X|@2f8%);{X5v

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
index 098b9275ba53ad78b29550a7a77c7fa8c62119a9..d30139e0229b043d52592ee8c1a49d0e261a7d9b 100644
GIT binary patch
delta 4159
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
TgnN46_&sGp@t@wfr%?DW{Xj<<

delta 3961
zcmZWs4Nz0r6}}H%!UF;X2}wYH9zTHq0fQn&2^!=_1Xf^;$~ul^7PrH8sm8xG+ocls
z$I=xY<e+O;yZe~hZnUgrXKe>(Y&S62QR}wB)h*0m4Gv>7Ely!Jb*$30=iQj$y(u%_
z+{^vGd+s^sp4@w1|F4<*7Z?k3Vj+q!gd;3d7-I;FWpRKYo)SVbNWf$EIo-8{?7tg*
zJi>oF&aEK)0VUyulg46Z_T=_caU*~9b&Xu}IeFd{M>sdcGA#++tYzXKv3tIY+IPYq
z9RC>JV%}zk;NQ$GW)Mch%9$N~;kMiWQ<p;=>SVn+D7(WfdT^5`q>qffhK@j6cnO>h
zzknlzn6?sb1|jyvKlL`kSrNks=w$gsd!!;_&+`ngLPcDy-k@PSe9jg!Cb-Y$GTjiN
zFhIFNAHTTRgMesp3brWtq{|quOY?~Pmf;R9)x|#k)IwZ&N|$CBPAICGQn;fiV9xa^
zbD1hIDvP>0l!S93)M12kL=i3-+iXNB!iK0r3?bNX!kG{|5W5kV5FUg|Pq^hQ#(=0n
z>_QwywB``5Cxvhw2Grycu1QC@F&y_IhyuqDdIjm?vaw@ER3Tary@-zxmk<vTYIH6c
zk&P%qaBES&4i~Ty?z6v5e>d&f9ZSfFhgF9Yy_zLr#+1C74Q9@-T+GtbfLJMk>CsG-
zgz?T}Bcm)dMd-R*5d)r}JP<YD5m_t+H67tEdqUik=upqD3iVWR%w$w1>dj6o?_NmZ
zh89w45#2*UD^u~TCai?jFbGl-w7A_f?>QQ0BjcV3u9^4_&%?ur=0u5`eoQwBJV`y1
z4h>u_qlQ!5GUg0i<MQHu742eloSH;YA6wwRToTg&x=4d`{uFKt3DkbRkOIw-+OTh;
z;PuG$(PR3M(=G73$O^^^Pa?}xLu3A8pHt!j-K7AWj<VEPR{ESF)vTo7P`Wt2%Ov)L
zAy1gNLt>yTuhE3YhKfKFU7ASl-*AXjIIsCKWU?O|(FMF@=`q}M5+Jyjg!|X<1O6S{
z3>93AF6c5^#UzT!6pbkOw4)&-Gpj;9t0mN%u?~0|b8c&cUfIfmbE>Y!b355-+yZ5c
ziy8Nf1UH@^O#5c&gv!MPRgS5}*qln=VP6;HWi)uggpBv#;Jj!0S^}ul8TBeJ>5kzf
zF$`m!l0Y*dlST(S$4)3FN3Vom867q_mE)aB{EHeL;(gAsCB)2aL^UD(^B(RXw5l>0
zJ-n;>x#Z{lbTC4+2YgHkycSawKUg3JrQoLy2ZM9K`IsY8y}(huA$BFa5t|#M2`=!5
zg>YO9K8ZbK@GEaP=v<!NCWfr!-O@eikEHYS<4RypTo3fCvokuQ#EA3J(VzOC9UQqP
ziMAV$4fO81dKY7d!uT?HE8Z^krZbxIU&RZi!K`~;GReEAyg|<oR0iAr%E|v5fs0G>
z)Qcy&Lq)CJULwG|2{QY;Vkq<11Od7=GNvV#GE*7>jwi~P2CORdc{<S=7N~=CZL-*u
zX=|WQE7RGq3Q_k^E5L_38B-EZnSbg8IHxy72I>fxzd-O1AJ?Z#qc<+0x;ec714(vi
zmQxZ$W}$+Z#SId-fp7s}ll$P)<oYCWOpTBvTCJg`o+b~#;L;7L?^QAr&nLwMvQo2b
zB2_(KD!@>R%;hIRhD{aVx2ZB_R!iqZrgbno;LWrZ@#qUbyY)wo7iGd_!=KVBrD6H-
zJjcYurk7y3R;IrJU#80}-obkT`2=2oF<!=8Poj)ILx39@GUjSBWl}Q*_;cnK$=(kw
zr9@_y0AFWSWt>S7Yf%hb$?N%n5lM>9<CTNU=4J~pku5WRCY3TKLrU2BN~kj=i_P~9
zMzQHNSmB;QChtk3^5UE~MZtv}BRt5F30&z^P?{^i-*aWm0iH5t#u9PrUgHm7)+iIS
zXHbDHPk{M6vna~S&y*&2M<x|i=QoMuhxwb}alU=2B+RBPQ9$VC6Am@@f?84faX|w-
zE08T#l}&9mn&?7DOuPFEWxT~ed3&Lial*;MHc%AFcvBALUn#OO9dNp+4WgFGcs`f%
zJC_L%XO=M<BW2pm0%(fuX%hFjJdsiIE<SXi>fvB9K+<xVfdwjqA1)UlZAERW9)At2
znwSr0iCJQ7E}t&5Z-tQLy0YBOOo)XM#^34*9&8RgWh22_QYKCCOaYy9s6+tcO4*td
zCdzcK6riwF#@s5T%#l(7manoXO6mz04SQDUq;@?;RC9FI09Y)WrOf4JlsRVURYzkS
z;_PGb#N63V%wSzDTgYvu(%#hqRIHIP=ZYzFYK;IjWiqCBIb}X76QJHIW8PaqnNO?&
zG?mL3X9;D_mkY3Et&HhdNtp|41=zk$#<Z4F=F&O=zGss$_EnVm!e(Y#V8*shKU|A1
z$L)j<{ZcLb&AZ(DQGVD}A)8ohp%aHI1bBVDjIpk!%<tC=u)9*mnAcEdv{HcmRrY*I
zHDs5G%q(83KEw>dkGP6ZVcHYHSM|0^>|Iw8^9TZ*)iTR^E46&9y0a^Q0XSJ=7VqeJ
z&&F|bA<j>)E8cVOM6k!*Doe&Iaopp3aTTkq&*uL#?{luD*W6k!?-t?f%5eLf;)9{=
zE;;_f3fFFlrL{_U)7DV$$rdv4BAPDoJ4RJ5x<ft-*0T6w2;LJ1)`-@AF~S{;$46v=
zSKG__3%m?otz@z;+qKuY&&}Jy{^G!gDZAB~<IWsn9;BitS@fD!@a}i|C-qk}c!#Cm
zzBsJGH%Xc|{cD>i-P@^S9Tj4mqEk3JbxOy2Pp2-z!Ax*_gTXtqA|9!sXhZJKS22ID
zAX*Tuh&F_nutd!76i0YJzQ&FCxpfOayX@G8KEG!1f60~+e9@BthXOq!bRuXVy>=V?
zq_#);D+*94By6<AXmOE{)(R~fv!G|AOzX#w1iT9Lb?tDnPLGGz#k&1cTT}P}fqZIx
zJDjeU&Gc4KCbOX(&NlR9N?aXVFETEEg`eD4&FOW-{QNl~TCluSq3vHAWgxx2Z;9H)
zD|s7B^kMwjM<Bc;vprl%ZJRc=!!I}Wz|R_^m4j7usJO8miW_;j+1Md<Q>dnFX;VA=
zrb%Y1zlJhp&F$few=8hKSqon^%R=nlKoz!^+u_Q~t9AQ`8FysK5z_U6!oTwa=c|_1
pusKT`L~gc9R(#xvbx-D?dUHG6*!*MgZjOc;dmdx>!eP&5{s%B)=_&vK

-- 
2.4.11

