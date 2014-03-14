Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Mar 2014 13:52:54 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: dwmw2@infradead.org, ben@decadent.org.uk
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	Don Fry <don.fry@intel.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: linux-firmware: Update Intel BT devices firmware patch files
 (7260/3160)
Message-ID: <20140314135254.2edf9d2e@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates firmware patch files for following Intel Bluetooth Devices:
- Intel Wireless Bluetooth 7260
- Intel Wireless Bluetooth 3160

This firmwares fixes
- No SCO data over EHCI

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 18145 -> 21121 bytes
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 17917 -> 21001 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 4bcb3b5..7876548 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2254,9 +2254,9 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: 1344.01.33
+Version: auto.WP_1303_02_patch_0.1.54.1 (0x36) 
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: 1344.01.33
+Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
 
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
index 49554882ae6a94e9943d7d69c37f935c814f2aed..204b8463e670813a2f697f1e83024a19b86fecaa 100644
GIT binary patch
delta 10188
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
IFzK8B0j4kOvj6}9

delta 7214
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

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
index ac13fab3fcc85efe1898f7399eb7b255002cb98a..79dba14130c82abf358bd42aab3f4798a0f92993 100644
GIT binary patch
delta 10219
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

delta 7012
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

-- 
1.8.3.2

