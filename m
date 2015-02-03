Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Feb 2015 13:47:30 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org, linux-bluetooth@vger.kernel.org,
	tedd.an@intel.com
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7265 (D0)
Message-ID: <20150203134730.479b65a9@tedd-linux-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265 (D0)
also known as Intel StP D0.

Patch Version: 09

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   2 +-
 intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq | Bin 8441 -> 10677 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index c7c0aef..a04a799 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2430,7 +2430,7 @@ Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
 Version: STP2_C0_1339_02_patch_40.1
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
-Version: STP2_D0_1417_04_patch_04.1
+Version: STP2_D0_1417_04_patch_09.1
 
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq b/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
index 95a32a96d863a19726fa0d6faad5b0917cb6adcb..9a68ce6b63a44394baacd2c1ba50619764d130a3 100755
GIT binary patch
delta 4718
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

delta 2478
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
XoNYk+-s*2gEIHzT5drzy|IU8^#Ah30

-- 
1.9.1

