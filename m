Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help id'ing USB bluetooth adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Chiverton <thomas.chiverton@bluefinger.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402111236.34361.thomas.chiverton@bluefinger.com>
References: <200402111236.34361.thomas.chiverton@bluefinger.com>
Content-Type: text/plain
Message-Id: <1076505074.2777.69.camel@pegasus>
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
Date: Wed, 11 Feb 2004 14:11:15 +0100

Hi Thomas,

> Where do I start trying to figure out what chipset this 'ere adapter is, and 
> so if it is supported ?

it is a CSR BlueCore02 with HCI 16.4 firmware and 56 bit encryption.

> syslog reports:
> Feb 11 12:07:11 charles-compaq kernel: hub.c: new USB device 00:1f.2-1, 
> assigned address 9
> Feb 11 12:07:11 charles-compaq /sbin/hotplug: no 
> runnable /etc/hotplug/bluetooth.agent is installed
> Feb 11 12:07:14 charles-compaq /etc/hotplug/usb.agent: Setup hci_usb for USB 
> product a12/1/525
> Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
> urb dfa58700, burb dfa58a00
> Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
> urb dc7b0300, burb dfa58a00
> Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
> urb dfa58a00, burb dc7b0300
> Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
> urb dfa58a00, burb dc7b0300
> Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
> urb dc7b0300, burb dfa58a00
> Feb 11 12:07:14 charles-compaq /etc/hotplug/usb.agent: ... no modules for USB 
> product a12/1/525
> Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
> urb dfa58a00, burb dfa58280
> Feb 11 12:07:14 charles-compaq /etc/hotplug/usb.agent: ... no modules for USB 
> product a12/1/525

This looks like an USB problem. What kernel version is it? Do hciconfig
shows your Bluetooth adapter?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
