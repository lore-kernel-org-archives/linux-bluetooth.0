Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] kernel oops when usb dongle plugged in with
	module loaded
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040415232702.GA24097@gmx.net>
References: <20040415232702.GA24097@gmx.net>
Content-Type: text/plain
Message-Id: <1082161230.4489.36.camel@pegasus>
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
Date: Sat, 17 Apr 2004 02:20:30 +0200

Hi Nicholas,

> I face the same problem as Matthias Thomae with an Acer BT600 and
> utils/libs 2.6. I investigated the Oops after reinserting usb dongle
> problem a bit. And  noticed that it Oops only, when hci_usb module had
> been loaded before the dongle was plugged in. So unloading the module
> before plugging in the device and everthing works fine (of course only
> when the module was loaded thereafter automaticalls or manually).
> If you pull out the dongle and then unload the module, you can reinsert
> the BT dongle. If you manually modprobe the module before plugging in
> the device, it Oops too.
> 
> I tested  2.6.4 which doesn't seem to be affected, but 2.6.5 and
> 2.6.5-mh3 show this behaviour.

check the latest 2.6.6-rc or better Bitkeeper snapshot and tell the USB
guys if it still exists.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
