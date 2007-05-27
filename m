Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9050516b0705271135v6deebe42s5e822fcae630b0ac@mail.gmail.com>
Date: Sun, 27 May 2007 21:35:04 +0300
From: "Gilboa Davara" <gilboad@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180289071.21432.76.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<1180283796.21432.73.camel@aeonflux.holtmann.net>
	<1180286884.30116.12.camel@gilboa-work-dev.localdomain>
	<1180289071.21432.76.camel@aeonflux.holtmann.net>
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

Marcel,

On 5/27/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Gilboa,
>
> > > I am not
> > > really open for crazy hacks.
> >
> > Why crazy hack?
> >
> > kdebluetooth aside, If -I- (being, among others, the IceWM Fedora
> > maintainer) can use this wrapper (coupled with zenity and/or xdialog)
> > and create a workable out-of-the-box bluetooth experience on IceWM
> > (without the bluez-gnome dep-chain) and other low-end WM's - doesn't it
> > enhance the user experience?
>
> I agree that the bluez-gnome dependency chain is crazy, but that is a
> GNOME issue. However you can write a simple nice passkey agent for every
> windowing system that you wanna use. The scripting part is not a clean
> solution. We should have never used scripts for entering pin codes at
> all, but at that point of time any useful solution was not ready.

OK.
I can't say that I agree (IMHO having bash/scripting support for
right-about-everything is major feature in Linux/Unix - not a
drawback), but I accept the fact the being the upstream-man, you get
to choose what goes in and what doesn't - and this code doesn't.

> > ... And hopefully I took it, expanded it, and put it to good use.
> >
> > At best, I managed to enhance the bluetooth experience on
> > low-end/older/minimal distro/machines/configuration/etc. At worst,
> > (after some clean up) I created yet-another-how-to-do-passkey example.
> >
> > Having said all that, I'm far from forcing the issue down your throat...
> > I merely suggesting. If you don't like the idea, I'll keep it
> > Fedora-only, until a working DBUS patch is released... or until KDE4
> > comes out.
>
> I am fine with having something KDE specific since I don't really care
> about KDE, but this is not solution that is acceptable by Bluez
> upstream.

Just for the sake of the archives, this wrapper is completely generic - it has
nothing KDE (or kdebluetooth) specific in it.

... But as I said, you're the boss...

- Gilboa

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
