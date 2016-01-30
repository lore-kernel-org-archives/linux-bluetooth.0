Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 16:19:08 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 2/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7260 (B5/B6)
Message-ID: <20160129161908.7e7f0d81@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B5/B6)
also known as Intel WP2 B5 and WP1 B6.

Patch Version: 37

Release Version: 18.15

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq  | Bin 21161 -> 21908 bytes
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 20997 -> 21727 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index ee8569d..e418b92 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2663,9 +2663,9 @@ Version: WP_1303_02_patch_0.0.83.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: WP_1303_02_patch_0.0.83.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.34.1
+Version: BT_WilkinsPeak_B5_REL_37_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.34.1
+Version: BT_WilkinsPeak_B5_REL_37_0001
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
index 10feb8aeba152bb314c70101d533ca0992806dd9..ecbd44811f8627b9bda695184ab0269a5c4bd32b 100644
GIT binary patch
delta 6651
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
V&ZE}iq`Sl+mdj+myS+Gr`G5Kkjr{-s

delta 6040
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
R5QmqnDrQW-_O7xp{|BV^xYPgu

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
index 2ecca8c5694b1d8b2d77dd1fbe4d2cb0116aa3f2..098b9275ba53ad78b29550a7a77c7fa8c62119a9 100644
GIT binary patch
delta 6761
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
L$16j1cIJNp$i$pr

delta 6191
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

-- 
2.4.3

