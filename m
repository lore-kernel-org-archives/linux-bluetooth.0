Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 28 May 2007 09:39:31 +1000
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<200705280119.47962.dgollub@suse.de>
In-Reply-To: <200705280119.47962.dgollub@suse.de>
MIME-Version: 1.0
Message-Id: <200705280939.31695.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Suggesting bluez_pinhelper
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Daniel,

As part of our work on Qtopia we've wrapped the BlueZ DBUS interface and some 
of the Bluetooth socket types in a nice Qt way.  We've also done some work on 
OBEX support in Qtopia 4.2, with much nicer API in Qtopia 4.3.  

Check out http://doc.trolltech.com/qtopia4.2/qtopiabluetooth.html.  If there 
are some things which can be used by KDE (beats duplicating effort), I can 
work on separating the Bluetooth classes as a separate Solutions package or 
something.  Same goes for OBEX support.

-Denis

On Monday 28 May 2007 09:19, Daniel Gollub wrote:
> On Sunday 27 May 2007 15:52:30 Gilboa Davara wrote:
> > As some of you may be aware, the current version of kdebluetooth has no
> > support for recent (>= 3.9) bluez DBUS interface.
>
> Thats correct - it's even quite unmaintained for a while...
> I started at the #1 BlueZ Meeting a kdebluetooth-dbus-integration branch:
>
> http://websvn.kde.org/branches/work/kdebluetooth-dbus-integration/
>
> The libkbluetooth got a full rewrite and wraps the full BlueZ DBus API (and
> the Input Service so far ...) - main goal: avoid any linking against
> bluez-libs.
>
> The kio_slaves (kio_bluetooth, kio_sdp) and kcm_btpaired got ported to the
> new libkbluetooth API. The kbluetoothd got rewrite and renamed to
> kbluetooth and is now a "simple" tray icon application like bluez-gnome.
> And acts as (Default) Passkey Agent and Authorization Agent. It also
> includes a (very experimental) bluetooth input device wizard which makes
> use of the BlueZ Input Service.
>
> Actually i planned to make the first release last week ... but i run out of
> time. Feel free to give the latest SVN revision a try...
>
> > As it stands I got two options:
> > A. Use this code as a stop-gate until qt-dbus + kdebluetooth is released
> > (KDE 4?) maintaining this code as a Fedora-only blob.
>
> KDE4, got already some progress in supporting the BlueZ DBus API. There is
> an experimental Solid Management backend for Bluetooth (trunk/kdebase)
> which includes also a DBus based BlueZ. There is still some work left - but
> it has also an initial support for the input service. The
> Passkey/Authorization Agent support is still missing in KDE4, but will be
> implementend hopefully quite soon. Last but not least:
>
> - Juan started porting the kio_slaves for KDE4 based on Solid. He will do
> more work on KDE4 Bluetooth implementation during his GSoC project.
> - Tom Patzig is taking care about the input wizard for KDE3 and most other
> missing UI implementation (services, trusted users, ...) - later also KDE4
> stuff.
>
> I guess one of them will do also the implementation of the
> Passkey/Authorization Agent in the UI - as soon the solid implementation is
> done.
>
> The kdebluetooth-dbus-integration also includes a rewrite of kio_obex
> (called kio_obex2) from the kmobiletools project. kio_obex2 isn't based
> anymore on some own libqobex/libkobex implementation ... just based on
> obexftp and supports finally OBEX transport via USB.
>
> Btw. if there is any issue/problem with the DBus-"SUSE patch" let me know -
> in most cases it's my fault. It's a simple (async) implementation of a
> Default Passkey Agent and seems to work quite well.
>
> best regards,
> Daniel
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
