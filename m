Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Building btsco for Fedora 3
Message-Id: <20050515030849.266ff800.henryk@ploetzli.ch>
In-Reply-To: <42869C29.3040001@volantis.com>
References: <42869C29.3040001@volantis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__15_May_2005_03_08_49_+0200_DAuAnv6cYg+Qa0id"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 15 May 2005 03:08:48 +0200

--Signature=_Sun__15_May_2005_03_08_49_+0200_DAuAnv6cYg+Qa0id
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 15 May 2005 01:47:37 +0100 schrieb Mark Watson:

> > make[2]: Entering directory `/tmp/btsco'
> > gcc -DHAVE_CONFIG_H -I. -I. -I.    -I/usr/include -Wall -O2 -c
> > a2recv.c a2recv.c: In function `make_master':
> > a2recv.c:281: error: incompatible type for argument 2 of
> > `hci_switch_role'
>=20
> So, first question, can I get away with commenting out the relevant
> call?

Yes. This is from a2recv which you probably won't need anyways (it's for
receiving A2DP audio data) and that specific function is only a
workaround for the behaviour of the iPHONO audio dongle.

> > make: *** /lib/modules/2.6.11-1.14_FC3/source: No such file or=20
> > directory.  Stop.
>=20
> Turns out no modules source directory was installed with this kernel=20
> rpm, though it does exist for older kernels.

Hmm, can't help you with that (I'm mostly always using vanilla kernels
from kernel.org) but you will probably need the kernel sources to
compile.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__15_May_2005_03_08_49_+0200_DAuAnv6cYg+Qa0id
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFChqEmIjWgKE0OA2gRAqHNAJ4hKd3xqZ6Ur83DFTKkaP5pbNPo4wCggtrQ
eHfuxIyTkM/XqPRNIMp7ih4=
=BK9t
-----END PGP SIGNATURE-----

--Signature=_Sun__15_May_2005_03_08_49_+0200_DAuAnv6cYg+Qa0id--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
