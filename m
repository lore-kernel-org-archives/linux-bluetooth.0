Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some questions
From: Marcel Holtmann <marcel@holtmann.org>
To: DVornheder@t-online.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1BYJR5-1Xq5q40@cmpmail07.bbul.t-online.de>
References: <1BYJR5-1Xq5q40@cmpmail07.bbul.t-online.de>
Content-Type: text/plain
Message-Id: <1086863592.1607.47.camel@pegasus>
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
Date: Thu, 10 Jun 2004 12:33:13 +0200

Hi Dirk,

> Yesterday i bought a Belkin Bluetooth USB Adapter.
> 
> After plugin the adapter i get this messages:
> 
> Jun  9 21:36:05 pclap kernel: usb 1-1: new full speed USB device using
> address 
> 2
> Jun  9 21:36:05 pclap /etc/hotplug/usb.agent[11903]: need a device for
> this 
> command
> Jun  9 21:36:05 pclap hcid[4002]: HCI dev 0 registered
> Jun  9 21:36:05 pclap hcid[4002]: HCI dev 0 up
> Jun  9 21:36:05 pclap hcid[4002]: Starting security manager 0
> Jun  9 21:36:09 pclap kernel: Bluetooth: RFCOMM ver 1.3
> Jun  9 21:36:09 pclap kernel: Bluetooth: RFCOMM socket layer initialized
> Jun  9 21:36:09 pclap kernel: Bluetooth: RFCOMM TTY layer initialized
> 
> lsusb shows:
> 
> Bus 002 Device 002: ID 050d:0081 Belkin Components
> 
> With ciptool search the adapter is connecting to my AVM Fritz ISDN AP-X:
> 
> Jun  9 21:40:00 pclap hcid[4002]: pin_code_request
> (sba=00:0A:3A:51:81:4E, 
> dba=00:04:0E:85:35:15)
> Jun  9 21:40:00 pclap hcid[4002]: link_key_notify
> (sba=00:0A:3A:51:81:4E)
> Jun  9 21:40:00 pclap hcid[4002]: Saving link key 00:0A:3A:51:81:4E 
> 00:04:0E:85:35:15
> 
> hcitool scan shows:
> 
> Scanning ...
> 	00:04:0E:85:35:15	Bluetooth ISDN Access Point
> 	00:04:0E:83:3C:40	BlueZ (0)
>                            00:02:72:44:CF:9F                  
> BELKIN_PRT_44CF9F
> 
> My questions:
> 
> - No driver is loaded after plugin the adapter.
> 
>    Is this ok ?

I think the hci_usb is loaded, otherwise your device won't work.

> - How can i open a internet connection ?

Use pppd and the CAPI plugin for it. Check with capiinfo for your ISDN
access point.

http://www.holtmann.org/linux/bluetooth/isdn.html

> - How can i print on my usb printer which is connected to the
> BELKIN_PRT_44CF9F
> 
>    bluetooth adapter ?

First send me some info about this printer adapter for my list. The
output "hcitool info ..." will be nice.

The CUPS printing backend for Bluetooth will help you out here.

http://www.holtmann.org/linux/bluetooth/cups.html

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
