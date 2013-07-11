Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Jul 2013 21:01:50 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: [PATCH v2] Fix refcounting issues in rfcomm/tty.c
Message-ID: <20130711190150.GA24422@debian.seek.priv>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
List-ID: <linux-bluetooth.vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This is a second version of the previous patches I sent to linux-bluetooth
list. I grouped the two patches together since they are related.

I fixed some bugs in my previous attempt:

1. skb_queue_purge is now called in the cleanup method to avoid a circular
dependency between the dev struct and dlc struct.

2. refcomm_dev_release should check REFCOMM_TTY_RELEASED instead of
REFCOMM_RELEASE_ONHUP.

I checked with both bluez4 and bluez5 and everything works as expected.

The patch still depends on the tty_port patch I already sent to linux-kernel
and to its maintainer but I haven't received any reply yet.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>


--IS0zKkzwUGydFO0o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="rfcomm-tty-patch-v2.patch"

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index b6e44ad..d363c56 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -77,43 +77,143 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
 /* ---- Device functions ---- */
 
 /*
- * The reason this isn't actually a race, as you no doubt have a little voice
- * screaming at you in your head, is that the refcount should never actually
- * reach zero unless the device has already been taken off the list, in
- * rfcomm_dev_del(). And if that's not true, we'll hit the BUG() in
- * rfcomm_dev_destruct() anyway.
+ * rfcomm_dev_destruct is called when the tty_port refcount reaches zero
  */
 static void rfcomm_dev_destruct(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
 	struct rfcomm_dlc *dlc = dev->dlc;
 
-	BT_DBG("dev %p dlc %p", dev, dlc);
+	BT_DBG("destruct dev %p dlc %p", dev, dlc);
 
-	/* Refcount should only hit zero when called from rfcomm_dev_del()
-	   which will have taken us off the list. Everything else are
-	   refcounting bugs. */
-	BUG_ON(!list_empty(&dev->list));
+	tty_unregister_device(rfcomm_tty_driver, dev->id);
+
+	/* remove the dev from the list */
+	spin_lock(&rfcomm_dev_lock);
+	list_del_init(&dev->list);
+	spin_unlock(&rfcomm_dev_lock);
 
+	/* reset the DLC owner */
 	rfcomm_dlc_lock(dlc);
-	/* Detach DLC if it's owned by this dev */
 	if (dlc->owner == dev)
 		dlc->owner = NULL;
 	rfcomm_dlc_unlock(dlc);
 
-	rfcomm_dlc_put(dlc);
-
-	tty_unregister_device(rfcomm_tty_driver, dev->id);
-
 	kfree(dev);
-
 	/* It's safe to call module_put() here because socket still
 	   holds reference to this module. */
 	module_put(THIS_MODULE);
+
+	rfcomm_dlc_put(dlc);
+}
+
+static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
+{
+	struct hci_dev *hdev;
+	struct hci_conn *conn;
+
+	hdev = hci_get_route(&dev->dst, &dev->src);
+	if (!hdev)
+		return NULL;
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &dev->dst);
+
+	hci_dev_put(hdev);
+
+	return conn ? &conn->dev : NULL;
+}
+
+static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
+{
+	struct sk_buff *skb;
+	int inserted = 0;
+
+	BT_DBG("dev %p", dev);
+
+	rfcomm_dlc_lock(dev->dlc);
+	while ((skb = skb_dequeue(&dev->pending))) {
+		inserted += tty_insert_flip_string(&dev->port, skb->data,
+				skb->len);
+		kfree_skb(skb);
+	}
+
+	rfcomm_dlc_unlock(dev->dlc);
+
+	if (inserted > 0)
+		tty_flip_buffer_push(&dev->port);
+}
+
+static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	DEFINE_WAIT(wait);
+	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
+	struct rfcomm_dlc *dlc = dev->dlc;
+	int err;
+
+	BT_DBG("activate dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
+	       dev->channel, dev->port.count);
+
+	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
+	if (err < 0)
+		goto error_no_dlc_open;
+
+	/* Wait for DLC to connect */
+	while (1) {
+		prepare_to_wait(&dev->wait, &wait, TASK_INTERRUPTIBLE);
+
+		if (dlc->state == BT_CLOSED) {
+			err = -dev->err;
+			break;
+		}
+
+		if (dlc->state == BT_CONNECTED)
+			break;
+
+		if (signal_pending(current)) {
+			err = -EINTR;
+			break;
+		}
+
+		tty_unlock(tty);
+		schedule();
+		tty_lock(tty);
+	}
+	finish_wait(&dev->wait, &wait);
+
+	if (err < 0)
+		goto error_no_dlc_connect;
+
+	device_move(dev->tty_dev, rfcomm_get_device(dev),
+		    DPM_ORDER_DEV_AFTER_PARENT);
+
+	rfcomm_tty_copy_pending(dev);
+	rfcomm_dlc_unthrottle(dev->dlc);
+
+	return err;
+
+error_no_dlc_connect:
+	rfcomm_dlc_close(dlc, 0);
+error_no_dlc_open:
+	return err;
+}
+
+static void rfcomm_dev_shutdown(struct tty_port *port)
+{
+	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
+
+	BT_DBG("shutdown dev %p", dev);
+
+	if (dev->tty_dev->parent)
+		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
+
+	/* Close DLC */
+	rfcomm_dlc_close(dev->dlc, 0);
 }
 
 static const struct tty_port_operations rfcomm_port_ops = {
 	.destruct = rfcomm_dev_destruct,
+	.activate = rfcomm_dev_activate,
+	.shutdown = rfcomm_dev_shutdown,
 };
 
 static struct rfcomm_dev *__rfcomm_dev_get(int id)
