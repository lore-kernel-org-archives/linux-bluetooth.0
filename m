Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
From: "Florian Schaefer" <listbox@netego.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 28 Jan 2007 17:04:10 +0100
In-Reply-To: <45BCB900.8080807@xmission.com>
References: <E1HAsSn-0000V7-5M@washu.netego.de>
	<E1HBB3Y-0000YF-QI@washu.netego.de> <45BCB900.8080807@xmission.com>
Message-Id: <E1HBCVn-0000ZC-Ts@washu.netego.de>
Subject: Re: [Bluez-devel] aplay freezes with headsetd
Reply-To: Florian Schaefer <listbox@netego.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2004352398=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2004352398==
Content-Type: multipart/signed;
	boundary="---=---==-==-----=--=--==-==--===-=--=---";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Disposition: inline

-----=---==-==-----=--=--==-==--===-=--=---
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Brad,

On Sun, 28 Jan 2007 07:53:52 -0700, Brad Midgley said:

> > I already tried to load hci_usb via "modprobe hci_usb force_scofix" as
> > advised by the contact website but that didn't change anything. I'm usi=
ng
> > linux kernel 2.6.19 with the "plugz/patches/sco-flowcontrol-v3.0.diff"
> > patches here.
> >=20
> > Does anyone have positive or negative experiences with this Broadcom
> > adapter?
> > Anything else I might try?
>=20
> you've tried with and without force_scofix then?

Yep. As far as I could see absolutely nothing changed by this.

> There are still some broadcom adapters that no one has gotten to work. I
> haven't been keeping track... it would be nice if we had a list.
>=20
> Is this an internal adapter you're stuck with?

Yes, it is. Therefore I' prefer not to buy and attach an external one.
Would somehow beat the purpose of using a bt headset...

> btw did you apply the flow control kernel patch?

What patch do you mean? I'm using a vanilla 2.6.19 with just the
sco-flowcontrol-v3.0 patch from the bluetooth-alsa cvs. Is there anything
else I should try?

Ciao
Florian=


-----=---==-==-----=--=--==-==--===-=--=---
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Get my DSA key from: www.netego.de/hpc?p=download&l=en

iD8DBQBFvMl6+2lxodi1OoURAninAJsGX4g/1X5Hg+okFy3SH7HJjqrEVgCeIkIW
aKWoz6VJPVhDJWfKg1i9W1Q=
=Gulk
-----END PGP SIGNATURE-----

-----=---==-==-----=--=--==-==--===-=--=-----



--===============2004352398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2004352398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2004352398==--
