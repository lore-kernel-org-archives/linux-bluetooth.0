Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] udev rules entry for bluetooth mouse
From: Charles Bueche <charles@bueche.ch>
To: bluez-users@lists.sourceforge.net
Cc: Martin Stolle <mstoll@sus.mcgill.ca>
In-Reply-To: <1139411355.8712.24.camel@bluez.bueche.ch>
References: <1138872805.21953.20.camel@bluez.bueche.ch>
	 <43E1E11F.8040501@ycom.ch>  <1138880751.21953.38.camel@bluez.bueche.ch>
	 <1139331334.12556.3.camel@pc-05.ycom.ch>
	 <1139351059.22790.63.camel@localhost>
	 <1139411355.8712.24.camel@bluez.bueche.ch>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1143461376.22527.19.camel@bluez.bueche.ch>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Mar 2006 14:09:36 +0200

Hi again,

The V270 works after all. It was my error, I had two devices reporting
the same events in xorg.conf, so the speed was doubled.

Anyway, the V270 is fast, even with pointer acceleration =3D 1.0x in KDE

Another issue I'm having is that after 2 years of the big MX900 in my
right hand, I find the V270 a bit too small.

Charles

On Wed, 2006-02-08 at 16:09 +0100, Charles Bueche wrote:
> On mar, 2006-02-07 at 23:24 +0100, Marcel Holtmann wrote:
> > Hi Alexandre,
> >=20
> > > > Did you contact the hotplug team about this issue ?
> > >=20
> > > I got the folowing answer from hotplug ML :=20
> > >=20
> > > Kay Sievers <kay.sievers@vrfy.org>
> > >=20
> > > The kernel driver needs to set the "struct device", to get a "devic=
e"
> > > link
> > > in sysfs pointing to the physical device, otherwise the USB devices=
 are
> > > not
> > > reachable and udev can't match.
> >=20
> > and we don't have a "struct device", because the current integration =
of
> > the Bluetooth subsystem is a class device under /sys/class. It seems =
we
> > need to wait until the /sys/device unification found its way into the
> > kernel.
>=20
> Hi all,
>=20
> thanks for the analysis and explanations. From what I have read and
> tested, here is a resum=E9 of the Logitech V270 situation :
>=20
> - Logitech ignore Linux (this is not new, but need to be repeated)
> - the V270 mouse basically works as expected HID input device, but is
> overly sensible (probably due to its high resolution)
> - the mouse events go into /dev/input/mice by default
> - if evdev is loaded, mouse events go to /dev/input/event{1..N}
> - udev doesn't have the info to create a rule in 10-local.rules so the
> V270 get mapped to a fix name like /dev/input/v270
> - none of the tools I tried (locomo, logitech-applet) know the V270 for
> now. I tried to change some of them, but failed, due to lacking know-ho=
w
> in HID/USB/etc
> - KDE control center or xset cannot reduce the mouse sensibility enough
> to make it usable (at least for my 40 years muscles control ability)
>=20
> There is some hope to make all this work, with new kernel, xorg and ude=
v
> versions. Stay tuned :-)
>=20
> Charles
--=20
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
