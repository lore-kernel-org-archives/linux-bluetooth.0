Return-Path: <vitervo@nokia.com>
Date: Mon, 4 Jun 2007 13:32:56 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Patch] Keep rfcomm device in list until it's freed
Message-ID: <20070604103256.GH6310@null.research.nokia.com>
References: <20070601111156.GB6310@null.research.nokia.com> <1180711261.6726.6.camel@aeonflux.holtmann.net> <20070604083531.GF6310@null.research.nokia.com> <1180946944.13429.21.camel@violet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hcut4fGOf7Kh6EdG"
In-Reply-To: <1180946944.13429.21.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2007 at 10:49:04AM +0200, ext Marcel Holtmann wrote:
> Hi Ville,
> 
> > > > Here is patch for rfcomm to keep rfcomm device in list until it's really
> > > > unused.
> > > 
> > >         dev = __rfcomm_dev_get(id);
> > > +
> > > +       if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
> > > +               dev = NULL;
> > > +
> > >         if (dev)
> > >                 rfcomm_dev_hold(dev);
> > > 
> > > a test_bit() and then return NULL at the beginning makes more sense. No
> > > need to take the lock since test_bit() is atomic anyway.
> > 
> > How do I get flags then? Function only gets device id.
> 
> good point. I overlooked that part.
> 
> > I noticed another bug. If __rfcomm_dev_get returns null we end up using
> > NULL pointer. Fixed version attached.
> 
> Please remove this part:
> 
> -#ifndef CONFIG_BT_RFCOMM_DEBUG
> +#ifdef CONFIG_BT_RFCOMM_DEBUG

Removed.

> 
> And use this code:
> 
> 	if (dev) {
> 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
> 			dev = NULL;
> 		else
> 	                rfcomm_dev_hold(dev);
> 	}
> 
> It makes it a little bit more readable and easier to understand what we
> are doing there.

Agreed. New version attached.

-- 
Ville

--hcut4fGOf7Kh6EdG
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="20070604-0001-Bluetooth-Keep-rfcomm_dev-in-list-until-it-is-free.patch"

>From ec26804b4233376633061bc462f0c3a77b4d0780 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Mon, 4 Jun 2007 13:25:09 +0300
Subject: [PATCH 1/1] [Bluetooth] Keep rfcomm_dev in list until it is freed

This patch changes rfcomm tty release process so that tty is kept in list until
it is really freed. New device flag is introdused to keep track of released
ttys.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/rfcomm.h |    1 +
 net/bluetooth/rfcomm/tty.c     |   30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

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
index b2b1cce..12a84b5 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -95,6 +95,10 @@ static void rfcomm_dev_destruct(struct rfcomm_dev *dev)
 
 	BT_DBG("dev %p dlc %p", dev, dlc);
 
+	write_lock_bh(&rfcomm_dev_lock);
+	list_del_init(&dev->list);
+	write_unlock_bh(&rfcomm_dev_lock);
+
 	rfcomm_dlc_lock(dlc);
 	/* Detach DLC if it's owned by this dev */
 	if (dlc->owner == dev)
@@ -156,8 +160,13 @@ static inline struct rfcomm_dev *rfcomm_dev_get(int id)
 	read_lock(&rfcomm_dev_lock);
 
 	dev = __rfcomm_dev_get(id);
-	if (dev)
-		rfcomm_dev_hold(dev);
+
+	if (dev) {
+		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+			dev = NULL;
+		else
+			rfcomm_dev_hold(dev);
+	}
 
 	read_unlock(&rfcomm_dev_lock);
 
@@ -265,6 +274,12 @@ out:
 
 	dev->tty_dev = tty_register_device(rfcomm_tty_driver, dev->id, NULL);
 
+	if (IS_ERR(dev->tty_dev)) {
+		list_del(&dev->list);
+		kfree(dev);
+		return PTR_ERR(dev->tty_dev);
+	}
+
 	return dev->id;
 }
 
@@ -272,10 +287,7 @@ static void rfcomm_dev_del(struct rfcomm_dev *dev)
 {
 	BT_DBG("dev %p", dev);
 
-	write_lock_bh(&rfcomm_dev_lock);
-	list_del_init(&dev->list);
-	write_unlock_bh(&rfcomm_dev_lock);
-
+	set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
 	rfcomm_dev_put(dev);
 }
 
@@ -329,7 +341,7 @@ static int rfcomm_create_dev(struct sock *sk, void __user *arg)
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	BT_DBG("sk %p dev_id %id flags 0x%x", sk, req.dev_id, req.flags);
+	BT_DBG("sk %p dev_id %d flags 0x%x", sk, req.dev_id, req.flags);
 
 	if (req.flags != NOCAP_FLAGS && !capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -370,7 +382,7 @@ static int rfcomm_release_dev(void __user *arg)
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	BT_DBG("dev_id %id flags 0x%x", req.dev_id, req.flags);
+	BT_DBG("dev_id %d flags 0x%x", req.dev_id, req.flags);
 
 	if (!(dev = rfcomm_dev_get(req.dev_id)))
 		return -ENODEV;
@@ -415,6 +427,8 @@ static int rfcomm_get_dev_list(void __user *arg)
 
 	list_for_each(p, &rfcomm_dev_list) {
 		struct rfcomm_dev *dev = list_entry(p, struct rfcomm_dev, list);
+		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+			continue;
 		(di + n)->id      = dev->id;
 		(di + n)->flags   = dev->flags;
 		(di + n)->state   = dev->dlc->state;
-- 
1.5.1.1


--hcut4fGOf7Kh6EdG--