@@ -147,22 +247,6 @@ static struct rfcomm_dev *rfcomm_dev_get(int id)
 	return dev;
 }
 
-static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
-{
-	struct hci_dev *hdev;
-	struct hci_conn *conn;
-
-	hdev = hci_get_route(&dev->dst, &dev->src);
-	if (!hdev)
-		return NULL;
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &dev->dst);
-
-	hci_dev_put(hdev);
-
-	return conn ? &conn->dev : NULL;
-}
-
 static ssize_t show_address(struct device *tty_dev, struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
@@ -184,7 +268,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	struct list_head *head = &rfcomm_dev_list;
 	int err = 0;
 
-	BT_DBG("id %d channel %d", req->dev_id, req->channel);
+	BT_DBG("add dev id %d channel %d", req->dev_id, req->channel);
 
 	dev = kzalloc(sizeof(struct rfcomm_dev), GFP_KERNEL);
 	if (!dev)
@@ -298,30 +382,10 @@ out:
 
 free:
 	kfree(dev);
+	module_put(THIS_MODULE);
 	return err;
 }
 
-static void rfcomm_dev_del(struct rfcomm_dev *dev)
-{
-	unsigned long flags;
-	BT_DBG("dev %p", dev);
-
-	BUG_ON(test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags));
-
-	spin_lock_irqsave(&dev->port.lock, flags);
-	if (dev->port.count > 0) {
-		spin_unlock_irqrestore(&dev->port.lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&dev->port.lock, flags);
-
-	spin_lock(&rfcomm_dev_lock);
-	list_del_init(&dev->list);
-	spin_unlock(&rfcomm_dev_lock);
-
-	tty_port_put(&dev->port);
-}
-
 /* ---- Send buffer ---- */
 static inline unsigned int rfcomm_room(struct rfcomm_dlc *dlc)
 {
@@ -333,10 +397,11 @@ static inline unsigned int rfcomm_room(struct rfcomm_dlc *dlc)
 static void rfcomm_wfree(struct sk_buff *skb)
 {
 	struct rfcomm_dev *dev = (void *) skb->sk;
-	struct tty_struct *tty = dev->port.tty;
+
 	atomic_sub(skb->truesize, &dev->wmem_alloc);
-	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags) && tty)
-		tty_wakeup(tty);
+	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags))
+		tty_port_tty_wakeup(&dev->port);
+
 	tty_port_put(&dev->port);
 }
 
