Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Mar 2014 19:08:14 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: ben@decadent.org.uk, david.woodhouse@intel.com
Cc: linux-bluetooth@vger.kernel.org, emmanuel.grumbach@intel.com,
	don.fry@intel.com, tedd.an@intel.com
Subject: linux-firmware: Add firmware patch file for Intel Bluetooth 7260
 ROM-spin
Message-ID: <20140321190814.252602a0@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the firmware patch file for
- Intel Wirless 7260 BT ROM-spin SKU, also known as WP2 B5.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   3 ++-
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 0 -> 3558 bytes
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq

diff --git a/WHENCE b/WHENCE
index ca0f30b..724f9ff 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2258,7 +2258,8 @@ File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
 Version: 1344.01.33
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: 1344.01.33
-
+File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
+Version: WP_1345_01_patch_0.0.06.1
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
 --------------------------------------------------------------------------
diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
new file mode 100644
index 0000000000000000000000000000000000000000..de0245a0b76d73211592104304345a436e19b0ac
GIT binary patch
literal 3558
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
Ef1V~LYybcN

literal 0
HcmV?d00001

-- 
1.8.3.2

