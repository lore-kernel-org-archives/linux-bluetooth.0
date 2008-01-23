Return-Path: <cyrus@holtmann.org>
Message-ID: <1201097235.47974a133555f@netmail.crc.ca>
Date: Wed, 23 Jan 2008 09:07:15 -0500
From: Jean-Michel Bouffard <jean-michel.bouffard@crc.ca>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluetooth on SUSE 10.3
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hi,

I am trying to install a D-Link DBT-120 USB Bluetooth adapter on OpenSUSE 10.3.
When I connect the adapter the log shows:
kernel: usb 3-1: new full speed USB device using uhci_hcd and address 2
kernel: usb 3-1: new device found, idVendor=0a5c, idProduct=2033
kernel: usb 3-1: new device strings: Mfr=0, Product=0, SerialNumber=0
kernel: usb 3-1: configuration #1 chosen from 1 choice
kernel: Bluetooth: Core ver 2.11
kernel: NET: Registered protocol family 31
kernel: Bluetooth: HCI device and connection manager initialized
kernel: Bluetooth: HCI socket layer initialized
kernel: Bluetooth: HCI USB driver ver 2.9
kernel: usbcore: registered new interface driver hci_usb
kernel: Bluetooth: Broadcom Blutonium firmware driver ver 1.1
kernel: usbcore: registered new interface driver bcm203x

And lsusb shows:
Bus 003 Device 002: ID 0a5c:2033 Broadcom Corp. BCM2033 Bluetooth

When I try to run "hcitool dev" I cannot see the adapter.

>>From some documentation I have read that the lsusb result should be:
Bus 001 Device 018: ID 0a5c:2001 Broadcom Corp.
I have installed every required packages for BlueZ, including the firmware for
the BCM2033 chip. In the past I even installed this BT adapter easily on an
older version of SUSE. I was using bluefw to manually load the firmware into
the card but today this tool doesn't seem to exist anymore. So how could I load
the firmware into the adapter? Or any other suggestions are welcome.

Thanks.

--
Jean-Michel


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
