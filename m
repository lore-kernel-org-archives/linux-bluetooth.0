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
Subject: [PATCH 2/2] rfcomm: move the device under its parent if already connected
Date: Sat,  4 Jan 2014 17:30:38 +0100
Message-Id: <1388853038-6917-3-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1388853038-6917-1-git-send-email-gianluca@sottospazio.it>
References: <1388853038-6917-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a userspace regression introduced with the conversion
of the rfcomm tty code to a proper tty_port driver.

Currently the tty device is moved under the parent only when a
successful BT connection is established.

Unfortunately this doesn't take into account the situation in which the
BT connection is already there, i.e. when the rfcomm device is created
with the flag RFCOMM_REUSE_DLC: in this case the tty device is never
moved under its parent.

This causes a regression with ModemManager which checks the parent
device to determine if the tty is likely to be connected to a modem:
it finds a NULL parent and skip the AT probe sequence.

The patch fixes the regression by calling device_move() in the function
rfcomm_dev_carrier_raised().

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
Reported-by: Beson Chow <blc+bluez@mail.vanade.com>
---
 net/bluetooth/rfcomm/tty.c | 47 ++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a535ef1..9e217d7 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -111,12 +111,34 @@ static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
 	return rfcomm_dlc_open(dev->dlc, &dev->src, &dev->dst, dev->channel);
 }
 
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
 /* we block the open until the dlc->state becomes BT_CONNECTED */
 static int rfcomm_dev_carrier_raised(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
 
-	return (dev->dlc->state == BT_CONNECTED);
+	if (dev->dlc->state == BT_CONNECTED) {
+		device_move(dev->tty_dev, rfcomm_get_device(dev),
+			    DPM_ORDER_DEV_AFTER_PARENT);
+		return 1;
+	}
+
+	return 0;
 }
 
 /* device-specific cleanup: close the dlc */
@@ -169,22 +191,6 @@ static struct rfcomm_dev *rfcomm_dev_get(int id)
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
@@ -576,12 +582,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	BT_DBG("dlc %p dev %p err %d", dlc, dev, err);
 
 	dev->err = err;
-	if (dlc->state == BT_CONNECTED) {
-		device_move(dev->tty_dev, rfcomm_get_device(dev),
-			    DPM_ORDER_DEV_AFTER_PARENT);
-
+	if (dlc->state == BT_CONNECTED)
 		wake_up_interruptible(&dev->port.open_wait);
-	} else if (dlc->state == BT_CLOSED)
+	else if (dlc->state == BT_CLOSED)
 		tty_port_tty_hangup(&dev->port, false);
 }
 
-- 
1.8.5.2
