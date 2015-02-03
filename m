Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Feb 2015 13:47:18 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B3)
Message-ID: <20150203134718.07f87e73@tedd-linux-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B3)
also known as Intel WP2 B3.

Patch Version: 72

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   2 +-
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 23911 -> 24778 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 7f2d6bf..3c10ae0 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2418,7 +2418,7 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.65.1
+Version: WP_1303_02_patch_0.0.72.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: WP_1303_02_patch_0.0.65.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
index 73999d104cf1bfba7936c8f3e3ed8858c277e2ac..7248c7312b006e4cc4bda80853709afcf4edd4a9 100644
GIT binary patch
delta 8068
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
I{fiy{2PWGa)&Kwi

delta 7302
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
F{{b-hBA);N

-- 
1.9.1

