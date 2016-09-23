Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 6/7] Revert "Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data"
Date: Fri, 23 Sep 2016 18:56:31 +0100
Message-ID: <1474653392-28770-7-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 84cb3df02aea4b00405521e67c4c67c2d525c364.

This commit solved the specific race condition mentioned in the commit:

"HCI_UART_PROTO_SET flag is set before hci_uart_set_proto call. If we
receive data from tty layer during this procedure, proto pointer may
not be assigned yet, leading to null pointer dereference in rx
method hci_uart_tty_receive.

This patch fixes this issue by introducing HCI_UART_PROTO_READY flag
in order to avoid any proto operation before proto opening and
assignment."

The design of the commit seems to be attempting to implement a
lockless solution by relying on atomic variables.

However, HCI_UART_PROTO_READY introduces a race condition here:

static int hci_uart_set_proto(struct hci_uart *hu,
...
        hu->proto = p;
+       set_bit(HCI_UART_PROTO_READY, &hu->flags);

        err = hci_uart_register_dev(hu);
        if (err) {
+               clear_bit(HCI_UART_PROTO_READY, &hu->flags);
                p->close(hu);
                return err;
        }

The issue here is that hci_uart_register_dev() allocates the
memory for hu->hdev and HCI_UART_PROTO_READY is set before
hdev is allocated. This means there is a risk that an unallocated hdev
is accessed because HCI_UART_PROTO_READY is set too early.

For example, hci_uart_tty_wakeup() used the HCI_UART_PROTO_READY flag
which means a transmission work item could potentially be scheduled
in hci_uart_tx_wakeup() when hdev has not been allocated.

Instead use a solution using locking supplied in commits:
"Bluetooth: Use single return in hci_uart_tty_ioctl() call"
"Bluetooth: Add mutex to hci_uart_tty_ioctl()"
"Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking"

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 11 ++++-------
 drivers/bluetooth/hci_uart.h  |  1 -
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 1fc9817..499fb09 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -229,7 +229,7 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
 		hu->proto->flush(hu);
 
 	return 0;
@@ -494,7 +494,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 
 	cancel_work_sync(&hu->write_work);
 
-	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
@@ -502,7 +502,6 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		}
 		hu->proto->close(hu);
 	}
-	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
 	kfree(hu);
 }
@@ -529,7 +528,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -553,7 +552,7 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 	if (!hu || tty != hu->tty)
 		return;
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
 		return;
 
 	/* It does not need a lock here as it is already protected by a mutex in
@@ -641,11 +640,9 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 		return err;
 
 	hu->proto = p;
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
-		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		p->close(hu);
 		return err;
 	}
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 0701395..f0707f4 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -97,7 +97,6 @@ struct hci_uart {
 /* HCI_UART proto flag bits */
 #define HCI_UART_PROTO_SET	0
 #define HCI_UART_REGISTERED	1
-#define HCI_UART_PROTO_READY	2
 
 /* TX states  */
 #define HCI_UART_SENDING	1
-- 
2.7.4
