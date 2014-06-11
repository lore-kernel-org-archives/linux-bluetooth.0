Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jun 2014 15:38:41 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	Ethan Ge <ethan.ge@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: [PATCH] linux-firmware: Update Intel BT firmware for 3160 / 7260 /
 7265
Message-ID: <20140611153841.04db1c7f@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch files for
- Intel Wireless Bluetooth 3160 (ROM SPIN SKU)
- Intel Wireless Bluetooth 7260 (ROM SPIN SKU)
- Intel Wireless Bluetooth 7265

This version fixes several issues including
- BT mouse and Headset connection issue
- WiFi Co-existance issue
- LED blinking issue

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 LICENCE.ibt_firmware                     |   2 +-
 WHENCE                                   |   6 ++++--
 intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq  | Bin 0 -> 9602 bytes
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 3558 -> 9421 bytes
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 10612 -> 14026 bytes
 5 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq

diff --git a/LICENCE.ibt_firmware b/LICENCE.ibt_firmware
index 262784b..f878c6a 100644
--- a/LICENCE.ibt_firmware
+++ b/LICENCE.ibt_firmware
@@ -1,4 +1,4 @@
-Copyright © 2013, Intel Corporation.
+Copyright © 2014, Intel Corporation.
 All rights reserved.
 
 Redistribution.  Redistribution and use in binary form, without
