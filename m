Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Oops with 2.6.5-mh3
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040417092404.GA1880@gmx.net>
References: <407C4B88.1010102@thomae-privat.de>
	 <1082161132.4489.33.camel@pegasus>  <20040417092404.GA1880@gmx.net>
Content-Type: text/plain
Message-Id: <1082192480.4489.50.camel@pegasus>
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
Date: Sat, 17 Apr 2004 11:01:20 +0200

Hi Nicholas,

> The problem was already submitted to lkml (i found at least 3reports) 
> and one time declared impossible by Andrew Morton. I can't reproduce
> this error with 2.6.6-rc1 because, the usb dongle ain't even working
> at all. It seems USB is a bit messed up in that release.

for me it looks like that the hci_usb driver hits some bugs in the
current USB subsystem, but Alan Stern is going to fix them all. Please
work with him to fix them. If we need to change something on our side,
he will send me a patch and I'll include it.

> In 2.6.5 there is an easy workaround. If you don't need the hci_usb 
> SCO (CONFIG_BT_HCIUSB_SCO) support, disable it in your kernelconfig. 

Do this also work for 2.6.6-rcX?

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
