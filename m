Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] 2.6.5 problems turned to 2.6.3 but also problems
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200404121621.56191.wim.delvaux@adaptiveplanet.com>
References: <200404120349.34338.wim.delvaux@adaptiveplanet.com>
	 <200404121317.52361.wim.delvaux@adaptiveplanet.com>
	 <1081776828.5398.109.camel@pegasus>
	 <200404121621.56191.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1081781733.5398.137.camel@pegasus>
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
Date: Mon, 12 Apr 2004 16:55:33 +0200

Hi Wim,

> > where do you get them? In the hci_usb driver or in the USB subsystem?
> 
> 	it scrolls by so fast that It is hardly visible on the console.
> 	However I can detect that the call stack is only 3 entries deep

try to use the netconsole support in 2.6.5.

> > Know problem. Some broken device which needs a longer timeout value.
> 
> 	The device at hand is the Acer BT500 BT Dongle  Where can I set that
> 	timeout ?

Look at the USB mailing list archive. I don't remember where it was, but
the Acer BT500 is one of these buggy dongles.

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
