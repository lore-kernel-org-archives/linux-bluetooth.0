Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Feb 2015 13:47:26 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B6)
Message-ID: <20150203134726.551f48c1@tedd-linux-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B6)
also known as Intel WP1 B6.

Patch Version: 24

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   2 +-
 intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq | Bin 9602 -> 16716 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 7d55d48..84185a2 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2424,7 +2424,7 @@ Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
 Version: WP_1345_01_patch_0.0.24.1
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.10.1
+Version: WP_1345_01_patch_0.0.24.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
index 3c889ce1662a35aea2ce374bd4fe4ca292acedb3..eec0450576c6ee53f6cf8b6b091c997c8b9aa039 100644
GIT binary patch
literal 16716
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
THzmH|2oaV4%Y(8}ejEM=I1ArV

delta 4317
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

-- 
1.9.1

