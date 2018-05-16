Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com,
        sukumar.ghorai@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 2/6] linux-firmware:Update firmware patch for Intel Bluetooth 7265 (D1)
Date: Wed, 16 May 2018 10:52:12 +0530
Message-Id: <1526448136-11511-2-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1526448136-11511-1-git-send-email-amit.k.bag@intel.com>
References: <1526448136-11511-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the firmware file for Intel Bluetooth 7265
Also it is known as Intel stonePeak(STPD1).

FW Build: REL_52_00001

Release Version: 20.60.0.2

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 WHENCE                                     |   2 +-
 intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 47627 -> 48587 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index dccd2cc0adf9..fe93312e8131 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2973,7 +2973,7 @@ Version: BT_StonePeak_C0_REL_59_0001
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
 Version: BT_StonePeak_D0_REL_37_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
-Version: BT_StonePeak_D1_REL_51_00001
+Version: BT_StonePeak_D1_REL_52_00001
 File: intel/ibt-11-5.ddc
 Version: LnP/SfP_REL0458
 File: intel/ibt-11-5.sfi
diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
index e445f24b37d500cf10c85da97e4af92baecf798f..302239aa68979d1351e5c5960784afcdffe24bd3 100644
GIT binary patch
delta 13439
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

delta 12437
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

-- 
2.7.4

