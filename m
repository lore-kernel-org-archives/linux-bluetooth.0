Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 1 Aug 2006 13:32:28 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060801113228.GB15098@esaurito.net>
References: <000b01c6b55b$2ec2d650$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <000b01c6b55b$2ec2d650$9d0cc70a@dlh.st.com>
Subject: Re: [Bluez-devel] Reading data on two l2cap sockets
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1532299933=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1532299933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2006 at 04:41:05PM +0530, Mayank BATRA wrote:
>=20
> Now, if I send data on sk1, the line "Got something on sk1" is printed, b=
ut if I send data on sk2, the line "Got something on sk2" is never printed.

I don't know the internals but you should really FD_SET readfds after every
select() invocation, i.e. move the readfds initialization inside the while =
loop.

filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

If there is any better use for being famous and respected than using
that status to question orthodoxy, I haven't found it yet.
-- Eric S. Raymond

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEzzvMABzeamt51AERAsreAJ4r7IdHyIaNLIOZvVIAbkfgIrFKVgCff/4p
NF7K/zqnWqwMBqikDibEh0E=
=aRVS
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--


--===============1532299933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1532299933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1532299933==--
