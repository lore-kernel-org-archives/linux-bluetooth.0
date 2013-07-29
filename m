Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v5 5/6] rfcomm: Fix the reference counting of tty_port
Date: Mon, 29 Jul 2013 17:08:12 +0200
Message-Id: <1375110493-5237-6-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

The tty_port can be released in two cases: when we get a HUP in the
functions rfcomm_tty_hangup() and rfcomm_dev_state_change(). Or when the
user releases the device in rfcomm_release_dev().

In these cases we set the flag RFCOMM_TTY_RELEASED so that no other
function can get a reference to the tty_port.
The use of !test_and_set_bit(RFCOMM_TTY_RELEASED) ensures that the
'initial' tty_port reference is only dropped once.

The rfcomm_dev_del function is removed becase it isn't used anymore.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---

Notes:
    v5: always use !test_and_set_bit() to release the tty_port

 net/bluetooth/rfcomm/tty.c | 46 ++++++++++++----------------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 583f713..3e078b7 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -324,23 +324,6 @@ free:
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
-	tty_port_put(&dev->port);
-}
-
 /* ---- Send buffer ---- */
 static inline unsigned int rfcomm_room(struct rfcomm_dlc *dlc)
 {
@@ -454,8 +437,9 @@ static int rfcomm_release_dev(void __user *arg)
 		tty_kref_put(tty);
 	}
 
-	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
-		rfcomm_dev_del(dev);
+	if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+		tty_port_put(&dev->port);
+
 	tty_port_put(&dev->port);
 	return 0;
 }
@@ -607,6 +591,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 				 *    rfcomm_dev_lock -> dlc lock
 				 * 2. tty_port_put will deadlock if it's
 				 *    the last reference
+				 *
+				 * FIXME: when we release the lock anything
+				 * could happen to dev, even its destruction
 				 */
 				rfcomm_dlc_unlock(dlc);
 				if (rfcomm_dev_get(dev->id) == NULL) {
@@ -614,7 +601,10 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 					return;
 				}
 
-				rfcomm_dev_del(dev);
+				if (!test_and_set_bit(RFCOMM_TTY_RELEASED,
+						      &dev->flags))
+					tty_port_put(&dev->port);
+
 				tty_port_put(&dev->port);
 				rfcomm_dlc_lock(dlc);
 			}
@@ -741,16 +731,10 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
 
-	if (!dev)
-		return;
-
 	BT_DBG("tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
 						dev->port.count);
 
 	tty_port_close(&dev->port, tty, filp);
-
-	if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
-		tty_port_put(&dev->port);
 }
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -1050,17 +1034,11 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	if (!dev)
-		return;
-
 	tty_port_hangup(&dev->port);
 
-	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-		if (rfcomm_dev_get(dev->id) == NULL)
-			return;
-		rfcomm_dev_del(dev);
+	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags) &&
+	    !test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
 		tty_port_put(&dev->port);
-	}
 }
 
 static int rfcomm_tty_tiocmget(struct tty_struct *tty)
-- 
1.8.3.4
