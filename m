Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Sep 2015 11:51:45 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"An, Tedd" <tedd.an@intel.com>, Kyle McMartin <kyle@infradead.org>
Subject: [PATCH 3/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7265 (C0/D0)
Message-ID: <20150921115145.694a4f48@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265 (C0/D0)
also known as Intel StP C0 and StP D0.

C0 Patch Version: 54
D0 Patch Version: 15

Release Version: 153

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 24121 -> 27481 bytes
 intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq | Bin 24486 -> 27244 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 847b1a3..6cc082c 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2544,9 +2544,9 @@ Version: WP_1345_01_patch_0.0.34.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: STP2_C0_1339_02_patch_43.1
+Version: STP2_C0_1339_02_patch_54.1
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
-Version: STP2_D0_1417_04_patch_15.1
+Version: STP2_D0_1417_04_patch_28.1
 File: intel/ibt-11-5.ddc
 Version: LnP/SfP_REL0190
 File: intel/ibt-11-5.sfi
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index ffab54ae5914ecdb6e3943ae980f85302f3967f6..6201968596e332af1e645ba1e1ce6c957be6274e 100644
GIT binary patch
delta 9958
zcmcgSeOy#k+Rwf7!3AdE0>g(0c);O9MI96kO>IC_bV)Hx(6F$qWm`Xn{Ae_DE{KXB
z33hyUt$bH3G~6|%UfLaetp&4EU#p?82EQ6x-9}?;)N!kQ+2wuCy-eJBcmI7~{GGYy
zKA-1#&U2n~&U0-)$@P5BIk??@VZea^T0YY_k&n<K0I>ZH08+uPJv528j`!FJks?9Z
zJFRFM2z@#r20ajeG*}uB=!s{O$IhBi1kmC1*bVqR<xIC5yM`V7q`$UHU$e)lKgjt^
z2(OV~5AWORV)SNw-}6VY<b$v#{;8druGCJgF9Bham?NaX-dIU|!5i-L*a2aY-(Pcb
z?sFs+#u#G`#?+ujyT{S_K92I_C#&IIfU%pEF}7)`m9wOZxt$-Xtntg%bbi2iJoZYI
zNNrqP;u)=Z*399jBHwq`*uat&$+s&)u4`!%XQv~0YlcdQmt!vZxP4E%<<KXqKe_St
z_i!o1cdpy?%Wk@xAL^(>vDZHAOVZymxg&vqErD->OSXi(N{{0rI%fX>z9j*;z1VNX
z=gQ<$HJu+S15<Rj>QcpgT~qQA+dia`k`rwsG>}|{eMp8Ym7gyT|2WhW8+xg$gBjC^
zaAwk)B6vhrF0}O}MM3(O$jE$=3Dl72O6H7!?GiG)9CqA4C50DvVZTPydPKNsyNvy+
z>aBktwD-hi9_?*w7oy-O?bfD0bv<u^C(%~Wq3Q8Jl$5UZXkY8_*jteCcE`2%hr8~R
z$OYKahVM>neAky<d=2N}53bNd&+p>ludl;*{bO2M5qG>#=n?VxcxWXE)qVXpZE#Al
z-lCzB&NORI2H3>J1d9UHY6eI3Edh8DyvxuXb=b~p0WM=3qXSrJ1lWr$E*fA~9KgtU
z`lT+8Hzm`%x@nV5!*S9x0G`YQ;IaT7#&#9k^br7WjRNS-2Ke=8fH$zgM1V`!*4+m{
zrc#$a#qs`Q0OzpXssxz)BtX9dO;jzHQ@DowS`J=p)S%b!FB>6+*u2=zyoXr)vz!K@
z0$VG#1|3L>c}beSq@vcor21AylcWbJFj-AS06E;8`lkd3NGlB;+P`S5d^Q577!2@t
zLqI^I=22l@U!o1%DMpaqijZ`Q;N_ZT7uQ1~K;nJiW^0Zh@2^6evVRu~QpoRPcPHWd
z#}N&ETCeb{xARb5{Hq;agpv4ts}FWguD-PhB#%RMdmIi9e?+$yk?e2P6p+sIi$gse
z^r+n6m)(%*)9kp8g!_@m8v9jfWo%f_d3^8h(Hq+k#(Ch42|9@FV8UWQ4;7|@bQ=2|
zrpY$=^5(jmYZITHg)rmlk#C$q_{d0)!xYwIO<#&YgO9r?FMs<@TP=A{_dLQpCb)DG
z30FP$Sa_)huIxux2%NFCR8Q|Kj*s}O8*#>bkec9#&4qn%Ykiz2(*7reg$l#q>{^X)
z!WGhxyB>(Q0HjTkkvIO-5N7MRt!eNudcfIsrh){P<&n&f^$283y=nB|WDUCE&t5j)
z9@_v>`dE;bWB*c0LCl-O62woQ0n5ILAlV1-Y{?d3JBqN4{|m-+=S&94F<w_0cNmvj
zFA`Ye{vucrn00K#ZnHh~*dnbp&WCXJw{s>)dqBHKi2%E9r3<9+Ss*q1P4X;5npOWu
zbJuv*``hORqDQZ@5^#rAhxmkfXd#%Nvub!y_^WVP0c-<^k(!x;@t*hyA8h@zp>ixP
z!w|Cr=X+TQ2$uyAeArHgf>08MEgS@=0fb@=2uGtpNQedjCrOxM1YuVk2rUSosRiL>
zY`?{38v+8(gCHa!9X4+=K2y<&X}I4YK1+v-#tcGLItY0g_?`*EzAO+N%SND*ksw&J
zLAX8+ginzW5aGk8b|T{L10hV03a4WK0aQ?ct8y|bN7!O)&KZcCiOPyWcoE-!i|zV@
zAe_SIRcs;}H#o6>^RuneKN*2@vH9jZ(6mwziWY$I#?@>8_<whWBV*7P|JSZixxvdb
zH=u8Fgh5{nx`G3b{aQyDrsB>Ht*C(nQ7gxjp0t+IEMXzv7)2!^DFL=>>y5%5CDw@h
z6D8(K40OMc8>Lcr8KVXK)Fn)z$)PXvVmxgRO;QuMFhr2xLTGm4!45@AeY|u-gjASA
ztb{?dgr<d=9V0^LW4iE=8U%FM&IwjNRuCafKHg}TD1@hN%JW!tnhfttQ{HRu8i>?@
zi{LpAsYU(|s$@P(UzA3apqPLp0FMem%lNcp*Gz@)gQ{!qhowU!YE6pd$&S6(KKN!`
z8c`W|nnkUjz8toZW`<AWD`wE2hv%scbYdtX!GZ9NX11jZpC0T`#%7x<JgaEgKQ;g>
zE}<m`lfxF`*(4K@?9#yLNqKh<(}x1EzK#ex*i%o6m&-U|U)bzV`+J0TAzC%QqZsVq
z2f=L5at;wnK)~f}w&!O}tNjW+p(o4Y6(OEjqmT7CVtB^EIy%z$iXwO86a~>%{dezo
zw>|b>604r=@`1*(>TTI5J?UFjDUEg&N~621X~2*BW@-4t{Fqxl@-bw8%hx^}0b)~a
z+Vg4eT)$BS8F1=VvX$Jtvx3iT7}meS(+}H52v#sTR(xo~`3Lh#@gh^LCuAjTh1WlJ
zYMqE70G@vC#`PPfKfn4t^Prwo*`i%S4{3_Vl*#q{ifExJp<GhAp$Rh_`1zhG306td
z^8@~Bd)gALpzqn4P!77D3j7V}@i<Q4(=*<V`SM+MwnkMi7AAuw&#5PY@bn63u!D24
zQ+EK?C(sRsmy=Zr_hLE)|0vhOlss{is|<f>j?v7Y38iJmM<-TPfY3ksAN{eoZ`?ZD
z@8Iwc&o&(3a^aR$Ew^!Y&Vz?^C(;FURD{uQjAMqWbkt+I20wFufM#D9&5QWGBZw{B
zvq@Mh&m_q$=iEx~a+>nom73TUqfV0>G5v#oKEQU#^A)Z&O#0KL8|TPUPJScT3u6DG
zur^x%?j1KE?s|c`M<0nyaOk=caQE2bOc+9d^EtI(k)3)`<Kw>Cek-fXms$fq3i%S}
z4xDi0qv&U3GeJJM@}k#_&)wbx9}z*g)4$zIHov`|;jTIflZgQ^=dZB&Z95S;;Yw%?
zF7JMa5)O9T?TUeb1Y5v#VV$?%=z=S6wlIjwjW*ovz^^0SdyXi?LPhx50k-0DMWW5t
zhEtJi#8U*G1?jd(Gk@AZ--vuBe?M}U^#KH?pvdUi6j%-3Re%11Y=b@Nf)t5op}sF{
zK_|~;xTRuhs1&>Dj3}Z`8s!l(=E<mTIwv{^Q;ai$JWoe=(|IvL7%RF7F{@&nNvCnF
zBXLZ-II#QzpT#)lVje6lMAFa&rXaRl=50S+V_GA!u(6txa+t|@Ac&$rnDS<qm&pzk
z>}A(nN^cNy#YI}KxW=^Lg=W(rV^%Z^NtJ`MFz29(^|9Ub(YPSxNii~JQ(QNFB0g0d
zJd}%g;y{+o@!f(l8lQ>U5)#xt(#Fap^$Are%-*99faNKipC_=PV=Yf&Gg$H5UO^*<
z%%v-a1S$SOVSZuAe#gEz&!!_?g;5Y%O01g?c53|?WT7894}EIgp}nR2hF;S6qAsC?
z(2q_)Qk?}%d`^jt{dS~n$EmI6`3)r-{uFjfI*INan<4n3{3-|Z;<*X@zjndJUw2p5
z?|Z`9(v4(V=4L%@Nff!Av^_CdSMP%QdU`2w6t{_n49#=|!l-Z6>aNwUr!SBucPu3I
z3kNnYiG>uny4|@XIZxb}?2M7$zdRzpv;Gdb_xu3nxAL2W@YkFYa;Qe;iDx5YsQCnH
z8~<2;hq3RL85~U8F{eA3hzxj423isJrqhbBq=B{HTbBG&uN$$uoZX1k$uN%CPcWFZ
zXSWPx{f3`<$K+l)!VWvjk*7%R6=AQE^&HO1fo`+hW9VilLs!VXiUI7aGM0&XRTg7S
z_QbT}o8)Xoiss}>5$#K;LDPxY;ogP6yAZ~^Rc`1`U~brtsQt-JF)YkE(!A)EfMJ)*
z0>)l0i*_;j%aVVHfqISiEV?)zr!7^OFYn46Y5LfNn~>m*!CyrXoMBHLvAm+>k}4Y=
zGn8a+Jj;>7NU&J3;i|Sw!4^m&8;5u{9qbIufA1>#>`<#Z_Rrv<8<)o)hPKg-NkN#C
zi8AJ7(%ZB)`2jUg>rfffnOw=6lIZZ1hv?RnAlBw2nc#zzLcTYN8iuW;JBI}k?8Boy
zYW=Ta<-9+crjy0AkpvO!N|6a%q>eWYqYG2V(0@w}B9QQ+fD$gGw$Yc<f-q}{jJcTB
zMh^_nS7m}Kc9-zeFNaHfZz^4CPB9tM)Xwp(S{-lvD{VFhiL1cd2Xb9Ex6vc%R`sS?
zGMr(C_gE$FX(gXkmC^6h57T2AK@tkhvV?Cl*6=6IbXn#!`X8A=1bOK)!QIR}eoZ<Z
zowb2Fv#gn_pvuM*KKS*-W-EFO>uuuT^cH5&h!MY`?~JexSJ9J9M$e8j<+i~sJvWm^
zj(nA#8kw7H$Qs;QRD349G@-5hs9k(>7Hu4rK|dT7G*SU?T1XI*y^ObwpewTH((~Ct
z1bqsDVRSiPK9W8)dNJ)99Yo;6dm2iJ8q-EU9}|SRK1#;Kja|kUXVZ;i=ZfLg@4XAj
zr_73T>&xgjV=d}9bmM&wWev5oQI91^*7?yghUDb&$hJ6V1HF+GM9?utCP*LG79DFh
z*-MA#L&3n7jSPL`#;W3`ZLCZ?a{L-5tZDo-`rUY|I`y?!kbsWK9nJ7da*NpG_1vlS
zUT)B`*`FiJ$(=Bh5p0~Woc=f=Xi$xKcSU<9O{^H^8#g#X{#6U(qt*%QAW9-|WhmA~
zOKIE0NzpYip?3-~H%OjynfWoAJ06Le?i-_aP~CW0V8MN@RFhZeP|dVGmtmYHu-wIH
z3Z#c0Ry9e&v&S$CF_&vdRb`?rW(#*U%WK-w>>Zb0GYp`J%X5Q#nC8j#?Yl^SLzsVO
zEX0q%ytNCTslr28U}5|`DHa58pl=WyS}%81?}MvaEJT?O(FjotAX`G}RfGv%CTKMZ
zdSY9O$ff3QYx+;qdTVMS3=Tn2Aa2j}F$&E#DP1RW*YYZ}UMMAv`aE~oGYZA^?O87f
z&*rdqhdie1+f{B@K7qMG@|-8N4gL5R>X*JgpILi=_0MIbif83ppq^CPf?TxjX;;>>
zY9|HkFbLazvZGjd#T&EbMQ;+`K!<P5t1NMB*%`~lUv%bffS!vdvQ{etY^)FQMn;y1
z%w&yMIm0U1z0wv);^IVgG$h)ZYO>ZDx76aWzmlHzFHDb2OlcVB4Hu$_xMk>}z+hTJ
zqP>l=+W08LYRKQRG}<9SEKX8Z!%X*%;r;4!Yb6#*z#njFfZrfQd-ou}ae!Zf9p0>l
z2W92}t!Arb3+LG$%cEVBA7^$=t{$`uBa;+p!~NXWrFc1Z)OgO?wEnQ_xB4}{75&kN
zT2Wk%yExfuQp6SQPzak5p64!6!IOLw1d+=T=5x&0C_yC24Xk#TD!gS#KAzPexU=I$
zn~xNb$_+=Vvl?PaK7oU02g1<*2ic(xIUA<o=2-X0U<Or1!vd@mfxrB|L1%kcz1nFN
z@o2fONQ~wZt0xacmFXqnS!K-RrH8wOwGZQxiM0z$hoFCj8?DdpAhQidVY-I<`r;q?
z=Ubnj8*f?%4wHsV!a3SObYo#SuPxbd({@BIFYv@$4~Q*F(TWVlueLoGSYv1E#lvfT
zg@3X=H$j+B7<S~qAQ*;o<I$0nU>%=f3co7ZpbX1f&txs~L6S9Bn{?Xp?ctr(j+#>e
zkF@-psZ)e8(LsfXqC9y~;QBp-qvDBp_+QCh5hsb^ShoT93e>JOX>#C{ZSDEYn#Q<0
zj9wW>WBvTN8d2{Z5*ni`;;xNdulE^4AA+UrW7p45DG<f2MR9x-Pdc=*go6p|C#>hw
zYPA#A&)pEYb<xti%E-g7b|{O%YLjNMuQOn2j-U_bEgqqow<(j@fEREz?^-{|dbc!#
zi>hniIgrg;%IF{Sax+ijxjwL(_Dvd`;69vS0qZb$e#Sd(4;?jW#)B<o&<R`WM7)W$
zFYqv&jx6ha&t=Bj;VBnsium@FD_?>w&{K~z(g~2X15{PLs!>_6!id@Y=%l2`lF5S_
z{i}}AFD9kWZ|Nd6=IzoouIG_ErRkh_TzCwcG0zV(riib(080?Bp)RFi{k{c;6p$G{
zwg+qxM0h1$T$lAuX?lLlOJ9Hp<fRKQ(MKnjs*}I@ep&yUld~P(RW{rwnmg;nNU&x`
z#fe`lR(YKHS<%{?va58YviE!8>bASWV>Kgxg4}VkFA9b`CFBM3$bng9-r(Hx(i=@1
zY}}PtU#9UhakybVQG$!fIpO?I=R8uQAAmR*!;Rz5*BE1>%0I_~pT|e6nuGzTRrXHr
zFqk0cOF^nraC0?-qUM-^WD1XI=aEhnr*dz?6lPvvb_N-K6dtXcW44ls&i9-Xt8Uu1
zw9AQ~4f^I!X8njp9=}~Y+}d=G<ZI8Ra#~iCU^LA?#hb^@^;ldU2Wbi9e&4EH@zFMj
z2EryDkLEvFAgpCj7BYc=sqDSxT<cHzA{M99G1Qgy&PVSwHQ{PK{!RZcebDe3CW^Sv
z^G9>hu=S(%aID0U!#Dbu_)6lVY=xN0AgY##7tFWFVI?-r^C1DtRc<&0LwI%7(10~<
z@MqvB(r&Es;HXZrP_M$qsy>*yEZP{l{Qd}s8()8tC2}Oq9wm$iIP{^dKcv4O4$X?t
z*Z|IeLSrpYwDI!AOGgs!gvpKrQe6J8jL&j@<b=b2=*Q6=R~BoD>eSgbRgQfDmk}%K
z&7gbkPo6gI3+U0mKF!tCq8YgHX>+Yxt%NhwB__asC6)vKx@xWgzc>fx+TApPUb=sj
zBVvHjTBhi%LY=oeGP>YMq*t+_?)Gk_CnU{C6aZLlLB<FbGyePbk63>k%GO!SP^>+$
z=5eI9cm}?57v0ZlNO2e7g_r>uYo-J=R<b(ALl`ZmZv{ZsGBo}TWgvDO2=o0(EL63e
z$FjjK9ob|6%UWz}ux-TVz^1a#FWX1on^HuRrY7*^573EIUsSJUFMhSaTykb=5lx+T
zRE@c8l`$VpE20?>5Pn}7EqY*X$wr)i77uLF1JMgM{{>;o4)0xdWF(<_<_cV__w-w~
zdwDn4qc}~Qs~VRpp9$9=`i5S3V5-AZFqp-9SG9DyyR=c!;Kn>=HOGvvkHWg+m9Eb`
z^&Oj^_>dFpzz`*ZF^SKaUN1yNL0Y|VV$srwq(aM#`myOnpcS`)b)=q$j1Rc68TFi)
zRF^ZWzQA0^>5($=@sbVghPSzBERk3<L)P5O)H*m*W(Y?}2d9S;_&w|f1J?-!qk&)Q
z-0d038!@$MR^P)fyr$>ixkxMu&jKT-vgR~?_5r_<n}*?J<kbIi;3zs}cG?TtaPM!s
z&f1R1JFFgy#b2XQuPYFCd}N@{5cFEto9@swBdAHQ_+CLF2JgRj%}z671{)O8<=a6l
zI>q0f&v&Hv$A9Q6P3@G7e%jTvJv99VJZBD4xBHUu`^4^l!Ym*w-|!6$-2?Uigd!^s
z_zs44Nt^!#hWbu@7qq=Qr!zOOx%c?j)4$~3XJvUW!o=k)cahd#`gUdVjr;EX!Uc_R
zEZStu=`@y#kNIl8-hJ;$SJ@Y&6}DlX(;vr8=rN-R+RcamgYGPN$dTz&40JcmMmNk$
z>&(zf3S?QYQo_-x^VZQqHj38oVtog{KA&+=I+tD}M&7|sjAR!nkS5=|-=&W+rb1)5
z@fi`0aaX1qqeXoTqz*G`#7tC>B^|MiYd_b{ROpGzM%$)a!V(ZsCmJEvMej_{&IrR-
zq03yu@-kd(XixC46{;guy&gMTootmhRnW-kiT9m+SFavj6Mhi{|CD$1<RrE!i2N97
zT>~rXpu9(baC!z^RQTywRfz4K$@sctyoOA452mI7Puonoc*f^LR6O;w7>{yb(hxd(
zX0IBH-+~dF3T%Hu?A%#FSleudomvGJ(=V`?Tv`-_T{eedub-<HT#_}7md_5tmj8@l
z6IX|2Kx)`<x@1lewz!yKDHy|R(>JW8kN<2h-&;(7_}N1B;H>zO6#Vz@D!VWJd2x`4
z+_?-pEV@=Yxs<y>mp^FXwM*!49z3BIku{GIIq%MNg;kp`((1Xr_p5x9grAvk9w?h-
zo|u}?+5-DCD{R=&<~326<(|f!ZV3n-6?EUcb86`#9>>9dwpt@!Sm|>mXQp;wYGlL*
z1{ebq(>H%GyQxN?eTYf$ubTdau+C(s()^(D{UBr6Rr$<uo%=V*yvVr~f$YxM77vzA
zR2NWTE~T$O6g0kG{B8_>4UvAI@^8O$(jBE0{DKA4Te@3qga<z?gMWn2l=)svY$k13
z5ai|VhZz>?=A>H5y}NYp!<R=eo%f@8+}GbZeir$edb>EYkWtS`#j}Jc5&F`?k^IJo
z==%#h)Cy0QF(N%_JU}Gw68%kCkiyn-hGhrlqI|uNzE&QDZC)e~2eeL;{pCv9vM30<
zZ?TNU?_Qr&!vXrn;vnp<M-*(ca|(Wzp>I9%Qv7PHXab3;g$H)(yeT{LD$6T*U-?q{
tc*PX@O+{G990_fOLfTm|lDaCwwD@0sB>H8=1a2aYUGfVKsAI{A{{b_Xjnn`D

delta 6469
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

diff --git a/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq b/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
index 833ae26100e21ff7d1709312b318b0978d4e29b4..032d82556fd85ccfa24698fbb987905daed317eb 100644
GIT binary patch
delta 10903
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
Na@k9qK<_R){l7lE-*Nx|

delta 8113
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
BbIbq$

-- 
2.1.0

