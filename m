Return-Path: <stern@rowland.harvard.edu>
Date: Wed, 28 Apr 2004 15:13:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <greg@kroah.com>
cc: bluez-devel@lists.sourceforge.net, Marcel Holtmann <marcel@holtmann.org>,
   USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: PATCH: (as265) Fix bluetooth driver's wait_for_urb()
In-Reply-To: <20040428174325.GG32040@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0404281433040.678-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 28 Apr 2004, Greg KH wrote:

> On Wed, Apr 28, 2004 at 01:25:08PM -0400, Alan Stern wrote:
> > Greg:
> > 
> > Your recent change to struct urb broke this function in the bluetooth 
> > driver.
> 
> I know.  I really hate what the Bluetooth driver does, and it's up to
> them to keep up with the changes in urbs due to them statically
> including a urb in their structures.  That is what they agreed to when
> they did this a while ago.  They are on their own here...

I have to agree that life would be easier all 'round if the bluetooth code 
was changed to use dynamically-allocated URBs.

> > You know, I think usb_wait_for_urb() would make an excellent 
> > addition to usbcore.
> 
> No, no one should do that.  Just use the proper usb_alloc_urb() and
> usb_free_urb() and you will be fine.

There's more to it than that.  Yes, if all you're worried about is freeing 
an URB then usb_alloc_urb() and usb_free_urb() will take care of 
everything -- you don't even need to use synchronous unlinks.

However...  Suppose you want to cancel an outstanding URB and then reuse 
that URB for a new request.  Or suppose a driver's disconnect() routine 
has been called and it needs to cancel all outstanding URBs before 
allowing the driver to be unloaded from memory.  In both cases it's 
necessary to wait until _after_ the completion handler has finished -- in 
the first case because you don't want to reuse the URB's data fields while 
the completion handler may still be looking at them, in the second case 
because you don't want the completion handler to try to run when its code 
segment has been unloaded.

The second case is no longer an issue, even for the UHCI driver, because
it now implements the appropriate endpoint_disable method.  This will
prevent the majority of possible problems.

But the first case still applies.  (As does the case of maverick drivers
like Bluetooth that don't use usb_free_urb().)  So there has to be a way
for a driver to wait until an URB's completion handler has finished.  
That's the need addressed by usb_wait_for_urb().

> > At some future time we could consider replacing 
> > synchronous unlink_urb with asynchronous unlink plus wait_for_urb.
> 
> Why?  Does it cause undue hardship in the host controllers to have a
> synchronous unlink_urb?

There's two points of confusion here.  First, the host controller drivers
don't implement synchronous unlinking -- it's all handled higher up in
core/hcd.c.  As far as the HCDs are concerned everything is asynchronous.

Second, synchronous unlink_urb doesn't do what is needed because it 
doesn't guarantee that the completion handler will have finished when it 
returns.  It only guarantees that the completion handler will have 
finished if it returns _with no error_.  A race can cause such an error, 
but the driver will still have to wait until the completion handler has 
finished.  That's why usb_wait_for_urb() is needed.

Alan Stern
