Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 25 May 2007 20:57:33 +0200
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070525185733.GA9401@elmicha>
MIME-Version: 1.0
Subject: [Bluez-users] Using Bluez as a fake Bluetooth keyboard
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

I'm trying to use my computer as a fake Bluetooth keyboard for a laptop
running Windows XP with Toshiba's Bluetooth stack.

With Collin Mulliner's xkbd-bthid [1] it works if I start xkbdbthid.sh
(as root) on my computer and "sudo hidd --search" on a Linux laptop.

That Windows laptop doesn't even try to really connect. It sees the HID
service on my computer and says "Prepare the connection to a Remote-HID
and click OK" (what should I prepare there?!), and if I click OK it
_immediately_ says "Error with the registry" or "Error trying to register"
(I don't understand what they mean with "Fehler bei der Registrierung").

At that point, hcidump sees not a single byte flying through the air.

Perhaps before clicking OK, the keyboard is supposed to search for a
HID host and connect on its own? 

How could I do that with Bluez?

I'm using Bluez 3.10/3.11.

Regards...
		Michael



[1]: http://www.mulliner.org/bluetooth/xkbdbthid.php

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
