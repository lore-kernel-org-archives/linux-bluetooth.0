Return-Path: <cyrus@holtmann.org>
Subject: Re: Logitec MX5500 Bluetooth Version mismatch causing
 non-connectivity, workaround found
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Glenn Phillips <glenn@coriolis-storm.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <CAJD6O4+-e73hB1ody_cq-38HwF9p2ESQwQDAY-io_7bzHz3nFQ@mail.gmail.com>
References: <CAJD6O4KmmdrTLSj6Kj2PThFnkaFpcHp6y51b6a-LGygPw94e3g@mail.gmail.com>
	 <CAJD6O4+-e73hB1ody_cq-38HwF9p2ESQwQDAY-io_7bzHz3nFQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Qdjqn4fX/HRGeQzla/H2"
Date: Fri, 09 Sep 2011 21:10:45 +0200
Message-ID: <1315595445.29906.1.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Qdjqn4fX/HRGeQzla/H2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 09-09-2011 a las 11:22 -0700, Glenn Phillips escribi=C3=B3:
> On Fri, Sep 9, 2011 at 11:07 AM, Glenn Phillips
> <glenn@coriolis-storm.com> wrote:
>=20
>     Hello, I have recently become aware of and have since experienced
> some issues with my Logitec MX 5500 BT Kb/mouse combo.  After some
> recent updates to my Sabayon linux(gentoo) system I have been unable
> to use my Keyboard without modifying my udev rules.
>     I have generated a bug report on our bugzilla already here:
> http://bugs.sabayon.org/process_bug.cgi
>=20
>     Link to /var/log/messages output http://pastebin.sabayon.org/pastie/7=
014
>     and link to my workaround:
> http://ubuntuforums.org/archive/index.php/t-1466806.html
>=20
>     However I do not believe this is a good solution as this may break
> other Logitec devices that rely on bluetooth functionality rather than
> being able to fall back on usb only.
>=20
>     current version of bluez - 4.96-r1
>     previous working version - 4.93
>=20
>     Thank you
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Looks like:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/658471

summarizes your problem

--=-Qdjqn4fX/HRGeQzla/H2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk5qZLUACgkQCaWpQKGI+9SlhQCeKxpabN9bv2YYfZwfTPsTFJLK
BPAAn36+e3i1ziEaZ0+ynr2xqY2qMYhN
=lMmH
-----END PGP SIGNATURE-----

--=-Qdjqn4fX/HRGeQzla/H2--

