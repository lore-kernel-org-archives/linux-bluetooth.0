Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco under FC3
Message-Id: <20050107120154.424e0927.henryk@ploetzli.ch>
In-Reply-To: <5256d0b05010622152c32d3f4@mail.gmail.com>
References: <5256d0b05010520461ad68ff3@mail.gmail.com>
	<1105014278.4299.19.camel@pegasus>
	<5256d0b05010622152c32d3f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__7_Jan_2005_12_01_54_+0100_nBrZn//oOBoQpK8Z"
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
Date: Fri, 7 Jan 2005 12:01:54 +0100

--Signature=_Fri__7_Jan_2005_12_01_54_+0100_nBrZn//oOBoQpK8Z
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Fri, 7 Jan 2005 14:15:44 +0800 schrieb Peter Robinson:

> As seen below it detects the device, the voice settings and connects
> with a RFCOMM channel but then it just sits there. I end up just
> putting it into the background and try running the varoius examples.
> Output of all included below. I get no sound at all. any ideas or
> suggestions?

You did press the connect button on the headset, did you?

> [root@trinity btsco]# btsco 00:07:A4:0E:69:3D
...
> [1]+ btsco 00:07:A4:0E:69:3D &
> [root@trinity btsco]# mpg123 --au -
> /home/audio/mp3/green_day/american_idiot/green_day-boulevard_of_broke
> n_dreams.mp3
> | sbc/sbcenc - | ./a2play 00:07:A4:0E:69:3D

That is not supposed to work. btsco (the program) and a2play are two
different things. You should only be able to use one of them at any
one time, if a2play works for you at all (which it doesn't, as the
HS-810 can't do A2DP).

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Fri__7_Jan_2005_12_01_54_+0100_nBrZn//oOBoQpK8Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB3mwnIjWgKE0OA2gRAnQ/AJ9RxuLPiiyLP12KxS8z5/GhQtTGWgCg5e4q
0T/+yWiSJVrCvKCRy/1fpzw=
=467X
-----END PGP SIGNATURE-----

--Signature=_Fri__7_Jan_2005_12_01_54_+0100_nBrZn//oOBoQpK8Z--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
