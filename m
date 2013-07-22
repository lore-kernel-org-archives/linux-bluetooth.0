Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: linux-bluetooth@vger.kernel.org
Cc: peter@hurleysoftware.com,
	gustavo@padovan.org,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [RFC PATCH] rfcomm: avoid the nested locks in rfcomm_dev_add and fix rfcomm_dev_state_change
Date: Mon, 22 Jul 2013 19:15:00 +0200
Message-Id: <1374513300-12467-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

By setting the bit RFCOMM_TTY_RELEASED in the dev->flags we prevent the code to
take any reference to the device. This way we can unnest the rfcomm_dev_lock and
the rfcomm_dlc_lock in rfcomm_dev_add().

In rfcomm_dev_state_change we can now take a reference to the device without
having to drop the dlc lock: this way we ensure the dev cannot be used after
being freed.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 67 ++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 50b38d7..6ae7882e 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -196,6 +196,9 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	if (!dev)
 		return -ENOMEM;
 
+	/* avoid taking references to dev if not initialized */
+	set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
+
 	spin_lock(&rfcomm_dev_lock);
 
 	if (req->dev_id < 0) {
@@ -233,6 +236,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	list_add(&dev->list, head);
 
+	spin_unlock(&rfcomm_dev_lock);
+
 	bacpy(&dev->src, &req->src);
 	bacpy(&dev->dst, &req->dst);
 	dev->channel = req->channel;
@@ -277,19 +282,25 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	   holds reference to this module. */
 	__module_get(THIS_MODULE);
 
-out:
-	spin_unlock(&rfcomm_dev_lock);
-
-	if (err < 0)
-		goto free;
-
 	dev->tty_dev = tty_port_register_device(&dev->port, rfcomm_tty_driver,
 			dev->id, NULL);
 	if (IS_ERR(dev->tty_dev)) {
 		err = PTR_ERR(dev->tty_dev);
+
+		module_put(THIS_MODULE);
+
 		spin_lock(&rfcomm_dev_lock);
 		list_del(&dev->list);
 		spin_unlock(&rfcomm_dev_lock);
+
+		skb_queue_purge(&dev->pending);
+
+		rfcomm_dlc_lock(dlc);
+		dlc->data_ready   = NULL;
+		dlc->state_change = NULL;
+		dlc->modem_status = NULL;
+		dlc->owner = NULL;
+		rfcomm_dlc_unlock(dlc);
 		goto free;
 	}
 
@@ -301,8 +312,12 @@ out:
 	if (device_create_file(dev->tty_dev, &dev_attr_channel) < 0)
 		BT_ERR("Failed to create channel attribute");
 
-	return dev->id;
+	/* the device is initialized, we can take references to it */
+	clear_bit(RFCOMM_TTY_RELEASED, &dev->flags);
 
+	return dev->id;
+out:
+	spin_unlock(&rfcomm_dev_lock);
 free:
 	kfree(dev);
 	return err;
@@ -585,33 +600,21 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 		wake_up_interruptible(&dev->port.open_wait);
 	} else if (dlc->state == BT_CLOSED) {
 		tty = tty_port_tty_get(&dev->port);
-		if (!tty) {
-			if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-				/* Drop DLC lock here to avoid deadlock
-				 * 1. rfcomm_dev_get will take rfcomm_dev_lock
-				 *    but in rfcomm_dev_add there's lock order:
-				 *    rfcomm_dev_lock -> dlc lock
-				 * 2. tty_port_put will deadlock if it's
-				 *    the last reference
-				 *
-				 * FIXME: when we release the lock anything
-				 * could happen to dev, even its destruction
-				 */
-				rfcomm_dlc_unlock(dlc);
-				if (rfcomm_dev_get(dev->id) == NULL) {
-					rfcomm_dlc_lock(dlc);
-					return;
-				}
-
-				set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
-				tty_port_put(&dev->port);
-
-				tty_port_put(&dev->port);
-				rfcomm_dlc_lock(dlc);
-			}
-		} else {
+		if (tty) {
 			tty_hangup(tty);
 			tty_kref_put(tty);
+		} else if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
+			;
+		else if (rfcomm_dev_get(dev->id)) {
+			if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+				tty_port_put(&dev->port);
+
+			/* tty_port_put will deadlock if it is
+			 * the last reference
+			 */
+			rfcomm_dlc_unlock(dlc);
+			tty_port_put(&dev->port);
+			rfcomm_dlc_lock(dlc);
 		}
 	}
 }
-- 
1.8.3.3
