Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] host/usb-uhci.c: iso_find_start: gap in seamless
	isochronous scheduling
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403191230.18309.cijoml@volny.cz>
References: <200403191230.18309.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1079791305.31859.38.camel@pegasus>
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
Date: Sat, 20 Mar 2004 15:01:46 +0100

Hi Michal,

> I find out, that after installing your bthid driver, I gets into syslog 
> everytime my keyboard reconnects to dongle
> 
> host/usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
> 
> Can I somehow prevent this? Don't mean comment it out from kernel source :)

don't compile the hci_usb driver with the SCO support option ;)

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
