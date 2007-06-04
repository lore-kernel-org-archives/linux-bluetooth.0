Return-Path: <vitervo@nokia.com>
Date: Mon, 4 Jun 2007 11:35:31 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Patch] Keep rfcomm device in list until it's freed
Message-ID: <20070604083531.GF6310@null.research.nokia.com>
References: <20070601111156.GB6310@null.research.nokia.com> <1180711261.6726.6.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OROCMA9jn6tkzFBc"
In-Reply-To: <1180711261.6726.6.camel@aeonflux.holtmann.net>
List-ID: <bluez-devel.lists.sourceforge.net>


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

> > Here is patch for rfcomm to keep rfcomm device in list until it's really
> > unused.
> 
>         dev = __rfcomm_dev_get(id);
> +
> +       if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
> +               dev = NULL;
> +
>         if (dev)
>                 rfcomm_dev_hold(dev);
> 
> a test_bit() and then return NULL at the beginning makes more sense. No
> need to take the lock since test_bit() is atomic anyway.

How do I get flags then? Function only gets device id.

I noticed another bug. If __rfcomm_dev_get returns null we end up using
NULL pointer. Fixed version attached.

-- 
Ville

--OROCMA9jn6tkzFBc
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="20070604-0001-Bluetooth-Keep-rfcomm_dev-in-list-until-it-is-free.patch"

>From 2a97626c89dea1e9850e002320b4e3624a544cef Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Mon, 4 Jun 2007 11:30:56 +0300
Subject: [PATCH 1/1] [Bluetooth] Keep rfcomm_dev in list until it is freed

This patch changes rfcomm tty release process so that tty is kept in list until
it is really freed. New device flag is introdused to keep track of released
ttys.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/rfcomm.h |    1 +
 net/bluetooth/rfcomm/tty.c     |   27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 3c563f0..25aa575 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -323,6 +323,7 @@ int  rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc
 #define RFCOMM_RELEASE_ONHUP  1
 #define RFCOMM_HANGUP_NOW     2
 #define RFCOMM_TTY_ATTACHED   3
+#define RFCOMM_TTY_RELEASED   4
 
 struct rfcomm_dev_req {
 	s16      dev_id;
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index b2b1cce..b663452 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -41,7 +41,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/rfcomm.h>
 
-#ifndef CONFIG_BT_RFCOMM_DEBUG
+#ifdef CONFIG_BT_RFCOMM_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
@@ -95,6 +95,10 @@ static void rfcomm_dev_destruct(struct rfcomm_dev *dev)
 
 	BT_DBG("dev %p dlc %p", dev, dlc);
 
+	write_lock_bh(&rfcomm_dev_lock);
+	list_del_init(&dev->list);
+	write_unlock_bh(&rfcomm_dev_lock);
+
 	rfcomm_dlc_lock(dlc);
 	/* Detach DLC if it's owned by this dev */
 	if (dlc->owner == dev)
@@ -156,6 +160,10 @@ static inline struct rfcomm_dev *rfcomm_dev_get(int id)
 	read_lock(&rfcomm_dev_lock);
 
 	dev = __rfcomm_dev_get(id);
+
+	if (dev && test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+		dev = NULL;
+
 	if (dev)
 		rfcomm_dev_hold(dev);
 
@@ -265,6 +273,12 @@ out:
 
 	dev->tty_dev = tty_register_device(rfcomm_tty_driver, dev->id, NULL);
 
+	if (IS_ERR(dev->tty_dev)) {
+		list_del(&dev->list);
+		kfree(dev);
+		return PTR_ERR(dev->tty_dev);
+	}
+
 	return dev->id;
 }
 
@@ -272,10 +286,7 @@ static void rfcomm_dev_del(struct rfcomm_dev *dev)
 {
 	BT_DBG("dev %p", dev);
 
-	write_lock_bh(&rfcomm_dev_lock);
-	list_del_init(&dev->list);
-	write_unlock_bh(&rfcomm_dev_lock);
-
+	set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
 	rfcomm_dev_put(dev);
 }
 
@@ -329,7 +340,7 @@ static int rfcomm_create_dev(struct sock *sk, void __user *arg)
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	BT_DBG("sk %p dev_id %id flags 0x%x", sk, req.dev_id, req.flags);
+	BT_DBG("sk %p dev_id %d flags 0x%x", sk, req.dev_id, req.flags);
 
 	if (req.flags != NOCAP_FLAGS && !capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -370,7 +381,7 @@ static int rfcomm_release_dev(void __user *arg)
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	BT_DBG("dev_id %id flags 0x%x", req.dev_id, req.flags);
+	BT_DBG("dev_id %d flags 0x%x", req.dev_id, req.flags);
 
 	if (!(dev = rfcomm_dev_get(req.dev_id)))
 		return -ENODEV;
@@ -415,6 +426,8 @@ static int rfcomm_get_dev_list(void __user *arg)
 
 	list_for_each(p, &rfcomm_dev_list) {
 		struct rfcomm_dev *dev = list_entry(p, struct rfcomm_dev, list);
+		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+			continue;
 		(di + n)->id      = dev->id;
 		(di + n)->flags   = dev->flags;
 		(di + n)->state   = dev->dlc->state;
-- 
1.5.1.1


--OROCMA9jn6tkzFBc--
