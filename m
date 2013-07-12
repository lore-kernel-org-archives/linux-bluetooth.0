Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org,
	peter@hurleysoftware.com,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH 5/8] Use the tty_port_* functions in tty_open/tty_close/tty_hangup
Date: Fri, 12 Jul 2013 22:40:45 +0200
Message-Id: <1373661649-1385-5-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the tty_port_open tty_port_close and tty_port_hangup functions that manage
properly the port.count and the tty_port operations.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index c1dd55d..c8ef06d 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -766,47 +766,23 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct rfcomm_dev *dev = tty->driver_data;
-	unsigned long flags;
-	int id;
-
-	id = tty->index;
 
-	BT_DBG("tty %p id %d", tty, id);
+	BT_DBG("tty %p id %d", tty, tty->index);
 
 	BT_DBG("dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
 	       dev->channel, dev->port.count);
 
-	spin_lock_irqsave(&dev->port.lock, flags);
-	if (++dev->port.count > 1) {
-		spin_unlock_irqrestore(&dev->port.lock, flags);
-		return 0;
-	}
-	spin_unlock_irqrestore(&dev->port.lock, flags);
-
-	return 0;
+	return tty_port_open(&dev->port, tty, filp);
 }
 
 static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	unsigned long flags;
 
 	BT_DBG("tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
 						dev->port.count);
 
-	spin_lock_irqsave(&dev->port.lock, flags);
-	if (!--dev->port.count) {
-		spin_unlock_irqrestore(&dev->port.lock, flags);
-
-		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
-			spin_lock(&rfcomm_dev_lock);
-			list_del_init(&dev->list);
-			spin_unlock(&rfcomm_dev_lock);
-
-			tty_port_put(&dev->port);
-		}
-	} else
-		spin_unlock_irqrestore(&dev->port.lock, flags);
+	tty_port_close(&dev->port, tty, filp);
 }
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -1106,11 +1082,10 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	if (!dev)
-		return;
-
 	rfcomm_tty_flush_buffer(tty);
 
+	tty_port_hangup(&dev->port);
+
 	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
 		if (rfcomm_dev_get(dev->id) == NULL)
 			return;
-- 
1.8.3.2
