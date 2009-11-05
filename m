Return-Path: <cyrus@holtmann.org>
Message-ID: <4AF32308.3060400@dell.com>
Date: Thu, 05 Nov 2009 13:10:00 -0600
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
CC: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: hid2hci rules breaks standard USB dell mouses
References: <4AE18EA3.50701@pardus.org.tr>	<4AE1E1E8.3080902@dell.com>	<1256373518.7812.1.camel@localhost.localdomain>	<4AE7651C.7010809@dell.com> <20091028093118.71e8f55c@strolchi.home.s3e.de>
In-Reply-To: <20091028093118.71e8f55c@strolchi.home.s3e.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB09D0FA8D4EE2B5899E4CA8A"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB09D0FA8D4EE2B5899E4CA8A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stefan:

Stefan Seyfried wrote:
> On Tue, 27 Oct 2009 16:24:44 -0500
> Mario Limonciello <mario_limonciello@dell.com> wrote:
>
> Maybe a compromise for the near future:
> * update the rules / tools in bluez to be in sync with udev
> * don't install them by default unless "--enable-old-udev" (or
>   something like that) is ./configure'd
>
> Reasoning:
> * people might want to use new bluez with old udev (I personally would
>   avoid updating udev in a running system since it seems to interdepend=

>   on many things. Updating bluez has been painless for me over the last=

>   years).
>
> Marcel, Mario, does this sound acceptable? If yes, I am willing to
> prepare a patch.
>  =20
Since Marcel doesn't seem keen on my dropping support in BlueZ for
hid2hci (the patch has been ignored twice now), i'm fine with this.

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigB09D0FA8D4EE2B5899E4CA8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkrzIwgACgkQ2CrZjkA73YtfsQCgkWshjAjmzm6zQa5J9nGYOL66
8ogAni7NZUJPtrLLwhhaVgtznVfg8xlY
=x24t
-----END PGP SIGNATURE-----

--------------enigB09D0FA8D4EE2B5899E4CA8A--
