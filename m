Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/signed; boundary="Apple-Mail=_F7080255-A78E-45F8-9B3E-F2ED86E71423"; protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Bluez 5.18 on 3.12
From: Rick Mann <rmann@latencyzero.com>
In-Reply-To: <AE9E98E2-E507-43EC-9C1E-8464FB4F8F3C@me.com>
Date: Fri, 9 May 2014 10:30:10 -0700
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <32A2EB6D-6B9E-419B-871F-F74A1DE2B806@latencyzero.com>
References: <BC611432-5B36-4EA5-8667-082F55020330@me.com> <52C9C733-259A-427E-A857-9A291047620D@holtmann.org> <AE9E98E2-E507-43EC-9C1E-8464FB4F8F3C@me.com>
To: David Eriksson <ftslc@me.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_F7080255-A78E-45F8-9B3E-F2ED86E71423
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Look in the doc/mgmt-api notes. It's a little cryptic. I was able to run =
BLE scanning commands. You can't put it into advertising mode via the =
mgmt API (you'll have to use hcitool), and becoming a peripheral =
requires writing a plug-in (I'm going to attempt that today).

On May 9, 2014, at 08:02 , David Eriksson <ftslc@me.com> wrote:

> Thanks for info Marcel,
>=20
> Where can I read what's new/specific for the 1.4 release? =20
>=20
> I'm mainly after BLE, Hogp and passive scans.
>=20
>=20
> best David
>=20
> On 09 May 2014, at 13:06, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
>> Hi David,
>>=20
>>> Anyone here that have a feeling on how hard it would be to get bluez =
5.18+ with mgmt api running on 3.12?
>>=20
>> that should just work. Linux kernel 3.4 and later should be =
supported. I recommend at least kernel 3.9 to get mgmt API 1.3 which =
contains a bunch of fixes that we otherwise have to work around.
>>=20
>> Unless you need features from mgmt API 1.4, then you need at least =
Linux kernel 3.13.
>>=20
>> Regards
>>=20
>> Marcel
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Rick




--Apple-Mail=_F7080255-A78E-45F8-9B3E-F2ED86E71423
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNtEKIACgkQBzBA/9aDmJsn8ACcCmQIBBBJOuPhAPuzG/ZWV0Iq
P+kAnjaWkbsp4767q3VjQux8bO7/yia8
=sFEi
-----END PGP SIGNATURE-----

--Apple-Mail=_F7080255-A78E-45F8-9B3E-F2ED86E71423--
