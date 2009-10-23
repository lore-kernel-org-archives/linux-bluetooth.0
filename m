Return-Path: <cyrus@holtmann.org>
Message-ID: <4AE1E1E8.3080902@dell.com>
Date: Fri, 23 Oct 2009 12:03:36 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: hid2hci rules breaks standard USB dell mouses
References: <4AE18EA3.50701@pardus.org.tr>
In-Reply-To: <4AE18EA3.50701@pardus.org.tr>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0FD07A4198BDDA2EB563AC6"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0FD07A4198BDDA2EB563AC6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Don't use the rules and tool in bluez, they're broke.

Use the rules in udev.

Ozan =C3=87a=C4=9Flayan wrote:
> https://bugzilla.novell.com/show_bug.cgi?id=3D522287
>
> It seems that the rules matches some other devices than hid proxies
> trying to switch them to HCI mode causing the mouse to be nonfunctional=
=2E
>
> Just wanted to report it the correct list for a correct solution.
>
> Regards,
> Ozan Caglayan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigE0FD07A4198BDDA2EB563AC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkrh4egACgkQ2CrZjkA73Yt+CgCdFKtlnD9sKFhXxaMolSpnICvi
sBgAoIfEPxmd53nmeqCk+gEp3v9PZqgM
=aSHA
-----END PGP SIGNATURE-----

--------------enigE0FD07A4198BDDA2EB563AC6--
