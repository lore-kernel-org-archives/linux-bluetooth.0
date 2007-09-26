Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070926140507.GA5913@sus.mcgill.ca>
References: <20070924192203.GA31266@sus.mcgill.ca>
	<2759cf860709241233w621bd23akf3882800ad48cc28@mail.gmail.com>
	<1190672090.5133.133.camel@aeonflux.holtmann.net>
	<20070924222152.GA13130@sus.mcgill.ca>
	<1190675554.5133.151.camel@aeonflux.holtmann.net>
	<20070924232149.GA14346@sus.mcgill.ca>
	<2759cf860709250450yc36a945m846bd529d006b289@mail.gmail.com>
	<e1effdeb0709250524n16217623p194a891fa858810c@mail.gmail.com>
	<20070925123441.GA1032@sus.mcgill.ca> <20070926113035.GC8781@suse.de>
	<20070926140507.GA5913@sus.mcgill.ca>
Date: Thu, 27 Sep 2007 00:06:30 +0200
Message-Id: <1190844390.6484.30.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] help with Logitech Travel Mouse
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

Hi Martin,

> > > The other problem is - what about people who don't use gnome or kde?  I
> > > always thought Linux was about choice.  Clearly, if I want to use
> > > bluetooth, I am forced to use one of these desktop systems with their
> > > desktops, wms etc..., which is quite restrictive.  That is quite a step
> > > back from the  "hidd --search"  way of doing things!
> > > 
> > > (Now, I am not saying that hidd --search should be the only way -
> > > definitely not.  Gnome and KDE integratino are really important.  But
> > > please not at the expense of simple command-line tools!)
> > 
> > Just go ahead and write them. Take those python scripts as a base and write
> > some nice ncurses-based inputwizard. Or maybe XLib-based or whatever. Lots
> > of people are complaining that "there is no way to do it on the command line"
> > but the only people providing code are the desktop people.
> 
> Unfortunately, I am not a "desktop" person or "command-line" person.  I
> am a user.  A significant amount of people earn their living writing
> Gnome/KDE tools.  Thats, IMHO, why they provide code faster.  I don't
> think I have the time and resources to promise that I will write and
> maintain  tools that the bluez-team decided were no longer necessary. 
> 
> It's a shame.  I guess it's bound to happen - the more successful Linux
> gets, the more it's gonna be like Windows.  Less choice, more
> clicky-clicky!  I still don't quite understand the decision to drop
> support for command-line tools, but I am not entitled to judge the
> bluez-developers.  I can only express my frustration.

we have a perfect abstraction through the D-Bus interfaces we defined.
This allows all kind of users and languages. Meaning you can do whatever
you want. This is the choice. That we currently only have graphical
application that satisfy you is actually your problem. Most of us work
with Python since it is really simple to use the D-Bus API from within
it. The GTK/GNOME application exists, because I wrote them. The KDE
ones, because some KDE people cared. In Linux it has always been that
you have to step up and do something. This is how it works.

For the hidd case we provide smooth transition. So once you connected
via --search and --connect the new input service will pick up that HID
device on next boot and make it work. However --search and --connect and
are one-time commands only. No matter what you think or what you want or
what you read somewhere else. If you use them in a wrong why, then that
is your problem.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
