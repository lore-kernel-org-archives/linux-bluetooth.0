Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
Message-Id: <20041123033429.132bf84b.henryk@ploetzli.ch>
In-Reply-To: <41A234FA.7020303@xmission.com>
References: <41A22C0B.4050008@xmission.com>
	<41A234FA.7020303@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Nov_2004_03_34_29_+0100_ysCOMC7Tu+mYZ7.t"
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
Date: Tue, 23 Nov 2004 03:34:29 +0100

--Signature=_Tue__23_Nov_2004_03_34_29_+0100_ysCOMC7Tu+mYZ7.t
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Hmm, If I'm not mistaken a2play has even other problems. I tried to play
sbc_test_01.sbc (for a start) through it while doing hcidump -x (the
old hcidump, that is). When doing the set configuration hcidump said

< ACL data: handle 0x002b flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 0
      04 04 01 00 07 06 00 00 81 86 02 FA=20

which decodes as
ACP SEID =3D 1 (OK)
INT SEID =3D 1 (OK)
Media transport capability (OK)
Media Codec capability
	Audio (OK)
	SBC   (OK)
	Sampling frequency =3D 16kHz (should be 48)
	Channel mode =3D Joint stereo (should be mono)
	Block length =3D 4 (should be 16)
	Subbands =3D 8 (should be 4)
	Allocation method =3D SNR (OK)
	Bitspool =3D 2 to 250 (OK)

As you can see the only correct parameter (apart from the hardwired
ones) is the allocation method. All others seem to be kind of bit
reversed. As a side note: The new hcidump AVDTP parser has the same
problem.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Tue__23_Nov_2004_03_34_29_+0100_ysCOMC7Tu+mYZ7.t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBoqG5IjWgKE0OA2gRAtVDAJ98YeaiuV2wbAWNpAUDE0gLF72ASgCg67TC
ML+8KNP1aB92bzfWP9i/wBQ=
=+Zqo
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Nov_2004_03_34_29_+0100_ysCOMC7Tu+mYZ7.t--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
