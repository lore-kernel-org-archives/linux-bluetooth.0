Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20040428174325.GG32040@kroah.com>
References: <Pine.LNX.4.44L0.0404281321520.1238-100000@ida.rowland.org>
	 <20040428174325.GG32040@kroah.com>
Content-Type: text/plain
Message-Id: <1083175733.4000.67.camel@pegasus>
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
Date: Wed, 28 Apr 2004 20:08:53 +0200

Hi Greg,

> I know.  I really hate what the Bluetooth driver does, and it's up to
> them to keep up with the changes in urbs due to them statically
> including a urb in their structures.  That is what they agreed to when
> they did this a while ago.  They are on their own here...

I know that Max accepted this. So I also have to accept this, but this
doesn't count for the bfusb driver and inserting this hack prevents it
from oopsing on a UHCI controller, too.

> So, Bluetooth developers, have you reconsidered your "need" to put a
> static urb in your structure?  Are you convinced yet of the wrongness of
> your ways?  Do you want a patch to change your subsystem to follow the
> rest of the kernel with regards to USB?

Right now I don't have enough time to rewrite the hci_usb driver, but it
is on my todo list. Actually the bulk and isoc URB's should only be
started when they are needed. This means when an ACL or SCO link is
really established. However I think we should go back to the discussion
how we can combine an URB with a SKB in a nice way. This would also be
helpful for the bfusb driver.

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
