Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org,
	peter@hurleysoftware.com,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH 4/8] Move tty initialization and cleanup out of open/close
Date: Fri, 12 Jul 2013 22:40:44 +0200
Message-Id: <1373661649-1385-4-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Move the tty initialization from rfcomm_tty_open to rfcomm_tty_install and do
the same for the cleanup moving the code from rfcomm_tty_close to
rfcomm_tty_cleanup.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 82 +++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 9b0b064..c1dd55d 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -717,10 +717,55 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 }
 
 /* ---- TTY functions ---- */
+/*
+ * here we acquire the tty_port reference since it's here the tty is first used
+ * by setting the termios. We also populate the driver_data field and install
+ * the tty_port.
+ */
+static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+        struct rfcomm_dev *dev;
+        int err;
+
+        dev = rfcomm_dev_get(tty->index);
+        if (!dev)
+	        return -ENODEV;
+
+        /* Attach TTY */
+        rfcomm_dlc_lock(dev->dlc);
+        tty->driver_data = dev;
+        rfcomm_dlc_unlock(dev->dlc);
+        set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+
+        err = tty_port_install(&dev->port, driver, tty);
+        if (err < 0) {
+                clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+                tty_port_put(&dev->port);
+        }
+
+        return err;
+}
+
+/*
+ * here we do the reverse, by clearing the tty fields and releasing
+ * the reference to tty_port.
+ */
+static void rfcomm_tty_cleanup(struct tty_struct *tty)
+{
+	struct rfcomm_dev *dev = tty->driver_data;
+
+        /* Remove driver data */
+        clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
+        rfcomm_dlc_lock(dev->dlc);
+        tty->driver_data = NULL;
+        rfcomm_dlc_unlock(dev->dlc);
+
+        tty_port_put(&dev->port);
+}
+
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
-	struct rfcomm_dev *dev;
-	struct rfcomm_dlc *dlc;
+	struct rfcomm_dev *dev = tty->driver_data;
 	unsigned long flags;
 	int id;
 
@@ -728,14 +773,6 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 
 	BT_DBG("tty %p id %d", tty, id);
 
-	/* We don't leak this refcount. For reasons which are not entirely
-	   clear, the TTY layer will call our ->close() method even if the
-	   open fails. We decrease the refcount there, and decreasing it
-	   here too would cause breakage. */
-	dev = rfcomm_dev_get(id);
-	if (!dev)
-		return -ENODEV;
-
 	BT_DBG("dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
 	       dev->channel, dev->port.count);
 
@@ -746,16 +783,6 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 	}
 	spin_unlock_irqrestore(&dev->port.lock, flags);
 
-	dlc = dev->dlc;
-
-	/* Attach TTY and open DLC */
-
-	rfcomm_dlc_lock(dlc);
-	tty->driver_data = dev;
-	tty_port_tty_set(&dev->port, tty);
-	rfcomm_dlc_unlock(dlc);
-	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
-
 	return 0;
 }
 
@@ -764,9 +791,6 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
 	unsigned long flags;
 
-	if (!dev)
-		return;
-
 	BT_DBG("tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
 						dev->port.count);
 
@@ -774,14 +798,6 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 	if (!--dev->port.count) {
 		spin_unlock_irqrestore(&dev->port.lock, flags);
 
-		/* detach the TTY */
-		clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
-
-		rfcomm_dlc_lock(dev->dlc);
-		tty->driver_data = NULL;
-		tty_port_tty_set(&dev->port, NULL);
-		rfcomm_dlc_unlock(dev->dlc);
-
 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
 			spin_lock(&rfcomm_dev_lock);
 			list_del_init(&dev->list);
@@ -791,8 +807,6 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 		}
 	} else
 		spin_unlock_irqrestore(&dev->port.lock, flags);
-
-	tty_port_put(&dev->port);
 }
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -1165,6 +1179,8 @@ static const struct tty_operations rfcomm_ops = {
 	.wait_until_sent	= rfcomm_tty_wait_until_sent,
 	.tiocmget		= rfcomm_tty_tiocmget,
 	.tiocmset		= rfcomm_tty_tiocmset,
+	.install                = rfcomm_tty_install,
+	.cleanup                = rfcomm_tty_cleanup,
 };
 
 int __init rfcomm_init_ttys(void)
-- 
1.8.3.2
