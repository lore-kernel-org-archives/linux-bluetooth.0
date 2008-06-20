Return-Path: <cyrus@holtmann.org>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 20 Jun 2008 15:04:07 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HpzWIOM/BKew0l+"
Message-Id: <200806201504.07195.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] Fixes for RFCOMM #2
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

--Boundary-00=_HpzWIOM/BKew0l+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

rfcomm-keep-tty-data:
=A0 =A0 Fix the problem of disappearing packets when the socket is meant to=
 be
=A0 =A0 used as an rfcomm tty server. =A0The data needs to be queued since
=A0 =A0 packets might arrive after the socket has been connected, but
=A0 =A0 before the tty has been opened

Signed-off-by: Denis Kenzior <denis.kenzior@trolltech.com>

rfcomm-keep-modem-status:
=A0 =A0 Keep the modem status around in case the tty really needs it.

Signed-off-by: Denis Kenzior <denis.kenzior@trolltech.com>

--Boundary-00=_HpzWIOM/BKew0l+
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-keep-modem-status.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfcomm-keep-modem-status.patch"

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 98ec7a3..d74094d 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -180,6 +180,7 @@ struct rfcomm_dlc {
 	u8            addr;
 	u8            priority;
 	u8            v24_sig;
+	u8            remote_v24_sig;
 	u8            mscex;
 
 	u32           link_mode;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 0c2c937..2e37bb0 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1459,6 +1459,7 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 			clear_bit(RFCOMM_TX_THROTTLED, &d->flags);
 
 		rfcomm_dlc_lock(d);
+		d->remote_v24_sig = msc->v24_sig;
 		if (d->modem_status)
 			d->modem_status(d, msc->v24_sig);
 		rfcomm_dlc_unlock(d);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 2488027..41041ff 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -271,6 +271,9 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	dlc->owner = dev;
 	dev->dlc   = dlc;
+
+	/* Update the modem_status, call under lock */
+	rfcomm_dev_modem_status(dlc, dlc->remote_v24_sig);
 	rfcomm_dlc_unlock(dlc);
 
 	/* It's safe to call __module_get() here because socket already
@@ -588,6 +591,7 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	}
 }
 
+/* This is called under dlc lock, so we can safely mess with dlc here */
 static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 {
 	struct rfcomm_dev *dev = dlc->owner;

--Boundary-00=_HpzWIOM/BKew0l+
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-keep-tty-data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfcomm-keep-tty-data.patch"

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 2e37bb0..a90fe94 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -457,7 +457,6 @@ int rfcomm_dlc_send(struct rfcomm_dlc *d, struct sk_buff *skb)
 	if (len > d->mtu)
 		return -EINVAL;
 
-	rfcomm_make_uih(skb, d->addr);
 	skb_queue_tail(&d->tx_queue, skb);
 
 	if (!test_bit(RFCOMM_TX_THROTTLED, &d->flags))
@@ -1675,6 +1674,7 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
 		return skb_queue_len(&d->tx_queue);
 
 	while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
+		rfcomm_make_uih(skb, d->addr);
 		err = rfcomm_send_frame(d->session, skb->data, skb->len);
 		if (err < 0) {
 			skb_queue_head(&d->tx_queue, skb);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 41041ff..0600c54 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -77,6 +77,8 @@ struct rfcomm_dev {
 	struct device		*tty_dev;
 
 	atomic_t 		wmem_alloc;
+
+	struct sk_buff_head	pending_queue;
 };
 
 static LIST_HEAD(rfcomm_dev_list);
@@ -88,6 +90,8 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
 
 static void rfcomm_tty_wakeup(unsigned long arg);
 
+static void rfcomm_tty_copy_buffered(struct rfcomm_dev *dev);
+
 /* ---- Device functions ---- */
 static void rfcomm_dev_destruct(struct rfcomm_dev *dev)
 {
@@ -207,6 +211,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	struct rfcomm_dev *dev;
 	struct list_head *head = &rfcomm_dev_list, *p;
 	int err = 0;
+	struct sock *sk;
+	struct sk_buff *skb;
 
 	BT_DBG("id %d channel %d", req->dev_id, req->channel);
 
@@ -263,8 +269,19 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	init_waitqueue_head(&dev->wait);
 	tasklet_init(&dev->wakeup_task, rfcomm_tty_wakeup, (unsigned long) dev);
+	skb_queue_head_init(&dev->pending_queue);
 
 	rfcomm_dlc_lock(dlc);
+
+	if ((req->flags & (1 << RFCOMM_REUSE_DLC)) && (sk = dlc->owner)) {
+		rfcomm_dlc_throttle(dlc);
+		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+			skb_orphan(skb);
+			atomic_sub(skb->len, &sk->sk_rmem_alloc);
+			skb_queue_tail(&dev->pending_queue, skb);
+		}
+	}
+
 	dlc->data_ready   = rfcomm_dev_data_ready;
 	dlc->state_change = rfcomm_dev_state_change;
 	dlc->modem_status = rfcomm_dev_modem_status;
@@ -542,11 +559,16 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 	struct rfcomm_dev *dev = dlc->owner;
 	struct tty_struct *tty;
 
-	if (!dev || !(tty = dev->tty)) {
+	if (!dev) {
 		kfree_skb(skb);
 		return;
 	}
 
+	if (!(tty = dev->tty) || !skb_queue_empty(&dev->pending_queue)) {
+		skb_queue_tail(&dev->pending_queue, skb);
+		return;
+	}
+
 	BT_DBG("dlc %p tty %p len %d", dlc, tty, skb->len);
 
 	tty_insert_flip_string(tty, skb->data, skb->len);
@@ -631,6 +653,33 @@ static void rfcomm_tty_wakeup(unsigned long arg)
 #endif
 }
 
+static void rfcomm_tty_copy_buffered(struct rfcomm_dev *dev)
+{
+	struct tty_struct *tty = dev->tty;
+	struct sk_buff *skb;
+	int inserted;
+
+	if (!tty)
+		return;
+
+	BT_DBG("dev %p tty %p", dev, tty);
+
+	rfcomm_dlc_lock(dev->dlc);
+
+	inserted = 0;
+	while ((skb = skb_dequeue(&dev->pending_queue))) {
+		inserted += tty_insert_flip_string(tty, skb->data, skb->len);
+		kfree_skb(skb);
+	}
+
+	rfcomm_dlc_unlock(dev->dlc);
+
+	if (inserted) {
+		tty_flip_buffer_push(tty);
+		rfcomm_dlc_unthrottle(dev->dlc);
+	}
+}
+
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -695,6 +744,8 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 	if (err == 0)
 		device_move(dev->tty_dev, rfcomm_get_device(dev));
 
+	rfcomm_tty_copy_buffered(dev);
+
 	return err;
 }
 

--Boundary-00=_HpzWIOM/BKew0l+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--Boundary-00=_HpzWIOM/BKew0l+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_HpzWIOM/BKew0l+--
