Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170701160502l158c445dwd84a5876ce553820@mail.gmail.com>
Date: Tue, 16 Jan 2007 10:02:09 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <200701151033.37304.akohlsmith-bluez@benshaw.com>
MIME-Version: 1.0
References: <200701150802.45350.akohlsmith-bluez@benshaw.com>
	<1168867454.5728.8.camel@violet>
	<200701151033.37304.akohlsmith-bluez@benshaw.com>
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

On 1/15/07, Andrew Kohlsmith <akohlsmith-bluez@benshaw.com> wrote:
> dbus-send --system --dest=org.freedesktop.DBus --print-reply=1 /org/freedesktop/DBus
> org.freedesktop.DBus.ListNames
>    array [
>       org.freedesktop.DBus      :1.4      org.bluez      :1.9      :1.11   ]
>
> I only have an org.bluez interface.

Sorry, but this org.bluez is not an interface, but the bluez service.

> Talking with the guys in FreeNode's #dbus channel too they say that this kind
> of return code is an error:
>
> $ dbus-send --system --dest=org.bluez --print-reply=1 /org/bluez/hci0
> org.freedesktop.DBus.Introspectable.Introspect
>    <!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection
> 1.0//EN"
> "http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
> $
>
> (/org/bluez also sends the exact same response) -- they claim that running
> that should give me some methods/interfaces, a child node or an error.

Yep, hcid is not answering the Introspect calls with the interface
methods and their signatures.

-- Ulisses

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