diff --git a/WHENCE b/WHENCE
index 6a64fc2..67b6d22 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2300,11 +2300,13 @@ Version: auto.WP_1303_02_patch_0.1.55.1 (0x37)
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: auto.WP_1303_02_patch_0.1.55.1 (0x37)
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.06.1
+Version: WP_1345_01_patch_0.0.10.1
+File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
+Version: WP_1345_01_patch_0.0.10.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: STP2_C0_1339_02_patch_13.1 (0x0D)
+Version: STP2_C0_1339_02_patch_19.1 (0x013)
 
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
new file mode 100644
index 0000000000000000000000000000000000000000..3c889ce1662a35aea2ce374bd4fe4ca292acedb3
GIT binary patch
literal 9602
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
RYuH0X<)3*_H_C3o{{mS_1^55}

literal 0
HcmV?d00001

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
index de0245a0b76d73211592104304345a436e19b0ac..4fc3385c43148b0335eb40e73aa0dd1cf018628a 100644
GIT binary patch
literal 9421
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
C2E&5@

delta 1106
zcmY*YUuauZ82{ZrxxGoVCO2zGmbU3hnq<*A$h6LaeF$ZQIG9WrbF4VFF~kSK`lt0i
zXmh7qr$f53<FIcwU<FZOuv#*~k(So!tV@`aZFa`fhmO4naReW1HGZdKG<*1+bMEi=
zec%25ob&T@ciVHy*qR3lOz6svO@`W{69K|q01=2l+3R%LB3CR3Th9U};hO2IN4>AD
z;`EBDop;aZ=bL7{#FsJbQ@5<X-Ad;P|Lm37??ui}=hB-<1$WoF-`7T?2Yq6M5x0D0
zt;3vN>qxP1zyDt?-QGcDx*fkSh5I)LrPCWoWe>j+l1AC->`;uj;<lrk`M46wRg^Tt
zEs;|Q&MlCnJHqbh)Z2tD?0s>CUAW|2`f;$i>T#d_g)zqmb3)xHuAc$t&{x)h+kW79
zE6^7LUMB1&Y0q}xvmL<Rr-7YmK-mj)9RwB!fWKb?I_o)LBifTVK>d4y49*E^8edk!
zys8?!uEw9AR$=}?cvXX$rZyiV%n)?q93AGc+zDS-mjBBa+s00c=KJpnS8dA}t@mZ-
z3Okf}u<y_CYuYZ}re~gURsuAgJuJ<nq_c2Y*q-=CO8?a4NNY|PQhDov$>Mck^C^9o
z_N^PdqHoVBJ$fs8q^Pp&Z~3A;!R&SAi=Ievn|CSFIp;rmO0pWO>=$<ARMfW2r=U)?
z5La)i*VQShy4dg^550@37@@J0<z0Hn-5~C-Vw5Zm*26+K%^{pl4kO_-q<fEAfZ7F`
z1sqdITNmrSaVBDdpEcT^U0F;-#;?Ys*44x@tGNuv_2)p)hE_d9t684AJolY;dEwo6
zf=4u&k-;X}d;lqyF&O{JNHSZKDLifhAKqIXnq81a3Y*yEuF5a(Z60gNHg@k0O^ecD
z!afP4^cJM{5%c02z{h<P!H@Kfih5b%S5(U1$ej5L{*={F72Pii!%z6<`2p(@W!|-}
zj9T-2AQ0QRyigi67|Sq6S!(bv7}82gu}pHSK-xJIw*sX>2mF(;X#CSxP3!ThT|qwC
zb*HhENmDAx0L+A)3^9n2(p&hH9!!Df*&{JNcCW`c5ozV0M?^!6>mPVXS)|F@rPrlz
ap9OQY(6^O=e;F<CT=!#&aq)}pnDReCW?x7E

diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index 3177c2984b91dec69f61124cafada1e4fb29d491..13ae0690c04d156ae224858a03403bc2d958df4d 100644
GIT binary patch
delta 6529
zcmZWt3s_TEwqECva1sbPAt4~ook#>M3RQHtmexSE@^PJtV%2Hw2x?n8wGw<a_-GDP
z6dlFKvG;nNwgXmf!4V&A?FVz68mzYJI2tV41Rp)v+6EtE@a9^t!zXv0gh!kU-^w|A
z?REBE>tAcHz4rFcI{P-E>iX0`0S7Fds?pPtEHVJ;5dfILzhnoQu%MOdODH(pmr#2+
zp#a%#*kA5S5ls8j+NuQDLHjniq<1BI3ij1!G~1eDz$ZBrwQ1O<ec+b+2)_TDsy^du
zbv^z1?^9i-cGhP=Uf37Wb+J2EJVj;gsE>DKBd7hF_OB&J`>9-f2Pms*KPA~iwDJeE
z%8)ya@7W;hKx9*7zI~xRpMaLPpKsmKx-SxpfIUr-3s>i$+=U97++p+A&};HXGTQV1
zMUyhc!peLTrOhcRkj}T#tMkpYw%A<7yt<<;tMNjG-26>xLHGH#Kzli4Ez!z0l;B|9
z-}EJ1xOwy!xDw_&+i7@f7xLKnd=}zpiV#5y+-`>T8?M+APt=1^AT>Xo8x`b#DW+1X
zvu#W|1Bp{)^%LP*$>o>B&#R<p)s+rsh>c!KMqUP?3<ZO5NcQOi)60Mq4ZL%oqhrJ>
zDp@x>l!M%P;t?u-!hGcJQ6KW>Cei$2e6QkJ$r^n_RT8cCY{7QFN2%$t{m)|o-%FgY
zsy?E(7}txvl-^N`oY7jzp!QfT5k9I*vdjNHwrcW~LNdUWwb)<2W<hu{1J}afw5_S)
z`M&8fkq<)5xJt`r>_)+QXtr&~C%9Q3C28#{E*Z|OWPB5@k!{(PK(;*+B&$5&W3#(T
zs`L|*EJMjNRswEyMHq$?@0J`C67L2STp?D|mf!Wo%$DM8`A)_ofljcn68o`JvfHqK
zw)9DB5cYks``S*nf#**#@Zb};*FUz&j{VK7!0`C|*rloc<E8a!hx#~A1hyBdN`R~A
z>+i9_iQxCADT|%{O6;cNERP7lPVjF;JI=8HSCO_U0JISROEmzykVvG+GjU0k2>@>-
z0%Rp)bl_Lhk!B;6AuS_f24klGeT+DrNgBQCR{$U60(2m8&jL(CDn(j{^Z}A458wx+
z@M&T#lVq_i0Qd{iDWtPVw@Pq{4J}!<fkFjY@gS4#Sjz&p9jQnGoEyoY1kQ`}BQEtN
zVZiw~;O47<ONju^r2&qmf!mAp07=OJHxB7eByjuC4=Z@!7VCiPi~_D+4_vJQxV1*$
zB$UZT9>f91#p7Iw$cx3X2{^b2Gcr<vdyGOxRAhD<aAWaVh}3eu`!NNQoi(u8ZxVqj
zH%$gYoMGK3%(#YVV%XPyf^{lZQ|$_;>;?rn(AVHxFRAZWORV2mS1l>;51akSFQ+dI
z8bM2u)|UfM@dGwqJk6eSgot_3H1J>iqBEN2gTf`p8l1u9FSltj3mO9Rp|+92%_uNI
zA+Zv<k0pC<t1Ut@WF6H7+Xa7baCSS*ZdqfN<XF?Wnb7VOB#BgE+i4r80V<k{<3WuA
z2*udoXD4mJ=fMi`lH%=gL%w@-6>$PTO%ASUaON5XUgd=i6O2^>O&PNE9r-hcta?YB
zs+{Bq=M0qfK-JsUeKMOSMNc<4xpyvL)@vw(TCM#;1!V0lBbzcS_1yEI3hw|+SlSLA
zzCRO~pCK;KpsBSiCN~G=lGFbn?*ruZI%U(8<YBqh1>Z|eatlcIyk{>O98na<nyR#i
z9`)bb+GdC=fnewKc_DDS(9z)kl`9RSXF2y<nCNN{CU$hYRjn^4+WA)!bNKPD`GMb8
z@ps(iqQqAHOeD%3XA2JZWB#nf9K#q_apFV$Y?OJ*^%C|&E$8r#cFjRXx@#`}Dt&X1
zJvZ>_;D<6SN>XBz?1LuFSI8!HpGv$0H6YaT03dLZEUzFXccQr@fEr5ZX$8+&k_YU4
z)}wHrXg$%!v|8+nj<q8Q1jn@Fm<}roSvbHhq%Tj70j__{<NoN0Aly3B@1XE61csBi
z_yBh;iuxSGlv-T2#75aEDGFWXlt;uR8PJS!a}}~SO46!;KvV&-&eaUP1vQ=C*Wr}j
zbqt$DltHu1n90l?iY~e}+8%9(Bg6$Baw)17T8N7@kq&Tk%Y)!>a}zr>ZbcVd8EnJW
zf5G4#ak1acwQ{m+E7RICRYf4br`Yq-o~zc~j}9oJAhv(tSJM%*>3w0iw+FSd{bLxL
zEfi!;)I(MTK0{z=#oPn_Z0yKDI;~U^0hC0>PrMSALi?2>#VvE3L#eraFtiNqVZ(9g
zEuV8a%5x?V8%k2Yyx0W-e9!PZz)E-uH<q98IiAset9!BY)AEps4`8wb|BDwtU-#i_
z^wwxXLAE{KKCeVwq3n{iSCX9aJ6?F7`XX$rgFVP?rLHLsD&33^uF>v2w&yi7`R6+5
z<9>&)l#+P6>I%;EL;0Gg!bST2TYks=(#dc1swp9QRGvQXNZ2;&Cfm$yJG9Q4VlZW<
zgjp2L>hGC=Zm(*K4H=zL<pz632M|3&>jk3hvYK{MMtcsbgUT!pXmi^ucNy*D%s~Fi
z<*f%jnB?K9BVou7On}eODHM0HCOg=0knz#@G`codoLMH@76L;(=6mo{q>~c0CgSJ_
z#vUoU81$SKqq^xi$cl}`l4>$!)mR~m9}C=QbcQu0;pt$cf=aG~dY!jjdptqx>X-Mp
zCJ(*;>^e8}ep3#>rXO9h9B@)v@aaqImN||mSl2K@ueruH$)P<w*^+_Df)n}5C)r-E
zD0pZ6jrCX0rPAU&zuH6lsO}xzn`tGS=?pP-7jA3d|MX4S<6&EW@fru#P(gLShiTDr
zxScxOd7jN?WyEK`lon-Tz5z@^CN9xPILdZSYx(&&<vvSHplT^-v9v%J`tL@v`V#f$
zPNTUB{-c!J)XOCc)ODeiYo1}p>d5^9j;4sD11m~Fa>es*>iWS>y2WTOtoX2`*)|wz
zWa)mFy7n&RAfRj!em<AFcl$iQ%7YVhZ|=TGDd7*DgL*&oLV&-e=c7)8$%=IY%{;nA
zby=G-D;ZzEr~kUSMX#!2ATaqfEnI)m$GAgas8!1_1Yjox)l7??lZ9owYbgg@xB5m8
zq}h{~;d-2n`su>EXKbSbIS9!1%MZQuD(6ww9oFJ)8I;VvY~Ct#DiE;j$~~p9pSr#W
za{y{DZIni#_O{EPmVLgi?e)}6*Is+jLl5D;nS7PWv?OvA8&u%5L(Q!kM$7KwheTO)
z(2!Wf-QLZF1%*$*U*0}GlD1*Sh=eZm{Ec|^OYE}Wtyoiu(_L9q*+ay8T%JH-RDdT0
zhPB}`4Bj5<dbp3ee#Tblk-BKdkf(6r9R2AyBm0{QL(g}lHtZPmKBnXW@0-y3xvpsR
zzQO!Ftgw%-y{k$VgtqZbGb(Xdbis+PVSCPd%q=oVnU|u`afV7|SN1xq#i}nHNbqE-
zqd9;*MRH$3by2I}DlEcPIJ^L|BZ8|fxB$S$tz4w~2-E?*cSx%d?-89B%R1lv==IdP
zUUi-@s;)<qx1FgAx_o~1@4X=~*s#vS_3zF{{}(D9!^+ZiQ5|vuQVp%#Gq#AKchUE)
zY9@du-Y41Z135v?53g$=YZ207q}Pxl2KqW<Agcu1rASowZPg{JGbX}!@l9FFFw~L~
z6sRTTctXvfR^jxpQbBlt^j%^@%n8c<D?2Pl*DZ<B_<~8@U;*AZq<9d7DIRlO#LW;G
zP+x>0+F{Cv*_F?%e)TnI+1aadV?0SSxcBKCS=j+d?;)g?y4z1cy4gFRt0q*36#R<u
z80@=Cg08AxUe+6Qs0|%DxXoYHNblx$Owoa=nCPwVHMFySf{nkm=3KOHW^d()d%5)J
zqSZgBPYB1b*v=fq`E>r#F6bI9V!Cm3pGtCt7%~rQbF6uJhD+foj_@>>RavzBtob~g
z{6*$uRmQuZHojA?2V~7&+diRk<r?{4xqaoD36=8yq=ohp#SNNN32`tIbeCu|12LLY
z{5Q4=8qXD^3K*Y8lh22%mg8h@`S{g-N{mz)jV3L+{sqX|wl0SnwC`c0I94@B7oy{I
z%<|wD*Q=(B-6{ipSS$Xb+8HWf#nKQ3HmP%Yfgj%K{pFG%{-kaS70pISP_!;Q$6(Wi
ziaM*}Y~U7ehc`Qhi|I7^RN|)_1=G|BXx@}eZx8xoo^4Ruf~es^9+q>fD4~=Wpd9NU
z*@p~SOBUffW)e)zf9i?t{Orx6xSfoQ7Wn_>l7xp_p(gnadPCRo4PF!S9+ni7ZPS$D
z8^F`EEG<xI(PVqA)|+AE`N>;p;vCu48VnAnjm9%YS8Mox233-4)T;}It3fGBJQ6Y1
zBv<vVVe7q<-eG-(ChJonuqNOU4E#GaTj&FNu}(9`Bo9oJ2(G~kQF4J0BFp1Z4PjG6
z3XWZdVT=393sy#4F(sbhOKbMFm+IdG=+cMJgp!)i^^vgt?{nXyZp{67n`&klshMM<
z)gOA{`uT<{`_lqxOP-6=@Ls15Z!r+1v}J;sgO{TOp-NI?CN)zPakStZAuu7DM6=Pd
zDha;$&GHpM{QiwPI&6%n*JhS3;ATN-tJbb-PWLr?XQ<x~gPIVV2Hu;({@|U2F+Hh6
z%PoWas!1;DN=cLM7Su#@0$3aKsw1lN8kt5-HQN}mi6qiI?baS8=$*fc&Dv+vr~05~
z1Sc@gM$?9fDw8Z(#Ws!!-7+5rR1~%RIO^A8K0i5OZ=g(4k}?dj3XGx$y@T;nYZM##
z7t^cno>`f3*BYZ+1-fdIteyqq<WpkEq5RPuJSn3K5_DJ7=b^8c;?k)=a`TYo#OJ3-
zAuvfX0clgzW|~hITcRd7unJRSIKa`_00=mX&hGDDcMnDY1o+2N0{p-`$BvcxA>(!8
zc|3SFR*+r2@`f^K!JXLQc<`6!UWN_-d??~p!iMz@JSokVWOvBtr12f3DrJ+<O?h6q
zUu>cHL)-#57NfHzYm)e}a>Z9a)-^~J)_*V}pCIr$yb0rY*d4>$(*9Cx$<wEN2Rx9J
zODUIQI4eM`e9;4+KqH0qYlaW%)LwZ;l$hy2wi_DZpw>6YA{)(iEjJ#Z@f%xzSbsk>
zZXrxHcw7&luFfkDMm`}pR0s^GN60Y1L0O+*U7{ed_ra4ku=CEd;pIk_d@AGdc)}ua
zND)YpI{X>LEFw<K)qiRU8Tc69eSn{<QR50ZQ$Yug6bj;Ace+v38?3Y;UVO>$QRoMU
z@uCF$&dM948tpsz>lvdi8W&%NYigeu8-4CqMHY%2ZWG#I!}c~15(2=7Ot&vV{#rp6
z-+>LID?pfPYG({6BqkbT!)m<OqXeiHbB*aVq>FDDClSeh43Da^U2Z(4$~L-@2F;nD
zC>}RH7pmQEyuv|qj{k3IWWtoJo3)vi0$}-#V9gZGF;b}HmZYF2(&f#T{+KRbv8i3q
z_-i`qH;JjSPe|f=z%l21XFd!Y*Yluk$4IEq@KEd$Ge$_6A=a%RvSjn};#8IoMjY$I
z`{aQ|Sb(diZ;bd%TqZSEd@F7u-ABZa<Ccc*5@jZN08tlj5GTg(ren>bEB=L0t>@#d
z6!@QKB6W2{quWNNY2VY2@TF>J@!~THPiS2<QkGPy^p-*sSk!^U$B-XSPdAI!L@9LA
zDJg+TNs>XFnndJD-$?p0bkZD)EC9s7C=CMnjW>9U+KknpSeX38q#2`RNx4VfgUIP(
zuiDmJL3Q;!7H5z>)Ee;?nHoAW!3#F<vxeww)?h@6L5f8hkuA<PrO@+J#nq-1s#yG^
zX{tW|;<%;RmFWwqYw=jpHF8D5Wbqf%v*{uD8}N<}{F$y`p~{fyF0Dh6I>T_!p(aiS
z500_oN^{b}#7pXypoSS8;Vs-&RZIJ+;DJ&}?6&Sx#&7HNg0NLzB|NQSK;KcAA}oVz
zO~lIlc~R@46}%uMM^y{QN~xQN)=ja)0oA6jTUE`JeC7_67?NE)Vm9O%-h`|o%zlMt
z;0s4O`QUyjRAF29|Jy>SOSp8|5b<wjLHzB=6`?(S!JdmF1@YF%6merpQE0Dkbl|)1
zQUp=37{s-flF;5Cp9=I|wFu(dqn;Smoe}8i9wms&Qp=5aNP+fYTno?P+Jh-#Z|a1d
RX<BhqS~{iwtSBvo`ae0vYxMvC

delta 3191
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

-- 
1.8.3.2

