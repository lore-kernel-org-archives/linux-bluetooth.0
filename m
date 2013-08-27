Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH] rfcomm: don't release the port in rfcomm_dev_state_change()
Date: Tue, 27 Aug 2013 18:28:46 +0200
Message-Id: <1377620926-23370-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

When the dlc is closed, rfcomm_dev_state_change() tries to release the
port in the case it cannot get a reference to the tty. However this is
racy and not even needed.

Infact as Peter Hurley points out:

1. Only consider dlcs that are 'stolen' from a connected socket, ie.
   reused. Allocated dlcs cannot have been closed prior to port
   activate and so for these dlcs a tty reference will always be avail
   in rfcomm_dev_state_change() -- except for the conditions covered by
   #2b below.
2. If a tty was at some point previously created for this rfcomm, then
   either
   (a) the tty reference is still avail, so rfcomm_dev_state_change()
       will perform a hangup. So nothing to do, or,
   (b) the tty reference is no longer avail, and the tty_port will be
       destroyed by the last tty_port_put() in rfcomm_tty_cleanup.
       Again, no action required.
3. Prior to obtaining the dlc lock in rfcomm_dev_add(),
   rfcomm_dev_state_change() will not 'see' a rfcomm_dev so nothing to
   do here.
4. After releasing the dlc lock in rfcomm_dev_add(),
   rfcomm_dev_state_change() will 'see' an incomplete rfcomm_dev if a
   tty reference could not be obtained. Again, the best thing to do here
   is nothing. Any future attempted open() will block on
   rfcomm_dev_carrier_raised(). The unconnected device will exist until
   released by ioctl(RFCOMMRELEASEDEV).

The patch removes the aforementioned code and uses the
tty_port_tty_hangup() helper to hangup the tty.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 6d126fa..84fcf9f 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -569,7 +569,6 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 {
 	struct rfcomm_dev *dev = dlc->owner;
-	struct tty_struct *tty;
 	if (!dev)
 		return;
 
@@ -581,38 +580,8 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 			    DPM_ORDER_DEV_AFTER_PARENT);
 
 		wake_up_interruptible(&dev->port.open_wait);
-	} else if (dlc->state == BT_CLOSED) {
-		tty = tty_port_tty_get(&dev->port);
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
-				if (!test_and_set_bit(RFCOMM_TTY_RELEASED,
-						      &dev->flags))
-					tty_port_put(&dev->port);
-
-				tty_port_put(&dev->port);
-				rfcomm_dlc_lock(dlc);
-			}
-		} else {
-			tty_hangup(tty);
-			tty_kref_put(tty);
-		}
-	}
+	} else if (dlc->state == BT_CLOSED)
+		tty_port_tty_hangup(&dev->port, false);
 }
 
 static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
-- 
1.8.4
