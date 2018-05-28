Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com,
        sukumar.ghorai@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 2/2] linux-firmware: Update firmware patch for Intel Bluetooth 7265 (D0)
Date: Mon, 28 May 2018 13:51:19 +0530
Message-Id: <1527495679-1652-2-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1527495679-1652-1-git-send-email-amit.k.bag@intel.com>
References: <1527495679-1652-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the firmware patch for Intel Bluetooth 7265 (D0)
Also it is known as Intel StP D0

FW Build: REL_50_0002

Release Version: 20.60.0.2

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 WHENCE                                   |   2 +-
 intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq | Bin 38621 -> 39295 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 0f8591dfcd93..91e38e5585ae 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2972,7 +2972,7 @@ Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
 Version: BT_StonePeak_C0_REL_59_0001
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
-Version: BT_StonePeak_D0_REL_37_0002
+Version: BT_StonePeak_D0_REL_50_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
 Version: BT_StonePeak_D1_REL_54_00003
 File: intel/ibt-11-5.ddc
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq b/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
index cecb339d9d23d7f9650cfb8725a1cf8364477d62..98c9a740fd76b9c05ac0d5e80769300b13c1d31c 100644
GIT binary patch
delta 8999
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
VmhdAM6@Kkl6qELD*RdGpe*tSxy$}EZ

delta 8321
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

-- 
2.7.4

