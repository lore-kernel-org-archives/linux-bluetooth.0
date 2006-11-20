Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Olivier =?ISO-8859-1?Q?Cr=EAte?= <tester@tester.ca>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1163882230.3025.18.camel@TesterBox.tester.ca>
References: <1163882230.3025.18.camel@TesterBox.tester.ca>
Date: Mon, 20 Nov 2006 09:58:31 -0500
Message-Id: <1164034711.7762.8.camel@TesterBox.tester.ca>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Hiddev support
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1842001984=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1842001984==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Pmlan/f6KOzGwMYNLFV8"


--=-Pmlan/f6KOzGwMYNLFV8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

> > I recently got a logitech mx5000 bluetooth desktop. I got it to work
> > with bluez without too many problems (with the CVS hid2hci). It seems t=
o
> > behave mostly like the bluetooth dinovo. I also want to control the
> > display and use the special keys. But they are carried in hidp input
> > reports of type 3 (what the bluetooth hid spec calls "features"). I
> > looked at the 2.6.18-mh7 patch and it has support for full HID or at
> > least a way to get/send reports from userspace, but it seems that hidde=
v
> > has been removed from it? Why? Also, can't the HID code just be shared
> > with the USB version since its essentially the same anmd you'd get free
> > hiddev. There are events comments in the HID code saying it should be
> > independant from USB, might be a good occasion to do it.
>=20
> this is work in progress and I have seen some nice patches for sharing
> the HID layer between USB and Bluetooth. We will also have a feature
> that might be called hidraw to directly access the HID reports. So
> please stay tuned.

This is really nice, is there a public cvs/svn/git tree somewhere ? I've
been porting mx5000lib [1] to C and hiddev (while running in HID mode)
and it seems that I'm missing some of the information that's probably
not sent in proper format.=20

[1] http://sourceforge.net/projects/mx5000lib/
=20
P.S. lists.sf.net's mailman isn't letting me subscribe, so please keep me i=
n CC
--=20
Olivier Cr=EAte
tester@tester.ca

--=-Pmlan/f6KOzGwMYNLFV8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFYcKVHTiOWk7ZorsRAiuZAJ0dZudk8j6fuiE6VSfg1ST6w0XVJgCeNyB6
cg3AGLh/T9hfgCRmuLDAIAE=
=VBzu
-----END PGP SIGNATURE-----

--=-Pmlan/f6KOzGwMYNLFV8--


--===============1842001984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1842001984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1842001984==--
