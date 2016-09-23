Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 3/7] Bluetooth: Use single return in hci_uart_tty_ioctl() call
Date: Fri, 23 Sep 2016 18:56:28 +0100
Message-ID: <1474653392-28770-4-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vignesh Raman <Vignesh_Raman@mentor.com>

Remove multiple return statements in hci_uart_tty_ioctl() call and
added a single return statement.

This code re-organisation allows subsequent locking to be easily
added.

Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Rajeev Kumar <rajeev_kumar@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 9a3aab6..9497c46 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -697,34 +697,36 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 	case HCIUARTSETPROTO:
 		if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
 			err = hci_uart_set_proto(hu, arg);
-			if (err) {
+			if (err)
 				clear_bit(HCI_UART_PROTO_SET, &hu->flags);
-				return err;
-			}
 		} else
-			return -EBUSY;
+			err = -EBUSY;
 		break;
 
 	case HCIUARTGETPROTO:
 		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
-			return hu->proto->id;
-		return -EUNATCH;
+			err = hu->proto->id;
+		else
+			err = -EUNATCH;
+		break;
 
 	case HCIUARTGETDEVICE:
 		if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-			return hu->hdev->id;
-		return -EUNATCH;
+			err = hu->hdev->id;
+		else
+			err = -EUNATCH;
+		break;
 
 	case HCIUARTSETFLAGS:
 		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
-			return -EBUSY;
-		err = hci_uart_set_flags(hu, arg);
-		if (err)
-			return err;
+			err = -EBUSY;
+		else
+			err = hci_uart_set_flags(hu, arg);
 		break;
 
 	case HCIUARTGETFLAGS:
-		return hu->hdev_flags;
+		err = hu->hdev_flags;
+		break;
 
 	default:
 		err = n_tty_ioctl_helper(tty, file, cmd, arg);
-- 
2.7.4
