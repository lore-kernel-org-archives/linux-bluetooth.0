Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
Message-Id: <20050509144808.6deef7fa.henryk@ploetzli.ch>
In-Reply-To: <427EE726.8030801@xmission.com>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	<20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
	<20050509005413.3787d2d7.henryk@ploetzli.ch>
	<1115596897.8949.79.camel@pegasus>
	<20050509025805.331c34c7.henryk@ploetzli.ch>
	<1115600627.8949.93.camel@pegasus>
	<20050509033555.12509786.henryk@ploetzli.ch>
	<427EE726.8030801@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__9_May_2005_14_48_08_+0200_c9NCsxQswXymX8MM"
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
Date: Mon, 9 May 2005 14:48:08 +0200

--Signature=_Mon__9_May_2005_14_48_08_+0200_c9NCsxQswXymX8MM
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 08 May 2005 22:29:26 -0600 schrieb Brad Midgley:

> What do you think of making this code always compile in and run but=20
> report a warning and continue if the roleswitch call fails?

Would be fine with me. It's just that I wasn't sure whether a roleswitch
would break anything else.

> I think I understand now why the bluetake expects the headset to=20
> roleswitch. If the headset's radio can't have mixed slave/master=20
> connections open (scatternet?), then it needs the roleswitch in order
> to  talk to a cellphone at the same time as the dongle. Is that right?

Ah, thanks for clearing that up. I was wondering about that all the
time, and doubt that insisting on a roleswitch is something the spec
allows.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Mon__9_May_2005_14_48_08_+0200_c9NCsxQswXymX8MM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCf1wLIjWgKE0OA2gRAgmVAKCGbnaTCYmQC3lVa8Hxv9Plnh//LgCfSveG
tntIWRAjRc1hjCHanZ5qaeU=
=Mrvm
-----END PGP SIGNATURE-----

--Signature=_Mon__9_May_2005_14_48_08_+0200_c9NCsxQswXymX8MM--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
