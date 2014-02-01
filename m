Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add constants for LTK key types
Date: Fri, 31 Jan 2014 19:02:30 -0800
Message-Id: <1391223750-48812-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LTK key types available right now are unauthenticated and
authenticated ones. Provide two simple constants for it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 232c07804ca8..352d3d7d06bb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -346,6 +346,10 @@ enum {
 #define HCI_SMP_LTK			0x82
 #define HCI_SMP_LTK_SLAVE		0x83
 
+/* Long Term Key types */
+#define HCI_LTK_UNAUTH			0x00
+#define HCI_LTK_AUTH			0x01
+
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_AUTH_FAILURE		0x05
 #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
-- 
1.8.5.3

