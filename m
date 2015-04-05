Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_uart: Move setup callback into different location
Date: Sun,  5 Apr 2015 03:42:00 -0700
Message-Id: <1428230522-10628-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The setup callback got wrongly inserted between the enqueue and dequeue
callbacks. Move it to a better location.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_uart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 0b58a33eb5b2..04278b38b860 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -61,9 +61,9 @@ struct hci_uart_proto {
 	int (*open)(struct hci_uart *hu);
 	int (*close)(struct hci_uart *hu);
 	int (*flush)(struct hci_uart *hu);
+	int (*setup)(struct hci_uart *hu);
 	int (*recv)(struct hci_uart *hu, const void *data, int len);
 	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
-	int (*setup)(struct hci_uart *hu);
 	struct sk_buff *(*dequeue)(struct hci_uart *hu);
 };
 
-- 
2.1.0

