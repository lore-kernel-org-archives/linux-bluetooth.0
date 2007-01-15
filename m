Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sourceforge.net
Date: Mon, 15 Jan 2007 10:33:36 -0500
References: <200701150802.45350.akohlsmith-bluez@benshaw.com>
	<1168867454.5728.8.camel@violet>
In-Reply-To: <1168867454.5728.8.camel@violet>
MIME-Version: 1.0
Message-Id: <200701151033.37304.akohlsmith-bluez@benshaw.com>
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

On Monday 15 January 2007 8:24 am, Marcel Holtmann wrote:
> the session bus is not used by BlueZ at all. We only use the system bus.

Right, I figured that.  :-)

> So in general if your adapter has been found you should see org
> org.bluez/org/bluez/hci0 object with the org.bluez.Adapter interface.
> This interface on this path provides a SetMode method that can be used
> to change the mode from "connectable" to "discoverable".

dbus-send --system --dest=org.freedesktop.DBus --print-reply=1 /org/freedesktop/DBus 
org.freedesktop.DBus.ListNames
   array [
      org.freedesktop.DBus      :1.4      org.bluez      :1.9      :1.11   ]

I only have an org.bluez interface.  No org.bluez.Adapter, even though hci0 is 
up and running great (hcid is running, and hidd is running, my BT mouse works 
great)

> Since you speak about kdbus, I assume you don't use GNOME, but in that
> case you could install bluez-gnome and use the bluetooth-properties
> program to change the setting.

*nods* it looks like kdbus is working fine, as the dbus-send call itself is 
returning the exact same info... I just don't have a org.bluez.Adapter 
interface, nor do I have any hci0 object path.

Talking with the guys in FreeNode's #dbus channel too they say that this kind 
of return code is an error:

$ dbus-send --system --dest=org.bluez --print-reply=1 /org/bluez/hci0 
org.freedesktop.DBus.Introspectable.Introspect
   <!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 
1.0//EN"
"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
$

(/org/bluez also sends the exact same response) -- they claim that running 
that should give me some methods/interfaces, a child node or an error.

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
