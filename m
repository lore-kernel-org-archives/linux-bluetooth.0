Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Check for valid HCI UART driver flags
Date: Fri, 11 Jul 2014 07:12:57 +0200
Message-Id: <1405055578-30621-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Providing unknown or invalid flags to the HCI UART driver should
result in an error. So check which flags are valid and otherwise
return an error.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e00f8f5b5c8e..a49ee1b42439 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -477,6 +477,21 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 	return 0;
 }
 
+static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
+{
+	unsigned long valid_flags = BIT(HCI_UART_RAW_DEVICE) |
+				    BIT(HCI_UART_RESET_ON_INIT) |
+				    BIT(HCI_UART_CREATE_AMP) |
+				    BIT(HCI_UART_INIT_PENDING);
+
+	if ((flags & ~valid_flags))
+		return -EINVAL;
+
+	hu->hdev_flags = flags;
+
+	return 0;
+}
+
 /* hci_uart_tty_ioctl()
  *
  *    Process IOCTL system call for the tty device.
@@ -527,7 +542,9 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 	case HCIUARTSETFLAGS:
 		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
 			return -EBUSY;
-		hu->hdev_flags = arg;
+		err = hci_uart_set_flags(hu, arg);
+		if (err)
+			return err;
 		break;
 
 	case HCIUARTGETFLAGS:
-- 
1.9.3

