Return-Path: <cyrus@holtmann.org>
From: Michael Terry <michael.terry@canonical.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1215613690.26958.2.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
	<1214831713.6764.8.camel@bongo>
	<1214834796.11537.42.camel@violet.holtmann.net>
	<1214841475.6764.37.camel@bongo>
	<1214841780.11537.48.camel@violet.holtmann.net>
	<1214852035.6764.40.camel@bongo>
	<1214874653.11537.69.camel@violet.holtmann.net>
	<1215613690.26958.2.camel@bongo>
Date: Tue, 19 Aug 2008 13:33:20 -0400
Message-Id: <1219167200.8387.5.camel@bongo>
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
Content-Type: multipart/mixed; boundary="===============0810905399=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0810905399==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-E3hrosYUSmRn+5aHpx6h"


--=-E3hrosYUSmRn+5aHpx6h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Poke!

This has been languishing here for a over a month.  Could it please get rev=
iewed, so I can post the rest of the wizard patches?

-mt

On Wed, 2008-07-09 at 10:28 -0400, Michael Terry wrote:
> Hello, Marcel.
>=20
> On Tue, 2008-07-01 at 03:10 +0200, Marcel Holtmann wrote:
> > please only change create_bonding and leave the others alone. Also you
> > cast a little bit too much for my taste. For example void pointers
> > need
> > to extra cast.
>=20
> Attached is callback3.diff which only modifies create_bonding.
>=20
> I'm not sure which casts you felt were unnecessary.  I don't think I
> cast any void pointers.
>=20
> -mt
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> _______________________________________________ Bluez-devel mailing list =
Bluez-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listi=
nfo/bluez-devel

--=-E3hrosYUSmRn+5aHpx6h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIqwPg53i2YxNrdi0RAvZ3AKDfGxRUslliAIhcsfSsONCENu8tlQCeObAA
zsi/Gb850YIeDgoyCJ/9U9U=
=ciXj
-----END PGP SIGNATURE-----

--=-E3hrosYUSmRn+5aHpx6h--



--===============0810905399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0810905399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0810905399==--
