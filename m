Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: g@kroah.com, Alan Stern <stern@rowland.harvard.edu>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20040428181808.GA15218@kroah.com>
References: <Pine.LNX.4.44L0.0404281321520.1238-100000@ida.rowland.org>
	 <20040428174325.GG32040@kroah.com> <1083175733.4000.67.camel@pegasus>
	 <20040428181808.GA15218@kroah.com>
Content-Type: text/plain
Message-Id: <1083189940.4000.78.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: PATCH: (as265) Fix bluetooth driver's wait_for_urb()
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 29 Apr 2004 00:05:40 +0200

Hi Greg,

> > I know that Max accepted this. So I also have to accept this, but this
> > doesn't count for the bfusb driver and inserting this hack prevents it
> > from oopsing on a UHCI controller, too.
> 
> If you unlink the urb synchronously there should be no more problems, as
> Alan has fixed this in the UHCI driver, right?

last time I checked Alan's disable_endpoint patch it still crashes both
drivers and as you see the bfusb uses usb_free_urb().

> > Right now I don't have enough time to rewrite the hci_usb driver, but it
> > is on my todo list. Actually the bulk and isoc URB's should only be
> > started when they are needed. This means when an ACL or SCO link is
> > really established. However I think we should go back to the discussion
> > how we can combine an URB with a SKB in a nice way. This would also be
> > helpful for the bfusb driver.
> 
> What's wrong with just a pointer to the urb in the skb?

>>From my point the URB should be central point in an USB driver. The SKB
is only used as data buffer and if we use a SKB in the first place we
don't have to copy the data twice to send it to the HCI layer. I really
like to point to the SKB inside the URB, because otherwise I am still
playing tricks to combine these two data types.

> Some of the main reason I want to do this (becides all of the reference
> counting stuff) is to see if a separate pool of urbs could increase
> throughput any.  If we change the usb core to do this, and there is a
> speed increase, then the bluetooth drivers would also see this
> improvement.  But by trying to manage the memory yourself, you wouldn't
> :)
> 
> Good enough bribe?

I always got your point over a year ago, but the world is not perfect
and the lack of time keeps me from writing a new hci_usb driver from
scratch so it will working nicely with dynamic creation for the URB's
for the Bluetooth data and audio links links.

> Hey, I'll even write the patch for the hci_usb driver :)

I am glad to test every patch you send me, but it may take some days. I
still have another patch from Alan that is in my queue and he expects an
answer.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
