Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Marcel Holtmann <marcel@holtmann.org>
To: Ian Kumlien <pomac@vapor.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095880805.3277.4.camel@big>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
	 <1095877600.3211.15.camel@big>  <1095877744.6223.88.camel@pegasus>
	 <1095877955.3211.18.camel@big>  <1095878303.6223.93.camel@pegasus>
	 <1095878969.3211.23.camel@big>  <1095879167.6223.104.camel@pegasus>
	 <1095880805.3277.4.camel@big>
Content-Type: text/plain
Message-Id: <1095881187.6223.108.camel@pegasus>
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
Date: Wed, 22 Sep 2004 21:26:27 +0200

Hi Ian,

> > > 2 joysticks, one 6in1 card reader and one muvodrive, it all works.
> > > And, it registers the device correctly it just can't read from it.
> > 
> > are these devices all USB 2.0 capable? If yes, then they are handled by
> > the ehci_hcd host controller driver.
> 
> All except the monitor that also registers it self via usb, =)
> (I am really surprised about that actually)
> 
> Sam Sung Electronics
> Manufacturer: Samsung Electronics
> Serial Number: HVAWA04398
> Speed: 1.5Mb/s (low)
> USB Version:  1.10
> Device Class: 00(>ifc )
> Device Subclass: 00
> Device Protocol: 00
> Maximum Default Endpoint Size: 8
> Number of Configurations: 1
> Vendor Id: 0419
> Product Id: 8002
> Revision Number:  2.00
> 
> And here is the usb dongle output
> hci_usb
> Speed: 12Mb/s (full)
> USB Version:  1.10
> Device Class: e0(unk. ) <== Looks like something missing
> Device Subclass: 01
> Device Protocol: 01
> Maximum Default Endpoint Size: 64
> Number of Configurations: 1
> Vendor Id: 0db0
> Product Id: 1967
> Revision Number:  5.25
> 
> Should i change some identifier and test some?

here is nothing really important missing, because 0xe0 means wireless
class or so.

This looks really like an ohci_hcd problem with interrupt URBs.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
