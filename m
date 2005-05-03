Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
Message-Id: <20050503193204.3c102fe5.henryk@ploetzli.ch>
In-Reply-To: <20050503132023.39036.qmail@web8306.mail.in.yahoo.com>
References: <20050501172156.0ab4ad2a.henryk@ploetzli.ch>
	<20050503132023.39036.qmail@web8306.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__3_May_2005_19_32_04_+0200_eExNVgxkZeEDM4Lu"
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
Date: Tue, 3 May 2005 19:32:04 +0200

--Signature=_Tue__3_May_2005_19_32_04_+0200_eExNVgxkZeEDM4Lu
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 3 May 2005 14:20:23 +0100 (BST) schrieb Mayank Batra:

> If the source is sending me sbc file encoded from pcm
> file that was in big endian format, and i have an
> audio device that supports only little-endian format,
> then don't u think that i need to patch the sbc.c file
> when the data field is being filled ?????

No. Inside the SBC stream the endianess is clearly defined (as much
endianess as is left) and as long as the encoder got it right on the
encoding side you will be fine. The endianess that comes out of the
decoder has mostly nothing to do with SBC but only with what the
programmer wants.=20

So yes, we'd either have to define the interface so that our
decoder/encoder only generates/accepts big or little endian data and it
is up to the application to convert as necessary, or that choice must be
made a runtime configurable parameter of the functions.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Tue__3_May_2005_19_32_04_+0200_eExNVgxkZeEDM4Lu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCd7WZIjWgKE0OA2gRAoPtAJ9fRCHcgsM1rOdjAswmjSczY73LswCfSjuy
8OFv642omFeMY/gHbK0wgLQ=
=vAGP
-----END PGP SIGNATURE-----

--Signature=_Tue__3_May_2005_19_32_04_+0200_eExNVgxkZeEDM4Lu--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
