Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetty.c: usb_bluetooth_probe - improper number
	of endpoints.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200505131808.01414.ifuente@salleurl.edu>
References: <200505131808.01414.ifuente@salleurl.edu>
Content-Type: text/plain
Message-Id: <1116015676.18499.145.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 May 2005 22:21:15 +0200

Hi Inaki,

> That's what I obtain when I connect an USB bluetooth:
> 
> 	drivers/usb/class/bluetty.c: USB Bluetooth converter detected
> 	drivers/usb/class/bluetty.c: Bluetooth converter now attached to ttyUB0 (or 
> usb/ttub/0 for devfs)
> 	bluetty: probe of 1-2:1.1 failed with error -5
> 	bluetty: probe of 1-2:1.2 failed with error -5
> 
> If I do a dmesg 
> 	usb 1-2: adding 1-2:1.2 (config#1, interface 2)
> 	usb 1-2: 1.2 : hotplug
> 	bluetty 1-2:1.2 .usb_prove_interface
> 	bluetty 1-2:1.2 .usb_prove_interface - got id
> 	drivers/usb/class/bluetty.c: usb_bluetooth_probe - improper number of 
> endpoints.
> 	Bluetooth driver not bound.
> 
> Before it says the same with 1-2:1.1

this is the wrong mailing list. Our driver is hci_usb. For questions
about bluetty post to the USB mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
