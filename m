Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Oops in hci_usb when disconnecting built-in
	controller
From: Marcel Holtmann <marcel@holtmann.org>
To: Andy Ross <andy@plausible.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40CDE884.8080809@plausible.org>
References: <40CDE884.8080809@plausible.org>
Content-Type: text/plain
Message-Id: <1087237699.13792.42.camel@pegasus>
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
Date: Mon, 14 Jun 2004 20:28:19 +0200

Hi Andy,

> I have a new laptop, a Compaq R3000Z (AMD64, but currently running a
> 32 bit kernel).  It has a built-in USB Bluetooth device, which
> identifies itself as ID 049f:0086.  It works great with the hci_usb
> driver from boot.
> 
> The laptop also has a "wireless enable/disable" switch, which is a
> hardware switch that when pressed drops power to the internal 802.11b
> antenna and (apparently) disconnects the HCI controller from the USB
> bus.  When I use this, I get a 100% repeatable oops in the hci_usb
> driver.  The driver then locks up and refuses to unload, although the
> rest of the kernel appears to be unaffected.

this problem is already fixed. Try 2.6.7-rc3 or apply the -mh3 patch.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
