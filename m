Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	stable@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v3 3/4] rfcomm: always wait for a bt connection on open()
Date: Mon,  6 Jan 2014 21:23:52 +0100
Message-Id: <1389039834-24491-4-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
References: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes two regressions introduced with the recent rfcomm tty
rework.

The current code uses the carrier_raised() method to wait for the
bluetooth connection when a process opens the tty.

However processes may open the port with the O_NONBLOCK flag or set the
CLOCAL termios flag: in these cases the open() syscall returns
immediately without waiting for the bluetooth connection to
complete.

This behaviour confuses userspace which expects an established bluetooth
connection.

The patch restores the old behaviour by waiting for the connection in
rfcomm_dev_activate() and removes carrier_raised() from the tty_port ops.

As a side effect the new code also fixes the case in which the rfcomm
tty device is created with the flag RFCOMM_REUSE_DLC: the old code
didn't call device_move() and ModemManager skipped the detection
probe. Now device_move() is always called inside rfcomm_dev_activate().

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
Reported-by: Andrey Vihrov <andrey.vihrov@gmail.com>
Reported-by: Beson Chow <blc+bluez@mail.vanade.com>
---
 net/bluetooth/rfcomm/tty.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 32ef9f9..aeabade 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -58,6 +58,7 @@ struct rfcomm_dev {
 	uint			modem_status;
 
 	struct rfcomm_dlc	*dlc;
+	wait_queue_head_t       conn_wait;
 
 	struct device		*tty_dev;
 
@@ -123,8 +124,40 @@ static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
 static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
+	DEFINE_WAIT(wait);
+	int err;
+
+	err = rfcomm_dlc_open(dev->dlc, &dev->src, &dev->dst, dev->channel);
+	if (err)
+		return err;
+
+	while (1) {
+		prepare_to_wait(&dev->conn_wait, &wait, TASK_INTERRUPTIBLE);
 
-	return rfcomm_dlc_open(dev->dlc, &dev->src, &dev->dst, dev->channel);
+		if (dev->dlc->state == BT_CLOSED) {
+			err = -dev->err;
+			break;
+		}
+
+		if (dev->dlc->state == BT_CONNECTED)
+			break;
+
+		if (signal_pending(current)) {
+			err = -ERESTARTSYS;
+			break;
+		}
+
+		tty_unlock(tty);
+		schedule();
+		tty_lock(tty);
+	}
+	finish_wait(&dev->conn_wait, &wait);
+
+	if (!err)
+		device_move(dev->tty_dev, rfcomm_get_device(dev),
+			    DPM_ORDER_DEV_AFTER_PARENT);
+
+	return err;
 }
 
 /* we block the open until the dlc->state becomes BT_CONNECTED */
@@ -151,7 +184,6 @@ static const struct tty_port_operations rfcomm_port_ops = {
 	.destruct = rfcomm_dev_destruct,
 	.activate = rfcomm_dev_activate,
 	.shutdown = rfcomm_dev_shutdown,
-	.carrier_raised = rfcomm_dev_carrier_raised,
 };
 
 static struct rfcomm_dev *__rfcomm_dev_get(int id)
@@ -258,6 +290,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	tty_port_init(&dev->port);
 	dev->port.ops = &rfcomm_port_ops;
+	init_waitqueue_head(&dev->conn_wait);
 
 	skb_queue_head_init(&dev->pending);
 
@@ -576,12 +609,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	BT_DBG("dlc %p dev %p err %d", dlc, dev, err);
 
 	dev->err = err;
-	if (dlc->state == BT_CONNECTED) {
-		device_move(dev->tty_dev, rfcomm_get_device(dev),
-			    DPM_ORDER_DEV_AFTER_PARENT);
+	wake_up_interruptible(&dev->conn_wait);
 
-		wake_up_interruptible(&dev->port.open_wait);
-	} else if (dlc->state == BT_CLOSED)
+	if (dlc->state == BT_CLOSED)
 		tty_port_tty_hangup(&dev->port, false);
 }
 
@@ -1103,7 +1133,7 @@ int __init rfcomm_init_ttys(void)
 	rfcomm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
 	rfcomm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	rfcomm_tty_driver->init_termios	= tty_std_termios;
-	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL;
+	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	rfcomm_tty_driver->init_termios.c_lflag &= ~ICANON;
 	tty_set_operations(rfcomm_tty_driver, &rfcomm_ops);
 
-- 
1.8.5.2
