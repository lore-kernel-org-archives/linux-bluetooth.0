Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/signed; boundary="Apple-Mail=_9F68419B-4428-41DC-A602-4EFB7668EF49"; protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: BLE connection failing
From: Rick Mann <rmann@latencyzero.com>
In-Reply-To: <7BB1715C-A0F8-4F74-B0D4-D4CD353962BA@holtmann.org>
Date: Mon, 12 May 2014 19:51:57 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C4C34379-64F0-479E-8581-A4BDB32D24A3@latencyzero.com>
References: <B473A0F2-765A-47EC-950F-69FAF659504B@latencyzero.com> <9ED33F2C-C3EF-41D7-8559-C04F1E6CE21D@holtmann.org> <7E32DBFD-3A61-4126-8B8F-71E1E3D395EB@latencyzero.com> <7BB1715C-A0F8-4F74-B0D4-D4CD353962BA@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_9F68419B-4428-41DC-A602-4EFB7668EF49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On May 12, 2014, at 19:22 , Marcel Holtmann <marcel@holtmann.org> wrote:

> the kernel does way more than just sending the HCI command. It does =
tracking of the connections and also re-enabling of advertising when =
needed. If you are stuck with 3.10 kernel, then do not bother with LE =
peripheral role. It makes no sense.

Others have led me to believe I should be able to do this, just can't =
enable advertising via the mgmt interface. I can re-enable advertising =
if I need to.

What do you mean "tracking of the connections?"

--=20
Rick




--Apple-Mail=_9F68419B-4428-41DC-A602-4EFB7668EF49
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNxiM0ACgkQBzBA/9aDmJspLACfTg7FDgXIFlEXLBsfJLjNzSfy
SagAoPwpNnWSoKgY8KDemzt2RX9yh66t
=gJjk
-----END PGP SIGNATURE-----

--Apple-Mail=_9F68419B-4428-41DC-A602-4EFB7668EF49--
