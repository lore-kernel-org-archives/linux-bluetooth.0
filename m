Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 May 2015 08:25:18 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: [PATCH 3/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7260 (B3/B4)
Message-ID: <20150506082518.26cb7109@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B3/B4)
also known as Intel WP2 B3 and WP1 B4.

Patch Version: 79

Release Version: 152.1

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 25004 -> 25575 bytes
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 24778 -> 25366 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 9de6d49..fd6452d 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2450,9 +2450,9 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.72.1
+Version: WP_1303_02_patch_0.0.79.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.72.1
+Version: WP_1303_02_patch_0.0.79.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
 Version: WP_1345_01_patch_0.0.26.1
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
b/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq index
d09f36de89a51b474b3adf9968761f12fb9d14aa..484b723b6ce86445acde2d7072b037eefd7b100d
100644 GIT binary patch delta 6090
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
Xi3OpK9(jsTYwb^&ir3p~?acoJYj?7;

delta 5481
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

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq index
7248c7312b006e4cc4bda80853709afcf4edd4a9..b18fdfdfa8fb9b4a054de03a25e8aa8d1fe42488
100644 GIT binary patch delta 5842
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
RYMTAR%go9T&%9t^{vQ$oRbc=C

delta 5353
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

-- 
2.1.0

