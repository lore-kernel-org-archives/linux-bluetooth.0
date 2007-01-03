Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: jbarnett@pobox.com, BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1167793130.3356.17.camel@localhost>
References: <mailman.341782.1167746753.8777.bluez-devel@lists.sourceforge.net>
	<1167793130.3356.17.camel@localhost>
Date: Wed, 03 Jan 2007 10:28:53 +0100
Message-Id: <1167816533.20568.12.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problems with Dell BCM2045 USB device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jon,

> I have a Dell Inspiron 9400 that has a USB bluetooth local device based
> on the BCM2045 chip.

please show us the content of /proc/bus/usb/devices for this dongle.

> The options I use for hci_usb (in /etc/modprobe.d/hci_usb is:
> options hci_usb force_scofix=1 reset=1
> 
> I've also tried with no options and with only force_scofix=1. Same results.

Does normal operation like scanning for other devices work if you don't
give the reset=1 quirk? If yes, then this one is not needed at all.

If you load the hci_usb driver without force_scofix=1, what does
hciconfig show you.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
