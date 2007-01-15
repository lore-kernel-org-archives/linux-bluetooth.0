Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 15 Jan 2007 08:02:45 -0500
MIME-Version: 1.0
Message-Id: <200701150802.45350.akohlsmith-bluez@benshaw.com>
Subject: [Bluez-users] bluez and dbus - how to turn on discovery?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I've seen it in this list, but I can't find it now.

dbus is such a hairy pain in the ass, I hope that my opinion of it changes 
once I understand it more.

I would have thought that using a dbus "browser" such as kdbus I would have 
found a method to turn discovery on and off, as well as a bunch of other 
things.  However, browsing the system bus it I see

:1.0/org/bluez as an object (with nothing else)
org.bluez/org/bluez as an object (again with nothing else)

There isn't anything interesting in the session bus (at least not relating to 
Bluez, although I wasn't expecting to find anything.)

There is also an org.freedesktop.DBus interface in both the system and session 
busses with a ton of crap under it, but nothing bluez-related.

I haven't found much in the way of documentation on how to use this, yet we're 
all expected to use it.  Can someone assist in giving perhaps a crash course 
in controlling bluez through dbus?

-A.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
