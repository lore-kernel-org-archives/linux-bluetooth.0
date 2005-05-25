Return-Path: <steve.crane@rococosoft.com>
Subject: Small fix for L2CAP MTU
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
Cc: marcel@holtmann.org, jim.oleary@rococosoft.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ktXJ5eNPC+hR8y+KCRkt"
Date: Wed, 25 May 2005 15:41:39 +0100
Message-Id: <1117032099.5854.56.camel@baroque.rococosoft.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-ktXJ5eNPC+hR8y+KCRkt
Content-Type: multipart/mixed; boundary="=-pzZr5K/9CdE3+qKbVVFQ"


--=-pzZr5K/9CdE3+qKbVVFQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
I've attached a small change to the L2CAP layer which causes it to
better adhere to a sender's choice of MTU.

The background is that we have a test here where the client asks for an
omtu of 50 and tries to send more than this to the server, which in turn
checks that only 50 bytes were sent.

With the current kernel code, the omtu is always returned as the default
MTU (672) which causes our test to fail.

I've attached a patch against 2.6.11.10 (proposed by my colleague Jim
O'Leary) which assigns omtu from that proposed by the peer, iff we don't
care about the omtu.

Thanks,
Steve
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-pzZr5K/9CdE3+qKbVVFQ
Content-Disposition: attachment; filename=l2cap.patch
Content-Type: text/x-patch; name=l2cap.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

MTM1OSwxMzY0YzEzNTksMTM2NQ0KPCAJaWYgKHBpLT5jb25mX210dSA8IHBpLT5vbXR1KSB7DQo8
IAkJbDJjYXBfYWRkX2NvbmZfb3B0KHB0ciwgTDJDQVBfQ09ORl9NVFUsIDIsIHBpLT5vbXR1KTsN
CjwgCQlyZXN1bHQgPSBMMkNBUF9DT05GX1VOQUNDRVBUOw0KPCAJfSBlbHNlIHsNCjwgCQlwaS0+
b210dSA9IHBpLT5jb25mX210dTsNCjwgCX0NCi0tLQ0KPiAJaWYgKHBpLT5vbXR1ID09IDApIHsN
Cj4gCQkvKiBJZiB3ZSBkb24ndCBjYXJlIGFib3V0IHRoZSBNVFUsIHVzZSBwZWVyJ3MgcHJvcG9z
YWwgKi8NCj4gICAgICAgICAgICAgICAgIHBpLT5vbXR1ID0gcGktPmNvbmZfbXR1Ow0KPiAJfSBl
bHNlIGlmIChwaS0+Y29uZl9tdHUgPCBwaS0+b210dSkgew0KPiAgICAgICAgICAgICAgICAgbDJj
YXBfYWRkX2NvbmZfb3B0KHB0ciwgTDJDQVBfQ09ORl9NVFUsIDIsIHBpLT5vbXR1KTsNCj4gICAg
ICAgICAgICAgICAgIHJlc3VsdCA9IEwyQ0FQX0NPTkZfVU5BQ0NFUFQ7DQo+ICAgICAgICAgfQ0K



--=-pzZr5K/9CdE3+qKbVVFQ--

--=-ktXJ5eNPC+hR8y+KCRkt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBClI6jlgMqgVzLyWcRApI1AJ9lS0yfQi+Iipb2qJks8aQkE6Gb/QCeIc9e
eJxvHDs5Ls2AjSLi72D+hGQ=
=3Hj9
-----END PGP SIGNATURE-----

--=-ktXJ5eNPC+hR8y+KCRkt--
