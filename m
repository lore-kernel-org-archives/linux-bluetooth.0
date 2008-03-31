Return-Path: <cyrus@holtmann.org>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Date: Mon, 31 Mar 2008 13:56:25 +1000
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pDG8HVX7Ft6Y+nN"
Message-Id: <200803311356.25654.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] Resubmission of Fixes in rfcomm tty
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_pDG8HVX7Ft6Y+nN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Marcel,

Since you said you completely forgot about the patch, here is a resubmissio=
n=20
of my kernel patch for RFCOMM tty support from a while back. =20

rfcomm-tty-keep-socket-data:
If the TTY socket receives data before TTY is created, or the TTY is not=20
opened (e.g. on devfs) then the data is discarded. =A0This makes it impossi=
ble=20
to support some protocols which send data right away, e.g. DUN and HFP

This one should be applied first.

rfcomm-tty-echo-overflow:
The serial core sends us lots of 1 byte requests when dealing with=20
canonical ttys (e.g. ones that echo). =A0This attempts to fix this issue by=
=20
tweaking how the wfree is handled and also tries to be intelligent in the=20
handling these 1 byte requests by appending them to the pending packet if=20
there is room. =20

=2DDenis

--Boundary-00=_pDG8HVX7Ft6Y+nN
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-tty-keep-socket-data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rfcomm-tty-keep-socket-data.patch"

diff -r -U5 a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
--- a/net/bluetooth/rfcomm/core.c	2007-08-23 09:23:54.000000000 +1000
+++ b/net/bluetooth/rfcomm/core.c	2007-12-14 11:08:54.000000000 +1000
@@ -457,11 +457,10 @@
 	BT_DBG("dlc %p mtu %d len %d", d, d->mtu, len);
 
 	if (len > d->mtu)
 		return -EINVAL;
 
-	rfcomm_make_uih(skb, d->addr);
 	skb_queue_tail(&d->tx_queue, skb);
 
 	if (!test_bit(RFCOMM_TX_THROTTLED, &d->flags))
 		rfcomm_schedule(RFCOMM_SCHED_TX);
 	return len;
@@ -1021,10 +1020,11 @@
 		put_unaligned(htobs(__len16(len)), (__le16 *) &hdr->len);
 	} else {
 		hdr = (void *) skb_push(skb, 3);
 		hdr->len = __len8(len);
 	}
+	
 	hdr->addr = addr;
 	hdr->ctrl = __ctrl(RFCOMM_UIH, 0);
 
 	crc = skb_put(skb, 1);
 	*crc = __fcs((void *) hdr);
@@ -1673,19 +1673,23 @@
 	}
 
 	if (test_bit(RFCOMM_TX_THROTTLED, &d->flags))
 		return skb_queue_len(&d->tx_queue);
 
+	/* Need to lock this in case the tty driver might be messing with the tx queue */
+	rfcomm_dlc_lock(d);
 	while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
+		rfcomm_make_uih(skb, d->addr);
 		err = rfcomm_send_frame(d->session, skb->data, skb->len);
 		if (err < 0) {
 			skb_queue_head(&d->tx_queue, skb);
 			break;
 		}
 		kfree_skb(skb);
 		d->tx_credits--;
 	}
+	rfcomm_dlc_unlock(d);
 
 	if (d->cfc && !d->tx_credits) {
 		/* We're out of TX credits.
 		 * Set TX_THROTTLED flag to avoid unnesary wakeups by dlc_send. */
 		set_bit(RFCOMM_TX_THROTTLED, &d->flags);
diff -r -U5 a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
--- a/net/bluetooth/rfcomm/tty.c	2007-08-23 09:23:54.000000000 +1000
+++ b/net/bluetooth/rfcomm/tty.c	2007-12-14 11:13:23.000000000 +1000
@@ -75,20 +75,25 @@
 	struct tasklet_struct   wakeup_task;
 
 	struct device		*tty_dev;
 
 	atomic_t 		wmem_alloc;
+
+	struct tasklet_struct	copy_task;
+	struct sk_buff_head	rx_queue;
+	atomic_t		rxq_mem_alloc;
 };
 
 static LIST_HEAD(rfcomm_dev_list);
 static DEFINE_RWLOCK(rfcomm_dev_lock);
 
 static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb);
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err);
 static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
 
 static void rfcomm_tty_wakeup(unsigned long arg);
