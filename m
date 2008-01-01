Return-Path: <cyrus@holtmann.org>
Message-ID: <477AA678.4000707@boerkel.de>
Date: Tue, 01 Jan 2008 21:45:44 +0100
From: =?ISO-8859-1?Q?Thomas_B=F6rkel?= <thomas@boerkel.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Trouble with Tecom BT3030 - not recognized
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

HI!

I had a Tecom BT3030 running OK on Suse 10.1 with Kernel 2.6.16, Bluez
2.24 and Bluez firmware 1.0.

Now (since a few days) I am on Gentoo with Kernel 2.6.23 and I have tried:
- Bluez 2.25 + Bluez firmware 1.1
- Bluez 3.23 + Bluez firmware 1.1
- Bluez 3.23 + Bluez firmware 1.1

It's always the same. When I put the dongle into the USB port, I get
only this:
usb 3-1: new full speed USB device using uhci_hcd and address 9
usb 3-1: configuration #1 chosen from 1 choice

When I remove it, I get this:
bcm203x_complete: URB failed with status -84
or this:
usb 3-1: USB disconnect, address 9


My system should be installed correctly, because an Anycom 2.0 dongle
works flawlessly:
usb 3-1: new full speed USB device using uhci_hcd and address 10
usb 3-1: configuration #1 chosen from 1 choice
hcid[12188]: HCI dev 0 registered
Jan  1 21:36:01 asus hcid[12188]: HCI dev 0 up
Jan  1 21:36:01 asus hcid[12188]: Device hci0 has been added
Jan  1 21:36:01 asus hcid[12188]: Starting security manager 0
Jan  1 21:36:01 asus hcid[12188]: Device hci0 has been activated


lsusb with the non-working Tecom:
Bus 003 Device 011: ID 0a5c:2033 Broadcom Corp. BCM2033 Bluetooth


Somehow hcid does not react to the Tecom?

BTW, I also tried this with another new Gentoo system with the same
result. I somehow can't believe the Tecom died at the same time I
reinstalled the system.

Any help would be greatly appreciated. Thanks!

Thomas

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
