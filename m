Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
Message-Id: <20041125112509.75347786.henryk@ploetzli.ch>
In-Reply-To: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__25_Nov_2004_11_25_09_+0100_cRnxBwLPUGuXxb4W"
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
Date: Thu, 25 Nov 2004 11:25:09 +0100

--Signature=_Thu__25_Nov_2004_11_25_09_+0100_cRnxBwLPUGuXxb4W
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Thu, 25 Nov 2004 18:11:24 +0900 schrieb Alain Volmat:

> Well, it didn't work well, it seems to fail during the
> connection/configuration phase. Since I never heared you speaking
> about this headset I think you might be interested in the several log
> I took (just ask me if you want some other info).

Oh yes, we are. Seems your headset even is the first I've seen that
supports more than only media transport plus sbc codec: It announces a
Content Protection capability, namely SCMS-T (whatever that may be).

> got capabilities response
> sent set_config

Try again now. a2play is still very crude with regards to the
configuration setup and it seems you found a hard coded value: Your
headset only supports a bitpool size between 0x04 and 0x40 while the
others can do 0x02 to 0xFA and that was what a2play was trying to
configure. I made a trivial modification to simply mirror the values the
headsets sends back.=20

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Thu__25_Nov_2004_11_25_09_+0100_cRnxBwLPUGuXxb4W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpbMIIjWgKE0OA2gRAheAAJ42t2MRcw9b6vnVVj/9tcuMs4dYcACfcWor
goKIcflmkcFKNUPeIgMxxhI=
=wW/4
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Nov_2004_11_25_09_+0100_cRnxBwLPUGuXxb4W--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
