Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: henryzhang62@yahoo.com,
	BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <382531.424.qm@web57905.mail.re3.yahoo.com>
References: <382531.424.qm@web57905.mail.re3.yahoo.com>
Date: Wed, 20 Aug 2008 12:18:50 +0200
Message-Id: <1219227530.7591.320.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] should I use hciattach for my USB dongle?
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

> I have a USB dongle connected to my desktop. "hciconfig hci0 up" returns "can't open HCI socket.:Address family not supported by protocol". 
> 
> For serial port, run "hciattach /dev/ttyS1 bcsp 115200". But my dongle is self initialized with its own eeprom with USB port. 
> 
> What should I do to setup my dongle and make it work with my cell phone?

either the hci_usb or btusb driver will be used. Make sure that all
modules are loaded.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
