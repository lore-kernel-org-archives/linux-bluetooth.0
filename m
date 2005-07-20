Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <001501c58cf3$f1fdc990$1101a8c0@w2ksn>
From: "Stewart Nelson" <sn@scgroup.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: [Bluez-users] Can CNet USB dongle work with BlueZ?
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
Date: Tue, 19 Jul 2005 23:26:19 -0700

Hi,

I'm new to Bluetooth and would like to place calls on a Mot. V551
from Asterisk, using chan_bluetooth.  Although a recent Asterisk
is installed, the base system is Asterisk@home, running
2.4.21-27.0.1.EL kernel.

bluez-libs and bluez-utils compiled and installed with no
apparent error, but:

# hciconfig
Can't open HCI socket.: Address family not supported by protocol

dmesg shows (partial):
hub.c: new USB device 00:07.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0xc10/0x0) is not claimed by any active driver.

lsusb -v shows (partial):
Bus 001 Device 002: ID 0c10:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224
  bDeviceSubClass         1
  bDeviceProtocol         1
  bMaxPacketSize0        64
  idVendor           0x0c10
  idProduct          0x0000
  bcdDevice           15.00
  iManufacturer           1 SiW
  iProduct                2 SiW

Pardon my ignorance, but is the "not claimed" error caused by the device
being unsupported, or do I need to somehow enable the driver(s)?
(The dongle can talk to the phone ok under Win XP.)

If the former, is there some way to force a driver association, to see
if it will work?

If this dongle is not suitable, what do you recommend for such an
application?

Thanks,

Stewart



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
