Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sandro Weiser <sandro.weiser@gmx.de>
Reply-To: sandro.weiser@gmx.de
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT mouse disconnect
References: <200406201934.30037.sandro.weiser@gmx.de> <1087756769.4781.44.camel@pegasus>
In-Reply-To: <1087756769.4781.44.camel@pegasus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200406210029.58265.sandro.weiser@gmx.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 21 Jun 2004 00:29:56 +0200

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> May you wanna try to start hidd with the --timeout option and set your
> own value that is shorter than the timeout value of the mouse. My list
> says that it uses a timeout of 11 minutes. Maybe you wanna try eight
> minutes. In the case we terminate the connection everything should work
> fine.
I already tried with -t 0 and -t 999999 but none of them solved the problem=
=2E=20
After your email I tried -t 8 and now it works as expected.

thx
Sandro

=2D --=20
Sandro Weiser <Sandro.Weiser@gmx.de>
=46ingerprint: 77E0 7C87 4DB2 6BBB 5419  343C 7995 1C67 25B9 CBF1
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1g/keZUcZyW5y/ERAmtHAJ9TNlPIvto1cErz0t3pcUeMtVRouACZARGL
ubA0VjNEULwTGvKdHYUM3m8=3D
=3Djaqd
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
