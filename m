Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/6] Bluetooth: Add HCI_RSSI_INVALID for unknown RSSI value
Date: Thu,  4 Dec 2014 10:13:56 +0100
Message-Id: <1417684441-103825-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth core specification defines the value 127 as invalid for
RSSI values. So instead of hard coding it, lets add a constant for it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 569c077778b6..b6f7be1eb919 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -412,6 +412,7 @@ enum {
 
 /* The core spec defines 127 as the "not available" value */
 #define HCI_TX_POWER_INVALID	127
+#define HCI_RSSI_INVALID	127
 
 #define HCI_ROLE_MASTER		0x00
 #define HCI_ROLE_SLAVE		0x01
-- 
1.9.3

