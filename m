Return-Path: <cyrus@holtmann.org>
From: Michael Terry <michael.terry@canonical.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <024a01c8d88d$5515a790$6701a8c0@freqonedev>
References: <1214593557.6131.26.camel@bongo>
	<024a01c8d88d$5515a790$6701a8c0@freqonedev>
Date: Fri, 27 Jun 2008 15:42:30 -0400
Message-Id: <1214595750.6131.32.camel@bongo>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1344705308=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1344705308==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-62zPfDdMqyeey1TgbOXf"


--=-62zPfDdMqyeey1TgbOXf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-06-27 at 14:38 -0500, David Stockwell wrote:
> Is this version working against the old DBus interface, the new, experime=
ntal interface, or does it matter?

The old DBus interface.  I don't know about the new interface.

It shouldn't matter much.  The important stuff was UI changes.  The new
dbus stuff was added in common/client, so if and when that gets ported
to our new interface overlords, my changes will too.

-mt

--=-62zPfDdMqyeey1TgbOXf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIZUKm53i2YxNrdi0RAsarAJ9KGj9wq0y04m+rRg8XdHZYlU0CKQCeIp+O
KpSFSOIUuv2qKTLDoYqXlRE=
=srEk
-----END PGP SIGNATURE-----

--=-62zPfDdMqyeey1TgbOXf--



--===============1344705308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1344705308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1344705308==--