+static void rfcomm_tty_copy_buffered(unsigned long arg);
 
 /* ---- Device functions ---- */
 static void rfcomm_dev_destruct(struct rfcomm_dev *dev)
 {
 	struct rfcomm_dlc *dlc = dev->dlc;
@@ -192,10 +197,12 @@
 static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 {
 	struct rfcomm_dev *dev;
 	struct list_head *head = &rfcomm_dev_list, *p;
 	int err = 0;
+	struct sock *sk;
+	struct sk_buff *skb;
 
 	BT_DBG("id %d channel %d", req->dev_id, req->channel);
 
 	dev = kzalloc(sizeof(struct rfcomm_dev), GFP_KERNEL);
 	if (!dev)
@@ -248,12 +255,24 @@
 	dev->flags = req->flags &
 		((1 << RFCOMM_RELEASE_ONHUP) | (1 << RFCOMM_REUSE_DLC));
 
 	init_waitqueue_head(&dev->wait);
 	tasklet_init(&dev->wakeup_task, rfcomm_tty_wakeup, (unsigned long) dev);
+	skb_queue_head_init(&dev->rx_queue);
+	tasklet_init(&dev->copy_task, rfcomm_tty_copy_buffered, (unsigned long) dev);
 
 	rfcomm_dlc_lock(dlc);
+	if (req->flags & (1 << RFCOMM_REUSE_DLC)) {
+		sk = dlc->owner;
+		atomic_set(&dev->rxq_mem_alloc, 0);
+		while (sk && (skb = skb_dequeue(&sk->sk_receive_queue))) {
+			atomic_sub(skb->len, &sk->sk_rmem_alloc);
+			atomic_add(skb->len, &dev->rxq_mem_alloc);
+			skb_queue_tail(&dev->rx_queue, skb);
+		}
+	}
+
 	dlc->data_ready   = rfcomm_dev_data_ready;
 	dlc->state_change = rfcomm_dev_state_change;
 	dlc->modem_status = rfcomm_dev_modem_status;
 
 	dlc->owner = dev;
@@ -506,15 +524,24 @@
 static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 {
 	struct rfcomm_dev *dev = dlc->owner;
 	struct tty_struct *tty;
 
-	if (!dev || !(tty = dev->tty)) {
+	if (!dev) {
 		kfree_skb(skb);
 		return;
 	}
 
+	if (!(tty = dev->tty) || !skb_queue_empty(&dev->rx_queue)) {
+		atomic_add(skb->len, &dev->rxq_mem_alloc);
+		skb_queue_tail(&dev->rx_queue, skb);
+
+		if (atomic_read(&dev->rxq_mem_alloc) >= RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10)
+			rfcomm_dlc_throttle(dlc);
+		return;
+	}
+
 	BT_DBG("dlc %p tty %p len %d", dlc, tty, skb->len);
 
 	tty_insert_flip_string(tty, skb->data, skb->len);
 	tty_flip_buffer_push(tty);
 
@@ -588,10 +615,35 @@
 #ifdef SERIAL_HAVE_POLL_WAIT
 	wake_up_interruptible(&tty->poll_wait);
 #endif
 }
 
+static void rfcomm_tty_copy_buffered(unsigned long arg)
+{
+	struct rfcomm_dev *dev = (void *) arg;
+	struct tty_struct *tty = dev->tty;
+	struct sk_buff *skb;
+
+	if (!tty)
+		return;
+
+	rfcomm_dlc_lock(dev->dlc);
+
+	while ((skb = skb_dequeue(&dev->rx_queue))) {
+		int inserted;
+		inserted = tty_insert_flip_string(tty, skb->data, skb->len);
+
+		kfree_skb(skb);
+	}
+
+	tty_flip_buffer_push(tty);
+
+	rfcomm_dlc_unthrottle(dev->dlc);
+	rfcomm_dlc_unlock(dev->dlc);
+	tasklet_disable(&dev->copy_task);
+}
+
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct rfcomm_dev *dev;
 	struct rfcomm_dlc *dlc;
@@ -649,10 +701,12 @@
 		schedule();
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev->wait, &wait);
 
+	tasklet_schedule(&dev->copy_task);
+
 	if (err == 0)
 		device_move(dev->tty_dev, rfcomm_get_device(dev));
 
 	return err;
 }
@@ -671,10 +725,11 @@
 		/* Close DLC and dettach TTY */
 		rfcomm_dlc_close(dev->dlc, 0);
 
 		clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 		tasklet_kill(&dev->wakeup_task);
+		tasklet_kill(&dev->copy_task);
 
 		rfcomm_dlc_lock(dev->dlc);
 		tty->driver_data = NULL;
 		dev->tty = NULL;
 		rfcomm_dlc_unlock(dev->dlc);

--Boundary-00=_pDG8HVX7Ft6Y+nN
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-tty-echo-overflow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfcomm-tty-echo-overflow.patch"

diff -r -U5 a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
--- a/net/bluetooth/rfcomm/tty.c	2007-08-23 09:23:54.000000000 +1000
+++ b/net/bluetooth/rfcomm/tty.c	2007-12-14 11:13:23.000000000 +1000
@@ -292,18 +311,17 @@
 }
 
 /* ---- Send buffer ---- */
 static inline unsigned int rfcomm_room(struct rfcomm_dlc *dlc)
 {
-	/* We can't let it be zero, because we don't get a callback
-	   when tx_credits becomes nonzero, hence we'd never wake up */
-	return dlc->mtu * (dlc->tx_credits?:1);
+	return RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 }
 
 static void rfcomm_wfree(struct sk_buff *skb)
 {
 	struct rfcomm_dev *dev = (void *) skb->sk;
+	
 	atomic_sub(skb->truesize, &dev->wmem_alloc);
 	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags))
 		tasklet_schedule(&dev->wakeup_task);
 	rfcomm_dev_put(dev);
 }
