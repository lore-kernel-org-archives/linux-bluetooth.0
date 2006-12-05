Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Olivier =?ISO-8859-1?Q?Cr=EAte?= <tester@tester.ca>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <456FD9EE.1070000@prolly.org>
References: <1164939683.18828.24.camel@TesterBox.tester.ca>
	<456FD9EE.1070000@prolly.org>
Date: Mon, 04 Dec 2006 23:39:22 -0500
Message-Id: <1165293562.18828.70.camel@TesterBox.tester.ca>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] mx5000tools 0.1
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0611131062=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0611131062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PySmBHzQotJkl6mU6nKx"


--=-PySmBHzQotJkl6mU6nKx
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

New version:

http://dev.gentoo.org/~tester/dist/mx5000tools-0.1.1.tar.gz

I adds a daemon that translated some hid codes that are not understood
by the Linux kernel into usable ones (using uinput). And it also adds
support to display images. There is also a netpbm based function to
transform pbm files into the image format accepted by the keyboard.

Olivier


On Fri, 2006-01-12 at 02:29 -0500, Douglas Ward wrote:
> good work, i'll try it out tomorrow. maybe i can help figure out this=20
> image issue. I'd hate to be stuck in hid mode after all the searching i=20
> did to get the damn thing into hci mode though...
>=20
> Olivier Cr=EAte wrote:
> > Hi,
> >
> > I ported mx5000lib[1] .NET library to Linux and I made mx5000tools[2].=20
> >
> > It currently supports most operations that control the content of the
> > screen. Only 2 operations that SetPoint does on windows are not
> > supported, because I haven't managed to make them work. One is to
> > display images, I can decode the sent data[3], but when I try re-sendin=
g
> > the same data, it doesn't show up on the screen. The second is to chang=
e
> > the content of the menus there again, the keyboard doesn't seem to be
> > responsive to the commands that I send.
> >
> > It currently only works in HID mode because the bluez code does not yet
> > support full HID with hiddev.
> >
> > I should have a homepage and a SVN tree for it soon, I'll post the
> > address when I set it up.
> >
> >
> > [1] http://sourceforge.net/projects/mx5000lib/
> > [2] http://dev.gentoo.org/~tester/dist/mx5000tools-0.1.tar.gz
> > [3] http://dev.gentoo.org/~tester/image-drawer.c
> >
> >  =20
>=20
>=20
--=20
Olivier Cr=EAte
tester@tester.ca

--=-PySmBHzQotJkl6mU6nKx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFdPf6HTiOWk7ZorsRAphjAJwJORQKe4Dav2kSRaSWuztbCY++1wCdEaDQ
S/DDt8360ssCzIxAYqyxR2Y=
=wX3b
-----END PGP SIGNATURE-----

--=-PySmBHzQotJkl6mU6nKx--


--===============0611131062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0611131062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0611131062==--
