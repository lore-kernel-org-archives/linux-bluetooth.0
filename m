Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with hci_usb
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1078252920.15993.117.camel@localhost>
References: <1078247120.9057.85.camel@localhost>
	 <1078248609.1942.183.camel@pegasus>  <1078252920.15993.117.camel@localhost>
Content-Type: text/plain
Message-Id: <1078256552.1942.194.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 02 Mar 2004 20:42:32 +0100

Hi Nils,

> > Currently there is no real fix for it and once we have one, I have no
> > plans to backport it to 2.4.
> 
> Why that?
> 2.4 is still the stable kernel and used by many users, so I think it
> would be worth the effort.

the current stable kernel is 2.6 and it seems that 2.4 will be closed
with 2.4.27.

> Would you accept a patch given that someone else does the backport?

For this feature you need first to backport the voice setting patch from
2.6 and you have to add the notify framework patch. Both are HCI core
changes and I think these are 2.6 changes only, but if anyone builds a
clean set of patches for 2.4 we can talk again.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
