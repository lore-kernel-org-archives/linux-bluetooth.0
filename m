Return-Path: <greg@kroah.com>
Date: Wed, 28 Apr 2004 11:18:09 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>, g@kroah.com
Cc: Alan Stern <stern@rowland.harvard.edu>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: PATCH: (as265) Fix bluetooth driver's wait_for_urb()
Message-ID: <20040428181808.GA15218@kroah.com>
References: <Pine.LNX.4.44L0.0404281321520.1238-100000@ida.rowland.org> <20040428174325.GG32040@kroah.com> <1083175733.4000.67.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1083175733.4000.67.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Apr 28, 2004 at 08:08:53PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > I know.  I really hate what the Bluetooth driver does, and it's up to
> > them to keep up with the changes in urbs due to them statically
> > including a urb in their structures.  That is what they agreed to when
> > they did this a while ago.  They are on their own here...
> 
> I know that Max accepted this. So I also have to accept this, but this
> doesn't count for the bfusb driver and inserting this hack prevents it
> from oopsing on a UHCI controller, too.

If you unlink the urb synchronously there should be no more problems, as
Alan has fixed this in the UHCI driver, right?

> > So, Bluetooth developers, have you reconsidered your "need" to put a
> > static urb in your structure?  Are you convinced yet of the wrongness of
> > your ways?  Do you want a patch to change your subsystem to follow the
> > rest of the kernel with regards to USB?
> 
> Right now I don't have enough time to rewrite the hci_usb driver, but it
> is on my todo list. Actually the bulk and isoc URB's should only be
> started when they are needed. This means when an ACL or SCO link is
> really established. However I think we should go back to the discussion
> how we can combine an URB with a SKB in a nice way. This would also be
> helpful for the bfusb driver.

What's wrong with just a pointer to the urb in the skb?

Some of the main reason I want to do this (becides all of the reference
counting stuff) is to see if a separate pool of urbs could increase
throughput any.  If we change the usb core to do this, and there is a
speed increase, then the bluetooth drivers would also see this
improvement.  But by trying to manage the memory yourself, you wouldn't
:)

Good enough bribe?

Hey, I'll even write the patch for the hci_usb driver :)

thanks,

greg k-h
