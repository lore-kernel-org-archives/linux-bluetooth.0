Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jon Valvatne <jon@valvatne.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1087496559.3103.11.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] hidd --server only finding one device
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
Date: Thu, 17 Jun 2004 20:22:40 +0200

Hello again,

I've got my Logitech diNovo mouse & keyboard working with BlueZ by
finding them manually with hidd (with '--search' or '--connect <addr>').
But for some reason 'hidd --server' doesn't want to recognize both of
the devices at the same time: When it starts up it will detect whichever
device I use first, and not the other.

In other words, if I start typing on my keyboard after starting hidd, it
will work, but the mouse won't. If I start by clicking the mouse, that
will work, but the keyboard won't. This happens consistently, and the
non-working device will only start working if I first press its little
'connect' button and then manually connect it with 'hidd --connect
<addr>'.

Has anyone experienced anything like this? I can't imagine this is
intended or required behavior; if it can recognize one, why not the
other?

Jon



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
