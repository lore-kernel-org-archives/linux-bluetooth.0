Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4479225C.9090809@trn.iki.fi>
Date: Sun, 28 May 2006 07:09:00 +0300
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVu?= <tronic+bdtmwkm6@trn.iki.fi>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] rfcomm disconnects + hcid dying
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1259608133=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1259608133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB60A7E998003C60E4069A985"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB60A7E998003C60E4069A985
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Who is responsible for these parts? Why am I getting no replies to this
mail? Are any developers reading this list? Where should I send this, to
developers' private addresses or something?

Reposting, third time:


PROBLEM 1:

Whenever /dev/rfcomm0 (or rfcomm1) is closed, the corresponding Bluetooth=

device gets disconnected and I have to run hcitool cc xx:xx:xx:xx:xx:xx t=
o
get it working again. How can I have the devices automatically connected
at all times whenever they are within reach and the USB BT dongle is
plugged in?

My current workaround is an endless while loop that runs hcitool cc all
the time, but this is obviously quite ugly. It works, but I'd really want=

to have something more elegant.


PROBLEM 2:

My hcid keeps dying occassionally. I don't know why, but it just does
that. My current workaround is to have the init system restart it wheneve=
r
it dies, but this, too, is somewhat ugly. Haven't found any messages abou=
t
that in the logs yet, but that is partly because my log was flooded with
other stuff.


- Tronic -



--------------enigB60A7E998003C60E4069A985
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEeSJgOBbAI1NE8/ERAoRJAKCqNoReh7TVvrCuU9KaIP8qqfVqBwCfdpk6
1Mt35b8BozGaAmd8zLNB3TY=
=qM8F
-----END PGP SIGNATURE-----

--------------enigB60A7E998003C60E4069A985--


--===============1259608133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1259608133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1259608133==--
