Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: peter@hurleysoftware.com
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v3 3/6] rfcomm: Move the tty initialization and cleanup out of open/close
Date: Thu, 25 Jul 2013 20:32:10 +0200
Message-Id: <1374777133-12397-3-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374777133-12397-1-git-send-email-gianluca@sottospazio.it>
References: <1374777133-12397-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Move the tty_struct initialization from rfcomm_tty_open to rfcomm_tty_install
and do the same for the cleanup moving the code from rfcomm_tty_close to
rfcomm_tty_cleanup.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 108 ++++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 40 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index f5c2a0b..cd37f9b 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -633,49 +633,62 @@ static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
 		tty_flip_buffer_push(&dev->port);
 }
 
-static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
+/* do the reverse of install, clearing the tty fields and releasing the
+ * reference to tty_port
+ */
+static void rfcomm_tty_cleanup(struct tty_struct *tty)
+{
+	struct rfcomm_dev *dev = tty->driver_data;
+
+	if (dev->tty_dev->parent)
+		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
+
+	/* Close DLC and dettach TTY */
+	rfcomm_dlc_close(dev->dlc, 0);
+
+	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+
+	rfcomm_dlc_lock(dev->dlc);
+	tty->driver_data = NULL;
+	rfcomm_dlc_unlock(dev->dlc);
+
+	tty_port_put(&dev->port);
+}
+
+/* we acquire the tty_port reference since it's here the tty is first used
+ * by setting the termios. We also populate the driver_data field and install
+ * the tty port
+ */
+static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct rfcomm_dev *dev;
 	struct rfcomm_dlc *dlc;
-	unsigned long flags;
-	int err, id;
-
-	id = tty->index;
+	int err;
 
-	BT_DBG("tty %p id %d", tty, id);
-
-	/* We don't leak this refcount. For reasons which are not entirely
-	   clear, the TTY layer will call our ->close() method even if the
-	   open fails. We decrease the refcount there, and decreasing it
-	   here too would cause breakage. */
-	dev = rfcomm_dev_get(id);
+	dev = rfcomm_dev_get(tty->index);
 	if (!dev)
 		return -ENODEV;
 
 	BT_DBG("dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
 	       dev->channel, dev->port.count);
 
-	spin_lock_irqsave(&dev->port.lock, flags);
-	if (++dev->port.count > 1) {
-		spin_unlock_irqrestore(&dev->port.lock, flags);
-		return 0;
-	}
-	spin_unlock_irqrestore(&dev->port.lock, flags);
-
 	dlc = dev->dlc;
 
 	/* Attach TTY and open DLC */
-
 	rfcomm_dlc_lock(dlc);
 	tty->driver_data = dev;
-	tty_port_tty_set(&dev->port, tty);
 	rfcomm_dlc_unlock(dlc);
 	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
+	/* install the tty_port */
+	err = tty_port_install(&dev->port, driver, tty);
+	if (err < 0)
+		goto error_no_dlc;
+
 	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
 	if (err < 0)
-		return err;
+		goto error_no_dlc;
 
 	/* Wait for DLC to connect */
 	add_wait_queue(&dev->wait, &wait);
@@ -702,15 +715,42 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev->wait, &wait);
 
-	if (err == 0)
-		device_move(dev->tty_dev, rfcomm_get_device(dev),
-			    DPM_ORDER_DEV_AFTER_PARENT);
+	if (err < 0)
+		goto error_no_connection;
+
+	device_move(dev->tty_dev, rfcomm_get_device(dev),
+		    DPM_ORDER_DEV_AFTER_PARENT);
+	return 0;
+
+error_no_connection:
+	rfcomm_dlc_close(dlc, err);
+error_no_dlc:
+	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+	tty_port_put(&dev->port);
+	return err;
+}
+
+static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	struct rfcomm_dev *dev = tty->driver_data;
+	unsigned long flags;
+
+	BT_DBG("tty %p id %d", tty, tty->index);
+
+	spin_lock_irqsave(&dev->port.lock, flags);
+	dev->port.count++;
+	spin_unlock_irqrestore(&dev->port.lock, flags);
 
+	/*
+	 * FIXME: rfcomm should use proper flow control for
+	 * received data. This hack will be unnecessary and can
+	 * be removed when that's implemented
+	 */
 	rfcomm_tty_copy_pending(dev);
 
 	rfcomm_dlc_unthrottle(dev->dlc);
 
-	return err;
+	return 0;
 }
 
 static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
@@ -727,25 +767,11 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 	spin_lock_irqsave(&dev->port.lock, flags);
 	if (!--dev->port.count) {
 		spin_unlock_irqrestore(&dev->port.lock, flags);
-		if (dev->tty_dev->parent)
-			device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
-
-		/* Close DLC and dettach TTY */
-		rfcomm_dlc_close(dev->dlc, 0);
-
-		clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
-
-		rfcomm_dlc_lock(dev->dlc);
-		tty->driver_data = NULL;
-		tty_port_tty_set(&dev->port, NULL);
-		rfcomm_dlc_unlock(dev->dlc);
 
 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
 			tty_port_put(&dev->port);
 	} else
 		spin_unlock_irqrestore(&dev->port.lock, flags);
-
-	tty_port_put(&dev->port);
 }
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -1118,6 +1144,8 @@ static const struct tty_operations rfcomm_ops = {
 	.wait_until_sent	= rfcomm_tty_wait_until_sent,
 	.tiocmget		= rfcomm_tty_tiocmget,
 	.tiocmset		= rfcomm_tty_tiocmset,
+	.install                = rfcomm_tty_install,
+	.cleanup                = rfcomm_tty_cleanup,
 };
 
 int __init rfcomm_init_ttys(void)
-- 
1.8.3.3
