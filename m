Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 04 Apr 2007 14:38:36 +0200
From: "Harald Kubota" <hkubota@gmx.net>
Message-ID: <20070404123836.132910@gmx.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] dfutool  - does not work for me
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

How is dfutool supposed to work?

# dfutool -d /dev/bus/usb/005/025 archive abc
Can't find any DFU devices

this says it all. Does not work to read the current firmware from the USB device (a bluetooth dongle).
Without -d parameter strace shows /dev/bus/usb/ being scanned, but that does not help either.

Bluetooth by itself (e.g. pairing with stereo headphones) works.

lsusb shows:

Bus 005 Device 027: ID 04dd:90f2 Sharp Corp.
Bus 005 Device 025: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 002: ID 046d:c50e Logitech, Inc. MX-1000 Cordless Mouse Receiver
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

So what's the syntax to get the firmware out and put new firmware on it?
According to www.remote-exploit.org updating the CSR Bluetooth dongle works, but it might be device dependent (maybe mine does not support this at all), or I must not have hci module loaded. The man page of dfutool is not very helpful (no example), and even Google does not show up any example except Atmel microcontrollers and cell phones, neither applies here.

Harald


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
