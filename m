Return-Path: <cyrus@holtmann.org>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 20 Jun 2008 14:09:13 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p1yWIyi4kOW0ifA"
Message-Id: <200806201409.13306.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] Fixes for RFCOMM
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

--Boundary-00=_p1yWIyi4kOW0ifA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

Here's a cleaned up version of the fixes for RFCOMM:

rfcomm-keep-tty-data:
    Fix the problem of disappearing packets when the socket is meant to be
    used as an rfcomm tty server.  The data needs to be queued since
    packets might arrive after the socket has been connected, but
    before the tty has been opened

rfcomm-tty-no-canonical:
    Let the tty driver be non-canonical by default.  Fixes some issues
    with canonical mode not being handled properly in rfcomm_tty_write.

rfcomm-keep-modem-status:
    Keep the modem status around in case the tty really needs it.

-Denis

--Boundary-00=_p1yWIyi4kOW0ifA
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-keep-modem-status.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfcomm-keep-modem-status.patch"

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 98ec7a3..368628f 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -193,7 +193,8 @@ struct rfcomm_dlc {
 
 	void (*data_ready)(struct rfcomm_dlc *d, struct sk_buff *skb);
 	void (*state_change)(struct rfcomm_dlc *d, int err);
-	void (*modem_status)(struct rfcomm_dlc *d, u8 v24_sig);
+	void (*modem_status)(struct rfcomm_dlc *d);
+	u8            remote_v24_sig;
 };
 
 /* DLC and session flags */
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index e4142ea..6a97f02 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1458,8 +1458,9 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 			clear_bit(RFCOMM_TX_THROTTLED, &d->flags);
 
 		rfcomm_dlc_lock(d);
+		d->remote_v24_sig = msc->v24_sig;
 		if (d->modem_status)
-			d->modem_status(d, msc->v24_sig);
+			d->modem_status(d);
 		rfcomm_dlc_unlock(d);
 
 		rfcomm_send_msc(s, 0, dlci, msc->v24_sig);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index db27f3f..68023be 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -87,7 +87,7 @@ static DEFINE_RWLOCK(rfcomm_dev_lock);
 
 static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb);
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err);
-static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
+static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc);
 
 static void rfcomm_tty_wakeup(unsigned long arg);
 
@@ -292,6 +292,9 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	dlc->owner = dev;
 	dev->dlc   = dlc;
+
+	/* Update the modem_status, call under lock */
+	rfcomm_dev_modem_status(dlc);
 	rfcomm_dlc_unlock(dlc);
 
 	/* It's safe to call __module_get() here because socket already
@@ -619,9 +622,12 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	}
 }
 
-static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
+/* This is called under dlc lock, so we can safely mess with dlc here */
+static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc)
 {
 	struct rfcomm_dev *dev = dlc->owner;
+	u8 v24_sig = dlc->remote_v24_sig;
+
 	if (!dev)
 		return;
 

--Boundary-00=_p1yWIyi4kOW0ifA
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-keep-tty-data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfcomm-keep-tty-data.patch"

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 0c2c937..e4142ea 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -457,7 +457,6 @@ int rfcomm_dlc_send(struct rfcomm_dlc *d, struct sk_buff *skb)
 	if (len > d->mtu)
 		return -EINVAL;
 
-	rfcomm_make_uih(skb, d->addr);
 	skb_queue_tail(&d->tx_queue, skb);
 
 	if (!test_bit(RFCOMM_TX_THROTTLED, &d->flags))
@@ -1674,6 +1673,7 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
 		return skb_queue_len(&d->tx_queue);
 
 	while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
+		rfcomm_make_uih(skb, d->addr);
 		err = rfcomm_send_frame(d->session, skb->data, skb->len);
 		if (err < 0) {
 			skb_queue_head(&d->tx_queue, skb);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index c919187..f2a2e1c 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -77,6 +77,9 @@ struct rfcomm_dev {
 	struct device		*tty_dev;
 
 	atomic_t 		wmem_alloc;
+
+	struct sk_buff_head	rx_queue;
+	atomic_t		rxq_mem_alloc;
 };
 
 static LIST_HEAD(rfcomm_dev_list);
@@ -88,6 +91,8 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
 
 static void rfcomm_tty_wakeup(unsigned long arg);
 
+static void rfcomm_tty_copy_buffered(struct rfcomm_dev *dev);
+
 /* ---- Device functions ---- */
 static void rfcomm_dev_destruct(struct rfcomm_dev *dev)
 {
@@ -207,6 +212,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	struct rfcomm_dev *dev;
 	struct list_head *head = &rfcomm_dev_list, *p;
 	int err = 0;
+	struct sock *sk;
+	struct sk_buff *skb;
 
 	BT_DBG("id %d channel %d", req->dev_id, req->channel);
 
@@ -263,8 +270,20 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	init_waitqueue_head(&dev->wait);
 	tasklet_init(&dev->wakeup_task, rfcomm_tty_wakeup, (unsigned long) dev);
+	skb_queue_head_init(&dev->rx_queue);
+	atomic_set(&dev->rxq_mem_alloc, 0);
 
 	rfcomm_dlc_lock(dlc);
+
+	if ((req->flags & (1 << RFCOMM_REUSE_DLC)) && (sk = dlc->owner)) {
+		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+			skb_orphan(skb);
+			atomic_sub(skb->len, &sk->sk_rmem_alloc);
+			atomic_add(skb->len, &dev->rxq_mem_alloc);
+			skb_queue_tail(&dev->rx_queue, skb);
+		}
+	}
+
 	dlc->data_ready   = rfcomm_dev_data_ready;
 	dlc->state_change = rfcomm_dev_state_change;
 	dlc->modem_status = rfcomm_dev_modem_status;
@@ -539,11 +558,21 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
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
+
+		return;
+	}
+
 	BT_DBG("dlc %p tty %p len %d", dlc, tty, skb->len);
 
 	tty_insert_flip_string(tty, skb->data, skb->len);
@@ -627,6 +656,33 @@ static void rfcomm_tty_wakeup(unsigned long arg)
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
+	while ((skb = skb_dequeue(&dev->rx_queue))) {
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
@@ -691,6 +747,8 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 	if (err == 0)
 		device_move(dev->tty_dev, rfcomm_get_device(dev));
 
+	rfcomm_tty_copy_buffered(dev);
+
 	return err;
 }
 

--Boundary-00=_p1yWIyi4kOW0ifA
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-tty-no-canonical-default.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfcomm-tty-no-canonical-default.patch"

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index f2a2e1c..e1b7976 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1181,6 +1181,7 @@ int rfcomm_init_ttys(void)
 	rfcomm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	rfcomm_tty_driver->init_termios	= tty_std_termios;
 	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	rfcomm_tty_driver->init_termios.c_lflag &= ~ICANON;
 	tty_set_operations(rfcomm_tty_driver, &rfcomm_ops);
 
 	if (tty_register_driver(rfcomm_tty_driver)) {

--Boundary-00=_p1yWIyi4kOW0ifA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--Boundary-00=_p1yWIyi4kOW0ifA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_p1yWIyi4kOW0ifA--
