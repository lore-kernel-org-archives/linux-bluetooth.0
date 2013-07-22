Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: linux-bluetooth@vger.kernel.org
Cc: peter@hurleysoftware.com,
	gustavo@padovan.org,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v2 6/7] rfcomm: Fix the reference counting of tty_port
Date: Mon, 22 Jul 2013 18:27:14 +0200
Message-Id: <1374510435-12149-6-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
References: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

The tty_port can be released in two cases: when we get a HUP in the fuctions
rfcomm_tty_hangup or rfcomm_dev_state_change. Or when the user releases the
device in rfcomm_release_dev.

In these cases we set the flag RFCOMM_TTY_RELEASED so that no other function can
get a reference to the tty_port.

The rfcomm_dev_del function is removed because it isn't used anymore.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 17e5faa..428543e 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -308,23 +308,6 @@ free:
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
@@ -440,8 +423,9 @@ static int rfcomm_release_dev(void __user *arg)
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
@@ -609,6 +593,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 				 *    rfcomm_dev_lock -> dlc lock
 				 * 2. tty_port_put will deadlock if it's
 				 *    the last reference
+				 *
+				 * FIXME: when we release the lock anything
+				 * could happen to dev, even its destruction
 				 */
 				rfcomm_dlc_unlock(dlc);
 				if (rfcomm_dev_get(dev->id) == NULL) {
@@ -616,7 +603,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 					return;
 				}
 
-				rfcomm_dev_del(dev);
+				set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
+				tty_port_put(&dev->port);
+
 				tty_port_put(&dev->port);
 				rfcomm_dlc_lock(dlc);
 			}
@@ -742,9 +731,6 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 						dev->port.count);
 
 	tty_port_close(&dev->port, tty, filp);
-
-	if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
-		tty_port_put(&dev->port);
 }
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -1047,9 +1033,7 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
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
1.8.3.3
