Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <020801c4f8b0$b9cb2f90$6f04a8c0@ZBOX>
From: "Suriyan" <suriyan@netgadgets.co.th>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=windows-874
Subject: [Bluez-devel] Re: Re: Re: Re: multi rfcomm/sco connection
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 Jan 2005 21:12:18 +0700

Hi Lars,

> I looked into this problem back "than", but due to a shortage of time I
> never had a chance to really fix this (Marcel stated that the best thing
> would be a complete rewrite of hci_usb anyway).

I have try to make change in hci_usb.c first.

> There should be plenty of discussion in the mailing list archive about
> how to fix the stuff and how it might be done (main problem was the
> interrupt context in the notify function and the not-send urbs (queue
> must be empty before setting the new alternate setting...)

By added debug code for checking interrupt context on serveral functions
in hci_usb.c, I cannot found any functions that in not in_interrupt
context except in hci_usb_probe().

Then I added ioctl() in hci_usb.c and call it from sco_connect() [sco.c]
that not in_interrupt context, it does dynamically change alternate setting
vary by sco_num but it's work only for outgoing connection. However this
solution is not recommended by Marcel previously that I used to proposed.

> would be great if you could fix it, as I don't think I'll have time for
> this in the next... months... :(

If you have better solution to fix it please let me known before. 

Thanks.

Regards,
Suriyan.




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
