Return-Path: <cyrus@holtmann.org>
Message-ID: <4A9FEBD1.4090107@dell.com>
Date: Thu, 03 Sep 2009 11:16:17 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: =?UTF-8?B?RGVubmlzIEJqw7Zya2x1bmQ=?= <db@zigo.dhs.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez killed my dell mouse
References: <9d6d1f835a39000a57424074f0ad2fc9.squirrel@zigo.org>
In-Reply-To: <9d6d1f835a39000a57424074f0ad2fc9.squirrel@zigo.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F5057E7AE217BBF9A319AEC"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F5057E7AE217BBF9A319AEC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Dennis:

Dennis Bj=C3=B6rklund wrote:
> With the latest version of bluez my mouse no longer work. I noticed thi=
s
> when my fedora 11 installation got a new version of bluez and then my
> mouse didn't work anymore.
>
> I found that in scripts/bluetooth-hid2hci.rules there is a rule like th=
is:
>
> ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"413c", ENV{ID_CLASS}=3D=3D"mous=
e",
> ATTRS{bmAttributes}=3D=3D"e0", KERNEL=3D=3D"mouse*", RUN+=3D"/usr/sbin/=
hid2hci
> --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
>
> that seem to be the problem. When I remove it I can use the mouse again=
=2E
> The mouse is a Dell USB mouse with vendor id 413c and product id 3010.
>
>  =20
Please test with the hid2hci binary and rules from udev.  The ones from
bluez are outdated and several deficiencies like these were identified.

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig8F5057E7AE217BBF9A319AEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqf69QACgkQ2CrZjkA73YsQpQCffwBhokvaP/ubwfz/lkMasTNC
WsQAoJy77TqxKolHCFMobHPtZqILtlI9
=i2Ma
-----END PGP SIGNATURE-----

--------------enig8F5057E7AE217BBF9A319AEC--
