Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 mouse not working.
From: Kim Pedersen <jungle@saphire.dk>
Reply-To: jungle@saphire.dk
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200407251632.32162.cijoml@volny.cz>
References: <1090765201.983.13.camel@aquarius>
	 <200407251632.32162.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1090769444.983.19.camel@aquarius>
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
Date: Sun, 25 Jul 2004 17:30:44 +0200

Hi Michal,

On Sun, 2004-07-25 at 16:32, Bc. Michal Semler wrote:
> And you should better run hotplug
> apt-get install hotplug

I did this, and installed hotplug.

I also installed the usbutils package. lsusb gives me:

Bus 005 Device 001: ID 0000:0000  
Bus 004 Device 001: ID 0000:0000  
Bus 003 Device 003: ID 046d:c703 Logitech, Inc. 
Bus 003 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 002: ID 046d:c00c Logitech, Inc. Optical Wheel Mouse
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000 


The Optical wheel mouse is my standard USB mouse, not the new Bluetooth
one.


After reading Marcel Holtmann's post I also manually created some device
nodes with this shell script:

#!/bin/sh
mkdir -p /dev/usb/hid
mknod /dev/usb/hid/hiddev0 c 180 96
mknod /dev/usb/hid/hiddev1 c 180 97
mknod /dev/usb/hid/hiddev2 c 180 98
mknod /dev/usb/hid/hiddev3 c 180 99
mknod /dev/usb/hid/hiddev4 c 180 100
mknod /dev/usb/hid/hiddev5 c 180 101
mknod /dev/usb/hid/hiddev6 c 180 102
mknod /dev/usb/hid/hiddev7 c 180 103
mknod /dev/usb/hid/hiddev8 c 180 104
mknod /dev/usb/hid/hiddev9 c 180 105
mknod /dev/usb/hid/hiddev10 c 180 106
mknod /dev/usb/hid/hiddev11 c 180 107
mknod /dev/usb/hid/hiddev12 c 180 108
mknod /dev/usb/hid/hiddev13 c 180 109
mknod /dev/usb/hid/hiddev14 c 180 110
mknod /dev/usb/hid/hiddev15 c 180 111

I found the above by Googling around. Please correct me if I am doing
something wrong with this.

Still after this, it doesnt quite seem to work.

hcitool scan still reports:
Device is not available: Success

and hid2hci also still reports:
Switching device 046d:c703 to HCI mode failed (No such device)

I must be missing a step somewhere since you guys are able to get it
working properly.

Thanks,

Sincerely,

// Kim Pedersen
  -- Freedom Matters!




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
