Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [PATCH v2 1/3] Bluetooth:  Add HCI Coding Format definitions
Date: Fri, 23 Nov 2012 14:59:28 +0100
Message-Id: <1353679170-3738-2-git-send-email-m.knudsen@samsung.com>
In-Reply-To: <1353679170-3738-1-git-send-email-m.knudsen@samsung.com>
References: <1353679170-3738-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/hci.h b/lib/hci.h
index 2f18ec8..5e5f6b5 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -295,6 +295,15 @@ enum {
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
 /* Link Key types */
 #define HCI_LK_COMBINATION		0x00
 #define HCI_LK_LOCAL_UNIT		0x01
-- 
1.7.9.5

