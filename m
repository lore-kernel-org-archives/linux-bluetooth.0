Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci not working with Logitech diNovo
From: Marcel Holtmann <marcel@holtmann.org>
To: Julian Scheel <julian@jusst.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200404010050.30919.julian@jusst.de>
References: <200404010024.48742.julian@jusst.de>
	 <1080772414.2536.15.camel@pegasus>  <200404010050.30919.julian@jusst.de>
Content-Type: text/plain
Message-Id: <1080803843.2610.1.camel@pegasus>
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
Date: Thu, 01 Apr 2004 09:17:23 +0200

Hi Julian,

> > I have seen this error with 2.6, but the switching still works. Check
> > with hciconfig if you got your Bluetooth device.
> 
> thanks for your quick reply, but the device isn't listed with hciconfig, and 
> it doesn't stops working, which I assume should happen after switching this, 
> but before loading the bluetooth hid-drivers, shouldn't it?

testing with the latest 2.6.5-rc3-bk1 it reports success, but after that
my kernel freezes. I have not enough time to dig deep enough into it, so
feel free to provide a patch if you found the problem.

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
