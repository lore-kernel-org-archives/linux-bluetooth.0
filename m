Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 12:33:53 +0100
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: andrey.vihrov@gmail.com
Cc: peter@hurleysoftware.com, marcel@holtmann.org,
	gregkh@linuxfoundation.org, jslaby@suse.cz,
	linux-bluetooth@vger.kernel.org
Subject: Re: A problem with "rfcomm bind" and wvdial
Message-ID: <20140106113353.GA21381@sottospazio.it>
References: <20140105154942.GA12621@sottospazio.it>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <20140105154942.GA12621@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 05, 2014 at 04:49:42PM +0100, Gianluca Anzolin wrote:
> Hello,
> 
> I looked at your problem this afternoon and I think I know what's happening:
> wvdial is opening the port with the flag O_NONBLOCK. As expected the rfcomm
> code returns immediately instead of waiting for the BT connection to come
> up. Then wvdial sends the AT commands and the writes fail.

Hi,

could you please test the attached patch?

If it works and people are ok with it I'll submit it along with the other fixes
I already sent to the list.

Thank you,
Gianluca

--Nq2Wo0NMKNjxTN9z
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-rfcomm-always-wait-for-a-bt-connection-on-open.patch"

>From 2da1095aceb22bc323ceb9e1a4f43d92ebe5c2b6 Mon Sep 17 00:00:00 2001
From: Gianluca Anzolin <gianluca@sottospazio.it>
Date: Mon, 6 Jan 2014 12:19:51 +0100
Subject: [PATCH] rfcomm: always wait for a bt connection on open()

This patch fixes a regression introduced with the recent rfcomm tty
rework.

The current code uses the carrier_raised() method to wait for the
bluetooth connection when a process opens the tty. However processes may
open the port with the O_NONBLOCK flag or set the CLOCAL termios flag.

In those cases the open() syscall returns immediately without waiting
for the bluetooth connection to complete. This behaviour confuses
userspace which expects a working bluetooth connection.

The patch removes the carries_raised() method and restores the previous
working behaviour by waiting for the connection in rfcomm_dev_activate().

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
Reported-by: Andrey Vihrov <andrey.vihrov@gmail.com>
---
 net/bluetooth/rfcomm/tty.c | 79 ++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 84fcf9f..e9683bb 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -58,6 +58,7 @@ struct rfcomm_dev {
 	uint			modem_status;
 
 	struct rfcomm_dlc	*dlc;
+	wait_queue_head_t       conn_wait;
 
 	struct device		*tty_dev;
 
@@ -103,20 +104,57 @@ static void rfcomm_dev_destruct(struct tty_port *port)
 	module_put(THIS_MODULE);
 }
 
-/* device-specific initialization: open the dlc */
-static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
+static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
 {
-	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
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
 
-	return rfcomm_dlc_open(dev->dlc, &dev->src, &dev->dst, dev->channel);
+	return conn ? &conn->dev : NULL;
 }
 
-/* we block the open until the dlc->state becomes BT_CONNECTED */
-static int rfcomm_dev_carrier_raised(struct tty_port *port)
+/* device-specific initialization: open the dlc */
+static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
+	DEFINE_WAIT(wait);
+	int err;
 
-	return (dev->dlc->state == BT_CONNECTED);
+	err = rfcomm_dlc_open(dev->dlc, &dev->src, &dev->dst, dev->channel);
+	if (err)
+		return err;
+
+	while (1) {
+		prepare_to_wait(&dev->conn_wait, &wait, TASK_INTERRUPTIBLE);
+
+		if (dev->dlc->state == BT_CLOSED) {
+			err = -dev->err;
+			break;
+		} else if (dev->dlc->state == BT_CONNECTED)
+			break;
+		else if (signal_pending(current)) {
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
 
 /* device-specific cleanup: close the dlc */
@@ -135,7 +173,6 @@ static const struct tty_port_operations rfcomm_port_ops = {
 	.destruct = rfcomm_dev_destruct,
 	.activate = rfcomm_dev_activate,
 	.shutdown = rfcomm_dev_shutdown,
-	.carrier_raised = rfcomm_dev_carrier_raised,
 };
 
 static struct rfcomm_dev *__rfcomm_dev_get(int id)
@@ -169,22 +206,6 @@ static struct rfcomm_dev *rfcomm_dev_get(int id)
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
@@ -258,6 +279,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	tty_port_init(&dev->port);
 	dev->port.ops = &rfcomm_port_ops;
+	init_waitqueue_head(&dev->conn_wait);
 
 	skb_queue_head_init(&dev->pending);
 
@@ -575,12 +597,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
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
 
@@ -1096,7 +1115,7 @@ int __init rfcomm_init_ttys(void)
 	rfcomm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
 	rfcomm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	rfcomm_tty_driver->init_termios	= tty_std_termios;
-	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL;
+	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	rfcomm_tty_driver->init_termios.c_lflag &= ~ICANON;
 	tty_set_operations(rfcomm_tty_driver, &rfcomm_ops);
 
-- 
1.8.5.2


--Nq2Wo0NMKNjxTN9z--
