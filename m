Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP sink code finally
Message-Id: <20050501171637.412450f8.henryk@ploetzli.ch>
In-Reply-To: <20050426123412.48950.qmail@web8310.mail.in.yahoo.com>
References: <20050426123412.48950.qmail@web8310.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__1_May_2005_17_16_37_+0200_U.hh+h_pH9he2R0p"
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
Date: Sun, 1 May 2005 17:16:37 +0200

--Signature=_Sun__1_May_2005_17_16_37_+0200_U.hh+h_pH9he2R0p
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 26 Apr 2005 13:34:12 +0100 (BST) schrieb Mayank Batra:

> > Hmm, how do I test that? I can't seem to get my
> > audio dongle to connect.

Ah, stupid me. I forgot to enable pairing mode on the audio dongle.

> > Is there anything else I've got to do apart from=20
> > | hciconfig hci0 class 0x200404
>=20
> Don't know whether this is required...?

Seems so. After doing

> > | sdptool add A2SNK
> > | ./a2snk

_and_ enabling pairing on the audio dongle nothing happened. But as soon
as I changed my device class the audio dongle started a connection. Now
a2snk stalls after "Sent Stream End Point Discovery Response".

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__1_May_2005_17_16_37_+0200_U.hh+h_pH9he2R0p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCdPLYIjWgKE0OA2gRArDdAKCyqxFm5hKXRajM5JZlRqhY0uxBJACcDfyD
/orr2fXEFrfyB2stySbMc6g=
=uHN5
-----END PGP SIGNATURE-----

--Signature=_Sun__1_May_2005_17_16_37_+0200_U.hh+h_pH9he2R0p--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
