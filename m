Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Getting installed usb bluetooth adaptor into
	linux system
From: Marcel Holtmann <marcel@holtmann.org>
To: David Mezkiriz <dmezkiriz@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040722103539.36998.qmail@web41303.mail.yahoo.com>
References: <20040722103539.36998.qmail@web41303.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1090518368.21828.37.camel@pegasus>
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
Date: Thu, 22 Jul 2004 19:46:09 +0200

Hi David,

> Ok I understand, so network adaptors don't use any
> device nodes.
> 
> After being plugged my usb bluetooth adaptor I did
> this one:
> #dmesg | grep hciconfig
> but I didn't get any output.

and this is stupid anyway. Call only "hciconfig -a".

> Then I tried 
> #dmesg | grep usb
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 17:26:20 Mar 13
> 2003
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> usb-uhci.c: v1.275:USB Universal Host Controller
> Interface driver
> usb.c: registered new driver hiddev
> usb.c: registered new driver hid
> usb.c: USB device 2 (vend/prod 0xa12/0x1) is not
> claimed by any active driver.
> usb.c: registered new driver hci_usb
> 
> Seems to have detected my usb adaptor, doesn't it?,
> but I don't know how to proceed.

Yes. That is your Bluetooth dongle. As I said try "hciconfig -a".

> I follow your advice, so I typed:
> #ls -la /proc/bus/usb/devices
> 
> and this is what I got
> 
> -r--r--r--    1 root     root            0 Jul 22
> 12:25 /proc/bus/usb/devices
> 
> 
> Upss! I'm quite confused, cause I don't get anything
> in it.
> 
> If you can think of something else, please let me
> know...

Do a "cat /proc/bus/usb/devices" and send it over if hciconfig don't
find your device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
