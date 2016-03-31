Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1459443653.22297.7.camel@intelfx.name>
Subject: Fallout from commit 70fdb77 "audio/avrcp: Fix not always requesting
 capabilities"
From: Ivan Shapovalov <intelfx@intelfx.name>
Reply-To: intelfx@intelfx.name
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Thu, 31 Mar 2016 20:00:53 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lGXOPKPlJyTgoDFxbJnK"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-lGXOPKPlJyTgoDFxbJnK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The commit 70fdb7 "audio/avrcp: Fix not always requesting capabilities"
introduced a series of bugs where the code thinks that session-
>controller->player cannot be NULL, but in fact it can be so. The first
one was fixed in 177d27 "audio/avrcp: Fix crash when connecting to controll=
ers", but there remain multiple code pathes via avrcp_register_notification=
() -> callback -> avrcp_handle_event() -> avrcp_{status,track,playback_pos,=
settings,uids}_changed() where session->controller->player may be dereferen=
ced.

I'm unsure how to fix that properly (either not register notifications,
or ignore specific callbacks if s->c->player is NULL), so I'm just
reporting this.

Ref.:=C2=A0https://bugs.archlinux.org/task/48644

--=20
Ivan Shapovalov / intelfx /


Please Cc: me on replies as I'm not subscribed to the list.
--=-lGXOPKPlJyTgoDFxbJnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW/VfFAAoJEHveF8jk4w6ddgMP/1yfcCMuPnLtNRueStT08JTg
WqFGYQollGmi8DvVxymEol1twB8F+A0rAJPxxNdxjIpooAWg/M2JmevdVNED+8b0
2uSslwKwo1OoF0gJKciiE2Po0D4WKTIaDAFbNYB5p0oWq9KzGPqSiC8aIDho/OS8
PZ7M1WebaWH6C1TEXpOHIwmJp3ZTZrr/ibKYjkXKAQJMYNxab4h4nLHmg6odG6YT
qArqH3lwq2U5gr5jLIPp3cXGfrJaoMU7EN8j9oQzAbeEz3/Oshu1EEV7H+ehBuw9
j4qb4nzgE5c8HM/69u9z4UwXmfWP/pUs8uutKz0e5LCT47Co70qrKBuEH8RZ74f2
7SA5hB1Yk4RG7WUCcgnFUSwzoW58wuDBfFeCrZa26WtTUafsTXyHBe/HlcbcNDvf
4/iy34W8Oselukt4q99YKCQD/ovzC0VPIXCX++DDATfjUDg91gvszFlJj7K8Bs55
EUNvSlP3UAwa29CY6oxDMnEEe8xQeLYA1j1znAWeDM8IDD6SICAmM146PLaaG0FM
msLTtJ5SP0CWa67rJKr58R1MqkVdMXWCdfISYvuZYMCPxPBty9KnAHLmGhlBbLFm
cEttk9Yaz6V91I4kxQGknzNrrTsHcok3OohOscDfCRnMJ8PAl3B4ewcCFwjTdtip
0ZY28dZsNyuTK8JlwDwW
=QQEt
-----END PGP SIGNATURE-----

--=-lGXOPKPlJyTgoDFxbJnK--

