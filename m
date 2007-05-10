Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Erwin Authried <eauth@softsys.co.at>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1178780976.25565.6.camel@aeonflux.holtmann.net>
References: <4641DA61.8040709@tao-group.com>
	<1178722356.8628.96.camel@aeonflux.holtmann.net>
	<4641E662.6080303@tao-group.com>
	<1178724426.8628.102.camel@aeonflux.holtmann.net>
	<4641EA96.7070204@tao-group.com>
	<1178726532.8628.107.camel@aeonflux.holtmann.net>
	<be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>
	<46420306.8020509@tao-group.com>
	<1178780976.25565.6.camel@aeonflux.holtmann.net>
Date: Thu, 10 May 2007 10:01:50 +0200
Message-Id: <1178784111.10803.27.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [Bluez-users] API documentation?
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

Am Donnerstag, den 10.05.2007, 09:09 +0200 schrieb Marcel Holtmann:
> Hi David,
> 
> > >> to be quite frankly, then don't ask me about it. If you wanna screw
> > with
> > >> your system you are on your own.
> > 
> > You seem not to have much experience with embedded systems.
> 
> actually I have quite some experience with embedded systems and I used
> to think the same way as you do right now, but D-Bus is the way to go
> even for embedded systems. There is no excuse. If D-Bus is not suitable
> then fix D-Bus and don't blame the system using it.
> 
> > On my system, there are two instances of dbus-daemon occupying 432 pages and
> > 304 pages respectively, an instance of dbus-launch with 244, and an instance
> > of hcid with 348. There are also two *more* instances of dbus-daemon, but they
> > may be specific to the user and so irrelevant. Even so, that's still a total
> > of 1328 pages, or 5312kB.
> > 
> > That's just not *reasonable* on a system with low memory, especially since
> > Bluetooth will be the only thing that uses it.
> 
> And how is the D-Bus overhead a BlueZ problem. Again if the current
> D-Bus daemon and its library is not suitable, then fix it.
> 
Until now, it seems that nobody has ported d-bus to uClinux. Doing that
isn't trivial, because there are several uses of fork() that isn't
available in uClinux. In openwrt, there isn't any mention of d-bus at
all. Most probably, the footprint is too large for memory-restricted
systems. Because of that and the fact there are very few (if any)
projects for embedded systems that use d-bus it's hardly worth the
effort to port it. Bluez has worked quite well for embedded systems with
older versions, but since it ignores the demands of embedded systems
it's probably better to use a different bluetooth stack. 

Regards,
Erwin



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
