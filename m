Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex Holland <ah160@student.cs.york.ac.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
References: <200404182321.55431.dvornheder@t-online.de> <200404190935.34433.ah160@student.cs.york.ac.uk> <1082370224.4403.33.camel@pegasus>
In-Reply-To: <1082370224.4403.33.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404191419.59021.ah160@student.cs.york.ac.uk>
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
Date: Mon, 19 Apr 2004 14:19:58 +0100

On Monday 19 Apr 2004 11:23, Marcel Holtmann wrote:

> you can find it at http://www.bluez.org/drivers.html

Ah, thanks! Could you put that URL in the Kernel help page for the 
blutonium driver? It's a bit of an enigma at present.

While it doesn't seem to oops on Gentoo anymore, neither does it seem to 
actually work - hciconfig can't see any devices. I've enclosed 
information which will hopefully help find out why.

Thanks.

Alex Holland

------------------------------------------------

The dongle's a Belkin F8T001, the original model. Bluefw works very 
temprementally; sometimes it just doesn't, for no apparent reason, with 
the dongle timing out. Blue-fw was uninstalled before trying out the 
Blutonium kernel module, and BCM-LEGAL.txt, BCM2033-FW.bin and 
BCM2033-MD.hex placed in /usr/lib/hotplug/firmware/

Athlon T-Bird 900Mhz
Gentoo stable, gentoo-dev-sources-2.6.5-r2. 
bluez-hcidump-1.8
bluez-libs-2.5
bluez-sdp-1.5
bluez-utils-2.5
latest CVS KDE Bluetooth

dmesg excerpts:
---------------------------------------------
...blah...
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
...blah...
bcm203x_probe: Mini driver request failed
bcm203x: probe of 1-2:1.0 failed with error -5
drivers/usb/core/usb.c: registered new driver bcm203x
drivers/usb/core/usb.c: registered new driver hci_usb
...blah...
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
-----------------------------------------------

lsusb gives the following:

Bus 001 Device 003: ID 0a5c:2033 Broadcom Corp. BCM2033 Bluetooth

---------------------------------------------

lsmod provides the following:

l2cap                  21380  2
hci_usb                 9664  0
bluetooth              43812  4 l2cap,hci_usb
bcm203x                 4416  0
firmware_class          7616  1 bcm203x

kernel config:
------------------------------------------------
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
# CONFIG_BT_SCO is not set
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
# CONFIG_BT_BNEP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
# CONFIG_BT_HCIUSB_SCO is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIBCM203X=m
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
-------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
