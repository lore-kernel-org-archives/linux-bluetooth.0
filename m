Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data
Date: Fri, 11 Mar 2016 12:19:26 +0100
Message-Id: <1457695166-16467-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

HCI_UART_PROTO_SET flag is set before hci_uart_set_proto call. If we
receive data from tty layer during this procedure, proto pointer may
not be assigned yet, leading to null pointer dereference in rx method
hci_uart_tty_receive.

This patch fixes this by setting the HCI_UART_PROTO_SET flag once proto
is fully initialized and introduces HCI_UART_PROTO_BUSY flag to avoid
concurrent call to set_proto. We could have fixed this with a mutex as
well.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 16 +++++++++-------
 drivers/bluetooth/hci_uart.h  |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c00168a..fab2641 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -638,6 +638,7 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 		return err;
 
 	hu->proto = p;
+	set_bit(HCI_UART_PROTO_SET, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
@@ -692,14 +693,15 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 
 	switch (cmd) {
 	case HCIUARTSETPROTO:
-		if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
-			err = hci_uart_set_proto(hu, arg);
-			if (err) {
-				clear_bit(HCI_UART_PROTO_SET, &hu->flags);
-				return err;
-			}
-		} else
+		if (test_and_set_bit(HCI_UART_PROTO_BUSY, &hu->flags))
 			return -EBUSY;
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+			err = -EBUSY;
+		else
+			err = hci_uart_set_proto(hu, arg);
+		clear_bit(HCI_UART_PROTO_BUSY, &hu->flags);
+		if (err)
+			return err;
 		break;
 
 	case HCIUARTGETPROTO:
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 4814ff0..1a97fa9 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -95,6 +95,7 @@ struct hci_uart {
 /* HCI_UART proto flag bits */
 #define HCI_UART_PROTO_SET	0
 #define HCI_UART_REGISTERED	1
+#define HCI_UART_PROTO_BUSY	2
 
 /* TX states  */
 #define HCI_UART_SENDING	1
-- 
1.9.1
