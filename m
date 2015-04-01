Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Remove unneeded extra ( ) in valid flags check
Date: Wed,  1 Apr 2015 13:51:51 -0700
Message-Id: <1427921514-22465-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 48a0c250d5b8..1363dc616ace 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -499,7 +499,7 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 				    BIT(HCI_UART_INIT_PENDING) |
 				    BIT(HCI_UART_EXT_CONFIG);
 
-	if ((flags & ~valid_flags))
+	if (flags & ~valid_flags)
 		return -EINVAL;
 
 	hu->hdev_flags = flags;
-- 
2.1.0

