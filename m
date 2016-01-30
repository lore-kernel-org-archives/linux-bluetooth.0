Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 16:19:13 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 3/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7260 (B3/B4)
Message-ID: <20160129161913.24b6bbbd@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B3/B4)
also known as Intel WP2 B3 and WP1 B4.

Patch Version: 85

Release Version: 18.15

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 25343 -> 25857 bytes
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 25117 -> 25631 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index e418b92..3d6ee03 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2659,9 +2659,9 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.83.1
+BT_WilkinsPeak_B3_REL_85_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.83.1
+BT_WilkinsPeak_B3_REL_85_0001
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
 Version: BT_WilkinsPeak_B5_REL_37_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
index 0e761127e4a78fff67480e4dff14650b7d4769e7..b057cb0b926c2b1898f2f8ffeaa10f78cdc57053 100644
GIT binary patch
delta 4712
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
IqRGJh4|4<%YXATM

delta 4176
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
OH>E4=qZc<B6#oafv|hjf

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
index e3bc1cb5f4119110659bd7eef2722c1d3034d1a4..6627aecc54c6d341bd7fe5848f40a5ad112f5cae 100644
GIT binary patch
delta 4633
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

delta 4107
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

-- 
2.4.3

