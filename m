Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org,
	peter@hurleysoftware.com,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH 6/8] Fix the reference counting of tty_port
Date: Fri, 12 Jul 2013 22:40:46 +0200
Message-Id: <1373661649-1385-6-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

The tty_port can be released in two places: in rfcomm_tty_hangup when the flag
RFCOMM_RELEASE_ONHUP is set and there is a HUP and in rfcomm_release_dev.

There we set the flag RFCOMM_TTY_RELEASED so that no other function can get a
reference of the tty_port.

The destructor is changed to remove the device from the list.

Remove also rfcomm_dev_del which isn't used anymore.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 56 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index c8ef06d..0d61d65 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -77,11 +77,7 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
 /* ---- Device functions ---- */
 
 /*
- * The reason this isn't actually a race, as you no doubt have a little voice
- * screaming at you in your head, is that the refcount should never actually
- * reach zero unless the device has already been taken off the list, in
- * rfcomm_dev_del(). And if that's not true, we'll hit the BUG() in
- * rfcomm_dev_destruct() anyway.
+ * the port destructor is called when the tty_port refcount reaches zero
  */
 static void rfcomm_dev_destruct(struct tty_port *port)
 {
@@ -90,10 +86,10 @@ static void rfcomm_dev_destruct(struct tty_port *port)
 
 	BT_DBG("dev %p dlc %p", dev, dlc);
 
-	/* Refcount should only hit zero when called from rfcomm_dev_del()
-	   which will have taken us off the list. Everything else are
-	   refcounting bugs. */
-	BUG_ON(!list_empty(&dev->list));
+	/* remove the dev from the list */
+	spin_lock(&rfcomm_dev_lock);
+	list_del_init(&dev->list);
+	spin_unlock(&rfcomm_dev_lock);
 
 	rfcomm_dlc_lock(dlc);
 	/* Detach DLC if it's owned by this dev */
@@ -394,27 +390,6 @@ free:
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
@@ -530,8 +505,10 @@ static int rfcomm_release_dev(void __user *arg)
 		tty_kref_put(tty);
 	}
 
-	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
-		rfcomm_dev_del(dev);
+	/* release the TTY if not already done in hangup */
+	if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+		tty_port_put(&dev->port);
+
 	tty_port_put(&dev->port);
 	return 0;
 }
@@ -662,6 +639,7 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 {
 	struct rfcomm_dev *dev = dlc->owner;
 	struct tty_struct *tty;
+
 	if (!dev)
 		return;
 
@@ -687,7 +665,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 					return;
 				}
 
-				rfcomm_dev_del(dev);
+				set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
+				tty_port_put(&dev->port);
+
 				tty_port_put(&dev->port);
 				rfcomm_dlc_lock(dlc);
 			}
@@ -754,9 +734,9 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = tty->driver_data;
 
-        /* Remove driver data */
-        clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
-        rfcomm_dlc_lock(dev->dlc);
+	/* Remove driver data */
+	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+	rfcomm_dlc_lock(dev->dlc);
         tty->driver_data = NULL;
         rfcomm_dlc_unlock(dev->dlc);
 
@@ -1087,9 +1067,7 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 	tty_port_hangup(&dev->port);
 
 	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-		if (rfcomm_dev_get(dev->id) == NULL)
-			return;
-		rfcomm_dev_del(dev);
+		set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
 		tty_port_put(&dev->port);
 	}
 }
-- 
1.8.3.2
