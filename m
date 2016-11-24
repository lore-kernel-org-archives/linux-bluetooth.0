Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "G, Jaya P" <jaya.p.g@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 2/5] linux-firmware: Update firmware patch for Intel
 Bluetooth 7265 (D1)
Date: Thu, 24 Nov 2016 09:37:35 +0000
Message-ID: <DAC39EC0A5DE12469D14E5A0B14E6CF53B3E3C5D@BGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "G, Jaya P" <jaya.p.g@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265 (D1)
also, it is known as Intel StP D1

StP D1 FW Patch Version: 25

Release Version: 19.30

Signed-off-by: G, Jaya P <jaya.p.g@intel.com>
---
 WHENCE                                     |   2 +-
 intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 45680 -> 47932 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index f0ff33c..dea5910 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2777,7 +2777,7 @@ Version: BT_StonePeak_C0_REL_59_0001
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
 Version: BT_StonePeak_D0_REL_37_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
-Version: BT_StonePeak_D1_REL_20_0001
+Version: BT_StonePeak_D1_REL_25_0001
 File: intel/ibt-11-5.ddc
 Version: LnP/SfP_REL0257
 File: intel/ibt-11-5.sfi
diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
index 4edb93e5f904770390d45e9fbff7479df2d2297a..905e027e1d210aed9a2d353fd7470cd39fe92c98 100644
GIT binary patch
delta 16414
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
T!AD2aZ_@E@A`?xR_g4NNZBX9{

delta 13114
zcmbVSdstM}+JE<+Vc1+}fEk86dtkUJ=%`?*r~{!Q-cZrJrHE!|rh}Rc-ey2RR77#%
zrLsa3f>P8{8_a6(*hxK>pjLxgjvg!gveV!pvyR30u05iAp65INe1E(%YwzECUu(T<
z?X~ym2dv``>&sL>^3<z=18J~QuB`D5H>G6(%$4%ISq|LUS0_a?(t-7M(;16>gWc%7
zD-Fq$cz3uvoL4hKHps05d$HV5`2+o?aUXQFhh01Vm?J)Nz~;GsMRE$WQzBF2{I3e(
zD@Lg04`iF&swIvd+h;Pf&TcYhp#za^T&3M)wKy4-?=c<iR=a7x)p>2-D`i0EY*z;H
zb@mO;_C6C|m+kS(uX>yFI<;h+pCs^7VNVYzwpp$QgMtQ;iu&y)A0z84#pnU)k8S`B
zbPGZz?q~_<3goSy^@gO}@l(<1YfrED?Z{N3h9~K;mUG81z4G+h9L*gsxpfR0gUmc@
zI}`-G6fG{=9_sZbGf-ph4^YZT9;fE$4DR@&u&m>rnlF9xB0R2N?=m@E*S_~SghOM#
zX38D0pcu&OeW63sW;gMTW$~>1OgLK~)am3}I-6BqjE&l{`@S}?RPo;JFf`~ya%X0t
zfl4Ij^_^LD5dX?;&pK!_v|C$0Z~eO{4V?^VOwesNwSJ~V4f+>VYwRX-NCw!AL3sT)
z@O1>)!VfnYpmkP{*&g1Us4^>jxXJL)CO^qN4yk+gpsx>j{PLe8Cm(j$P5qDhwaY!z
zA*5q?<6T2<N^i`GL&?^^Q%k+~ti%3Og#M64tcnfGChOUdkb~o$+39sYbs~4%lefk#
z@*&6AKvU8+XH0u1rK_K<*T<Bq>9r`H8!YWs;0%+TjH&auqBScpd0w2dO!tn(zn;gi
z+y^LlCmuAne`iB$lz0D5b5JIf29@DBY5gqcNiz2qby=5rTh*Gjzr5<ebl$M4llk^h
zmlheCti5p@de;$F^#RW|6&{w<1vX*K$%yB%O$MhCdySsY0qHXrV)KEq=@6UlQOD#3
z^bT%I4Sd^VXfpf`e8AgQr_9wg=bz**eti{;RcFV7$p9T&`0<|2zWx7dDm>>0y8l7)
z^#q7VrJ^*nNoX1dcNAS)<6Gw?xqiPZ5g8=czwUBs&oeTs25F#Tzq?(*?s)9w+snGf
zZFaVgH??!p8Y^^JqlBuE_h!4*!vQ9y>{EMPdYg~KZgji-+DD^fd;*TFpWtTqZZhc6
zzy;qUe=xQaQmeP!n2Fa;W#dgyGKvScwQhU3H^B{MW4(?%U^@8f*9<4Ujy#<8c<#=r
zpWSgm{>yIzZC;&U+Qy@N(@MVLwac$xaq78o(9|!eRN}lSc;kWm(m$FE=L=8tyup|y
zb|XAC_%sbsXQh~iFyMB)!Pwj!!)y{qA=JZ9kNpY?c2hoO{(}eD3Eg7>po9U~ECqN4
z6Fb=ppc^U48{jP!{(L6~cvAr|%n$k10P}-Mt0cm-DjJ{y=^ZUVVJyH#q?K_1=Mn%W
z_5mp93s8x)ED`yV0P6bze2;}etpmtM+KQAs03Z$Nccf2}0gj|157Nk?06(Px{E8GX
z5+EDtJW{M4U|l-uN(U3{dlo>E3GiSPz~^HCinGzjap(xrd896+r_oMSG8k>v1HAbM
z(xgcMQzru)$^|%zwE8&!Gt$VJ0DF<1n~m3Vus-AioLmerU<rDM6#f!Gj|mkAJ*lh%
z;S8=Vi8D~Y9n(+tw`j>v?or4Dhj7(7iDX5(fOHk<JETse`$&(FWI@0wkV25ONd1sf
zkus3RBTYxjLt28g3hD57xBlv#NAV%Ots7CjtvO?yEfbD{#NL~_Nxd!O<lff8+}_sl
z*}X08{N7euesAk^QEw~E*xRx`ZavNKAIaz&EksuzLufzC+{@qiT5qfDt=?8=U2p67
z+r2GmeQ%3@*KV|%m^Qj(cUf<JrfgGvWeo>~vdz6-*``JcL<&PXD%_P~%MHo1-Z_DD
zO*#H;A@%-kkx0Qv$C1siO;t~4lRIxwnyJ6upsNf9E=LF4omA|PdTcKQZs|_!v%SDQ
zi~??N2KLV+;Eu)ucW^auRpWuvST7ZVP6{`ISzwiBohS|Qs1CYq!BP_Ey<AyP;`GL7
z!nJ+FC&v)`ki6?XTg#d4n@=f&>p<xT+$H{i`z2naBrJp~AqhSitR<Md>@%9Rgpd<H
zIZ3=J#fMd})lRLcrVxX(Es|A)Qd!`56B+1xBWAriU^QoPThn@KU~~x&Hf}|f*pd{B
z1zH*;x5v~ds8)ubGo9Z=7d(%e3NhzHCugd{9&^<fbg4)dFP!G%-1((QA`k9`3p$7U
z-FmjcZ*yR?M~&o`$4PdZ;Ix?09zhvz{LXJ;x4|{Zt*n(!md-A-{X)!sf3N%OwxeXe
zf1;oDR_m=Zp1fY-3_K^2ELKHuebLLe)bN08Q$-B@rhAXt_klAVG>Aw9YY^0%)BMda
z%)bOM4aF52M~Sbk_5M@7sA}?&JXG;yI{$GsQgGi8q*RY)62RN`l-GzmIsGOLc_}bl
zx=QWyfNTkD6nFkPo{9z@PD5+M&??swWAr$Yf>%>Leg%Kq!Yz_5&yaleAQ^^M9p6sg
zP-_EmbPM6#`rFe04I0v+?h`r|W01G$&3e=|QWQZ@w-@1qf@3z}(jrRyX$>{cdH~d6
zkI-JK8Ui{pJ}5Qz4A4l<8=ML5b~yhl9gS)q2VXwKuN3yF83$<$(lWv1i=c!MHODaP
zugOkLXo^2I5or=qPE(p19K<&`B1UBOC{7aSP7lg}^9H5^uEjs@#i}D@a&QnS4BpM&
znM6E7bm1bQgV9u|Q3VPU#@Mvl980E$tYEKBA{Rn(=wDc9blB5A*{c;I+X0(PEYMUM
zXx>3)hjxk;R>e>b8kRe6S65mk9V9Qzg~N;!7`pTP^>J2JpThGi4)>53!d*C4#ZiuI
ztsd6)OjrA_miv<>5iT4B@sy*+4_Db}zOwYzMGaXVnaf&^k<TJ`irtx$KpAD%oDSvr
z!*;TYH!y#Y@A)DzUrry&H<>?xBUM&eYQM;nV$EGq<e7ab1KTuD%{-89X6(`?vLPys
z!9g1p$CQ(QMh#%r5LNW>0WV#B@bX(PGRvt&mcOymqf;L(N_c7_)nn#0%X^(78>5#p
zV~Hbr+C*KuY_lBu!F{vY&e+)dV58-Vmfe1BPzm4u)6&lGH;c3-CJEtn{~Nc+7x;9E
z<UV7Q8y}ZevM(l-;fW>Y*>J_zjTM`G6bk#UzkNEm`UUx9MQ)&3@jRMJysIR?X~VhH
zRiN8jjH6T)o8~97!1tpT$mCcZ*%_PRepjtpE$iqc*JBexZ(>Q)$3V2KMIU`eJ9B<-
zK*oTNNo1Uwxk8?aixlfp_7`+bkJFJoaa!gCIUN_r942?-7R2nj;>RrjxW*RCy`BYk
zN0iZv6M4bm!hl}Pj@OZW@mlG8tT5zE{9sd&Fw!KvGM=j_`_rRh<DY3ggLjAExOnlK
z)I7}|g^_Ui5O{J3M$6dc#vu``!i#H%ArTn?uxCug$&-?nko;?>h9lRQ2H&2LPUk?m
z;g`N=Xu<H7)Vwp6DDl*OBsh|-1tWAc^0?}df&{J9tCRC1`x9cx&k22!dvFt%8Caqy
zxy4n~cFP2fz-J{jHh5IHKe=jZIHdMBNc~HAZ!BhHY@ZR4qIewxXuQrjGzERvYZZe?
zLm#cbx+h9msvF|@KIpY>DgIb@NP9w<G#-18*!pDmyUF>1tbzt1;VVCGXn4^9e{vOK
zC-i}=Ux**0sZ`4yWMbbSaR=QQD5QB&-w0+C8I#bLwDz4oV6q$Trz>=Zdn^l{73UsR
z@jcsR-Au&?&1SpS`%KUN2DmA6+-`I5R*Cfy^P`<)C29h`X%mHG8zks`DKS3e%gX_a
zRYu5v*cnh=V*jdp<E;k96DC!k|Atr-`}v)2I~JLt2wk9mdkQ`a)-`yNp2Ss8_jrF?
zOs1MxT|mV?EDU5#5+B2Lg9`XDR;da!e3(=hzge#>P1V>uS9)r}ZT4R@VJgzzCxHAj
z$)71D50c_y*!U7qc|>9<wzfDY>e(VUhk`eQ>|~Ek-mGYr?e-^g`$d}OJDQub4Pa&)
zW;>=~PfV;HhR+hB*sLkkquAXCEYomsflZ+)f!LGpH_s}5s#>;tEA|UK>6f~O+_vWC
z@4BXbqlz+va!p`diNe2n`sNq85|C|vzu8Nu0ew3&YIgP?%J`6B{WYffEbi04<|`&~
z>CngUapM+^o4o%~XHQ!`ly+)^G9*te$g1laDm$GcfeyZg29e9h2UC~bcgOB#i*?0d
zb7tUCksq2c|H!cn98;Gl7UKAnw4@a4qSAStA)uRK!DD+gSHmdx%(p0vgZJpkz5a1y
z26%h`S({?^44I!?JQSxA+o5#8hq%b&Cd+{Zg%*~!m7r6t!J`hO*gces=?E!=4(AfZ
z^6OfDBO`R9#6z+18DYq5)b)|wxT4>fQAp0}&WaiK;XV;dLgfIR$G+Hx=69MKoA;5+
z1ENi}mwh_Y4lgRzlv~UFJX-Pa!I>m|>^~fNrRjLbzf-F)LpV2?^WCxu>$wUia;`D3
zShiUuB)+n<SH`A2<^Vi~*uuNX<tN^AtXH!Spj6|*fb))Qi`m}C_U8Qr<QZp^S$s~s
zI@fUwhsknelvwCMR}^mVHvh2gessC02X+jh&a>sIc?s21`5iLzEwGi{A6wyx&)Lj%
zXMe0~xyvcQBXFm}$FoNB+wP#<vXc@A`C(uM^AdS^P&AWIY6hv2L|V&+Qmu3Tq)|w0
z9?hJvKV|u=#l7*6D}%KDI{_aHzuV*G2SE<a_H}B7fp{dxMykF!X@c$3Q1%Po%QdkM
zX1mOiA>@uOW5dbB<WQ5J1HQf8RfgSoRRKC15?wQnF2*ii4mwtNo_6OemA?qOy12>a
zpM9^?pr&g-waYB2d3_2+?iz<tcWJQhyfMI|lllJ0dgg~q8?4`7h|ws1?82ut$4R56
z@;L5|aE*!42ZW~PIdgMkWfSVA9)`cL#GsE!5BQM$n4H4=gM_DqdVO|vZ(dgyWAk;K
zCC{eBcztvwe=BoM?ll=sk(DW$K#>ni)2I*sX5jiU@@mQ;`Ke<=g3rJ-r0GZp$i0-5
z@V!`|<=b!ekjva^=#V&=TXK)Dz*)xrAo{`MH0#=}7H+=enm(pPnTu6GWFT)iH9%e;
zJlM-Q3{Us>+rF6mJh<;z=NX4PuT;L>I!CQs4N5cb<gtGU$`YO{nsJp{Q5u0)NTy#^
zEuMY_c(ufTG2U4)`X%^Ie}?V6P%xP+ct(>NC}m-4%oluml36pA_lNYPc1?N`L`~(V
zGow639_5ap9<@t{<5q_=?;}mmB$?<|<@9dG>ieO_=ZfEeHflb_2$i0l{o9Tk`AQ$(
z44$d<;x@W%mGA&JqkR;926dnzYMJbsJ{F>#otWqEA5p3eK#EhF6~um{TZ{ko_A&_z
zYE0s}cN9ODe6PbR-^(cFKUKr<qqe~HesbKt1W6cp!Dq4}o~~(;soFWTcu1$Y^R#e?
z+|L?G-CrUHojwP2X_G;B5NQ=&8<Dzm-T7YCDLrMKnUQCd)8eekFMXExWEZ*#*DA*$
z@}Jbu0r$Np^|*C1w#-OYk%^9$*bTVEF*Yue<=t(DAeMj72Ii$W`dTf^@G6gt8ZuM!
z?PYyw##&a`QL=p1ZjozgdZDkIhYTcLL*iBE96Rk-v1&3mH-3LHCcoy3?oYq565Y^p
zaT(L43o<8$>d1qk5s_7wWi8^Jly@iR-~vl|nkvtgo5`SI(V-Py&REL7zo6Cd#cIWB
z86I~Ba95y+6b?%;z1)Uf7i5)=bd1;P>n_I3ui?7o+kLnz%z49+zsfpA9&7QT8oHUA
zgB%OnF1#aC2)&M?j4j{@R}|+sFU)_sfM^`MZeNINRfgX;|8OSufFd0qyHqh53fSVq
z<p8tAgKJ~qrW_?a=wP5ClSyJ)Xp-I7W&Pr>O`TF@WHQ~DO8DEe3)x9M^uBZ0=#<>*
za2y_P+e68UwCM1PP69mmU}4^fs(sY0iYiUd_UtG#AAa9Tj;5)CMG*u&OCz|zmq?@T
z`>09v$RJOp19znXvJTDVox{UIzxva=(`~z)tAU{Q9F186C*2%gs6ViME4er#a#$FS
zw>&IlnK*iAF{5kM$5_zl`bF2VM<;=!1&<avHx=OX8|bXauigHLY#TmE?YJ6lR5gn{
z^3D``^zXy_5w{UK7Dsc+h*Y^2AM2)KI8N7;WZj4XNh|-9qiX@^+J_jd(>a;L2c0{v
z7Ab^Lg2MA7bY8SnCStmV7Vaaek)zZ*QEoPBRj67Otc|8=mLcr^R#G@}IKQ6ij3ye+
z@%xL(#cS2x4_=+mI<^)<#91Ya^Oo3$sL9olLH<kCiU(L<d8?+kyb`&7HIqpy^!@wm
zQOi6R3quXz_fsE>h`j6^EqHlFuTyi|XiR;n{U}WMhn%BhQF3uS>6@Nl@^HJ<)7$a9
z(x6rvXxYow03Y(zpn?K*fFY$gxfo({6#Dq-On2D$<Gm%(YUYXp@G(dq{gs9;t+Xso
zk<dzGu$0*^#7<D=ut{(sW`a_QT}rndw1OzH>&{_!*|3d8!z5G<k=r-MP`7CrSxiex
z9JBIQ4S=#3iYLJ&>})rXGOF*+8~PMFhxO@1?iE_qy4r)e$sX?43?ZdFU((vLEF^<(
zGQ9nlw*&7)GbK@$seC#(@A~xo(Dr^^wB!4)-#1n4`dMXrs%&C4_lo_Be}gKj1e8&F
z7*vq3pvf?x$H&oR=vTd|N7eC7n*mj8%uy{)Bi3E<pM3VoDTjN7N9Tb8eiwvg>c->a
z#_$&s9OH23F@~E0v+&>P?!*4>xDTB9<a#u{LB+;LWQfn8+p=gHsIK^y2@x5J38--*
z{wMFA5|OEJb9{`I@IZlk!$<9WNhFs}ax&9R=9oC#EO6DHg>cPzWF+C2CejX(bAHkp
z3g9<cW(47AR>FW8sBbh6?$Q>w;_2uOi)TP|J1w!q7y&o!iVbi$qaXM)hvPq?8rUD&
zHoVMDmg=>B1MuNzU>}30&;httw9o;wwVi#@qBJVzV_Ar<{z25CXUEb=Bo;Hj(c^+<
zo8*F~S}JJ?x|N#8tu#kVy{IO5QoR|g+dCZk=YxZEZCitxW|!KgHry=vhJ$q%$@Wo`
zSleD=AC;(>;OWPY^-%DhKkGI6Xnh<>8Xcw*8MkCp<D+rplX0VC`#r63iAw#B#@qPJ
z*u9`~AU?e+qtAf!RQ{T28#=2u{fLk5u<t(kVzhP=)`<t{^Y{9dK-JyBmBWhrukqZG
zjU5qc%!-gImO0{gWSHYmChX|XSMoDYK3kb^k`5hJ)U!BzS|Q?c%9^B|6L+ps`x!g~
z{r$cmlg5OatW5u?QnQtJlf1sJNxTC)G>*FKtilQv8>3gSh9)7;?z}>k<l&EtY8Li?
zpd$~b5Uq}1V|Bz`sqS5zFmyLx7lP|AQtAr|!NLBX5<dHhhI|8+CYCX&obybgQc3QQ
zNltlcqpqvVy1U0+v^w|>S}%UQs>5Sm=$7MhL5i~SB{l6e<VMyck~TKYUzGRS36yI&
zDIOaxS=7FWygK$JW&&}`?n~0MLzv-YPIh?6;5NQaBvLt%idgIY9Lc0KJIT}s&-b)=
zzQ>pQcgEnqhRc!YOTGUmu(XPoR8{`w<EaNpxd)faz_)&m$hLu+QhXt^mx0RgtFPvT
zU)4A56*i~9CFV8>@89U@c9-=oJ(|(riQxTqt8@L!-o<pp;~P=>8aLv)A>xbzt}i3A
z$H__QxG)nfL*L=ra|6k_{7U$&FV}AqxxNmM!J&J6G??vt2`;Glm*!X4-gYX_zeLqS
za49~al(Pe4Hbw%x&phRA{L-e{s1RRo;Uzv!*~TyJ8zNA+!_3RLn8w&fyD8paH=6BT
z)(iYCch&vrJjt1`FiFxTZP(UG@%6B#E+-gtVLA9p1pnzlmB>v4-iGd-6NAXT2{XvF
ziDlw_&qAymxG(OQXdtsDxgay92*`Jn3}jx83o?GHfc!JZKo(ARLG-x-(mB~c7Ef_O
zlBWsC&r=L!*;E%Ke!76%pK2g0b6t?I=LF=pTmvyqb3qg{1mw{)16e=a1(D7a5aziV
zL3uOjnVoZ1#VZfA(&aj2g<e5QpK}p;=oFF7C?rWU+{yMC>jFgCyEls}bj%_?Gna+C
z^GB6*%X=FK1>LA<{mc0L7W1tO8gI8V<kHMwJT1OEGty)?zIU6B36@th#9+w<o0rER
zDYt?v@^yI9ZJF-O8mRoI1@}wv+rLHD?6ax049z7;|G3Ws=x|{9`v>Vz>Ww5-nfw*p
z{N)6Vi{*pX(sRnNZS<t#(cvtI1)m}rn+X(*W^{Sj;l5wbn19V8tB2iEOS%UOR0z1R
zq^IX=`rS{@*FufG2Wr3yl}h6Vp+;GGl#%LS%b{a*`O~8U&rZC9c369A9>3ekBP(Y*
zr1h-n@li&+Eo_@_Cy(#_J=+;Ozgced!2>=%oK^7QXN2h7`8uVg0Ccrj%S36oI)|oV
zH{KkNU~lMY%B-*GM+662pTls$7Ke(qt}glfyy5PXMM>Y5XTEDHJa2$&=4dy$GfSs;
zgY|`S_j+l0PlvudTWe-Q7hL;D(tF_2lH4Y#pY2H5^?}C}82B~peh*UxH-CMcV{UB#
znu|rlG|RE*`6x#`{w93G*kWlcdpJBmxMty=q}lZU$ulS9nX4D2;oS2y4N^>emMHNa
zozilC&(pMX^-`Op!x?G3O;UcqDt!3i&NnLUMlEia=}4{hknpe3#X~{HK0lh&J)bA8
z0;lIvLp$fzlKQzWz|naWAa3(&$-DDhkb`*w;+a=Vj^w!@d*=&?e10uCKHmkY$`=r2
zzBUow2Tq5iK)Q&tiN}9EQVtS+y91t2UT$^flZE-2q$R%}tD8^m=Ig|cn->TggBR42
zPZqe?T7~Z|(esFfwd8LLU66to1SI-}bwN`kTP0sg=14=`f@RZWAIpl|EYcTX0z=Nd
z;36_-ksuPkC@g|Hn};hcb)E)6ou)z10CL_Z`HN<eFBZ87=e#HgC%srpF2Cr4WEKd>
zz=B=GRxnQ-SL$K`d1i4fxv|(qCUJ>?q%El>x0bjd{7V9o{?ab;<4Z2uluHF<^wMm1
zI!q+Ijl8-vN!bbM@Gn)VqV)C+$bcO!1Myuk`DtlZ%BNi^R(cqx!t$iVJ&`IVT`{HP
zU$_|(4NmT5s&uO7Td?ugQj{lMOG8NE%UON@)zxFmx0bd#S4}CeO^mXR<!U6ZI;Sj7
zf02-1U+!-j;F!m?OHx`@nha2B@EjI5{;C*>!hhp%?k(ucMKA{~_~Fjm@@>lkq>RXe
zM}h}S0$4`D>tShtgpnT(5hk^im!|qSLb<t2z2$0`-FP26EM9nqmh!n=l(p8L<<5fB
zA+lpxhQE|w%BEODJGMl*vGFTkm+?S;UFMQq$1)*@)0WqgKbE^7ca{stEJH2nF}NT$
zgMiE{tR>PFF380~0a>`BmUygmL98nTWbw*c;=9TPIlfXrmaVEK0k60qjjIG?<trnk
zG!Sy)6+K3Dc1Wy)W>t?_WihKHXtj&fzE=b(<Lbv!r&eoG{Ok~NdvzZYUgW~N1K;%H
zY+7GbOQMW<14NxrRzwjzvX{t@!1V&d0bzGV>$<eKf3s&4U2rZQBL|GDNL;atPNPxK
zxv998B(8BmmKF<0)tc$-={4lenlv(CZ9HwxUi*yb&2-)xfvsk3BHMP1e7bfK8NAL#
zPwrZQVfVUPGHksIlC@4iUSD5J^c!4|wDkf~x1pAdGG$W5TTLP2sj1r_Fw~oBNwzuf
z8Br><CW@HlIOMlDSAeBC&h4dh1$%mbZw_fQ_apO4R<Q*o<g1dXV57;q4LbNnk-8v!
zVU9WPDaj<crAPaU5bqL-EWP^10&sps!11}b96xR=b4kR;K4j*`C2Uy@`D|mR*n21y
zlzNnnBJ;|M{ORr%7&wjJ4e3Avr*9u4on^6Nfo`XOZ+RwJP<~X5bZ!(>1yp2`f(jSp
zMwx&FZOSD5s|J#{HjQBI$H>i1BgEou<pNW9WhPls=^}o%LO`N6XOg1LE{J85fW&Rd
zB<r@gAcraiBynpPHI=<JmXvIDVW`_IFbt>~MK)C(5j#@5ML?Qr29u@Re96{rE^?Jy
z1$0<-CfQMaG*r|J>#8VX#|&oS0(*8V$=*Jc?Aq=kZP+GAkJ^z*UfXdrP9(jsnj+&-
zl0%|Pbg!m!+eltbKk`<Mi>4Xd1x=H7W|BeG{^aD&=`>JZGFlwU_#FaMF3BWK<mfb!
zIeiU9s?baU(w$a@=P+zOg5`H$7}AFfe+N4{NWt<}%zif>y&4cd8_e=$)KP%bbl+=0
zBF(jl)bx$o!EAR8QSQ>RsU|XXmsadZ@=n2#xw|sS2fJJxi6;~Za!9JR%k;6O{`%OB
zfzHWNmd6#w*|u3c1<ZNx9Nvq^d-RIoA>fe1dH)gKCzjnV849ZvY!>XvBp>h5)6GK9
zo@HXE6uSh5m-l9pGkaY`rMm@W#jBa*^H*JvhfbvEwM=sHH5cUG9zkZ^>zSne^-T8O
zF{0jA5CCtAl5WRurf>$A?8_uy@0-qiPLke8Pq>EzrW5JbnJ#M}W)?rmJu|SJ=S6Z?
zUlrsk-pC}^-w0#x93#KKVPMbgBQL$livv3Mn!va9%}io{a}N9SF*4$<K$9NtcDn(;
z5dYioe+T|+Wx&_re<uFtBK2;m@es3U1)eFD{#d2}kcn5<)2~zI383c{cn)3q;~Aa-
zNr$p{X<Hya1*HC<`4LYb7OVYMgCBnHY<KWqO6ZdRyjd>eQwjG<0yj^Z6H^lSQOoNs
z&b@$)Pb0l8%JC~Vw`^8h@^UZ_F2)b1J%OJJy~?Z-g`M^_)g|RW+5Qk8poba~$c#Ge
z+=N!``If%;0yaIVMD@28S&OHkyv50!Mm&Xeo{Ig>%`0JSUJj=duZf%x<@)G88YbA>
zJE22{Cw$Tn@>g9T(}$?`k8yjuhqWCb^Y=$G3R1Fv$ndZLJi(OWcj)*Zk8}t7@n<Bk
zF~SC1#@`b@;+F9b-xb+7_y)B>e%pU9nEP}IzTLiM6`_0I6wpTp?gjUDiwLcHOF)@}
znQY@BGUi}IFjUh}rQ!i&t`nGK^@)@zxqb>8wx3kiFA0|NsTcWee&TlxtM&`LUJdtx
zGr)$=iy%JJC^#UXig((cbzoqT_}S(|KhQlw$|88igzE%rYqj*ngXJ6eUQp!doVTf@
zrbBOLmN+LVx)R-(%W%Zl7%uhB!qRcMDVeC>b@{L*=b&J4>bq5`mO^t(q_?M*ZW;34
z*MFA&S))N8*Xq9|#$PzMlJQ!t^HJFOg_zSyd_DQ)-LROfLkl|S$2a+)D*p2ECQ#&E
zX1!oW_g)mcs-EP&_c4h&6d;~UsSN@{${~BqP(vSl*c-y#1n&sFQeq2lzH1PvN_<D)
z9D3LuQ`R{UKZ9TESZMpJs}DYfo_GD4kZ%+?M>gAu?ub%sP1z(MnMaygM-%Bjq8skD
znV#axH{*AD9@3gnt^`lDL`J!HsepWK>zUTpR;%*}%Z<+nwQrzZLtZ|5nhZVWQXC!$
z5@gn~t7PQ+E{Nkj!T7xQE#&3nE}e1bkbpEDuO$;txNM7ThXthhL@k+m(gnHLEFd48
ztR*u(bU~~~1jO=TEqUJJf*e08ARk+5Nq&n9(nx1hH-0pHf*frbDNflwe8Bp@ksTlW
iH>B+Ne?yEX{tNQj(vyhPq6f9)?NbSil6-M$`Tqjm#evZP

-- 
1.9.1


