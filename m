Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com,
        sukumar.ghorai@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 5/6] linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B5/B6)
Date: Wed, 16 May 2018 10:52:15 +0530
Message-Id: <1526448136-11511-5-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1526448136-11511-1-git-send-email-amit.k.bag@intel.com>
References: <1526448136-11511-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the firmware patch for Intel Bluetooth 7260 (B5/B6)
also known as Intel WP2 B5 and WP1 B6.

Patch Version: 42

Release Version: 20.60.0.2

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 21888 -> 23105 bytes
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 0e352a998a95..7cb4cae60437 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2963,9 +2963,9 @@ Version: BT_WilkinsPeak_B3_REL_87_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: BT_WilkinsPeak_B3_REL_87_0001
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: BT_WilkinsPeak_B5_REL_39_0001
+Version: BT_WilkinsPeak_B5_REL_42_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
-Version: BT_WilkinsPeak_B5_REL_39_0001
+Version: BT_WilkinsPeak_B5_REL_42_0001
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
index 889d248b3729f8406e07750ef93a485af9fd8d00..601747c36371f6258125716f6c906d0bca34ed35 100644
GIT binary patch
delta 6063
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
J6_r-z{{Z^x)gb@?

delta 5030
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

-- 
2.7.4

