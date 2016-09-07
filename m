Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 2/4] Bluetooth: prevent a race condition on hci_uart_tty_ioctl() call
Date: Wed, 7 Sep 2016 15:15:08 +0100
Message-ID: <1473257710-2073-3-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1473257710-2073-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1473257710-2073-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vignesh Raman <Vignesh_Raman@mentor.com>

Add global mutex lock to prevent reentrancy in the hci_uart_tty_ioctl()
ioctl handling. This prevents concurrency of all function calls within
hci_uart_tty_ioctl handling including hci_uart_set_proto().

Also removed multiple return statements in hci_uart_tty_ioctl call and
added a single return statement since the mutex needs to be unlocked
before exiting the function.

Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Rajeev Kumar <rajeev_kumar@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 1e338d5..cf1883d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -51,6 +51,8 @@
 
 #define VERSION "2.3"
 
+static DEFINE_MUTEX(ioctl_mutex);
+
 static const struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
 
 int hci_uart_register_proto(const struct hci_uart_proto *p)
@@ -685,7 +687,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 			      unsigned int cmd, unsigned long arg)
 {
 	struct hci_uart *hu = tty->disc_data;
-	int err = 0;
+	int result = 0;
 
 	BT_DBG("");
 
@@ -693,45 +695,52 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 	if (!hu)
 		return -EBADF;
 
+	mutex_lock(&ioctl_mutex);
 	switch (cmd) {
 	case HCIUARTSETPROTO:
 		if (!test_bit(HCI_UART_PROTO_SET, &hu->flags)) {
-			err = hci_uart_set_proto(hu, arg);
-			if (!err)
+			result = hci_uart_set_proto(hu, arg);
+			if (!result)
 				set_bit(HCI_UART_PROTO_SET, &hu->flags);
-			else
-				return err;
 		} else
-			return -EBUSY;
+			result = -EBUSY;
 		break;
 
 	case HCIUARTGETPROTO:
 		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
-			return hu->proto->id;
-		return -EUNATCH;
+			result = hu->proto->id;
+		else
+			result = -EUNATCH;
+		break;
 
 	case HCIUARTGETDEVICE:
 		if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-			return hu->hdev->id;
-		return -EUNATCH;
+			result = hu->hdev->id;
+		else
+			result = -EUNATCH;
+		break;
 
 	case HCIUARTSETFLAGS:
 		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
-			return -EBUSY;
-		err = hci_uart_set_flags(hu, arg);
-		if (err)
-			return err;
+			result = -EBUSY;
+		else {
+			result = hci_uart_set_flags(hu, arg);
+			if (result)
+				return result;
+		}
 		break;
 
 	case HCIUARTGETFLAGS:
-		return hu->hdev_flags;
+		result = hu->hdev_flags;
+		break;
 
 	default:
-		err = n_tty_ioctl_helper(tty, file, cmd, arg);
+		result = n_tty_ioctl_helper(tty, file, cmd, arg);
 		break;
 	}
+	mutex_unlock(&ioctl_mutex);
 
-	return err;
+	return result;
 }
 
 /*
-- 
2.7.4
