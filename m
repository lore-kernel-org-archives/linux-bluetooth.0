Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC code cleanup
Message-Id: <20041128182342.21ade782.henryk@ploetzli.ch>
In-Reply-To: <1101620847.18467.19.camel@pegasus>
References: <1101592165.27074.31.camel@pegasus>
	<20041128053245.4608f749.henryk@ploetzli.ch>
	<1101620847.18467.19.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__28_Nov_2004_18_23_42_+0100_/XM0C+xzwYU4lqS7"
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
Date: Sun, 28 Nov 2004 18:23:42 +0100

--Signature=_Sun__28_Nov_2004_18_23_42_+0100_/XM0C+xzwYU4lqS7
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 28 Nov 2004 06:47:27 +0100 schrieb Marcel Holtmann:

> I hope that we get no performance problems with this cleanups.

I planned to test that anyways.

> The decoder is working for me. I tried it before I checked in my
> changes.

Hmm, you're right. I checked out the old version that I knew was working
and as that didn't work either (while sbctest _did_ work) I concluded
that simply the sound output was broken.

Hmm, somehow it stops working after some time (that is: I only get noise
on the speakers) and if I simply play any file in xmms (a second or so
will suffice) it works again ... for a couple of seconds.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__28_Nov_2004_18_23_42_+0100_/XM0C+xzwYU4lqS7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBqgmjIjWgKE0OA2gRArgaAKDnFD0IIMfYIFaxFK9F50sdP4my4wCggmDZ
Z6ryoWQN/PkeCEnEZwnpaTw=
=HD9R
-----END PGP SIGNATURE-----

--Signature=_Sun__28_Nov_2004_18_23_42_+0100_/XM0C+xzwYU4lqS7--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
