Return-Path: <cyrus@holtmann.org>
Subject: Re: Reaching out again for serious bug in sixaxis plugin & generic
 wireless transport with userspace daemon idea
References: <55A4BA19.6030109@gmail.com>
 <1436873556.20249.50.camel@hadess.net>
 <a59e2e07885f3ee4bcb02cf370b3ff4c.squirrel@mungewell.org>
 <55A5733E.3020207@gmail.com> <1436938182.20249.59.camel@hadess.net>
From: Sergey Kondakov <virtuousfox@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
To: simon@mungewell.org, Bastien Nocera <hadess@hadess.net>
Message-ID: <55A6119C.3020507@gmail.com>
Date: Wed, 15 Jul 2015 12:54:04 +0500
MIME-Version: 1.0
In-Reply-To: <1436938182.20249.59.camel@hadess.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9Fvb1mdO6XpGrpvAiBS25HTxpHqpwDd8x"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Fvb1mdO6XpGrpvAiBS25HTxpHqpwDd8x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.07.2015 10:52, simon@mungewell.org wrote:
> Oddly (or perhaps not) these 'funny' packets show up more frequently if=
 I
> exercise the LEDs
> --
> root@blind-fury:/sys/class/leds/0005:054C:0268.0002::sony1#
> echo heartbeat > trigger

Tried that but with usb-host instead of heartbeat (which I don't have)
and wiggling mouse (which triggers the led). At first it's gone crazy
with 2-4 the frequency but when I tried to repeat it latter it was about
the same as always... still pretty frequent, every 10-30 seconds.
Sometimes 2 in short burst (1-5 seconds) with bigger pause.

> For reference this is seen with Bluez git, kernel 4.1rc7 on Xubuntu 15.=
04.
> I am unable to use 4.2 as there's another bug affecting me.
> I did not see this on 3.19 (stock kernel for system), but will recheck =
later.
> Simon

For me it was no less than entirety of bluez5 and kernel 3.x series, if
I recall.

On 15.07.2015 10:29, Bastien Nocera wrote:
> On Wed, 2015-07-15 at 01:38 +0500, Sergey Kondakov wrote:
> ...
>=20
> I skipped over the "technically accurate, all information provided
> technical description" to the "who gives a crap what this guy says, I'm=

> not going to help him anyway".
>=20
> Which I didn't read, maybe?

Which illustrates my point exactly.

> Whatever contributions you might have made in the past, or will in the
> future, insulting people's work will only get you so far.
>=20

Ignoring glitches will diminish your work, hurt all users and make it
look for everyone precisely in a way that I described.

Imagine what happened when distributions started to move (openSUSE at
least) bluez4->bluez5 while it didn't have any GUI whatsoever and was
still quite new... with no place to even properly complain (of course
distributions would send you to upstream and do nothing themselves).
"Wanna use some BT ? Better tech-up and go on a quest !"
Some (again, openSUSE) even still disable sixaxis plugin in their
packages. And properly rebuilding packages for binary distributions is a
pain. "Wanna play some games ? Screw you !"
BT support in all OSes seem to be treated with afterthought. Windows
even didn't have its own bluetooth stack until recently, I think. I
applaud any efforts to do it properly for Linux but your own attitude
don't exactly make it any easier either.

And BT standard itself is a mess that breaks OSI, you can't deny that.
Actually, seeing how any serious wireless devices use a helper device
(usually USB transponder with direct USB connection emulation) for
transporting their data (gaming mouses, pro-headphones, "hdmi video
transmitters") makes me think that if someone would come up with
userspace drivers that would replace usual USB emulation methods for
those and allow getting and sending data directly from user's wifi card
in a secure, defined and standardized (preferably by IEEE) way then BT
may go obsolete altogether. Such implementation may even be completely
data link (or even network) neutral for compatibility with any
underlying networking type.


--9Fvb1mdO6XpGrpvAiBS25HTxpHqpwDd8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlWmEZwACgkQrPLi+0dgLobouQD/VyZu3Yd9dOnWnXY1LiUtkeTM
5iGuopSPdeuKS0MWhCAA/jDuepztKYkPaSgfGiE2Py8GElLBJ+4u/pMcoqC/pxR4
=G7gE
-----END PGP SIGNATURE-----

--9Fvb1mdO6XpGrpvAiBS25HTxpHqpwDd8x--
