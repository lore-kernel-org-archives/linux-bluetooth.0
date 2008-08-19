Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Tue, 19 Aug 2008 09:03:05 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808182326.48365.oliver@neukum.org> <1219118754.7591.70.camel@violet.holtmann.net>
In-Reply-To: <1219118754.7591.70.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808190903.05919.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag 19 August 2008 06:05:54 schrieb Marcel Holtmann:
> However when using the unlink version, this gives me spinlock lockup
> (with and without your IRQ disable patch). From the backtrace it seems
> that usb_unanchor_urb is calling spinlock_irq_save here.

This patch should fix it.

	Regards
		Oliver

----

--- linux-2.6.27-rc3/drivers/usb/core/urb.c.alt2	2008-08-18 16:24:41.000000000 +0200
+++ linux-2.6.27-rc3/drivers/usb/core/urb.c	2008-08-19 08:12:27.000000000 +0200
@@ -607,8 +607,12 @@ void usb_unlink_anchored_urbs(struct usb
 	while (!list_empty(&anchor->urb_list)) {
 		victim = list_entry(anchor->urb_list.prev, struct urb,
 				    anchor_list);
+		usb_get_urb(victim);
+		spin_unlock_irqrestore(&anchor->lock, flags);
 		/* this will unanchor the URB */
 		usb_unlink_urb(victim);
+		usb_put_urb(victim);
+		spin_lock_irqsave(&anchor->lock, flags);
 	}
 	spin_unlock_irqrestore(&anchor->lock, flags);
 }
