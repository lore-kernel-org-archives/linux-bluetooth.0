Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
Message-Id: <20050509033555.12509786.henryk@ploetzli.ch>
In-Reply-To: <1115600627.8949.93.camel@pegasus>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	<20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
	<20050509005413.3787d2d7.henryk@ploetzli.ch>
	<1115596897.8949.79.camel@pegasus>
	<20050509025805.331c34c7.henryk@ploetzli.ch>
	<1115600627.8949.93.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__9_May_2005_03_35_55_+0200_lR7xeKrzN=YjGM4r"
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
Date: Mon, 9 May 2005 03:35:55 +0200

--Signature=_Mon__9_May_2005_03_35_55_+0200_lR7xeKrzN=YjGM4r
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Mon, 09 May 2005 03:03:47 +0200 schrieb Marcel Holtmann:

> you must do it on the HCI level at the correct time. Look at the
> function hci_switch_role() for more details.

Ah, thanks, that does it. I copied and adapted the relevant code from
hcitool.c and it works like a charm. Problem is: When trying to do the
roleswitch the program can only run as root, which is not exactly what
I want. I committed it to cvs anyways, but it is #ifdef'd out. Compile
with -DROLESWITCH to use it.

This also gives nice insights as the audio dongle is not always sending
packets with the same size. They vary from 82 bytes to 634 (at least
that are the sizes I've seen up to now.)

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Mon__9_May_2005_03_35_55_+0200_lR7xeKrzN=YjGM4r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCfr5/IjWgKE0OA2gRAj2ZAKDAT3edahjerGk1Twu2hJbFngYwRACg8ia/
+jyulFgq/FSOb6th9/0WGtg=
=0AQ5
-----END PGP SIGNATURE-----

--Signature=_Mon__9_May_2005_03_35_55_+0200_lR7xeKrzN=YjGM4r--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
