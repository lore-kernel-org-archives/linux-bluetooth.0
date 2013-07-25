Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: peter@hurleysoftware.com
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v3 4/6] rfcomm: Implement .activate, .shutdown and .carrier_raised methods
Date: Thu, 25 Jul 2013 20:32:11 +0200
Message-Id: <1374777133-12397-4-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374777133-12397-1-git-send-email-gianluca@sottospazio.it>
References: <1374777133-12397-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Implement .activate, .shutdown and .carrier_raised methods of tty_port to
manage the dlc, moving the code from rfcomm_tty_install() and
rfcomm_tty_cleanup() functions.

At the same time the tty_open close and hangup functions are changed to use the
tty_port helpers that properly call the aforementioned tty_port methods.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 115 ++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 68 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index cd37f9b..24a7c8c 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -58,7 +58,6 @@ struct rfcomm_dev {
 	uint			modem_status;
 
 	struct rfcomm_dlc	*dlc;
-	wait_queue_head_t       wait;
 
 	struct device		*tty_dev;
 
@@ -104,8 +103,39 @@ static void rfcomm_dev_destruct(struct tty_port *port)
 	module_put(THIS_MODULE);
 }
 
+/* device-specific initialization: open the dlc */
+static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
+
+	return rfcomm_dlc_open(dev->dlc, &dev->src, &dev->dst, dev->channel);
+}
+
+/* we block the open until the dlc->state becomes BT_CONNECTED */
+static int rfcomm_dev_carrier_raised(struct tty_port *port)
+{
+	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
+
+	return (dev->dlc->state == BT_CONNECTED);
+}
+
+/* device-specific cleanup: close the dlc */
+static void rfcomm_dev_shutdown(struct tty_port *port)
+{
+	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
+
+	if (dev->tty_dev->parent)
+		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
+
+	/* close the dlc */
+	rfcomm_dlc_close(dev->dlc, 0);
+}
+
 static const struct tty_port_operations rfcomm_port_ops = {
 	.destruct = rfcomm_dev_destruct,
+	.activate = rfcomm_dev_activate,
+	.shutdown = rfcomm_dev_shutdown,
+	.carrier_raised = rfcomm_dev_carrier_raised,
 };
 
 static struct rfcomm_dev *__rfcomm_dev_get(int id)
@@ -228,7 +258,6 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	tty_port_init(&dev->port);
 	dev->port.ops = &rfcomm_port_ops;
-	init_waitqueue_head(&dev->wait);
 
 	skb_queue_head_init(&dev->pending);
 
@@ -563,9 +592,12 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	BT_DBG("dlc %p dev %p err %d", dlc, dev, err);
 
 	dev->err = err;
-	wake_up_interruptible(&dev->wait);
+	if (dlc->state == BT_CONNECTED) {
+		device_move(dev->tty_dev, rfcomm_get_device(dev),
+			    DPM_ORDER_DEV_AFTER_PARENT);
 
-	if (dlc->state == BT_CLOSED) {
+		wake_up_interruptible(&dev->port.open_wait);
+	} else if (dlc->state == BT_CLOSED) {
 		tty = tty_port_tty_get(&dev->port);
 		if (!tty) {
 			if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
@@ -640,12 +672,6 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = tty->driver_data;
 
-	if (dev->tty_dev->parent)
-		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
-
-	/* Close DLC and dettach TTY */
-	rfcomm_dlc_close(dev->dlc, 0);
-
 	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
 	rfcomm_dlc_lock(dev->dlc);
@@ -661,7 +687,6 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
  */
 static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct rfcomm_dev *dev;
 	struct rfcomm_dlc *dlc;
 	int err;
@@ -683,63 +708,22 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	/* install the tty_port */
 	err = tty_port_install(&dev->port, driver, tty);
-	if (err < 0)
-		goto error_no_dlc;
-
-	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
-	if (err < 0)
-		goto error_no_dlc;
+	if (err)
+		rfcomm_tty_cleanup(tty);
 
-	/* Wait for DLC to connect */
-	add_wait_queue(&dev->wait, &wait);
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (dlc->state == BT_CLOSED) {
-			err = -dev->err;
-			break;
-		}
-
-		if (dlc->state == BT_CONNECTED)
-			break;
-
-		if (signal_pending(current)) {
-			err = -EINTR;
-			break;
-		}
-
-		tty_unlock(tty);
-		schedule();
-		tty_lock(tty);
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&dev->wait, &wait);
-
-	if (err < 0)
-		goto error_no_connection;
-
-	device_move(dev->tty_dev, rfcomm_get_device(dev),
-		    DPM_ORDER_DEV_AFTER_PARENT);
-	return 0;
-
-error_no_connection:
-	rfcomm_dlc_close(dlc, err);
-error_no_dlc:
-	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
-	tty_port_put(&dev->port);
 	return err;
 }
 
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct rfcomm_dev *dev = tty->driver_data;
-	unsigned long flags;
+	int err;
 
 	BT_DBG("tty %p id %d", tty, tty->index);
 
-	spin_lock_irqsave(&dev->port.lock, flags);
-	dev->port.count++;
-	spin_unlock_irqrestore(&dev->port.lock, flags);
+	err = tty_port_open(&dev->port, tty, filp);
+	if (err)
+		return err;
 
 	/*
 	 * FIXME: rfcomm should use proper flow control for
@@ -756,7 +740,6 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	unsigned long flags;
 
 	if (!dev)
 		return;
@@ -764,14 +747,10 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 	BT_DBG("tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
 						dev->port.count);
 
-	spin_lock_irqsave(&dev->port.lock, flags);
-	if (!--dev->port.count) {
-		spin_unlock_irqrestore(&dev->port.lock, flags);
+	tty_port_close(&dev->port, tty, filp);
 
-		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
-			tty_port_put(&dev->port);
-	} else
-		spin_unlock_irqrestore(&dev->port.lock, flags);
+	if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+		tty_port_put(&dev->port);
 }
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -1074,7 +1053,7 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 	if (!dev)
 		return;
 
-	rfcomm_tty_flush_buffer(tty);
+	tty_port_hangup(&dev->port);
 
 	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
 		if (rfcomm_dev_get(dev->id) == NULL)
@@ -1164,7 +1143,7 @@ int __init rfcomm_init_ttys(void)
 	rfcomm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
 	rfcomm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	rfcomm_tty_driver->init_termios	= tty_std_termios;
-	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL;
 	rfcomm_tty_driver->init_termios.c_lflag &= ~ICANON;
 	tty_set_operations(rfcomm_tty_driver, &rfcomm_ops);
 
-- 
1.8.3.3
