Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with kernel-2.6.5
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040421194424.GA26270@gmx.net>
References: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
	 <1082550752.23959.34.camel@pegasus>  <20040421194424.GA26270@gmx.net>
Content-Type: text/plain
Message-Id: <1082575338.23959.59.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 21 Apr 2004 21:22:18 +0200

Hi Nicholas,

> > give 2.6.6-rc2 a shot, because it includes the outstanding Bluetooth and
> > USB updates. If it still oopses report it on the USB mailing list.
> 
> It should solve his problem, as it it possible too connect the dongle,
> when hci_usb already loaded. Unfortunately it seems to contain a bunch
> of new problems. 
> You can't unplug the dongle or unload the hci_usb module anymore, without 
> crashing the usb subsystem.

there are some outstanding USB patches. Report all problems to the USB
mailing list or try the 2.6.6-rc2-mmX if available.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