@@ -373,7 +438,7 @@ static int rfcomm_create_dev(struct sock *sk, void __user *arg)
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	BT_DBG("sk %p dev_id %d flags 0x%x", sk, req.dev_id, req.flags);
+	BT_DBG("create sk %p dev_id %d flags 0x%x", sk, req.dev_id, req.flags);
 
 	if (req.flags != NOCAP_FLAGS && !capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -410,11 +475,12 @@ static int rfcomm_release_dev(void __user *arg)
 {
 	struct rfcomm_dev_req req;
 	struct rfcomm_dev *dev;
+	struct tty_struct *tty;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	BT_DBG("dev_id %d flags 0x%x", req.dev_id, req.flags);
+	BT_DBG("release dev_id %d flags 0x%x", req.dev_id, req.flags);
 
 	dev = rfcomm_dev_get(req.dev_id);
 	if (!dev)
@@ -429,11 +495,16 @@ static int rfcomm_release_dev(void __user *arg)
 		rfcomm_dlc_close(dev->dlc, 0);
 
 	/* Shut down TTY synchronously before freeing rfcomm_dev */
-	if (dev->port.tty)
-		tty_vhangup(dev->port.tty);
+	tty = tty_port_tty_get(&dev->port);
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
+
+	/* release the TTY */
+	if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+		tty_port_put(&dev->port);
 
-	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
-		rfcomm_dev_del(dev);
 	tty_port_put(&dev->port);
 	return 0;
 }
@@ -446,7 +517,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	int n = 0, size, err;
 	u16 dev_num;
 
-	BT_DBG("");
+	BT_DBG("get_dev_list");
 
 	if (get_user(dev_num, (u16 __user *) arg))
 		return -EFAULT;
@@ -494,7 +565,7 @@ static int rfcomm_get_dev_info(void __user *arg)
 	struct rfcomm_dev_info di;
 	int err = 0;
 
-	BT_DBG("");
+	BT_DBG("get_dev_info");
 
 	if (copy_from_user(&di, arg, sizeof(di)))
 		return -EFAULT;
@@ -518,7 +589,7 @@ static int rfcomm_get_dev_info(void __user *arg)
 
 int rfcomm_dev_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 {
-	BT_DBG("cmd %d arg %p", cmd, arg);
+	BT_DBG("dev_ioctl cmd %d arg %p", cmd, arg);
 
 	switch (cmd) {
 	case RFCOMMCREATEDEV:
@@ -552,7 +623,7 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 		return;
 	}
 
-	BT_DBG("dlc %p len %d", dlc, skb->len);
+	BT_DBG("dev_data_ready dlc %p len %d", dlc, skb->len);
 
 	tty_insert_flip_string(&dev->port, skb->data, skb->len);
 	tty_flip_buffer_push(&dev->port);
@@ -563,37 +634,17 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 {
 	struct rfcomm_dev *dev = dlc->owner;
+
 	if (!dev)
 		return;
 
-	BT_DBG("dlc %p dev %p err %d", dlc, dev, err);
+	BT_DBG("dev_state_change dlc %p dev %p err %d", dlc, dev, err);
 
 	dev->err = err;
 	wake_up_interruptible(&dev->wait);
 
-	if (dlc->state == BT_CLOSED) {
-		if (!dev->port.tty) {
-			if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-				/* Drop DLC lock here to avoid deadlock
-				 * 1. rfcomm_dev_get will take rfcomm_dev_lock
-				 *    but in rfcomm_dev_add there's lock order:
-				 *    rfcomm_dev_lock -> dlc lock
-				 * 2. tty_port_put will deadlock if it's
-				 *    the last reference
-				 */
-				rfcomm_dlc_unlock(dlc);
-				if (rfcomm_dev_get(dev->id) == NULL) {
-					rfcomm_dlc_lock(dlc);
-					return;
-				}
-
-				rfcomm_dev_del(dev);
-				tty_port_put(&dev->port);
-				rfcomm_dlc_lock(dlc);
-			}
-		} else
-			tty_hangup(dev->port.tty);
-	}
+	if (dlc->state == BT_CLOSED)
+		tty_port_tty_hangup(&dev->port, false);
 }
 
 static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
@@ -602,12 +653,11 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 	if (!dev)
 		return;
 
-	BT_DBG("dlc %p dev %p v24_sig 0x%02x", dlc, dev, v24_sig);
+	BT_DBG("dev_modem_status dlc %p dev %p v24_sig 0x%02x",
+	       dlc, dev, v24_sig);
 
-	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV)) {
-		if (dev->port.tty && !C_CLOCAL(dev->port.tty))
-			tty_hangup(dev->port.tty);
-	}
+	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV))
+		tty_port_tty_hangup(&dev->port, true);
 
 	dev->modem_status =
 		((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : 0) |
@@ -617,145 +667,86 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 }
 
 /* ---- TTY functions ---- */
