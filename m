Return-Path: <daryl@vanvorst.org>
From: "Daryl Van Vorst" <daryl@vanvorst.org>
To: "'James Courtier-Dutton'" <James@superbug.demon.co.uk>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Siegfried Lehmann'" <Siegfried.Lehmann@CetecomUSA.com>, "'Benjamin Ko'" <Benjamin.Ko@CetecomUSA.com>
Subject: RE: [Bluez-devel] Qualification testing - rfcomm
Date: Tue, 8 Jul 2003 16:23:12 -0700
Message-ID: <000201c345a7$e6a3df20$d5b5160a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <3F0B3BE8.10008@superbug.demon.co.uk>
List-ID: <bluez-devel.lists.sourceforge.net>

James,

Unfortunately I'm not going to be of much help with SCO testing...  We've
been doing our testing with Cetecom (they're on the CC list).

It may be possible for you to arrange something with them if you (or someon=
e
else) are making a product. Contact Ben Ko (benjamin.ko@CetecomUSA.com) if
you'd like to discuss it.

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> James Courtier-Dutton
> Sent: July 8, 2003 2:47 PM
> To: Daryl Van Vorst
> Cc: BlueZ Mailing List; 'Marcel Holtmann'
> Subject: Re: [Bluez-devel] Qualification testing - rfcomm
>=20
>=20
> Daryl Van Vorst wrote:
> > Marcel,
> >=20
> > Finally got some results on those latest rfcomm changes for=20
> > qualification. Looks like there are a few more problems. :(=20
>  But we're=20
> > close. :)
> >=20
> > TP/RFC/BV-09-C:
> > "Verify that the IUT handles flow control correctly when=20
> the Tester,=20
> > acting as a device conforming to Bluetooth version 1.0B,=20
> controls the=20
> > data flow using the Modem Status Command. The IUT's device=20
> role is of=20
> > no importance."
> >=20
> > The command and console output:
> >=20
> > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > rctest[351]: Connected
> > rctest[351]: Sending ...
> > rctest[351]: Send failed. Resource temporarily unavailable(11)
> >=20
> > The IUT sends data in 5 frames, then stops for aboue 20s,=20
> then sends 5=20
> > more, then stops, etc. Technically, this test passed because we did=20
> > stop sending data after the tester send MSC stop to the IUT. But=20
> > something's clearly not right.
> >=20
> > There is an hcidump of the session attached.
> >=20
> > TP/RFC/BV-12-C:
> > "Verify that the IUT handles aggregate flow control=20
> correctly when the=20
> > Tester, acting as a device conforming to Bleutooth version 1.0B,=20
> > controls the data flow using the Flow Control on/off=20
> commands FCon and=20
> > FCoff. The IUT's device role is of no importance."
> >=20
> > The command and console output:
> >=20
> > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > rctest[362]: Connected
> > rctest[362]: Sending ...
> > rfcomm_recv_mcc: Unknown control type 0x18
> > rfcomm_recv_mcc: Unknown control type 0x28
> >=20
> > The IUT does not respond to FCoff with FCoff, and continues sending=20
> > data. It also does not respond to FCon with FCon.
> >=20
> > There is an hcidump of the session attached.
> >=20
> > -Daryl.
>=20
> Any chance of doing some tests with SCO ?
> It might help us with some of the currently problems there=20
> are with SCO=20
> and usb dongles.
> Cheers
> James
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.=20
> www.parasoft.com/bulletproofapps=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/b> luez-devel
>=20
