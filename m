Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO stuck on a Netgear WGT634U (mips)
Message-Id: <20060304024114.38d9b29f.henryk@ploetzli.ch>
In-Reply-To: <4407C5CF.6060208@xmission.com>
References: <20060303011433.c498e85e.henryk@ploetzli.ch>
	<4407C5CF.6060208@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__4_Mar_2006_02_41_14_+0100_jSZpvgMeB_D5I3JX"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 4 Mar 2006 02:41:14 +0100

--Signature=_Sat__4_Mar_2006_02_41_14_+0100_jSZpvgMeB_D5I3JX
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Thu, 02 Mar 2006 21:27:59 -0700 schrieb Brad Midgley:

> very impressive. Did you have to put a hub in place since it only has
> one usb port? The hub has often been a problem on x86. If you have to
> use a hub, try both 1.1 and 2.0.

Ah, you're right. I completely forgot about the hub. Yes, I had been
using a hub since I will need a lot of USB ports when this device is
finally doing all that it is supposed to do. However, in the meantime
I'm booting off the net (makes experimenting with kernels, etc. much
easier) and don't need it.

Unfortunately that's not it. The bevahiour is exactly the same,
regardless of whether I'm using a hub or not.

I just remembered the scotest program and tried it: Sending from the
Netgear and receiving on my Laptop works, but not the other way round.

There is also some peculiarity that I found while looking at the
problem in hcidump: hcidump -t reports the same timestamp
(16358398.715819904) for every event. Could this have something to do
with it?

I don't think the device has a rtc and I developed some sort of theory
that maybe some timer is set that won't fire or something, but I don't
know how to check that or even where to look.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sat__4_Mar_2006_02_41_14_+0100_jSZpvgMeB_D5I3JX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFECPBPvI90l8kWns8RAmmkAKCAUyVUDk9UzKK1XTqLw0XBiYpWawCgng28
LXdKzddn80ltP0n26kcMA9U=
=pPBH
-----END PGP SIGNATURE-----

--Signature=_Sat__4_Mar_2006_02_41_14_+0100_jSZpvgMeB_D5I3JX--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
