Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-Id: <200701281844.l0SIiEWQ001697@zini.netego.de>
MIME-Version: 1.0
From: "Florian Schaefer" <listbox@netego.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 28 Jan 2007 19:44:06 +0100
In-Reply-To: <45BCD97E.5030909@xmission.com>
References: <E1HAsSn-0000V7-5M@washu.netego.de>
	<E1HBB3Y-0000YF-QI@washu.netego.de> <45BCB900.8080807@xmission.com>
	<E1HBCVn-0000ZC-Ts@washu.netego.de> <45BCD97E.5030909@xmission.com>
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
Content-Type: multipart/mixed; boundary="===============0355165206=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0355165206==
Content-Type: multipart/signed;
	boundary="--==-=-==-==-==--=---====-===---=--=-==--";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Disposition: inline

----==-=-==-==-==--=---====-===---=--=-==--
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Brad

On Sun, 28 Jan 2007 10:12:30 -0700, Brad Midgley said:

> > Yes, it is. Therefore I' prefer not to buy and attach an external one.
> > Would somehow beat the purpose of using a bt headset...
>=20
> I can understand this. As far as I know broadcom hasn't helped Marcel
> and that's part of the reason it's hit-or-miss with different revs of
> their hardware.

Somehow I still don't want to give up --- yet. What are the symptoms with
those revs that won't work? Is this counting down of the
bt_headset->hw_ptr to zero with a stall afterward typical?

I've read about some patches for the 2.6.20 kernel. Is there anything in
there that might be helpful?

> > What patch do you mean? I'm using a vanilla 2.6.19 with just the
> > sco-flowcontrol-v3.0 patch from the bluetooth-alsa cvs. Is there anythi=
ng
> > else I should try?
>=20
> that's the right one. It doesn't help your broadcom issue though.

Seemingly.

Ciao
Florian


----==-=-==-==-==--=---====-===---=--=-==--
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Get my DSA key from: www.netego.de/hpc?p=download&l=en

iD8DBQBFvO79+2lxodi1OoURAoAiAJ9fv27nC7N1v4eMd0Ae2CFoyWQeQwCeOu8g
r52p6jusY8djWMThl1SFaeA=
=G5pd
-----END PGP SIGNATURE-----

----==-=-==-==-==--=---====-===---=--=-==----



--===============0355165206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0355165206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0355165206==--
