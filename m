Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Nov 2013 17:21:23 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: dwmw2@infradead.org, ben@decadent.org.uk
Cc: don.try@intel.com, tedd.an@intel.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] linux-firmware: Update Intel Bluetooth devices firmware
 patch files
Message-ID: <20131113172123.5702c78d@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates firmware patch files for following Intel Bluetooth devices:
- Intel Wireless Bluetooth 7260
- Intel Wireless Bluetooth 3160

This patch fixes
- sometimes device doesn't response to HCI_reset after multiple reboot
- issue with HCI stress testing
- issue with some multi profile cases

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 16761 -> 18145 bytes
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 16516 -> 17917 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 2d52804..b4429ca 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2195,9 +2195,9 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: 1334.02.2E
+Version: 1344.01.33
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: 1334.02.2E
+Version: 1344.01.33
 
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
index cd23169b8bd7ef8b7bfa2ddaed0c44dc52910ffc..49554882ae6a94e9943d7d69c37f935c814f2aed 100644
GIT binary patch
delta 6475
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
KUs-C+XZ|0#s4+eO

delta 5183
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
WGyt^ZR)v<3%6zKmo%bru)c*tjvYT!I

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
index 44736e45b6764b8aa3369ec0a2c18f4657e02ef9..ac13fab3fcc85efe1898f7399eb7b255002cb98a 100644
GIT binary patch
delta 6429
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

delta 5038
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

-- 
1.8.1.2

