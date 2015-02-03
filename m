Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Feb 2015 13:47:23 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B5)
Message-ID: <20150203134723.781e4e1e@tedd-linux-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B5)
also known as Intel WP2 B5.

Patch Version: 24

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   2 +-
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 12316 -> 16552 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 0103974..7d55d48 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2422,7 +2422,7 @@ Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.13.1
+Version: WP_1345_01_patch_0.0.24.1
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
 Version: WP_1345_01_patch_0.0.10.1
 File: intel/ibt-hw-37.8.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
index 63e6448a359c527d66154ed2682f75172768fe06..a1b59597bea5f4070d1f3d8935fbe9ddd2aa8328 100644
GIT binary patch
delta 9157
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

delta 4852
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

-- 
1.9.1

