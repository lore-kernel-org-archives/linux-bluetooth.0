Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Driver version problems..hci_usb & bluetooth
	parser
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050222172313.48745.qmail@web26410.mail.ukl.yahoo.com>
References: <20050222172313.48745.qmail@web26410.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1109095826.8506.28.camel@pegasus>
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
Date: Tue, 22 Feb 2005 19:10:26 +0100

Hi,

> when I tape
> #modprobe -f hci_usb
> it works, I can do an hciconfig hci0 up  an using
> hcitool etc...
> 
> 
> dmesg tells:
> hci_usb: no version for "struct_module" found: kernel
> tainted.
> hci_usb: no version magic, tainting kernel.
> Bluetooth: HCI USB driver ver 2.7 
> usbcore: registered new driver hci_usb 
> 
> I don't understand where is the matter. But is it
> possible that HCI USB driver is a ver 2.7 and the
> Bluetooth: Core ver 2.6 in the same kernel?

this is no problem. All modules have there own version number.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