-static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
-{
-	struct sk_buff *skb;
-	int inserted = 0;
-
-	BT_DBG("dev %p", dev);
-
-	rfcomm_dlc_lock(dev->dlc);
-
-	while ((skb = skb_dequeue(&dev->pending))) {
-		inserted += tty_insert_flip_string(&dev->port, skb->data,
-				skb->len);
-		kfree_skb(skb);
-	}
-
-	rfcomm_dlc_unlock(dev->dlc);
-
-	if (inserted > 0)
-		tty_flip_buffer_push(&dev->port);
-}
-
-static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
+static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct rfcomm_dev *dev;
-	struct rfcomm_dlc *dlc;
-	unsigned long flags;
-	int err, id;
-
-	id = tty->index;
+	int err;
 
-	BT_DBG("tty %p id %d", tty, id);
+	BT_DBG("install tty %p id %d", tty, tty->index);
 
-	/* We don't leak this refcount. For reasons which are not entirely
-	   clear, the TTY layer will call our ->close() method even if the
-	   open fails. We decrease the refcount there, and decreasing it
-	   here too would cause breakage. */
-	dev = rfcomm_dev_get(id);
+	dev = rfcomm_dev_get(tty->index);
 	if (!dev)
 		return -ENODEV;
 
-	BT_DBG("dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
-	       dev->channel, dev->port.count);
-
-	spin_lock_irqsave(&dev->port.lock, flags);
-	if (++dev->port.count > 1) {
-		spin_unlock_irqrestore(&dev->port.lock, flags);
-		return 0;
-	}
-	spin_unlock_irqrestore(&dev->port.lock, flags);
-
-	dlc = dev->dlc;
-
-	/* Attach TTY and open DLC */
-
-	rfcomm_dlc_lock(dlc);
+	/* Attach TTY */
+	rfcomm_dlc_lock(dev->dlc);
 	tty->driver_data = dev;
-	dev->port.tty = tty;
-	rfcomm_dlc_unlock(dlc);
+	rfcomm_dlc_unlock(dev->dlc);
 	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
-	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
-	if (err < 0)
-		return err;
+	err = tty_port_install(&dev->port, driver, tty);
+	if (err < 0) {
+		clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+		tty_port_put(&dev->port);
+	}
 
-	/* Wait for DLC to connect */
-	add_wait_queue(&dev->wait, &wait);
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
+	return err;
+}
 
-		if (dlc->state == BT_CLOSED) {
-			err = -dev->err;
-			break;
-		}
+static void rfcomm_tty_cleanup(struct tty_struct *tty)
+{
+	struct rfcomm_dev *dev = tty->driver_data;
 
-		if (dlc->state == BT_CONNECTED)
-			break;
+	BT_DBG("cleanup tty %p id %d", tty, tty->index);
 
-		if (signal_pending(current)) {
-			err = -EINTR;
-			break;
-		}
+	/* Remove driver data */
+	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+	rfcomm_dlc_lock(dev->dlc);
+	tty->driver_data = NULL;
+	rfcomm_dlc_unlock(dev->dlc);
 
-		tty_unlock(tty);
-		schedule();
-		tty_lock(tty);
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&dev->wait, &wait);
+	/*
+	 * there is a circular dependency between dev and dlc
+	 * dev holds a reference to a dlc
+	 * dlc->tx_queue hold skbufs with references to dev
+	 * so purge the tx_queue
+	 */
+	skb_queue_purge(&dev->dlc->tx_queue);
 
-	if (err == 0)
-		device_move(dev->tty_dev, rfcomm_get_device(dev),
-			    DPM_ORDER_DEV_AFTER_PARENT);
+	tty_port_put(&dev->port);
+}
 
