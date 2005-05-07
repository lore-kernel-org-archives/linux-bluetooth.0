Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] yes, a2dp timing is whacked
Message-Id: <20050507222047.430774e9.henryk@ploetzli.ch>
In-Reply-To: <1115494053.9031.15.camel@pegasus>
References: <42792979.90109@xmission.com>
	<20050507031314.548afb03.henryk@ploetzli.ch>
	<1115429201.9031.5.camel@pegasus>
	<1115494053.9031.15.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__7_May_2005_22_20_47_+0200_AJAGHW_Ypfke3uf/"
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
Date: Sat, 7 May 2005 22:20:47 +0200

--Signature=_Sat__7_May_2005_22_20_47_+0200_AJAGHW_Ypfke3uf/
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sat, 07 May 2005 21:27:33 +0200 schrieb Marcel Holtmann:

> forget about this stupid idea. I tried it and it is not working out.

I didn't like it either.

> So the best thing is too encode two or three full AVDTP frames in
> advance and have them ready to send. The sending can't be controlled
> be usleep(). We need a time that kicks in every whatever msec and
> makes us to transmit the next frame.

That's what I would favour. According to the libc manual setitimer()
would be the function of choice, if nobody else has a better idea (RTC,
anyone?).

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sat__7_May_2005_22_20_47_+0200_AJAGHW_Ypfke3uf/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCfSMnIjWgKE0OA2gRAnBnAJ4pSI0ycbWpM6kLtv8cfn54DG+gYQCeJcbO
d3S0ZGTyLWExRyd5LY1wG2c=
=DL4P
-----END PGP SIGNATURE-----

--Signature=_Sat__7_May_2005_22_20_47_+0200_AJAGHW_Ypfke3uf/--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
