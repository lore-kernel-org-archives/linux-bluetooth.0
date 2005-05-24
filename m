Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How to turn off Discoverable?
Message-Id: <20050524195429.2b08788a.henryk@ploetzli.ch>
In-Reply-To: <AC1F8662-8C37-4138-8C33-5E0AAEFE96CA@pepper.com>
References: <AC1F8662-8C37-4138-8C33-5E0AAEFE96CA@pepper.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__24_May_2005_19_54_29_+0200_hMOIw2W1vclxn/aw"
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
Date: Tue, 24 May 2005 19:54:29 +0200

--Signature=_Tue__24_May_2005_19_54_29_+0200_hMOIw2W1vclxn/aw
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 24 May 2005 13:37:32 -0400 schrieb Michael Frey:

> Is there an hciconfig command to make my bluetooth module not =20
> "Discoverable"?

Yes. "Discoverable" in Bluetooth terms is called "inquiry scan", so
hciconfig hciX pscan will disable inquiry scan and make your module not
discoverable. (Attention: The seemingly similar page scan means
"connectable" and without it you won't be able to accept new
connections, so better not disable that.)

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Tue__24_May_2005_19_54_29_+0200_hMOIw2W1vclxn/aw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCk2peIjWgKE0OA2gRAoNDAJ44oqz7FH5B4JP5Q9Fu8XHxkzvuvgCfRywA
4xvi8qqilHqG8odWvzyDu0g=
=hDJL
-----END PGP SIGNATURE-----

--Signature=_Tue__24_May_2005_19_54_29_+0200_hMOIw2W1vclxn/aw--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
