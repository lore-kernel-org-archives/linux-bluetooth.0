Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Feb 2015 13:47:21 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B4)
Message-ID: <20150203134721.16354599@tedd-linux-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B4)
also known as Intel WP1 B4

Patch Version: 72

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                 |   2 +-
 intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq | Bin 24137 -> 25004 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 3c10ae0..0103974 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2420,7 +2420,7 @@ Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
 Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.65.1
+Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
 Version: WP_1345_01_patch_0.0.13.1
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
index 978b96d2f7982638e4c3a89f319e1e9600e3ebf0..d09f36de89a51b474b3adf9968761f12fb9d14aa 100644
GIT binary patch
delta 8200
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

delta 7504
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

-- 
1.9.1

