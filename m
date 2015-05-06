Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 May 2015 08:24:44 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: [PATCH 2/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7260 (B5/B6)
Message-ID: <20150506082444.0ab39e35@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B5/B6)
also known as Intel WP2 B5 and WP1 B6.

Patch Version: 26

Release Version: 152

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq  | Bin 16716 -> 17508 bytes
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 16552 -> 17310 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index b3aa287..9de6d49 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2454,9 +2454,9 @@ Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.24.1
+Version: WP_1345_01_patch_0.0.26.1
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.24.1
+Version: WP_1345_01_patch_0.0.26.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
b/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq index
eec0450576c6ee53f6cf8b6b091c997c8b9aa039..5b855e57a5e5b39c12866d60502221fbad4dc653
100644 GIT binary patch delta 4188
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
awhmnMl~qovOHk48SCuiQw@MvF%>Mwj2vtG=

delta 3431
zcmY+GeNYp38podv0X88afdmK;!V-{|@U}q2fG80dOK<Fz^E{7nsD}>iFfHeWsx^9h
zk}~R`w!S^iG<U;I!FH}_u~pAedgpn;tF3mNDb(sgYi)42PCBC%lyiEDa?fr|+5O`?
z``hR9y!_sGCwrJH-Aom;Z&nKou%Kp&^%hmUnhZdC2mo0y6X1j1fkuFh*W%uc4Siu4
zhz4#`3~-l<4pwn-BaH7qC)i-u@WlfM+p-zg!JaD_Zt|Y^bk@qAp0y5tBC?>j`KfIM
zb~2`}c6!TW?=w{%cfs(dVV}0A9<8$IM#|7c?~uI91N>^{#$#<BXR9+lj&i5hklmdQ
z-$deDp2mswR>^XFZL2f6=>79ofp1*fo+eh4y43L0sga(q8`VMC$U}@ca=RBSz{Tup
zO*#@7B&XIS|Hl5|>dq6?_L=Wc|Jg0+De(^qVtnS)k}YcldisZZsJ%<iG0VpHa5~j>
z1A8*)70A|SdVc(!>z6%;n!B%0caWjgG&lav@Ltco`^=bX3dXjo+@?)r?_!PMp=W(u
zd*`0VAB9HM`{%s$p73~XypVOn8`SRR{>7e;|J~ftPG7Lc&^`B$*!^=pe5gu)b_Y@T
zV5Povx_kIm+=q|g&717=k9<KV*-IZ?_Hdlf0PLEm`SJekhKj~}+Ree((T%>~se2<S
zNmGSmxFO2g)k{%9FFWKO(PcJ79qnYNg5JJ?+7a#=>^v-10!uJCz7OK2Tq!UGJ$|xX
z7@Zh}@%K~U!CP>5u4Ld{vR(GXO=&gzuZFApqW4mN`^f%civ9t+(-+Lu+`aw12QGy9
z7*o8}_>ns6bxc*8Vt?QO4nYVj)NS~-x+#%)4qyW*vl(C=>9@_OiMD0Tbpgx|svK6+
zo-R@|aOgl3WZ}AK3wok8_*!&+7as#`18Ih~{cJ3-Pw2_2fK4OikV;4$q!6ho3RoZM
z2<aB-gb~<PYGBur+DW@eePY`JET07IrW9Zs(}5jJrT8>pj}bdV`i^vu^h8bTtBnRW
zndBfXCA~)a6X^recO)ZqE{&8!T2&0JPy*~=DX_<HPCN<E&|u8O1v{;ziu3LrzMu|7
zZ)1j|10sv&Jd^X&@K78h%=AkLSZge`Dy1FZWBUVQ24J1>Qcmu4AmX+|6KMs1YWeZ2
zm`tV}AI9uX75y2m?Ju%A;#|QD_QrY`KkC^$yF15P21yKO->uE^l>*<NAXZazy>>BL
z&FTJ)%UQ1Mo*tMK+VEPbE4{8Ttoaqk$&%loiH8|6Dt9#=Wh+%$9Zs-yruKwLKW7vB
z12xG$qXsKARl0`Mh`l`rFKMh@vRosy2rv`mUN=N>wxK<qZmvE~EE>ffI~$1_$_siU
z?T-BU_7z!s(k9x&GuWKTZV7kXY>wFYEOv7^@6d5vskId(u=NldHwy5z#xQDxZ^K71
ziZlN+Qp)Ve+G+P1@R+u^qKNKfX-@c|L@)vj8f9bnnDz+F(AlHScz5U)*DbDM5&lo>
zSld*jHiJ`bW}IU2XwJ4PlD*9lX`TD2r7NBvTun@Hd$5Zc5kCVF&nB`>2PQ6>=(vOL
zgb@eg8W*rGst$0N-7JlsyS<w3uleuB5N%r832L1mkLy|zWMq)e8WD}2OPq2{O;e8Z
zvr)i{`Bu1au|Ah!alO74PwAbiU@V68x$@{fR*H^~_v6`kMc%_2iI@yI)<Ai9MMlcU
zN5ZXn3;xp3jOPrB&>pQ6YBBn8*r*^voJ2Ab{P;<Nf_QWiu_yW+zW^9drz^2>DeyWP
zhOh+qpXq^rhSW%UmUM$`Iv4&ov0OfyHocT2&*aAulOla{yhMu3e!ON@kQKDdG=F7D
zZmn3%F$=)D@b^hS$FGtau)$)H7jV<wAm<i~SAEVH+>YN{ymIVJknp-x0e?tUko-i6
zyp$&3{WJx!nk4c{x`02XD~Qo75s&o`_{6$JUPn!LB6VYPhEr9Ogzsl8N0m(x`eWE(
zo2^w9EXNzRH1VOy%oiUOnJeVEZYN8*x-x}iz5)2DWZ;_&bhA9Y+<Yl$=hn*uf^->E
z@g1Ci30Y><CJW|eDIC7ENDjNR1WdLox^;=}ZwlRKx2PslalpPF)3X&0=jd`L2h4V=
zX43F-_HyKMEUH!MSe>(0-iH(PF(5yGj(`gmc(Y~4;a#gp68f?R+ynck8yMiNM&Rir
ze7N9cW+lFzn}qIMMR)xfQm!Mp0+!|}dh>=&BJbr1=*(9TU#3I`^98IbP>@ZWL{1h6
zxYXf{@zR#kxX|lZD(`-KmgIECAz*!>BD}>ek-rzVn>7?FhVM-PUT6n?n(jqxEK;~P
zWlQdXA_1Q(R*;4qiCioeaAk>txE4s{vl0P+U8*2Oxf1!jRKONqLAX4Le8~&Au1rD9
z`4Sl~6Y!;S1z`&$a<g2(S1P>evNf8O$kjIBuf7O;uM6)~thQcRME?P6fD?!5GsJK%
zZp}4zr#1vPFL$EHsYpHLkWz=70&ZUDwaHRX7K-F{BJe@dBq@a2%HQC&%8qAdsDf7w
z{KsUS4%kNFs38=-Yy;oOQj8UeDfWdCJ5!iO_wr~UxIKLH(HFtG$e{{3uyIi?b}h1~
zT8r_Ii#EuY_X_=8(C&<Nb>I${J6=nR7&%ToCHRG_TJ9X6-w<-vRdwL*sveW9Bd6)-
z1ZIXx(Nz61?yK&RM-A{&RPy2u#Kj8ITPBh8nvS%ycPuGJ4;X!1MF_stO<7WapPK{F
zy6{wuTNNzEnVKSb)&u2IEVrZ%UtN-he_rC3(;XEOUAVLbwYB;9*;0?3dYuxju5H2h
zY87!E3nfzPZoxsf-z*zpYo$n{w{n=dEE!)|R*xr_`DNea^Q&md02}LGz%z9%m|S1L
LSpMp+&td)#DyCCB

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq index
a1b59597bea5f4070d1f3d8935fbe9ddd2aa8328..fe52824a5d0ff9a20482bdbe839a9d4bac91d9fb
100644 GIT binary patch delta 4101
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

delta 3416
zcmZWreNa@_6+iE>yF8X<SzwU`*5&Pju*=u3u(FF1U6C=Qv4%Rv5@ixhF|i%etQDJ$
z^OTjULB%K@Co)qf1L|~eLQ-mNYcnPSHAY&eh5Au2XjWsVbcT$mjCB-4&)#**d(%ID
zbMHI9^Zo8U?|t|l*S&))=iZ;z0tW)9xS|9TuUC-(2#*243R8WqP@uaSVDr`Z{juYJ
zPwZBM*rWlmzOcPqj345H|Lhe)&HY~-Y;VZsyzQ+$bA6<J>&t1gaC+L@e<93;0=3U%
zEAR(gO7li~$`c-N<$j-||I3I@!!wO~nRPXJsG(<=v)d1@HQd-!ZJubUG(3&*Wmb^f
zmkBqb_I1zf!tqwie0*i8O!3n5-+l(J>Q^^rgrl*Ps-7uT)4Ic;3fTf+0#UQOKJ{2%
z56S9NJ2rRqFWl5i`=Ie#LDrdZF5H<1obXO&n*O0f6EvP?O4cE0?dor({q6*jTROT|
z)bZC6h2Mk%63IGKUK%}qZP0(Hw&mKrMiSJg%#0rI-{-&ofE(c_VdP!jm(oP?X2Ae{
zT9?Id+_d-UAIFDP2WA5Fob+^Nv_SAd8|_=fKM9}f-<~<SDHv)^Y?=8i_P|UKuk)GB
zJBfu)RwX#^we;VP|Me5te^YqrNigIlx%0`OUlfChAl&DDB8;5e91NYhKa`d_Suo-v
zKGe*OgqnjRK>OKx_m1&Y?@m=P6e!l$^ICr>a5StO5YG69bXip~CpQU`p+IN%k|FVG
zGweD{B!DS2N8btYlioC#gw_s{4GiBJhS87G;NcOtJ5$_!f@FjK_(^Ttfy<GsOzM49
zM<>ZQq$NBQb_GMZad#*F?T3K~Kf=vsbz1~D1Y;X0)K0>X3LskzfGMgK_@=5RnfpG#
zPYGGI0P6{F)#9+qDLf*p`WUd{{K_m8)oQG%)MA-Bv-zSLgfYSt-G#%kAbdxwz=M!M
z$RQLH8VP-bae^rZgoT8yglYo_6SO`gfC>Z)!AqbMC0sOupi2WGlmUW29fTmQmBg(i
zY$xm`e4wJ2evCGs5C#a>2zpAUgs_~joj^BFI7K*1m?#9nSPVjy6NHa%-uf=mo+{0)
z0UNzuUJUH(A5itFw{rdJzA&d2{dZ<t_c&Z5Om#5|gwq<@m9b-C61w`r9zeL1z<i3Q
z`=V;*xacnMznu&BYqB`Nk2QO2VSP^g^Kn_6aGz%5xUe=h&*sZ9&xce_wC&MagHCXD
zC4~d3#G}lCO4R)W+haxXegbf5bP=>H8@D&?T_sk$99eVM;5V^lyjF*qg1B7eRvBXm
zyjvD~Ec`B}R7Q>naEHx!vHE(n1W1bR4kvf@Rm=$*;&6vht{XE&<&cAX+`@G=d7(g5
zq_WTM8)SRQ5|&5$Hfa&wiR5TBMr9X8VT&lra-+jax#5wx97mF{3}WMl0ltb$95%q$
zkqa6l8qY<e_BgD&Y=K0)6IZmdkR~<ji0e!;7yx<*COUj~&)gPU!f&mBWg)Jh4u;?Q
z?+3$~B^rY+y>W+Y+FadBbGbK?>39M9wWjB%9nnCm^P@Xis^{sn!PJSu*~+h|L)&Rk
z423@zQG;<cUeT`MJ3Uw!Z^3o(bxAT8XEdzZKg4%nz0R22nm>7uF6`&iG2rU-fN;ly
zyLGwN&e+iQdwux=z@G6ZTl&9{Iq0G5NbNeSYv2NCO(?|;35o!n0^|D=I^35=!^LUD
zp6nY#Fe-MB4MmErEs3lfOGf`sf*<M~hS~4l;W*~)g1!UaPE^Ec)iUNUi5=KvP%u(F
zV}=YJ_->Md@#`3KHL1dKf{K-%1K0Nw!1X+#n(zW)jASP~=uBRM&B^QJooh&7#@CZO
z@E0ixx3zl4e4WyPtwy&t>^gs%zA+xWV6@0xte{gty}M&<61+6=g)K3YcqA>5Eo-lj
z4iHQ|ssoo~p!@i2Dy%l3)$|iQY6{5Rxs#YXW4eT0=?cc4%$W2H34fKLV9Y6uv1Cg4
zQKo`1&}^jSvdt3qnydILMto>4k%v>IG6nlw34b@&?+lc<C*ghWhAjC<OyiA|_Rf==
z_%o>iV_?7^dDVduTxPNJw7g}hz)vlT$P;sz<B}{pZ%V_utW|g}OQ8^=kxi+2L_4oD
z;d*fuo);AgS7^4ALWNbrL93mY((!?Hr9AhGH0()XsZGM`HUr+Yx%svXG-fLbJWF2#
zQd*u}$WLToQ}#-{oUI7co5>Vj%#m;;N95_UJkI%{?6jURGrne?gg53XEIZ~h=H*-o
zZ|5qQHVb3c=1KUkJOvZXV$5rH2`B6drb%Q>gQHqw@Pg3g!BdW6yys9TZL~6_ALmPl
z99fuJ@JgEOP1V`LWEY)OgBP0$evVHH6vj2#%y@I5bf`!{ROK)tP$Z$cSiyMbF=kt_
zgj%P9Da>U|i&Mfxmx2-V81tS>LgRb|W3)4-ZN7x*B??AxFs8j^8)lWJ@oq1AOV^|~
zP$|7@K|a{0BZ?oCN|^0dxR}gmE`I5j(7r&#+6A@pvvQ|^vAqi#H8j{=Z5}Kwvn96`
zWY9Pq?h9>?oajph_-0u?AIwKAvpHq09iiU=n0j3Yu2%@PgnGh{2+`a8s1Prgt;7;f
zt32$bA{O>jPnG@{6%$n!i&5vzK#y0U+(-W#bX3oI8?mBX<ZGPxYWW*-Z>Q;JgcQz~
zH{#NT3e#>EV+I#C;_^ib=IDIJ{B@C;Kjy)SMLvC?NIMS>h8}<+C~8D}vEp_7tRhz)
z=U@r5`KF={Yo6<nGdoKevwpD|Rf~N%_M9EJE%wVb0&b@9?czFIyF_8zxPUSDm(<~F
mJ_S=>#+d*3>aby{oLRG)ng%sEy|jjYBORRSw_7W7xc>sOwNM=Z

-- 
2.1.0

