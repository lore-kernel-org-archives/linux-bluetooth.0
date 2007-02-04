Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-Id: <200702041313.l14DDs5v002728@zini.netego.de>
MIME-Version: 1.0
From: "Florian Schaefer" <listbox@netego.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun,  4 Feb 2007 14:13:49 +0100
In-Reply-To: <200701281844.l0SIiEWQ001697@zini.netego.de>
References: <E1HAsSn-0000V7-5M@washu.netego.de><E1HBB3Y-0000YF-QI@washu.netego.de>
	<45BCB900.8080807@xmission.com><E1HBCVn-0000ZC-Ts@washu.netego.de>
	<45BCD97E.5030909@xmission.com>
	<200701281844.l0SIiEWQ001697@zini.netego.de>
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
Content-Type: multipart/mixed; boundary="===============0870920512=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0870920512==
Content-Type: multipart/signed;
	boundary="---=------==-----------=======-=-==-=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Disposition: inline

-----=------==-----------=======-=-==-=-=-=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everybody!

On Sun, 28 Jan 2007 19:44:06 +0100, Florian Schaefer said:

[...]
> On Sun, 28 Jan 2007 10:12:30 -0700, Brad Midgley said:
>=20
> > > Yes, it is. Therefore I' prefer not to buy and attach an external one.
> > > Would somehow beat the purpose of using a bt headset...
> >=20
> > I can understand this. As far as I know broadcom hasn't helped Marcel
> > and that's part of the reason it's hit-or-miss with different revs of
> > their hardware.
>=20
> Somehow I still don't want to give up --- yet. What are the symptoms with
> those revs that won't work? Is this counting down of the
> bt_headset->hw_ptr to zero with a stall afterward typical?
>=20
> I've read about some patches for the 2.6.20 kernel. Is there anything in
> there that might be helpful?

Just for the record: It turned out that my Broadcom bluetooth does work
after all. I just had to make sure, that the hci_usb modules gets loaded
with the force_scofix option the _first time_ it gets loaded after a new
system start.=20

This old btsco method works fine then. The newer headsetd doesn't work
that good however. All I get to hear is a rather deep distorted,
disrupted sound, as if is is played with a much too low sample rate.
However, those sounds don't seem to depend on the file I play, therefore
I rule a frequency problem out.

Ciao
Florian


-----=------==-----------=======-=-==-=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Get my DSA key from: www.netego.de/hpc?p=download&l=en

iD8DBQBFxdwR+2lxodi1OoURAljmAKCKPFk/Rk0SHSuQ9PdbMQHAU91FNgCdGsxh
3GR9G408jOvGLW/3jJPLJAk=
=xIN7
-----END PGP SIGNATURE-----

-----=------==-----------=======-=-==-=-=-=--



--===============0870920512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0870920512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0870920512==--
