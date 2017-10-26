Return-Path: <ronald@innovation.ch>
Date: Wed, 25 Oct 2017 22:14:53 -0700
From: =?iso-8859-1?B?PT9VVEYtOD9xP1JvbmFsZD0yMFRzY2hhbD1DMz1BNHI/PQ==?= <ronald@innovation.ch>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Dean Jenkins <Dean_Jenkins@mentor.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_ldisc: Allow sleeping while proto locks
 are held.
Message-ID: <20171026051453.GA15910@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Commit dec2c92880cc5435381d50e3045ef018a762a917 ("Bluetooth: hci_ldisc:
Use rwlocking to avoid closing proto races") introduced locks in
hci_ldisc that are held while calling the proto functions. These locks
are rwlock's, and hence do not allow sleeping while they are held.
However, the proto functions that hci_bcm registers use mutexes and
hence need to be able to sleep.

In more detail: hci_uart_tty_receive() and hci_uart_dequeue() both
acquire the rwlock, after which they call proto->recv() and
proto->dequeue(), respectively. In the case of hci_bcm these point to
bcm_recv() and bcm_dequeue(). The latter both acquire the
bcm_device_lock, which is a mutex, so doing so results in a call to
might_sleep(). But since we're holding a rwlock in hci_ldisc, that
results in the following BUG (this for the dequeue case - a similar
one for the receive case is omitted for brevity):

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c
  in_atomic(): 1, irqs_disabled(): 0, pid: 7303, name: kworker/7:3
  INFO: lockdep is turned off.
  CPU: 7 PID: 7303 Comm: kworker/7:3 Tainted: G        W  OE   4.13.2+ #17
  Hardware name: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C, BIOS MBP133.8
  Workqueue: events hci_uart_write_work [hci_uart]
  Call Trace:
   dump_stack+0x8e/0xd6
   ___might_sleep+0x164/0x250
   __might_sleep+0x4a/0x80
   __mutex_lock+0x59/0xa00
   ? lock_acquire+0xa3/0x1f0
   ? lock_acquire+0xa3/0x1f0
   ? hci_uart_write_work+0xd3/0x160 [hci_uart]
   mutex_lock_nested+0x1b/0x20
   ? mutex_lock_nested+0x1b/0x20
   bcm_dequeue+0x21/0xc0 [hci_uart]
   hci_uart_write_work+0xe6/0x160 [hci_uart]
   process_one_work+0x253/0x6a0
   worker_thread+0x4d/0x3b0
   kthread+0x133/0x150

We can't replace the mutex in hci_bcm, because there are other calls
there that might sleep. Therefore this replaces the rwlock's in
hci_ldisc with rw_semaphore's (which allow sleeping). This is a safer
approach anyway as it reduces the restrictions on the proto callbacks.
Also, because acquiring write-lock is very rare compared to acquiring
the read-lock, the percpu variant of rw_semaphore is used.

Lastly, because hci_uart_tx_wakeup() may be called from an IRQ context,
we can't block (sleep) while trying acquire the read lock there, so we
use the trylock variant.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
---
Changes in v2:
  - Add back locking in hci_uart_tx_wakeup(). Removing the locking
    altogether there was wrong, as nicely pointed out by Dean Jenkins.

 drivers/bluetooth/hci_ldisc.c | 38 ++++++++++++++++++++++----------------
 drivers/bluetooth/hci_uart.h  |  2 +-
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index eec95019f15c..31def781a562 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -115,12 +115,12 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 	struct sk_buff *skb = hu->tx_skb;
 
 	if (!skb) {
-		read_lock(&hu->proto_lock);
+		percpu_down_read(&hu->proto_lock);
 
 		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 			skb = hu->proto->dequeue(hu);
 
-		read_unlock(&hu->proto_lock);
+		percpu_up_read(&hu->proto_lock);
 	} else {
 		hu->tx_skb = NULL;
 	}
@@ -130,7 +130,14 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
-	read_lock(&hu->proto_lock);
+	/* This may be called in an IRQ context, so we can't sleep. Therefore
+	 * we try to acquire the lock only, and if that fails we assume the
+	 * tty is being closed because that is the only time the write lock is
+	 * acquired. If, however, at some point in the future the write lock
+	 * is also acquired in other situations, then this must be revisited.
+	 */
+	if (!percpu_down_read_trylock(&hu->proto_lock))
+		return 0;
 
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		goto no_schedule;
@@ -145,7 +152,7 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	schedule_work(&hu->write_work);
 
 no_schedule:
-	read_unlock(&hu->proto_lock);
+	percpu_up_read(&hu->proto_lock);
 
 	return 0;
 }
@@ -247,12 +254,12 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
 
-	read_lock(&hu->proto_lock);
+	percpu_down_read(&hu->proto_lock);
 
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		hu->proto->flush(hu);
 
-	read_unlock(&hu->proto_lock);
+	percpu_up_read(&hu->proto_lock);
 
 	return 0;
 }
@@ -275,15 +282,15 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s: type %d len %d", hdev->name, hci_skb_pkt_type(skb),
 	       skb->len);
 
-	read_lock(&hu->proto_lock);
+	percpu_down_read(&hu->proto_lock);
 
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		read_unlock(&hu->proto_lock);
+		percpu_up_read(&hu->proto_lock);
 		return -EUNATCH;
 	}
 
 	hu->proto->enqueue(hu, skb);
-	read_unlock(&hu->proto_lock);
+	percpu_up_read(&hu->proto_lock);
 
 	hci_uart_tx_wakeup(hu);
 
@@ -486,7 +493,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
-	rwlock_init(&hu->proto_lock);
+	percpu_init_rwsem(&hu->proto_lock);
 
 	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
@@ -503,7 +510,6 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 {
 	struct hci_uart *hu = tty->disc_data;
 	struct hci_dev *hdev;
-	unsigned long flags;
 
 	BT_DBG("tty %p", tty);
 
@@ -520,9 +526,9 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	cancel_work_sync(&hu->write_work);
 
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		write_lock_irqsave(&hu->proto_lock, flags);
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		write_unlock_irqrestore(&hu->proto_lock, flags);
+		percpu_up_write(&hu->proto_lock);
 
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
@@ -582,10 +588,10 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 	if (!hu || tty != hu->tty)
 		return;
 
-	read_lock(&hu->proto_lock);
+	percpu_down_read(&hu->proto_lock);
 
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		read_unlock(&hu->proto_lock);
+		percpu_up_read(&hu->proto_lock);
 		return;
 	}
 
@@ -593,7 +599,7 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 	 * tty caller
 	 */
 	hu->proto->recv(hu, data, count);
-	read_unlock(&hu->proto_lock);
+	percpu_up_read(&hu->proto_lock);
 
 	if (hu->hdev)
 		hu->hdev->stat.byte_rx += count;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index d9cd95d81149..66e8c68e4607 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -87,7 +87,7 @@ struct hci_uart {
 	struct work_struct	write_work;
 
 	const struct hci_uart_proto *proto;
-	rwlock_t		proto_lock;	/* Stop work for proto close */
+	struct percpu_rw_semaphore proto_lock;	/* Stop work for proto close */
 	void			*priv;
 
 	struct sk_buff		*tx_skb;
-- 
2.13.6
