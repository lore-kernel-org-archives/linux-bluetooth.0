Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix HCIUARTGETDEVICE ioctl when UART is not registered
Date: Sat, 12 Jul 2014 17:00:29 +0200
Message-Id: <1405177229-13849-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The protocol for the UART might be configured, but that does not
mean the HCI device is registered. Return an error in that case
and only return the index number when HCI_UART_REGISTERED is set.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 401a3be57cda..dc487b5d1156 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -539,7 +539,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 		return -EUNATCH;
 
 	case HCIUARTGETDEVICE:
-		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+		if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 			return hu->hdev->id;
 		return -EUNATCH;
 
-- 
1.9.3