@@ -690,14 +745,30 @@
 	struct sk_buff *skb;
 	int err = 0, sent = 0, size;
 
 	BT_DBG("tty %p count %d", tty, count);
 
+	/* We get lots of 1 byte requests in canonical mode */
+	/* So we just put them on the tail of our tx queue */
+	/* if possible */
+	
+	rfcomm_dlc_lock(dlc);
+	skb = skb_peek_tail(&dlc->tx_queue);
+	if (skb) {
+		size = min_t(uint, count, dlc->mtu - skb->len);
+		memcpy(skb_put(skb, size), buf + sent, size);
+		
+		sent += size;
+		count -= size;
+	}
+	rfcomm_dlc_unlock(dlc);
+	skb = 0;
+
 	while (count) {
 		size = min_t(uint, count, dlc->mtu);
 
-		skb = rfcomm_wmalloc(dev, size + RFCOMM_SKB_RESERVE, GFP_ATOMIC);
+		skb = rfcomm_wmalloc(dev, dlc->mtu + RFCOMM_SKB_RESERVE, GFP_ATOMIC);
 
 		if (!skb)
 			break;
 
 		skb_reserve(skb, RFCOMM_SKB_HEAD_RESERVE);
@@ -964,12 +1035,10 @@
 	BT_DBG("tty %p dev %p", tty, dev);
 
 	if (!dev || !dev->dlc)
 		return;
 
-	skb_queue_purge(&dev->dlc->tx_queue);
-
 	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) && tty->ldisc.write_wakeup)
 		tty->ldisc.write_wakeup(tty);
 }
 
 static void rfcomm_tty_send_xchar(struct tty_struct *tty, char ch)

--Boundary-00=_pDG8HVX7Ft6Y+nN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--Boundary-00=_pDG8HVX7Ft6Y+nN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_pDG8HVX7Ft6Y+nN--
