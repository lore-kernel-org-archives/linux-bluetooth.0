Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 09/16] Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races
Date: Fri, 7 Apr 2017 18:04:31 +0100
Message-ID: <1491584678-27228-10-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

When HCI_UART_PROTO_READY is in the set state, the Data Link protocol
layer (proto) is bound to the HCI UART driver. This state allows the
registered proto function pointers to be used by the HCI UART driver.

When unbinding (closing) the Data Link protocol layer, the proto
function pointers much be prevented from being used immediately before
running the proto close function pointer. Otherwise, there is a risk
that a proto non-close function pointer is used during or after the
proto close function pointer is used. The consequences are likely to
be a kernel crash because the proto close function pointer will free
resources used in the Data Link protocol layer.

Therefore, add a reader writer lock (rwlock) solution to prevent the
close proto function pointer from running by using write_lock_irqsave()
whilst the other proto function pointers are protected using
read_lock(). This means HCI_UART_PROTO_READY can safely be cleared
in the knowledge that no proto function pointers are running.

When flag HCI_UART_PROTO_READY is put into the clear state,
proto close function pointer can safely be run. Note
flag HCI_UART_PROTO_SET being in the set state prevents the proto
open function pointer from being run so there is no race condition
between proto open and close function pointers.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 41 ++++++++++++++++++++++++++++++++++++-----
 drivers/bluetooth/hci_uart.h  |  1 +
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 48826c3..65bfc0f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -114,8 +114,12 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 	struct sk_buff *skb = hu->tx_skb;
 
 	if (!skb) {
+		read_lock(&hu->proto_lock);
+
 		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 			skb = hu->proto->dequeue(hu);
+
+		read_unlock(&hu->proto_lock);
 	} else {
 		hu->tx_skb = NULL;
 	}
@@ -125,18 +129,23 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
+	read_lock(&hu->proto_lock);
+
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
-		return 0;
+		goto no_schedule;
 
 	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
 		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
-		return 0;
+		goto no_schedule;
 	}
 
 	BT_DBG("");
 
 	schedule_work(&hu->write_work);
 
+no_schedule:
+	read_unlock(&hu->proto_lock);
+
 	return 0;
 }
 
@@ -236,9 +245,13 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
 
+	read_lock(&hu->proto_lock);
+
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		hu->proto->flush(hu);
 
+	read_unlock(&hu->proto_lock);
+
 	return 0;
 }
 
@@ -260,10 +273,15 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s: type %d len %d", hdev->name, hci_skb_pkt_type(skb),
 	       skb->len);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	read_lock(&hu->proto_lock);
+
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+		read_unlock(&hu->proto_lock);
 		return -EUNATCH;
+	}
 
 	hu->proto->enqueue(hu, skb);
+	read_unlock(&hu->proto_lock);
 
 	hci_uart_tx_wakeup(hu);
 
@@ -474,6 +492,8 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
+	rwlock_init(&hu->proto_lock);
+
 	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
 
@@ -489,6 +509,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 {
 	struct hci_uart *hu = tty->disc_data;
 	struct hci_dev *hdev;
+	unsigned long flags;
 
 	BT_DBG("tty %p", tty);
 
@@ -515,8 +536,13 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		}
 	}
 
-	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+		write_lock_irqsave(&hu->proto_lock, flags);
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		write_unlock_irqrestore(&hu->proto_lock, flags);
+
 		hu->proto->close(hu);
+	}
 
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
@@ -574,13 +600,18 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 	if (!hu || tty != hu->tty)
 		return;
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	read_lock(&hu->proto_lock);
+
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+		read_unlock(&hu->proto_lock);
 		return;
+	}
 
 	/* It does not need a lock here as it is already protected by a mutex in
 	 * tty caller
 	 */
 	hu->proto->recv(hu, data, count);
+	read_unlock(&hu->proto_lock);
 
 	if (hu->hdev)
 		hu->hdev->stat.byte_rx += count;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 0701395..580ca98 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -85,6 +85,7 @@ struct hci_uart {
 	struct work_struct	write_work;
 
 	const struct hci_uart_proto *proto;
+	rwlock_t		proto_lock;	/* Stop work for proto close */
 	void			*priv;
 
 	struct sk_buff		*tx_skb;
-- 
2.7.4
