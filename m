Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex Holland <ah160@student.cs.york.ac.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
References: <200404182321.55431.dvornheder@t-online.de> <200404191952.11018.simone.gotti@email.it> <200404192121.31112.ah160@student.cs.york.ac.uk>
In-Reply-To: <200404192121.31112.ah160@student.cs.york.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404201028.08718.ah160@student.cs.york.ac.uk>
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
Date: Tue, 20 Apr 2004 10:28:08 +0100

Well, booted up today and it worked! To be honest though, I consider 
this to be a bad thing; it means it'll probably do the works 
sometimes/doesn't work sometimes thing that bluez-bluefw did too.

Conclusion? Don't go near USB dongles with Broadcomm chipsets. I wish I 
had a CSR.

Thanks for the help, anyway.

Alex Holland

Here's bits of dmesg and lsmod/usb, just in case it reveals anything:

---------------------------------------------------------------------
...blah...
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
drivers/usb/core/usb.c: registered new driver bcm203x
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
drivers/usb/core/usb.c: registered new driver hci_usb
...blah...
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
...blah...
Bluetooth: RFCOMM ver 1.2
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
-----------------------------------------------------------------------
Bus 001 Device 007: ID 0a5c:2001 Broadcom Corp.
-----------------------------------------------------------------------
rfcomm                 34780  2
l2cap                  21380  5 rfcomm
hci_usb                 9664  6
bluetooth              43812  15 rfcomm,l2cap,hci_usb
bcm203x                 4416  0
firmware_class          7616  1 bcm203x


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
