Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Bluetooth: Add constants for AMP controller type
Date: Sat,  5 Oct 2013 11:47:42 -0700
Message-Id: <1380998869-64411-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the constants for BR/EDR and 802.11 AMP controller types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e8bba05..8e3076e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -66,6 +66,10 @@
 /* First BR/EDR Controller shall have ID = 0 */
 #define HCI_BREDR_ID	0
 
+/* AMP controller types */
+#define AMP_TYPE_BREDR	0x00
+#define AMP_TYPE_80211	0x01
+
 /* AMP controller status */
 #define AMP_CTRL_POWERED_DOWN			0x00
 #define AMP_CTRL_BLUETOOTH_ONLY			0x01
-- 
1.8.3.1

