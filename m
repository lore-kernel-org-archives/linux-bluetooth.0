Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Subject: [RFC v3 1/6] Bluetooth: Add HCI_RSSI_INVALID for unknown RSSI value
Date: Thu,  4 Dec 2014 12:22:47 -0800
Message-Id: <1417724573-28561-1-git-send-email-jpawlowski@google.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

The Bluetooth core specification defines the value 127 as invalid for
RSSI values. So instead of hard coding it, lets add a constant for it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 569c077..b6f7be1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -412,6 +412,7 @@ enum {
 
 /* The core spec defines 127 as the "not available" value */
 #define HCI_TX_POWER_INVALID	127
+#define HCI_RSSI_INVALID	127
 
 #define HCI_ROLE_MASTER		0x00
 #define HCI_ROLE_SLAVE		0x01
-- 
2.2.0.rc0.207.ga3a616c
