Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v4 1/6] rfcomm: Take proper tty_struct references
Date: Fri, 26 Jul 2013 19:18:53 +0200
Message-Id: <1374859138-19467-2-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
References: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

In net/bluetooth/rfcomm/tty.c the struct tty_struct is used without
taking references. This may lead to a use-after-free of the rfcomm tty.

Fix this by taking references properly, using the tty_port_* helpers
when possible.

The raw assignments of dev->port.tty in rfcomm_tty_open/close are
addressed in the later commit 'rfcomm: Implement .activate, .shutdown
and .carrier_raised methods'.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index b6e44ad..cd7ff37 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -333,10 +333,9 @@ static inline unsigned int rfcomm_room(struct rfcomm_dlc *dlc)
 static void rfcomm_wfree(struct sk_buff *skb)
 {
 	struct rfcomm_dev *dev = (void *) skb->sk;
-	struct tty_struct *tty = dev->port.tty;
 	atomic_sub(skb->truesize, &dev->wmem_alloc);
-	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags) && tty)
-		tty_wakeup(tty);
+	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags))
+		tty_port_tty_wakeup(&dev->port);
 	tty_port_put(&dev->port);
 }
 
@@ -410,6 +409,7 @@ static int rfcomm_release_dev(void __user *arg)
 {
 	struct rfcomm_dev_req req;
 	struct rfcomm_dev *dev;
+	struct tty_struct *tty;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
@@ -429,8 +429,11 @@ static int rfcomm_release_dev(void __user *arg)
 		rfcomm_dlc_close(dev->dlc, 0);
 
 	/* Shut down TTY synchronously before freeing rfcomm_dev */
-	if (dev->port.tty)
-		tty_vhangup(dev->port.tty);
+	tty = tty_port_tty_get(&dev->port);
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
 
 	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
 		rfcomm_dev_del(dev);
@@ -563,6 +566,7 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 {
 	struct rfcomm_dev *dev = dlc->owner;
+	struct tty_struct *tty;
 	if (!dev)
 		return;
 
@@ -572,7 +576,8 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	wake_up_interruptible(&dev->wait);
 
 	if (dlc->state == BT_CLOSED) {
-		if (!dev->port.tty) {
+		tty = tty_port_tty_get(&dev->port);
+		if (!tty) {
 			if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
 				/* Drop DLC lock here to avoid deadlock
 				 * 1. rfcomm_dev_get will take rfcomm_dev_lock
@@ -591,8 +596,10 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 				tty_port_put(&dev->port);
 				rfcomm_dlc_lock(dlc);
 			}
-		} else
-			tty_hangup(dev->port.tty);
+		} else {
+			tty_hangup(tty);
+			tty_kref_put(tty);
+		}
 	}
 }
 
@@ -604,10 +611,8 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 
 	BT_DBG("dlc %p dev %p v24_sig 0x%02x", dlc, dev, v24_sig);
 
-	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV)) {
-		if (dev->port.tty && !C_CLOCAL(dev->port.tty))
-			tty_hangup(dev->port.tty);
-	}
+	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV))
+		tty_port_tty_hangup(&dev->port, true);
 
 	dev->modem_status =
 		((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : 0) |
-- 
1.8.3.4
