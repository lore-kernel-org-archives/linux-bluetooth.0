Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 16/16] Bluetooth: hci_ldisc: Add ioctl_mutex avoiding concurrency
Date: Fri, 7 Apr 2017 18:04:38 +0100
Message-ID: <1491584678-27228-17-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

There is a concurrency risk with hci_uart_tty_ioctl() running with
itself. Also there is a race condition between hci_uart_tty_close()
clearing the HCI_UART_PROTO_SET flag whilst hci_uart_tty_ioctl() runs.

Even though the HCI_UART_PROTO_SET flag is atomic, this is not
sufficient to prevent hci_uart_tty_ioctl() from potentially accessing
freed or stale variables when hci_uart_tty_close() completes. This is
because the hci_uart_tty_ioctl() thread can run in parallel with the
hci_uart_tty_close() thread. This means the HCI_UART_PROTO_SET flag
can change at any time during the execution of hci_uart_tty_ioctl()
which can lead to a malfunction.

Therefore, add a mutex lock called ioctl_mutex in hci_uart_tty_ioctl()
to prevent self concurrency of hci_uart_tty_ioctl(). In
hci_uart_tty_close() add ioctl_mutex around the clearing of the hu
value from tty->disc_data and clearing the HCI_UART_PROTO_SET flag.

This mutex lock ensures that tty->disc_data does not become NULL
and the HCI_UART_PROTO_SET flag cannot become clear whilst the main
body of hci_uart_tty_ioctl() executes.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 5 +++++
 drivers/bluetooth/hci_uart.h  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ec9b96f..dbf16835 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -488,6 +488,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
 	rwlock_init(&hu->proto_lock);
+	mutex_init(&hu->ioctl_mutex);
 
 	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
@@ -531,10 +532,12 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		hu->proto->close(hu);
 	}
 
+	mutex_lock(&hu->ioctl_mutex);
 	/* Detach from the tty */
 	tty->disc_data = NULL;
 
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
+	mutex_unlock(&hu->ioctl_mutex);
 
 	if (test_and_clear_bit(HCI_UART_REGISTERED, &hu->flags)) {
 		hci_uart_flush(hdev);
@@ -745,6 +748,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 	if (!hu)
 		return -EBADF;
 
+	mutex_lock(&hu->ioctl_mutex);
 	switch (cmd) {
 	case HCIUARTSETPROTO:
 		if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
@@ -784,6 +788,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 		err = n_tty_ioctl_helper(tty, file, cmd, arg);
 		break;
 	}
+	mutex_unlock(&hu->ioctl_mutex);
 
 	return err;
 }
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 580ca98..54c435d 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -91,6 +91,8 @@ struct hci_uart {
 	struct sk_buff		*tx_skb;
 	unsigned long		tx_state;
 
+	struct mutex		ioctl_mutex;	/* HCI_UART_PROTO_SET lock */
+
 	unsigned int init_speed;
 	unsigned int oper_speed;
 };
-- 
2.7.4
