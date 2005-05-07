Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] yes, a2dp timing is whacked
Message-Id: <20050507031314.548afb03.henryk@ploetzli.ch>
In-Reply-To: <42792979.90109@xmission.com>
References: <42792979.90109@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__7_May_2005_03_13_14_+0200_w2TQ6oEkpKAGqAg."
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
Date: Sat, 7 May 2005 03:13:14 +0200

--Signature=_Sat__7_May_2005_03_13_14_+0200_w2TQ6oEkpKAGqAg.
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Wed, 04 May 2005 13:58:49 -0600 schrieb Brad Midgley:

> Maybe for convenience, libsbc should compute the timeslice for the
> frame.

It does now. I added a function sbc_time(sbc_t *sbc) which computes the
microseconds for one frame. I then replaced the fixed value in a2play's
usleep() call with the time the whole packet should take to play (time
for one frame times number of frames in the packet) multiplied by
(arbitrarily chosen) 0.8 to make up for the time lost with computing and
sending.

> I will start by looking at the rtc interface and trying to find hooks
> in alsa for timing.

That would be really cool.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sat__7_May_2005_03_13_14_+0200_w2TQ6oEkpKAGqAg.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCfBYtIjWgKE0OA2gRAsznAJ9cC32DeJu/FM/agfFT0vu02nrE2QCgplms
VeTfOLDPp9i8EJf6fypnZN8=
=jqvP
-----END PGP SIGNATURE-----

--Signature=_Sat__7_May_2005_03_13_14_+0200_w2TQ6oEkpKAGqAg.--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
