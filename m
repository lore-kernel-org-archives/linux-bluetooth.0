Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 May 2010 13:10:10 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Christian Birchinger <joker@netswarm.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Auto trust entry remove
Message-Id: <20100524131010.631647d3.ospite@studenti.unina.it>
In-Reply-To: <20100524105659.GA19294@netswarm.net>
References: <20100524083330.GA18128@netswarm.net>
	<20100524085344.GA18433@netswarm.net>
	<20100524113122.c084d160.ospite@studenti.unina.it>
	<20100524105659.GA19294@netswarm.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__24_May_2010_13_10_10_+0200_dNi0bddvg5OI+T6W"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__24_May_2010_13_10_10_+0200_dNi0bddvg5OI+T6W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 24 May 2010 12:56:59 +0200
Christian Birchinger <joker@netswarm.net> wrote:

> On Mon, May 24, 2010 at 11:31:22AM +0200, Antonio Ospite wrote:
>=20
> First of all i know what prevented the BT HID from being added.
> The netlink plugin was disabled and that's required for this
> to work. Really stupid mistake.
>=20
> The device gets added now and for the first time i get input data
> from it.
>

Good.

> > On Mon, 24 May 2010 10:53:44 +0200
> > Christian Birchinger <joker@netswarm.net> wrote:
> >=20
> > Christian, I can only say that it works for me with the kernel patches
> > from http://lists.ozlabs.org/pipermail/cbe-oss-dev/2010-May/007274.html
> > and an updated sixaxis-cable patch which I haven't published yet
> > because it was not final and I didn't want to leave temporary stuff,
> > which could be soon deprecated, archived on the Internet; that may
> > confuse people.
>=20
> Thanks for the hint, i just patched my kernel an rebooted. This is the
> output when i plug the controller over USB:
>=20
> sony 0003:054C:0268.0007: input,hiddev96,hidraw3: USB HID v1.11 Joystick =
[Sony PLAYSTATION(R)3 Controller] on usb-0000:00:1a.0-1.3.4/input0
> sony 0003:054C:0268.0007: Calling sixaxis_set_operational_usb
> sony 0003:054C:0268.0007: Sony PS3 Controller bdaddr: <controller addr>
>=20
> So it works fine.
>

Yes.

> > Let me know if you want me to send this updated sixaxis-cable to you
> > privately.
>=20
> Yes, that would be interesting. Is there some default location to find
> the recent public release of it too? I'm alsways exctracting it from
> the Fedora srpm.
>

The one from Fedora srpm uses libusb and hence has to detach and
reattach the usbhid driver in order to work. With my patch+my
sixaxis-cable plugin libusb is not needed anymore, but I am not
publishing it because I didn't receive feedback on those kernel patches
from kernel people, and I feel that means extending hidraw should be the
way, I just haven't found the time to work on it yet. I am sending the
sixaxis-cable plugin to you in another mail just to show the concept,
don't distribute it yet, keep in mind that it should be changed to use
hidraw once I finished with this.

> Thanks a lot for your help
> Bye, Christian
>=20

You're welcome.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Mon__24_May_2010_13_10_10_+0200_dNi0bddvg5OI+T6W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkv6XpIACgkQ5xr2akVTsAEZhwCgocUNmXL8GqObXoEybyat9vtK
HT8An26srgj/5LKiotttOYG7YowDltQd
=vTPm
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2010_13_10_10_+0200_dNi0bddvg5OI+T6W--
