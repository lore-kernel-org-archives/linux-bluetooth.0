Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v3 1/8] Bluetooth: Add HCI authentication capabilities macros
Date: Fri, 28 Jun 2013 10:56:27 +0200
Message-Id: <1372409794-24688-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add macros for the HCI capabilities as described in the Bluetooth Core
Specification v4.0, Volume 2, part E, section 7.1.29.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 include/net/bluetooth/hci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3c592cf..a01fbb4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -296,6 +296,12 @@ enum {
 #define HCI_AT_GENERAL_BONDING		0x04
 #define HCI_AT_GENERAL_BONDING_MITM	0x05
 
+/* I/O capabilities */
+#define HCI_IO_DISPLAY_ONLY	0x00
+#define HCI_IO_DISPLAY_YESNO	0x01
+#define HCI_IO_KEYBOARD_ONLY	0x02
+#define HCI_IO_NO_INPUT_OUTPUT	0x03
+
 /* Link Key types */
 #define HCI_LK_COMBINATION		0x00
 #define HCI_LK_LOCAL_UNIT		0x01
-- 
1.8.1.4

