Return-Path: <cyrus@holtmann.org>
From: Florian Echtler <floe@butterbrot.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1221203646.4280.5.camel@bernd.floe.gotdns.org>
References: <1220904984.8005.8.camel@pancake.floe.gotdns.org>
	<1220906328.24928.9.camel@cookie.hadess.net>
	<1221203646.4280.5.camel@bernd.floe.gotdns.org>
Date: Fri, 12 Sep 2008 09:22:47 +0200
Message-Id: <1221204167.4280.8.camel@bernd.floe.gotdns.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Can't connect to Trust Bluetooth mouse..
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0699999958=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0699999958==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/a5I7rVFBdmsNVhz/DgF"


--=-/a5I7rVFBdmsNVhz/DgF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> And nothing else anymore, even after I click the connect button. Just an
> empty window labeled "connecting to device..", but nothing else happens
> (especially no bluetooth communication). In the console,
> bluetooth-properties shows:
>=20
> ** (bluetooth-properties:7171): CRITICAL **: dbus_g_proxy_begin_call:
> assertion `DBUS_IS_G_PROXY (proxy)' failed
>=20
> So I'm getting suspicious that this is in fact a DBus problem.. any
> ideas?
P.S. When I try to connect from the command line (using the commands
from http://wiki.bluez.org/wiki/HOWTO/InputDevices), the connection and
the mouse work! So I'm starting to get really confused now, the problem
seems to be in bluetooth-properties itself.. ?

Yours, Florian

--=-/a5I7rVFBdmsNVhz/DgF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjKGMcACgkQ7CzyshGvathGCACgladd3I0y3lI58stNJ4mxeJqz
9zUAoKZvWIf3x/Ob+1MXNJjwG0uesrmF
=FOn1
-----END PGP SIGNATURE-----

--=-/a5I7rVFBdmsNVhz/DgF--



--===============0699999958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0699999958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0699999958==--
