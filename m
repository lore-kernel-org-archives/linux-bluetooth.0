Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC packer done, kind of
Message-Id: <20041124213730.46aefcb7.henryk@ploetzli.ch>
In-Reply-To: <1101307146.27351.104.camel@pegasus>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	<1101191260.26578.43.camel@pegasus>
	<20041123074829.7f978ce7.henryk@ploetzli.ch>
	<1101201897.26578.54.camel@pegasus>
	<20041123204901.776fe240.henryk@ploetzli.ch>
	<1101243809.27351.18.camel@pegasus>
	<20041124042114.5e1fee94.henryk@ploetzli.ch>
	<1101272477.27351.67.camel@pegasus>
	<41A43E8A.8030602@xmission.com>
	<1101307146.27351.104.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__24_Nov_2004_21_37_30_+0100_dtV+UR0lbsG3AbLI"
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
Date: Wed, 24 Nov 2004 21:37:30 +0100

--Signature=_Wed__24_Nov_2004_21_37_30_+0100_dtV+UR0lbsG3AbLI
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Wed, 24 Nov 2004 15:39:06 +0100 schrieb Marcel Holtmann:

> > a2play will also accept '-' for stdin now. you should try it to see
> > if my latest change makes it work for your headset.

Brad, you're brilliant. a2play started working for me this morning.

And Marcel, so are you: Now I can do
sox foo.ogg -r 44100 -s -w -t au - | sbc/sbcenc - | ./a2play <bdaddr> -

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Wed__24_Nov_2004_21_37_30_+0100_dtV+UR0lbsG3AbLI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpPEPIjWgKE0OA2gRAvqCAKDMtWv4VKX+RM8r+RAFVr90Exg0FQCgkdTw
PQ5J6/1uDI3Uau0jUXywQF4=
=v4g9
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Nov_2004_21_37_30_+0100_dtV+UR0lbsG3AbLI--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
