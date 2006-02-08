Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] udev rules entry for bluetooth mouse
From: Charles Bueche <charles@bueche.ch>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1139351059.22790.63.camel@localhost>
References: <1138872805.21953.20.camel@bluez.bueche.ch>
	 <43E1E11F.8040501@ycom.ch>  <1138880751.21953.38.camel@bluez.bueche.ch>
	 <1139331334.12556.3.camel@pc-05.ycom.ch>
	 <1139351059.22790.63.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1139411355.8712.24.camel@bluez.bueche.ch>
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
Date: Wed, 08 Feb 2006 16:09:15 +0100

On mar, 2006-02-07 at 23:24 +0100, Marcel Holtmann wrote:
> Hi Alexandre,
>=20
> > > Did you contact the hotplug team about this issue ?
> >=20
> > I got the folowing answer from hotplug ML :=20
> >=20
> > Kay Sievers <kay.sievers@vrfy.org>
> >=20
> > The kernel driver needs to set the "struct device", to get a "device"
> > link
> > in sysfs pointing to the physical device, otherwise the USB devices a=
re
> > not
> > reachable and udev can't match.
>=20
> and we don't have a "struct device", because the current integration of
> the Bluetooth subsystem is a class device under /sys/class. It seems we
> need to wait until the /sys/device unification found its way into the
> kernel.

Hi all,

thanks for the analysis and explanations. From what I have read and
tested, here is a resum=E9 of the Logitech V270 situation :

- Logitech ignore Linux (this is not new, but need to be repeated)
- the V270 mouse basically works as expected HID input device, but is
overly sensible (probably due to its high resolution)
- the mouse events go into /dev/input/mice by default
- if evdev is loaded, mouse events go to /dev/input/event{1..N}
- udev doesn't have the info to create a rule in 10-local.rules so the
V270 get mapped to a fix name like /dev/input/v270
- none of the tools I tried (locomo, logitech-applet) know the V270 for
now. I tried to change some of them, but failed, due to lacking know-how
in HID/USB/etc
- KDE control center or xset cannot reduce the mouse sensibility enough
to make it usuable (at least for my 40 years muscles control ability)

There is some hope to make all this work, with new kernel, xorg and udev
versions. Stay tuned :-)

Charles
--=20
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
