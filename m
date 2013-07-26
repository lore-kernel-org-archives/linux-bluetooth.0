Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v4 2/6] rfcomm: Remove the device from the list in the destructor
Date: Fri, 26 Jul 2013 19:18:54 +0200
Message-Id: <1374859138-19467-3-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
References: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

The current code removes the device from the device list in several
places. Do it only in the destructor instead and in the error path of
rfcomm_add_dev() if the device couldn't be initialized.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index cd7ff37..9c0e142 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -76,13 +76,6 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
 
 /* ---- Device functions ---- */
 
-/*
- * The reason this isn't actually a race, as you no doubt have a little voice
- * screaming at you in your head, is that the refcount should never actually
- * reach zero unless the device has already been taken off the list, in
- * rfcomm_dev_del(). And if that's not true, we'll hit the BUG() in
- * rfcomm_dev_destruct() anyway.
- */
 static void rfcomm_dev_destruct(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
@@ -90,10 +83,9 @@ static void rfcomm_dev_destruct(struct tty_port *port)
 
 	BT_DBG("dev %p dlc %p", dev, dlc);
 
-	/* Refcount should only hit zero when called from rfcomm_dev_del()
-	   which will have taken us off the list. Everything else are
-	   refcounting bugs. */
-	BUG_ON(!list_empty(&dev->list));
+	spin_lock(&rfcomm_dev_lock);
+	list_del(&dev->list);
+	spin_unlock(&rfcomm_dev_lock);
 
 	rfcomm_dlc_lock(dlc);
 	/* Detach DLC if it's owned by this dev */
@@ -282,7 +274,9 @@ out:
 			dev->id, NULL);
 	if (IS_ERR(dev->tty_dev)) {
 		err = PTR_ERR(dev->tty_dev);
+		spin_lock(&rfcomm_dev_lock);
 		list_del(&dev->list);
+		spin_unlock(&rfcomm_dev_lock);
 		goto free;
 	}
 
@@ -315,10 +309,6 @@ static void rfcomm_dev_del(struct rfcomm_dev *dev)
 	}
 	spin_unlock_irqrestore(&dev->port.lock, flags);
 
-	spin_lock(&rfcomm_dev_lock);
-	list_del_init(&dev->list);
-	spin_unlock(&rfcomm_dev_lock);
-
 	tty_port_put(&dev->port);
 }
 
@@ -750,13 +740,8 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 		dev->port.tty = NULL;
 		rfcomm_dlc_unlock(dev->dlc);
 
-		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
-			spin_lock(&rfcomm_dev_lock);
-			list_del_init(&dev->list);
-			spin_unlock(&rfcomm_dev_lock);
-
+		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
 			tty_port_put(&dev->port);
-		}
 	} else
 		spin_unlock_irqrestore(&dev->port.lock, flags);
 
-- 
1.8.3.4
