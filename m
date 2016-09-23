Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 7/7] Bluetooth: Prevent scheduling of work after hci_uart_tty_close()
Date: Fri, 23 Sep 2016 18:56:32 +0100
Message-ID: <1474653392-28770-8-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Deepak Das <Deepak_Das@mentor.com>

There is a work queue hu->write_work that can be scheduled to handle
a transmission work item in BCSP scenarios that are described below.

In these scenarios, the payload of a BCSP frame can contain a HCI
message as follows:

a) Normal sending of a HCI message within a BCSP frame from upper
layers via hci_uart_send_frame().

b) BCSP retransmission due to a failure to get a BCSP ACK indication.
This resends an old HCI message triggered by the BCSP timer timeout event
handled by bcsp_timed_event().

c) Sending of a BCSP ACK frame in response to a received reliable BCSP
frame is handled in bcsp_complete_rx_pkt() which allows an empty payload
(no HCI message) to be sent.

A good reproduction scenario of the crash is for a bad UART driver to
corrupt or cause a total loss of incoming BCSP frames. This leads to a link
failure so the BCSP timer is periodically triggered in an attempt to
retransmit unacknowledged frames. Then upper layers request the HCI UART
to close immediately before the BCSP timer event is handled. This causes
a race condition between closing the HCI UART and retransmitting a BCSP
frame.

The current solution is using cancel_work_sync(&hu->write_work) within
hci_uart_tty_close() in an attempt to cleanse the work queue of the
transmission work item.

It should be noted that a transmission work item is scheduled into the work
queue by hci_uart_tx_wakeup() which can be running in an atomic context
such as a UART driver interrupt thread or in a process context. Therefore,
it is possible for hci_uart_tx_wakeup() to interrupt or run concurrently
with hci_uart_tty_close().

In addition, hu->proto->close(hu) calls bcsp_close() which frees the
various queues of messages and deletes the BCSP timer.

The current solution has a flaw because hci_uart_tty_close() fails to
inhibit the asynchronous b) and c) transmission events from adding a work
item to the work queue AFTER cancel_work_sync(&hu->write_work) has been
executed. A crash occurs after bcsp_close() has freed the message queues
which are subsequently accessed when the work queue work item runs
hci_uart_write_work(). Therefore, there is a race condition.

Also it has been seen that hci_unregister_dev(hdev) may attempt
to send HCI frames via hci_uart_send_frame() which is AFTER
cancel_work_sync(&hu->write_work) runs. hci_unregister_dev(hdev) was
seen to run for 2 seconds. This could trigger BCSP retransmissions
leading to a crash after the subsequent call to hu->proto->close(hu).
The cancel_work_sync(&hu->write_work) provides no protection in this
case.

This flaw was masked as typically retransmissions should be rare and
Bluetooth has a low sub-system rate of being actively shutdown.

This fix introduces a new HCI_UART proto flag bit called
HCI_UART_UNREGISTERING to indicate the unregistering state of the HCI UART.
This flag is used to prevent the addition of a transmission work item after
hci_uart_tty_close() starts to run.

Note that a spinlock is necessary because it is not possible to check
the state of the atomic flag and to schedule the work queue in an atomic
sequence of operations in hci_uart_tx_wakeup(). This means that the flag
must be prevented from changing state after the flag is checked and before
the work queue is scheduled in hci_uart_tx_wakeup().

Signed-off-by: Deepak Das <Deepak_Das@mentor.com>
Signed-off-by: Rajeev Kumar <rajeev_kumar@mentor.com>
Signed-off-by: Dean_Jenkins@mentor.com
---
 drivers/bluetooth/hci_ldisc.c | 16 +++++++++++++++-
 drivers/bluetooth/hci_uart.h  |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 499fb09..44bdbbc 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -125,15 +125,22 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&hu->schedule_lock, flags);
+	if (test_bit(HCI_UART_UNREGISTERING, &hu->flags))
+		goto no_schedule;
 	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
 		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
-		return 0;
+		goto no_schedule;
 	}
 
 	BT_DBG("");
 
 	schedule_work(&hu->write_work);
 
+no_schedule:
+	spin_unlock_irqrestore(&hu->schedule_lock, flags);
 	return 0;
 }
 
@@ -464,6 +471,8 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
+	spin_lock_init(&hu->schedule_lock);
+
 	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
 
@@ -479,6 +488,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 {
 	struct hci_uart *hu = tty->disc_data;
 	struct hci_dev *hdev;
+	unsigned long flags;
 
 	BT_DBG("tty %p", tty);
 
@@ -488,6 +498,10 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (!hu)
 		return;
 
+	spin_lock_irqsave(&hu->schedule_lock, flags);
+	set_bit(HCI_UART_UNREGISTERING, &hu->flags);
+	spin_unlock_irqrestore(&hu->schedule_lock, flags);
+
 	hdev = hu->hdev;
 	if (hdev)
 		hci_uart_close(hdev);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index f0707f4..2cc63db 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -90,6 +90,8 @@ struct hci_uart {
 	struct sk_buff		*tx_skb;
 	unsigned long		tx_state;
 
+	/* prevent scheduling work during close */
+	spinlock_t		schedule_lock;
 	unsigned int init_speed;
 	unsigned int oper_speed;
 };
@@ -97,6 +99,7 @@ struct hci_uart {
 /* HCI_UART proto flag bits */
 #define HCI_UART_PROTO_SET	0
 #define HCI_UART_REGISTERED	1
+#define HCI_UART_UNREGISTERING	2
 
 /* TX states  */
 #define HCI_UART_SENDING	1
-- 
2.7.4
