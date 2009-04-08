Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Apr 2009 12:17:30 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Message-ID: <20090408161729.GD18671@hungrycats.org>
References: <200904041636.25409.gene.heskett@verizon.net> <20090407200201.GA18671@hungrycats.org> <1239145518.20817.915.camel@cookie.hadess.net> <200904081106.11442.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
In-Reply-To: <200904081106.11442.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2009 at 11:06:11AM -0400, Gene Heskett wrote:
> >Or you can use gnome-bluetooth which has those problems fixed.
> >
> If you are referring to 'bluetooth-wizard', it will not show me a device.=
  I'm=20
> told it will not show devices which are already paired.

gnome-bluetooth is a fork of bluez-gnome.  You'd probably have to build it =
out
of svn at svn://svn.gnome.org/svn/gnome-bluetooth unless someone's making
binary packages somewhere.

> I get what I assume is the same message from a:
>=20
> [root@coyote test]#  ./simple-agent hci0 00:0C:84:00:86:F8
> Creating device failed: org.bluez.Error.AlreadyExists: Bonding already ex=
ists
>=20
> I just found /var/lib/bluetooth/11:11:11:11:11:11 which has a group of sm=
all=20
> files in it, 2 or 3 being subjected to an updated timestamp (data in thes=
e=20
> files is kept in GMT).
>=20
> Is this the directory I need to mv someplace in order to rerun the blueto=
oth-
> wizard?  Ok, did that, bluetooth-wizard did show me the device, but then =
the=20
> pin screen only showed for an almost subliminal time & then reported that=
 it=20
> failed.
>=20
> That generated a new /var/lib/bluetooth tree, so I nuked that, and ran=20
> "simple-agent hci0 <bdaddr of this dongle>"
> That asked me for just one PIN and I gave it the default of 0000.  No err=
ors.
> And a new /var/lib/bluetooth tree was created.
>=20
> An l2ping <bdaddr of remote>
> Ping: 00:0C:84:00:86:F8 from 11:11:11:11:11:11 (data size 44) ...
> 4 bytes from 00:0C:84:00:86:F8 id 0 time 16.93ms
> 4 bytes from 00:0C:84:00:86:F8 id 1 time 10.86ms
> 4 bytes from 00:0C:84:00:86:F8 id 2 time 27.87ms
> 4 bytes from 00:0C:84:00:86:F8 id 3 time 28.87ms
> 4 bytes from 00:0C:84:00:86:F8 id 4 time 25.93ms
> 4 bytes from 00:0C:84:00:86:F8 id 5 time 25.89ms
>=20
> Is this normal?

All of that looks good.  Do you have a line in /var/lib/bluetooth/*/linkkeys
that looks like:

00:12:47:00:00:01 547603D831DB77377F203B74921E2F1A 0 4

(with a different bdaddr and key value, of course ;).

Actually it might be a good idea to post /var/lib/bluetooth/*/* here.  It
will contain the information that bluetoothd grabs at pairing time that is
often unavailable from utilities like sdptool later.

> But a second minicom -s, check to see the serial port is /dev/rfcomm0, wh=
ich=20
> does exist, select exit to minicom's main screen and it exits, reporting:
> minicom: cannot open /dev/rfcomm0: No route to host

And that doesn't.

> So that is where I am at.  Last Saturday morning it Just Worked(TM) witho=
ut=20
> all this hassle.  I would like it to work again.  What is the next=20
> troubleshooting step here?, I'll go at your pace this time.

Did you manage to get at the configuration variables of the eb101 from the
Coco3 side?  It looks like it's working (you can pair with it and ping it)
but somehow it has been configured to reject serial port connections.

Maybe the Coco3 is asserting a modem control line that makes the eb101 think
it should be offline?

> To those who suggested I use cu, or screen:  I don't have a cu, and 'scre=
en'=20
> cannot open any device I've named.  From a lengthy read of the manpage,=
=20
> 'screen' is a VT100 terminal, but without the ability to work with anythi=
ng=20
> but the local system, so I don't see as it could be useful here.

If you run 'screen /dev/rfcomm0' it will open a window on /dev/rfcomm0.
For a real serial port you may need something like=20
'screen /dev/ttyS0 9600 cs8 -parenb'.  It's a fairly minimal terminal
program which doesn't mess around trying to send modem AT commands or
assert modem control lines unnecessarily.

> I'll go see if I can find this cu.  Thanks everybody.

'cu' is part of 'uucp'.  On Debian it's packaged separately, on other
systems you'll need the rest of the uucp package as well.  It's a fairly
minimalist terminal program that I used to use for serial consoles
on headless systems and embedded devices, until I discovered that the
functionality was built into screen.


--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknczhkACgkQgfmLGlazG5xMLwCguCqPmPQEyDbD3tse8DRt10j/
83oAoM7zXv5XclewAawagAnQvMFaDLUq
=4dXR
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
