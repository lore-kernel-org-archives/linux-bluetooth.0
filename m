Return-Path: <fmvel@rnl.ist.utl.pt>
Subject: Re: [Bluez-users] Linux-2.6, Zaapa USB Dongle - can't find near
	devices
From: Filipe Veloza <fmvel@rnl.ist.utl.pt>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1086434730.16316.82.camel@pegasus>
References: <1086372047.8985.14.camel@castle.budism.pt>
	 <200406042022.58589.cijoml@volny.cz>  <1086374092.4424.24.camel@pegasus>
	 <1086434351.6274.2.camel@castle.budism.pt>
	 <1086434730.16316.82.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ER51wnWuHTCQUttRCGCc"
Message-Id: <1086534124.9206.2.camel@castle.budism.pt>
Mime-Version: 1.0
Date: Sun, 06 Jun 2004 16:02:04 +0100
List-ID: <bluez-users.lists.sourceforge.net>


--=-ER51wnWuHTCQUttRCGCc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Apperently now I can bring the device up ( maybe the command was worng
:P SORRY ). but there's still something that's doesn't feel right but
that would be another issue.

This is solved thanks for the help ppl.

I take the chance to annouce ( if anyone is interested ) I got a linux
box l2ping with a Nokia Ngage mogile using a Zaapa USB dongle.

Maybe you can add to the support page in order to help others finding
this info.

On Sat, 2004-06-05 at 12:25, Marcel Holtmann wrote:
> Hi Filipe,
>=20
> > here goes anyway :P
> >=20
> > [~]hciconfig -a
> > hci0:   Type: USB
> >         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
> >         DOWN
> >         RX bytes:0 acl:0 sco:0 events:0 errors:0
> >         TX bytes:0 acl:0 sco:0 commands:0 errors:0
> >         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >         Packet type: DM1 DH1 HV1
> >         Link policy:
> >         Link mode: SLAVE ACCEPT
>=20
> you said you've tried to bring up the device. Try again, because
> "hciconfig hci0 up" should bring it at least up.
>=20
> If it still fails look at dmesg or the syslog for any errors.
>=20
> > T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12 =
 MxCh=3D 0
> > D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D 8 #Cfgs=3D  =
1
> > P:  Vendor=3D0b7a ProdID=3D07d0 Rev=3D 1.34
> > S:  SerialNumber=3D3E402C78
> > C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D100mA
> > I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 Driv=
er=3Dhci_usb
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D1ms
> > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > I:  If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driv=
er=3D(none)
>=20
> You are right this is a Zeevo chip, but it is the old TC2001. I don't
> know if it helps, but try 2.6.6-mh3 or at 2.6.7-rc2-bk5.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> >From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
--=20
Filipe Veloza <fmvel@rnl.ist.utl.pt>

PGP ( ID:0xB8ED711C SERVER:pgp.mit.edu )

--=-ER51wnWuHTCQUttRCGCc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAwzHsjygwsrjtcRwRAkytAKCLHB11pSuRpdrGCa8HM/Cai0UQQwCgp//Z
7MnP0+JmGu2kE+29yEJAhcc=
=MFip
-----END PGP SIGNATURE-----

--=-ER51wnWuHTCQUttRCGCc--
