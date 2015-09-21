Return-Path: <cyrus@holtmann.org>
From: <Trey_Ramsay@Dell.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <Arulnambi_Raju@Dell.com>
Date: Mon, 21 Sep 2015 12:58:00 -0500
Subject: RE: BlueZ - LGPL dependency with GPL headers and sources
Message-ID: <E43CE124327DEB448881DE4DD408A8A323E808C1E9@AUSX7MCPS308.AMER.DELL.COM>
References: <E43CE124327DEB448881DE4DD408A8A323E808BAD1@AUSX7MCPS308.AMER.DELL.COM>
 <6E7C05F9-DAAE-4AC1-B735-BB7B2E8D333B@holtmann.org>
In-Reply-To: <6E7C05F9-DAAE-4AC1-B735-BB7B2E8D333B@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Trey,
>=20
> > We are making a BLE only product for embedded system and cannot use
> the whole bluez package due to lack of resources. We noticed that the BLE
> specific code (src/shared) is licensed under LGPL and we are trying to
> leverage the code as a shared library for our proprietary source BLE
> application, similar to btgatt-server tool. While compiling, we noticed t=
he
> LPGL code has a dependency with the following header and source files
> which are licensed as GPL.
> >
> > lib/bluetooth.h
> > lib/hci.h
> > lib/mgmt..h
> > lib/uuid.c
> > lib/uuid.h
> > src/shared/ad.c
> > src/shared/ad.h
> >
> > Are there plans to make the above files LGPL or LGPL compatible?
>=20
> the src/shared/ad.[ch] is actually a mistake. No code under GPL should ha=
ve
> been accepted into src/shared/ directory. That code is intentionally kept
> LGPL only.
>=20
> > Are there any plans in the future to remove the GPL dependencies from
> the LGPL code?
>=20
> The lib/uuid.[ch] is pretty old code and not really nicely abstracted in =
the first
> place. However it has been used to speed up the development of the GATT
> support. The plan is actually to replace that with a new implementation
> src/shared/uuid.[ch] under LGPL that nicely integrates.
>=20
How soon will this happen?  Do you need any help making this LGPL code?

> The other three are just a bunch of defines or structs. However they are
> kernel defines and structs and should be most likely come directly from t=
he
> kernel as UAPI. However we have never gotten around it to clean these up.
> Some of this is part of the old libbluetooth (which is still internally r=
equired).
> We are talking about 13 year old code here.
>=20
Do you mean that it is ok for us to use the lib/*.h  files even though it's=
 licensed as GPL?
The kernel headers are not exactly the same and may not be able to compile =
with the bluez package.

> Regards
>=20
> Marcel
