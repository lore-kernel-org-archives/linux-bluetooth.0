Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1082639361.4087c401a2ddb@webmail.natdesign.m.se>
From: Fredrik Hallgarde <bluez@tedde.nu>
To: Marian Gasparovic <marosg@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth/gprs problem
References: <20040422130453.95115.qmail@web20413.mail.yahoo.com>
In-Reply-To: <20040422130453.95115.qmail@web20413.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 22 Apr 2004 15:09:21 +0200

To return the discussion to the list I repost my reply to Marian here.
/Fredrik

Quoting Marian Gasparovic <marosg@yahoo.com>:

> Fredrik, you are right, I am on 2.4.25. I will try to
> switch.
>=20
> Marian
>=20
> --- Fredrik Hallgarde <bluez@tedde.nu> wrote:
> > Hi Marian,
> >=20
> > > > I have i-Tec USB Dongle with Broadcom chip
> > connected
> > > > to my notebook with Debian Woody. I am able to
> > > > establish bluetooth connection to my Siemens S55
> > > > mobile. After I start pppd for GPRS access to
> > Internet
> > > > I get connected. I can ping any server for as
> > long as
> > > > I want. But when I open any web page under
> > Konqueror
> > > > or try ping -f, after couple of seconds (10-20)
> > I
> > > > loose connection. First I see bluetooth going
> > away on
> > > > mobil display, then gprs disconnect and after a
> > minute
> > > > pppd finds it out too. Any suggestions where to
> > look ?
> > > > I tried it with several notebooks, usb bluetooth
> > > > devices and mobiles and only this i-Tec USB
> > Dongle
> > > > makes troubles. Under Windows XP it works
> > without a
> > > > problem.
> > >=20
> > > this can be a dongle problem, because the dongle
> > contains a Broadcom
> > > chip and we already know that under some weird
> > circumstances this is
> > > buggy. But actually I think that your PPP setting
> > are not correct for a
> > > GPRS dialin. Check the some GPRS+PPP HOWTO's.
> >=20
> > Even though I won't dispute Marcel's knowledge about
> > the chip I like to share my
> > experience with Bluetooth/GPRS.
> >=20
> > I ran into a similar problem using a Broadcom-based
> > IOGear USB Dongle and a NEC
> > e606 3G a couple of months ago. All went well for
> > maybe 30sec, after that nothing.
> > I eventually solved it by switching usb module used
> > in the 2.4.21 kernel (i.e.
> > not bluez but the overall usb-module).=20
> > You're not telling us which kernel you are running
> > but assuming a 2.4.x you
> > should have at least one other module to try.
> >=20
> > After that I never had any trouble using
> > Bluetooth/3G to stay connected.
> >=20
> > /Fredrik
>=20
>=20
> =3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Marian Gasparovic
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> "The mere thought hadn't  even  begun  to speculate about the merest
> possibility of crossing my mind."
>=20
>=20
>=20
>=20
> =09
> 	=09
> __________________________________
> Do you Yahoo!?
> Yahoo! Photos: High-quality 4x6 digital prints for 25=A2
> http://photos.yahoo.com/ph/print_splash
>=20




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
