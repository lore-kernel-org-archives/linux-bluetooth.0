Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] kernel panic
From: Marcel Holtmann <marcel@holtmann.org>
To: Ladislav Lhotka <lada@lhotka.elsatnet.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087722591.6692.14.camel@missotis.lhotkovi.cz>
References: <1087722591.6692.14.camel@missotis.lhotkovi.cz>
Content-Type: text/plain
Message-Id: <1087726146.25061.33.camel@pegasus>
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
Date: Sun, 20 Jun 2004 12:09:06 +0200

Hi Ladislav,

> I have been quite succesful with setting up Bluetooth on IBM ThinkPad
> T41p with Gentoo Linux (kernel 2.6.5-gentoo-r1). The only serious
> problem is that after enabling BT with Fn-F5 and doing
> 
> /etc/init.d/bluetooth start
> 
> I can neither disable BT with Fn-F5 nor shutdown the system - in both
> cases the system hangs with
> 
> <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
> 
> Does anyone have a similar experience? What more info can I provide?

sounds like the bugs in the hci_usb driver. Install 2.6.7.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
