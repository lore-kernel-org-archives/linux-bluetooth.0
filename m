Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20041123014732.3a03b10e.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Nov_2004_01_47_32_+0100_Yp/O6Dh8y4VQE+6E"
Subject: [Bluez-devel] SBC packer done, kind of
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
Date: Tue, 23 Nov 2004 01:47:32 +0100

--Signature=_Tue__23_Nov_2004_01_47_32_+0100_Yp/O6Dh8y4VQE+6E
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Ok, I'm now basically finished with sbc_pack_frame (joint stereo is not
handled yet). Though I tested it only with mono and two simple test
signals (one impulse and a sawtooth) because I can't load audio data
from files. (Marcel?)

Next thing (after joint stereo) would be some cleanup of sbc.c and
finally convertion to kernel indentation. I tried the Lindent script but
don't like what it does to the code, because most of it is nested in
some kind of for(blk ..) { for(ch ..) { for(sb ..) { ... } } } structure
and wasting a full 8 columns (out of the precious 80) for each of those
loops doesn't feel right to me.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Tue__23_Nov_2004_01_47_32_+0100_Yp/O6Dh8y4VQE+6E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBooipIjWgKE0OA2gRAqJsAKCzwbw8Wb5jGxiG07Rw8Da+uS722wCgwMAt
ZhOrZier+RwSiW2cKJtTOtc=
=DrYM
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Nov_2004_01_47_32_+0100_Yp/O6Dh8y4VQE+6E--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
