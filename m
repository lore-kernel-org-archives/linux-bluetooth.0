Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alexandre Boeglin <alex@boeglin.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040615222333.GA18668@boeglin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Subject: [Bluez-users] Motorola v600 and Obex problems
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
Date: Wed, 16 Jun 2004 00:23:33 +0200

Hello,

My current system is a Debian sid, running a stock 2.6.6 kernel.

My Bluetooth USB dongle is a noname with a CSR chip
(http://www.kabiloo.fr/boutique/telephonie/view.php?ref=USBDONGLE)
Vendor Id: 0a12
Product Id: 0001
Revision Number:  5.25

Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Class: 0x000100
HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
Manufacturer: Cambridge Silicon Radio (10)

My phone is actually a Motorola v525 flashed with the latest v600
firmware (the hardware is globally the same).

When transferring file from or to the phone using Obex Push, (with
obexftp, or gnome-bluetooth), the speed is generally around 2 or 3
kilobytes per second, which is really slow. I changed the preffered
packet type from DM1 to DH5, but it didn't changed anything...

Could someone tell me how to reach better performances? or what step I
must go through to find where the problem could be?

Thanks in advance,

Alex

-- 
Alexandre Boeglin
e. mail : alex@boeglin.org | Jabber : boeglin@jabber.org
ICQ UIN : 38852646 | Website : http://www.boeglin.org/
GPG fingerprint : 6B02 86CA A79E FA83 2FF0  3B83 14DE 4187 39C1 2786


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
