Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 mouse not working.
From: Marcel Holtmann <marcel@holtmann.org>
To: jungle@saphire.dk
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1090769444.983.19.camel@aquarius>
References: <1090765201.983.13.camel@aquarius>
	 <200407251632.32162.cijoml@volny.cz>  <1090769444.983.19.camel@aquarius>
Content-Type: text/plain
Message-Id: <1090770122.31693.2.camel@pegasus>
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
Date: Sun, 25 Jul 2004 17:42:03 +0200

Hi Kim,

> After reading Marcel Holtmann's post I also manually created some device
> nodes with this shell script:
> 
> #!/bin/sh
> mkdir -p /dev/usb/hid
> mknod /dev/usb/hid/hiddev0 c 180 96
> mknod /dev/usb/hid/hiddev1 c 180 97
> mknod /dev/usb/hid/hiddev2 c 180 98
> mknod /dev/usb/hid/hiddev3 c 180 99
> mknod /dev/usb/hid/hiddev4 c 180 100
> mknod /dev/usb/hid/hiddev5 c 180 101
> mknod /dev/usb/hid/hiddev6 c 180 102
> mknod /dev/usb/hid/hiddev7 c 180 103
> mknod /dev/usb/hid/hiddev8 c 180 104
> mknod /dev/usb/hid/hiddev9 c 180 105
> mknod /dev/usb/hid/hiddev10 c 180 106
> mknod /dev/usb/hid/hiddev11 c 180 107
> mknod /dev/usb/hid/hiddev12 c 180 108
> mknod /dev/usb/hid/hiddev13 c 180 109
> mknod /dev/usb/hid/hiddev14 c 180 110
> mknod /dev/usb/hid/hiddev15 c 180 111
> 
> I found the above by Googling around. Please correct me if I am doing
> something wrong with this.
> 
> Still after this, it doesnt quite seem to work.
> 
> hcitool scan still reports:
> Device is not available: Success
> 
> and hid2hci also still reports:
> Switching device 046d:c703 to HCI mode failed (No such device)

the error message is different, so I assume that you either don't
activated the hiddev support in your kernel or you use the dynamic USB
minor allocation. Check your kernel config for CONFIG_USB_DYNAMIC_MINORS
and CONFIG_USB_HIDDEV.

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
