Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2008 13:41:22 +0800
From: Dave Young <hidave.darkstar@gmail.com>
To: marcel@holtmann.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net
Subject: [PATCH] bluetooth : rfcomm tty BUG_ON() code fix
Message-ID: <20080107054122.GA4502@darkstar.te-china.tietoenator.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

1) In tty.c the BUG_ON at line 115 will never be called, because the the before list_del_init in this same function.
 115          BUG_ON(!list_empty(&dev->list));
So move the list_del_init to rfcomm_dev_del 

2) The rfcomm_dev_del could be called from diffrent path (rfcomm_tty_hangup/rfcomm_dev_state_change/rfcomm_release_dev),
So add another BUG_ON when the rfcomm_dev_del is called more than one time.

Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 

---
net/bluetooth/rfcomm/tty.c |   22 +++++++++++++---------
1 file changed, 13 insertions(+), 9 deletions(-)

diff -upr linux/net/bluetooth/rfcomm/tty.c linux.new/net/bluetooth/rfcomm/tty.c
--- linux/net/bluetooth/rfcomm/tty.c	2008-01-07 13:20:17.000000000 +0800
+++ linux.new/net/bluetooth/rfcomm/tty.c	2008-01-07 13:25:17.000000000 +0800
@@ -95,9 +95,10 @@ static void rfcomm_dev_destruct(struct r
 
 	BT_DBG("dev %p dlc %p", dev, dlc);
 
-	write_lock_bh(&rfcomm_dev_lock);
-	list_del_init(&dev->list);
-	write_unlock_bh(&rfcomm_dev_lock);
+	/* Refcount should only hit zero when called from rfcomm_dev_del()
+	   which will have taken us off the list. Everything else are
+	   refcounting bugs. */
+	BUG_ON(!list_empty(&dev->list));
 
 	rfcomm_dlc_lock(dlc);
 	/* Detach DLC if it's owned by this dev */
@@ -109,11 +110,6 @@ static void rfcomm_dev_destruct(struct r
 
 	tty_unregister_device(rfcomm_tty_driver, dev->id);
 
-	/* Refcount should only hit zero when called from rfcomm_dev_del()
-	   which will have taken us off the list. Everything else are
-	   refcounting bugs. */
-	BUG_ON(!list_empty(&dev->list));
-
 	kfree(dev);
 
 	/* It's safe to call module_put() here because socket still
@@ -313,7 +309,15 @@ static void rfcomm_dev_del(struct rfcomm
 {
 	BT_DBG("dev %p", dev);
 
-	set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
+	if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+		BUG_ON(1);
+	else
+		set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
+
+	write_lock_bh(&rfcomm_dev_lock);
+	list_del_init(&dev->list);
+	write_unlock_bh(&rfcomm_dev_lock);
+
 	rfcomm_dev_put(dev);
 }
 
