Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200701150802.45350.akohlsmith-bluez@benshaw.com>
References: <200701150802.45350.akohlsmith-bluez@benshaw.com>
Date: Mon, 15 Jan 2007 14:24:14 +0100
Message-Id: <1168867454.5728.8.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez and dbus - how to turn on discovery?
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

Hi Andrew,

> dbus is such a hairy pain in the ass, I hope that my opinion of it changes 
> once I understand it more.
> 
> I would have thought that using a dbus "browser" such as kdbus I would have 
> found a method to turn discovery on and off, as well as a bunch of other 
> things.  However, browsing the system bus it I see
> 
> :1.0/org/bluez as an object (with nothing else)
> org.bluez/org/bluez as an object (again with nothing else)
> 
> There isn't anything interesting in the session bus (at least not relating to 
> Bluez, although I wasn't expecting to find anything.)
> 
> There is also an org.freedesktop.DBus interface in both the system and session 
> busses with a ton of crap under it, but nothing bluez-related.
> 
> I haven't found much in the way of documentation on how to use this, yet we're 
> all expected to use it.  Can someone assist in giving perhaps a crash course 
> in controlling bluez through dbus?

the session bus is not used by BlueZ at all. We only use the system bus.

I never used kdbus and so I can't tell you if that would work or not. I
always use the native interface from C or from Python. Some people use
dbus-send, but I can't remember the syntax.

So in general if your adapter has been found you should see org
org.bluez/org/bluez/hci0 object with the org.bluez.Adapter interface.
This interface on this path provides a SetMode method that can be used
to change the mode from "connectable" to "discoverable".

Since you speak about kdbus, I assume you don't use GNOME, but in that
case you could install bluez-gnome and use the bluetooth-properties
program to change the setting.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
