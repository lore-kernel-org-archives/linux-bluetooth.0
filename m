Return-Path: <oliver@neukum.org>
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: PATCH: (as265) Fix bluetooth driver's wait_for_urb()
Date: Wed, 28 Apr 2004 22:05:45 +0200
Cc: bluez-devel@lists.sourceforge.net, Marcel Holtmann <marcel@holtmann.org>,
   USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0404281433040.678-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0404281433040.678-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200404282205.45073.oliver@neukum.org>
List-ID: <bluez-devel.lists.sourceforge.net>


> However...  Suppose you want to cancel an outstanding URB and then reuse
> that URB for a new request.  Or suppose a driver's disconnect() routine
> has been called and it needs to cancel all outstanding URBs before
> allowing the driver to be unloaded from memory.  In both cases it's
> necessary to wait until _after_ the completion handler has finished -- in
> the first case because you don't want to reuse the URB's data fields while
> the completion handler may still be looking at them, in the second case
> because you don't want the completion handler to try to run when its code
> segment has been unloaded.
>
> The second case is no longer an issue, even for the UHCI driver, because
> it now implements the appropriate endpoint_disable method.  This will
> prevent the majority of possible problems.

Ceterum censeo: Until you've solved all problems, the issue still exists.

> But the first case still applies.  (As does the case of maverick drivers
> like Bluetooth that don't use usb_free_urb().)  So there has to be a way
> for a driver to wait until an URB's completion handler has finished.
> That's the need addressed by usb_wait_for_urb().

Is there anybody using a synchronous unlink who doesn't want that?

> > > At some future time we could consider replacing
> > > synchronous unlink_urb with asynchronous unlink plus wait_for_urb.
> >
> > Why?  Does it cause undue hardship in the host controllers to have a
> > synchronous unlink_urb?
>
> There's two points of confusion here.  First, the host controller drivers
> don't implement synchronous unlinking -- it's all handled higher up in
> core/hcd.c.  As far as the HCDs are concerned everything is asynchronous.

As it should be.

> Second, synchronous unlink_urb doesn't do what is needed because it
> doesn't guarantee that the completion handler will have finished when it
> returns.  It only guarantees that the completion handler will have
> finished if it returns _with no error_.  A race can cause such an error,
> but the driver will still have to wait until the completion handler has
> finished.  That's why usb_wait_for_urb() is needed.

But is very poorly implemented.

	Regards
		Oliver
