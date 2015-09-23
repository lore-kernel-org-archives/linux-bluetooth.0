Return-Path: <cyrus@holtmann.org>
From: <Trey_Ramsay@Dell.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <Arulnambi_Raju@Dell.com>,
	<jamuraa@google.com>
Date: Wed, 23 Sep 2015 11:53:05 -0500
Subject: RE: BlueZ - LGPL dependency with GPL headers and sources
Message-ID: <E43CE124327DEB448881DE4DD408A8A323E81207EF@AUSX7MCPS308.AMER.DELL.COM>
References: <E43CE124327DEB448881DE4DD408A8A323E808BAD1@AUSX7MCPS308.AMER.DELL.COM>
	<6E7C05F9-DAAE-4AC1-B735-BB7B2E8D333B@holtmann.org>
	<E43CE124327DEB448881DE4DD408A8A323E808C1E9@AUSX7MCPS308.AMER.DELL.COM>
 <CABBYNZKzsqzKHoViQp4Y8OZigWzjwH5O+b2zZ5Q6b=3wZYqyLw@mail.gmail.com>
In-Reply-To: <CABBYNZKzsqzKHoViQp4Y8OZigWzjwH5O+b2zZ5Q6b=3wZYqyLw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi,
>=20
> +Marie
>=20
> On Mon, Sep 21, 2015 at 8:58 PM, wrote:
> >> Hi Trey,
> >>
> >> > We are making a BLE only product for embedded system and cannot use
> >> the whole bluez package due to lack of resources. We noticed that the
> >> BLE specific code (src/shared) is licensed under LGPL and we are
> >> trying to leverage the code as a shared library for our proprietary
> >> source BLE application, similar to btgatt-server tool. While
> >> compiling, we noticed the LPGL code has a dependency with the
> >> following header and source files which are licensed as GPL.
> >> >
> >> > lib/bluetooth.h
> >> > lib/hci.h
> >> > lib/mgmt..h
> >> > lib/uuid.c
> >> > lib/uuid.h
> >> > src/shared/ad.c
> >> > src/shared/ad.h
> >> >
> >> > Are there plans to make the above files LGPL or LGPL compatible?
> >>
> >> the src/shared/ad.[ch] is actually a mistake. No code under GPL
> >> should have been accepted into src/shared/ directory. That code is
> >> intentionally kept LGPL only.
> >>
> >> > Are there any plans in the future to remove the GPL dependencies
> >> > from
> >> the LGPL code?
> >>
> >> The lib/uuid.[ch] is pretty old code and not really nicely abstracted
> >> in the first place. However it has been used to speed up the
> >> development of the GATT support. The plan is actually to replace that
> >> with a new implementation src/shared/uuid.[ch] under LGPL that nicely
> integrates.
> >>
> > How soon will this happen? Do you need any help making this LGPL code?
>=20
> I guess we need to consent of the authors to change the ad.c.
>=20
> @Marie: Do you agree to change to LGPL (I suppose this was a mistake in t=
he
> first place)? If you do, could you please send a patch to changing it?

We also need uuid.[ch]

Hi Marcel,
How soon will it be to replace lib/uuid.[ch] with the LGPL implementations =
in src/shared/uuid[ch]?

>=20
> >> The other three are just a bunch of defines or structs. However they
> >> are kernel defines and structs and should be most likely come
> >> directly from the kernel as UAPI. However we have never gotten around
> it to clean these up.
> >> Some of this is part of the old libbluetooth (which is still internall=
y
> required).
> >> We are talking about 13 year old code here.
> >>
> > Do you mean that it is ok for us to use the lib/*.h files even though i=
t's
> licensed as GPL?
> > The kernel headers are not exactly the same and may not be able to
> compile with the bluez package.
> >
> >> Regards
> >>
> >> Marcel
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --
> Luiz Augusto von Dentz
