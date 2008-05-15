Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200805141058.13430.petr.palacky@coduco.com>
References: <200805141058.13430.petr.palacky@coduco.com>
Date: Thu, 15 May 2008 11:43:45 +0200
Message-Id: <1210844625.7025.38.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluez and more than two USB dongles in one HUB
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

Hi Petr,

> I have problem with using more than two USB dongles in one USB port using 4
> (and more)-port USB-HUB (with or without power supply)...
> 
> I have many USB dongles for testing purposes, the same with USB HUBs.
> If I connect two dongles into HUB everything works well, but if I want to 
> attach third (and more) they will not be activated via bluez stack...

try to load the hci_usb driver with the isoc=0 option or use the btusb
driver instead. If that doesn't help, mailing the USB guys, because this
is more an USB problem then a Bluetooth issue.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
