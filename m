Return-Path: <cyrus@holtmann.org>
From: Chen Chong <chongc@qca.qualcomm.com>
To: <dwmw2@infradead.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] ar3k: add support for QCA98XX/QCA24XX
Date: Fri, 28 Jun 2013 19:48:51 +0800
Message-ID: <1372420131-4421-1-git-send-email-chongc@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

add patch & syscfg for Qualcomm Atheros QCA98XX/QCA24XX

Signed-off-by: Chen Chong <chongc@qca.qualcomm.com>
---
 WHENCE                       |    2 ++
 ar3k/AthrBT_0x41020000.dfu   |  Bin 0 -> 31500 bytes
 ar3k/ramps_0x41020000_40.dfu |  Bin 0 -> 1820 bytes
 3 files changed, 2 insertions(+)
 create mode 100755 ar3k/AthrBT_0x41020000.dfu
 create mode 100755 ar3k/ramps_0x41020000_40.dfu

diff --git a/WHENCE b/WHENCE
index dd0c5b7..a0202af 100644
--- a/WHENCE
+++ b/WHENCE
@@ -1922,6 +1922,8 @@ File: ar3k/ramps_0x11020000_40.dfu
 File: ar3k/AthrBT_0x01020201.dfu
 File: ar3k/ramps_0x01020201_26.dfu
 File: ar3k/ramps_0x01020201_40.dfu
+File: ar3k/AthrBT_0x41020000.dfu
+File: ar3k/ramps_0x41020000_40.dfu
 
 Licence: Redistributable. See LICENCE.atheros_firmware for details
 
diff --git a/ar3k/AthrBT_0x41020000.dfu b/ar3k/AthrBT_0x41020000.dfu
new file mode 100755
index 0000000000000000000000000000000000000000..b1470d8da3f42179f050adb29cbd49ac7358610a
GIT binary patch
literal 31500
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

literal 0
HcmV?d00001

diff --git a/ar3k/ramps_0x41020000_40.dfu b/ar3k/ramps_0x41020000_40.dfu
new file mode 100755
index 0000000000000000000000000000000000000000..77383bbc78276a091e525eaee7ef373c77ac7bbd
GIT binary patch
literal 1820
zcmZA2eQZ-z7zXg?c70E~QP^!)rRZP<7T9p;WCRB3q?m;OS<GT)G8Axxh48T{DnTH{
zlw^?^r!L4JBM#jXAfOn>hYQi7V<BXi69R<9;RcKZ4O4^$2_f3<`1IC9<7xZrd*AcX
zbI-Z=7L~8Suy{Riii>{v=kFJM{7$KC4!G~Ruga{uICd<6K<?OBKb{1_7UK4Hz-qB)
zFUl)wwZn^A*S6X06Wwdq{oJ^x!@j*En%`+hqd%4P*}dZ}oVA;VdYcFAp?N2oHRE}&
zUu65<X83Ed$L;pdTn2dkeK&d^`ur#XZ2zvD@?_8t*90r%=g9HGj0pSVA)weFD~2l`
zm<cyp0&^?gDsK%`#cNBV1+BXx71af77yJ}xuu$kNW-qtr?3wpb2uQoN9u*bIcoWvG
zQ>bCx@rOPS#slRT+<b3&3_UN_ADe9@u?@p(mSQC=1g&bevv0LvQSuL0AKI-l3}Y~=
z(2BZE`^WFaVy;&l;m!fH;l%lKXvekTAEgc>hjL+is=81W^mN57ggg^py5uYLG*1V@
zUW=nb+E#LY@&WZqZYSWA5VhqaW`a@^147b93+3=?_L3szi{({XBA?MR2_-mtna~N$
zl^1BGd`KfQnMP$5t(N_Csbh`QUju5TWEiNE^|W5zO94;woL9<uMh%ji1{$T5b?YU>
zxJf$bX2&fu$atHC#(<dA)41ec2U;9k9ouA-<FrdDTke$wj5}mI?UY%}bje0~Ko&A{
zST->}DqqkZ`Hh~Gr#R**`HQs)DP!Cx5$4azw>N+RNif!uq8BB?+A9*HgOZ@blA<FL
zF~BW}(c6-scO*rVa+*Gn@8}~LqtEc1Q(_oFO)BI*s1?+!_EDd@N^Lc1GWS8PpdnSt
zOrhF9!|DhvR-?2;m9n->Enr-(w$r(47BiJ<BaNufX;l46tJSP2+y}Lh)~JQd)T$k{
zPJKh`RfMioG1{OKv{9w#dKF>&CKaQbRf29&DY{LarZJVKaaC2sJy1Jot2#~FRGPM{
z@9AD;Xoq7t&$-iyx*QKU9(FwH*yDK8@swlYKl!sxJm9DuFFIav9CRFZ9C5tmc-!%g
zW76?~<0HqE;{j}_+#2h`(Ck%fJF(N1XLsP<{5RefZjS{U)`dPh2#=drkQ<{WC*d}W
zc}2J_KDzks%e47=#(?XNJ9B3-6Xvd1nfO`Diz}H7jvp^T5@*hYUAcUkjq*}DW`$w2
zOS|zEj<jPcMvV6ADTuegGbA7T|9><=k7JX5-tjlnS#O!ee1_gkXT5E@cLP79v)(b?
z?*iA-S(9ehIbbxM^?_M)$il&N)<>p$i3?rntSQqyL!n|UD=<}gFe9DSjqYDO$WLYU
zqG5MF)}*o;ov$qxk6ZR34_vE;<|Kl+i*=cWU@_X()6kXQg*k9}^BTk9JQEHZ?bjCT
z0y@_+Is9YDF}gszCY>5LF@GeTebuLf>C9)qLPO?Z|8H?Mx?MTO%|1`)%ra+Z=Kg19
zMu#}INHEXni8^c<{kZnve9uY#UXZgj`Z3mfc{Evb%<-dFozFkR8$Dh3E$drqbP;<Q
zU7{^n99>iuVOdZ)f1c5$TH)Y9qsuwUCuTp}^!HE1LR`8OMULgl^`W>Zz#B2|Ip36p
ouWf#Q3ClYQcH@L5ygX;_>LttH+_H6Bcv^L!_<9vr>GI{j0h^T-ZU6uP

literal 0
HcmV?d00001

-- 
1.7.9.5

