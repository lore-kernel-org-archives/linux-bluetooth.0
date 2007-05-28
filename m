Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9050516b0705271135v6deebe42s5e822fcae630b0ac@mail.gmail.com>
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<1180283796.21432.73.camel@aeonflux.holtmann.net>
	<1180286884.30116.12.camel@gilboa-work-dev.localdomain>
	<1180289071.21432.76.camel@aeonflux.holtmann.net>
	<9050516b0705271135v6deebe42s5e822fcae630b0ac@mail.gmail.com>
Date: Mon, 28 May 2007 10:29:58 +0200
Message-Id: <1180340998.21432.92.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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

Hi Gilboa,

> > > kdebluetooth aside, If -I- (being, among others, the IceWM Fedora
> > > maintainer) can use this wrapper (coupled with zenity and/or xdialog)
> > > and create a workable out-of-the-box bluetooth experience on IceWM
> > > (without the bluez-gnome dep-chain) and other low-end WM's - doesn't it
> > > enhance the user experience?
> >
> > I agree that the bluez-gnome dependency chain is crazy, but that is a
> > GNOME issue. However you can write a simple nice passkey agent for every
> > windowing system that you wanna use. The scripting part is not a clean
> > solution. We should have never used scripts for entering pin codes at
> > all, but at that point of time any useful solution was not ready.
> 
> OK.
> I can't say that I agree (IMHO having bash/scripting support for
> right-about-everything is major feature in Linux/Unix - not a
> drawback), but I accept the fact the being the upstream-man, you get
> to choose what goes in and what doesn't - and this code doesn't.

from a security perspective, I am not doing this again. We already had a
major issue with the PIN helper script in the 2.x series.

Everybody is free to write their own passkey agent and if it uses
scripts to get the PIN input, that is fine. However bluez-utils will
probably never contain an installable passkey agent. These have to be in
the Bluetooth desktop packages or as an additional add-on. The major
reason is to keep the dependency chain small. With the old Python GTK
based helper script the package maintainers went mad and an install of
bluez-utils dragged GTK and Python onto your system. Not really funny if
you build an embedded box. Nowadays it is only D-Bus that is needed.

Even if the dependency chain of your wrapper is not a problem, I have
seen too much misuse of passkey-agent.c that I am going with it. Lets
keep bluez-utils clean and free of UI. This includes your code, even if
it is technically not UI code.

> > > ... And hopefully I took it, expanded it, and put it to good use.
> > >
> > > At best, I managed to enhance the bluetooth experience on
> > > low-end/older/minimal distro/machines/configuration/etc. At worst,
> > > (after some clean up) I created yet-another-how-to-do-passkey example.
> > >
> > > Having said all that, I'm far from forcing the issue down your throat...
> > > I merely suggesting. If you don't like the idea, I'll keep it
> > > Fedora-only, until a working DBUS patch is released... or until KDE4
> > > comes out.
> >
> > I am fine with having something KDE specific since I don't really care
> > about KDE, but this is not solution that is acceptable by Bluez
> > upstream.
> 
> Just for the sake of the archives, this wrapper is completely generic - it has
> nothing KDE (or kdebluetooth) specific in it.

Please see comment above :)

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
