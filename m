Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808181627.27053.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <200808181552.52655.oliver@neukum.org>
	 <1219068620.7591.52.camel@violet.holtmann.net>
	 <200808181627.27053.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 18 Aug 2008 16:36:22 +0200
Message-Id: <1219070182.7591.56.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > > On the other hand, this is audio and I don't really care if we loose a
> > > > packet or not.
> > > 
> > > It isn't limited to sound. The URBs for acl reception can also be delayed
> > > arbitrarily long.
> > 
> > We can move that into the notify() callback, but the killing the URBs
> > becomes a problem.
> 
> /**
>  * usb_unlink_anchored_urbs - asynchronously cancel transfer requests en masse
>  * @anchor: anchor the requests are bound to
>  *
>  * this allows all outstanding URBs to be unlinked starting
>  * from the back of the queue. This function is asynchronous.
>  * The unlinking is just tiggered. It may happen after this
>  * function has returned.
>  */
> void usb_unlink_anchored_urbs(struct usb_anchor *anchor)

then we can move the ACL handling into the notify() callback.

For the SCO ones, I don't see any chance since we have to do the
altsetting first.

Regards

Marcel


