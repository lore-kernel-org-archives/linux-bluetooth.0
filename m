Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [RFC 2/3] Bluetooth:  Add HCI Coding Format definitions
Date: Thu, 22 Nov 2012 13:05:07 +0100
Message-Id: <1353585909-28400-3-git-send-email-m.knudsen@samsung.com>
In-Reply-To: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
References: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add definitions for the codecs specified in CSA2.
---
 include/net/bluetooth/hci.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 45ec1de..60505da 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -284,6 +284,15 @@ enum {
 #define HCI_LM_RELIABLE	0x0010
 #define HCI_LM_SECURE	0x0020
 
+/* Coding Format */
+#define HCI_FORMAT_ULAW		0x00
+#define HCI_FORMAT_ALAW		0x01
+#define HCI_FORMAT_CVSD		0x02
+#define HCI_FORMAT_TRANSPARENT	0x03
+#define HCI_FORMAT_PCM		0x04
+#define HCI_FORMAT_MSBC		0x05
+#define HCI_FORMAT_VENDOR	0xff
+
 /* Authentication types */
 #define HCI_AT_NO_BONDING		0x00
 #define HCI_AT_NO_BONDING_MITM		0x01
-- 
1.7.9.5

