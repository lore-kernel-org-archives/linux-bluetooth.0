Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Cc: linux-bluetooth@vger.kernel.org
To: linux-firmware@kernel.org
From: "jaya.p.g" <jaya.p.g@linux.intel.com>
Subject: [PATCH 3/5] linux-firmware: Update firmware patch for Intel Bluetooth
 7260 (B5/B6)
Message-ID: <583F13F8.4090306@linux.intel.com>
Date: Wed, 30 Nov 2016 23:31:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 From 592574a4b1981b81c52e17642cf411d5e6ae5445 Mon Sep 17 00:00:00 2001
From: "jaya.p.g" <jaya.p.g@linux.intel.com>
Date: Wed, 30 Nov 2016 21:13:13 +0530
Subject: [PATCH 3/5] linux-firmware: Update firmware patch for Intel 
Bluetooth 7260 (B5/B6)

This patch updates the firmware patch for Intel Bluetooth 7260
also known as Intel WP2 B5 and WP1 B6.

Patch Version: 39

Release Version: 19.30

Signed-off-by: jaya.p.g <jaya.p.g@linux.intel.com>
---
  WHENCE                                   |   4 ++--
  intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq  | Bin 22089 -> 22069 bytes
  intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 21908 -> 21888 bytes
  3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index a76da16..7e698dc 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2769,9 +2769,9 @@ Version: BT_WilkinsPeak_B3_REL_86_0001
  File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
  Version: BT_WilkinsPeak_B3_REL_86_0001
  File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: BT_WilkinsPeak_B5_REL_38_0001
+Version: BT_WilkinsPeak_B5_REL_39_0001
  File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
-Version: BT_WilkinsPeak_B5_REL_38_0001
+Version: BT_WilkinsPeak_B5_REL_39_0001
  File: intel/ibt-hw-37.8.bseq
  Version: 1339_02.00
  File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq 
b/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
index 
d3c9edd3b68d1e845c893c0d226117141947472d..793a3d9db264e7b72aa0e7d976d0c9cc52f01f9f 
100644
GIT binary patch
delta 202
zcmX@PhH>i}MtR1*KU@rq3>*wBjJmw)OnfXr0R|xc#lXOz$na&N{u9L}fz^)`6dL#$
zI5b!f9(z!ar05G+(PR_GCyEK8Gl~};v?}cIU|?wDRbWI?^@0&()MQJhCyERlzt|XV
zt`=wbHl5-9f4vn5RaSSHfT~O;+cDd*pHpC9n8a{may#=))+a!wz~)qz)f|lKn+187
WS+m60GH`6(?UBg?6i^LSVFUmewLxP5

delta 222
zcmdnGhVkSYMt#P<KU@rq3>*wBjJmvPOnfXr0R|xc#lXOz$na$aD}zD_8-qfOEdvJ!
zke(?2L=j2R7qFrxfz^)`6dL#$I5b!f9(zzfS%ncr)eA<DQ3;|miWeTVD(vuJU})o2
zV4SSUgsjTz4iiw73j@b5Hinz4#TmX$XL$c#Z^dLiW;^an3JeUB7|yf+-88wF`6lZN
jAXi~?Aj@hFMzzg<d6rqTyaBp%^Ky?&9-x3=s0t$hBilta

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq 
b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
index 
d30139e0229b043d52592ee8c1a49d0e261a7d9b..889d248b3729f8406e07750ef93a485af9fd8d00 
100644
GIT binary patch
delta 203
zcmbQTnz3Ouqda5ZA1($)1`Y-mMqOTYCO#IR00R*JVqjoUWcV^s|A`_$g91Z=1k(bB
z+XWH<9t;dfioSpqO*UbCqPRfV|K{RrCksA(X1u}lf#C*{suzqPqb6H2JyGOnZFr!@
z`Totz0)|5h3Jv@SRZ@4DfT~0$+cC?rA5&mpn8a{kays)xwmU%P2d2$-EIb^H>YKfJ
Xwp+7&v0>oY%;u5F0~9C-QDFoCAPzz%

delta 223
zcmZoz%{XN>qdsHbA1($)1`Y-mMqOStCO#IR00R*JVqjoUWcadzl|i9|jX~jy4Fd-U
zke(?2L=j2R7qB9J1_g!!38n=Mw+kc!JQx@zt1zOddcg=XYJsr-&BfPF7JT~5c!TK!
z!;Q(BOvtLV?l1vWsc^J5JW%6&|K?=@!yyHQ2L8!<%yQhP6c`vLF&t?Dx@mGS^F_7?
jATIM}EfyXQMzzi6Jlm~V-T)oC`ICDl4^SW`M1>ImMa)F`

-- 
1.9.1