-	rfcomm_tty_copy_pending(dev);
+static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	struct rfcomm_dev *dev = tty->driver_data;
 
-	rfcomm_dlc_unthrottle(dev->dlc);
+	BT_DBG("open tty %p id %d", tty, tty->index);
 
-	return err;
+	return tty_port_open(&dev->port, tty, filp);
 }
 
 static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	unsigned long flags;
+	struct rfcomm_dev *dev = tty->driver_data;
 
-	if (!dev)
-		return;
-
-	BT_DBG("tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
+	BT_DBG("close tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
 						dev->port.count);
 
-	spin_lock_irqsave(&dev->port.lock, flags);
-	if (!--dev->port.count) {
-		spin_unlock_irqrestore(&dev->port.lock, flags);
-		if (dev->tty_dev->parent)
-			device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
-
-		/* Close DLC and dettach TTY */
-		rfcomm_dlc_close(dev->dlc, 0);
-
-		clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+	tty_port_close(&dev->port, tty, filp);
+}
 
-		rfcomm_dlc_lock(dev->dlc);
-		tty->driver_data = NULL;
-		dev->port.tty = NULL;
-		rfcomm_dlc_unlock(dev->dlc);
+static void rfcomm_tty_hangup(struct tty_struct *tty)
+{
+	struct rfcomm_dev *dev = tty->driver_data;
 
-		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
-			spin_lock(&rfcomm_dev_lock);
-			list_del_init(&dev->list);
-			spin_unlock(&rfcomm_dev_lock);
+	BT_DBG("hangup tty %p dev %p", tty, dev);
 
-			tty_port_put(&dev->port);
-		}
-	} else
-		spin_unlock_irqrestore(&dev->port.lock, flags);
+	tty_port_hangup(&dev->port);
 
-	tty_port_put(&dev->port);
+	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
+		set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
+		tty_port_put(&dev->port);
+	}
 }
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -765,7 +756,7 @@ static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, in
 	struct sk_buff *skb;
 	int err = 0, sent = 0, size;
 
-	BT_DBG("tty %p count %d", tty, count);
+	BT_DBG("write tty %p count %d", tty, count);
 
 	while (count) {
 		size = min_t(uint, count, dlc->mtu);
@@ -797,7 +788,7 @@ static int rfcomm_tty_write_room(struct tty_struct *tty)
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
 	int room;
 
-	BT_DBG("tty %p", tty);
+	BT_DBG("tty_write_room %p", tty);
 
 	if (!dev || !dev->dlc)
 		return 0;
@@ -1017,7 +1008,7 @@ static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	if (!dev || !dev->dlc)
+	if (!dev)
 		return 0;
 
 	if (!skb_queue_empty(&dev->dlc->tx_queue))
@@ -1030,7 +1021,7 @@ static void rfcomm_tty_flush_buffer(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
 
-	BT_DBG("tty %p dev %p", tty, dev);
+	BT_DBG("flush_buffer tty %p dev %p", tty, dev);
 
 	if (!dev || !dev->dlc)
 		return;
@@ -1049,25 +1040,6 @@ static void rfcomm_tty_wait_until_sent(struct tty_struct *tty, int timeout)
 	BT_DBG("tty %p timeout %d", tty, timeout);
 }
 
-static void rfcomm_tty_hangup(struct tty_struct *tty)
-{
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-
-	BT_DBG("tty %p dev %p", tty, dev);
-
-	if (!dev)
-		return;
-
-	rfcomm_tty_flush_buffer(tty);
-
-	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-		if (rfcomm_dev_get(dev->id) == NULL)
-			return;
-		rfcomm_dev_del(dev);
-		tty_port_put(&dev->port);
-	}
-}
-
 static int rfcomm_tty_tiocmget(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
@@ -1128,6 +1100,8 @@ static const struct tty_operations rfcomm_ops = {
 	.wait_until_sent	= rfcomm_tty_wait_until_sent,
 	.tiocmget		= rfcomm_tty_tiocmget,
 	.tiocmset		= rfcomm_tty_tiocmset,
+	.install                = rfcomm_tty_install,
+	.cleanup                = rfcomm_tty_cleanup,
 };
 
 int __init rfcomm_init_ttys(void)

--IS0zKkzwUGydFO0o--
