Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org
From: "jaya.p.g" <jaya.p.g@linux.intel.com>
Subject: [PATCH 1/5] linux-firmware: Update firmware patch for,Intel Bluetooth
 7265 (C0)
Message-ID: <583F1103.1050604@linux.intel.com>
Date: Wed, 30 Nov 2016 23:18:51 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 From b78f54e0f045658dd58ef7270641bb60122b0219 Mon Sep 17 00:00:00 2001
From: "jaya.p.g" <jaya.p.g@linux.intel.com>
Date: Wed, 30 Nov 2016 21:07:25 +0530
Subject: [PATCH 1/5] linux-firmware: Update firmware patch for
  Intel Bluetooth 7265 (C0)

This patch updates the firmware patch for Intel Bluetooth 7265 (C0) 
Also, it is known as Intel StP C0

StP C0 FW Patch Version: 59

Release Version: 19.30

Signed-off-by: jaya.p.g <jaya.p.g@linux.intel.com>
---
  WHENCE                                   |   2 +-
  intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 31019 -> 31056 bytes
  2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 86493be..d43c22b 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2775,7 +2775,7 @@ Version: BT_WilkinsPeak_B5_REL_38_0001
  File: intel/ibt-hw-37.8.bseq
  Version: 1339_02.00
  File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: BT_StonePeak_C0_REL_58_0001
+Version: BT_StonePeak_C0_REL_59_0001
  File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
  Version: BT_StonePeak_D0_REL_37_0002
  File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq 
b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index 
27a1c9cc12240abe951098ffe704ce3797e8f11e..7a227f131339fd1764acd31895746cc633dba62a 
100644
GIT binary patch
delta 6311
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
J`I-}?{|4+D5w!pS

delta 6193
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
Msa)3UDeeUBZ!D<v2LJ#7

-- 
1.9.1
