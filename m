Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC packer done, kind of
Message-Id: <20041123204901.776fe240.henryk@ploetzli.ch>
In-Reply-To: <1101201897.26578.54.camel@pegasus>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	<1101191260.26578.43.camel@pegasus>
	<20041123074829.7f978ce7.henryk@ploetzli.ch>
	<1101201897.26578.54.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Nov_2004_20_49_01_+0100_AFR7DgszJgbeB3XD"
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
Date: Tue, 23 Nov 2004 20:49:01 +0100

--Signature=_Tue__23_Nov_2004_20_49_01_+0100_AFR7DgszJgbeB3XD
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 23 Nov 2004 10:24:57 +0100 schrieb Marcel Holtmann:

> However it does not work as expected, but if you accept some noise you
> will get some results. I used these commands for testing:

Yes, the values sbclib.c puts into frame.pcm_sample don't look right.

If you don't have any objections I'll rename sbcdec as sbcplay (that's
more descriptive of what it does) and try to come up with an sbcenc and
sbcdec based on the audio file library
http://freshmeat.net/projects/audiofilelibrary

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Tue__23_Nov_2004_20_49_01_+0100_AFR7DgszJgbeB3XD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBo5QyIjWgKE0OA2gRApZnAKDDR1SI1Es6cTDZOtbAIBfVRgqJYgCgvr+p
S2u8EanLWVp87KELfvdmVbk=
=kc39
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Nov_2004_20_49_01_+0100_AFR7DgszJgbeB3XD--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
