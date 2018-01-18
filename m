Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] adapter: Add CreateDevice method
Date: Thu, 18 Jan 2018 11:03:09 +0100
Message-ID: <1897310.7mTL64GuO1@ix>
In-Reply-To: <EC7FA4A5-2523-4D7F-8C0C-4CD61EDFB6A5@holtmann.org>
References: <20180111110423.14498-1-szymon.janc@codecoup.pl> <EC7FA4A5-2523-4D7F-8C0C-4CD61EDFB6A5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thursday, 18 January 2018 10:40:04 CET Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > This allows to create Device1 object without discovery. This is needed =
for
> > some of qualification tests where there is no general discovery upfront
> > and we need to do connection to device with provided address.
> >=20
> > Another usecase is for scenario where scanning happen on one controller
> > but
> > connection handling on another.
> >=20
> > Implementation wide this results in new temporary device object being
> > created that if unused will be cleanup just like it would be if found
> > during discovery session.
>=20
> so what are the rules around the cleanup? On next discovery it is gone
> again, then that might needs to be mentioned.

Those are same rules so it will be gone only if it is left temporary (ie=20
Connect() or Pair() was never called). I'll document that.

> > This patch implements bare minimum properties needed for connection -
> > address and address type. If needed eg. for non-NFC based OOB it could =
be
> > extended with more options.
> > ---
> > doc/adapter-api.txt | 29 ++++++++++++++++
> > src/adapter.c       | 96
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed,
> > 125 insertions(+)
> >=20
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index 0533b674a..c8f3ce26e 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -145,6 +145,35 @@ Methods		void StartDiscovery()
> >=20
> > 			Possible errors: None
> >=20
> > +		void CreateDevice(dict properties) [experimental]
> > +
> > +			Creates new temporary device with defined properties.
>=20
> Why is this not returning the device object path that gets created? Seems=
 a
> waste time cycles to wait for a device showing up later.

I was thinking about that too. I'll make it return object path.

> > +
> > +			Parameters that may be set in the filter dictionary
> > +			include the following:
> > +
> > +			string Address
> > +
> > +				The Bluetooth device address of the remote
> > +				device. This parameter is mandatory.
> > +
> > +			string AddressType
> > +
> > +				The Bluetooth device Address Type. This is
> > +				address type that should be used for initial
> > +				connection. If this parameter is not present
> > +				BR/EDR device is created.
> > +
> > +				Possible values:
> > +					"public" - Public address
> > +					"random" - Random address
> > +
> > +			Possible errors: org.bluez.Error.InvalidArguments
> > +					 org.bluez.Error.AlreadyExists
> > +					 org.bluez.Error.NotSupported
> > +					 org.bluez.Error.NotReady
> > +					 org.bluez.Error.Failed
> > +
>=20
> Now what I wonder is that in case of LE, this should actually trigger a
> quick scan for that device so that you get advertising data and other
> information about the device. We are missing a kernel API for such a
> targeted case and that might need fixing as well.
>=20
> In case of BR/EDR, this might should trigger a connection and SDP discove=
ry.
>=20
> Otherwise this is not an API and just a hack to create a device path obje=
ct.
> So you are essentially just doing an =E2=80=9CInjectDevice=E2=80=9D inste=
ad of anything
> real.

Maybe we should just implicitly make it connect to device? That would keep=
=20
things simple and wouldn't require any additional kernel work. If connect=20
failed we remove device.

How does it sound?

> That said, using a DiscoverDevice() method name might be more accurate.
>=20
> Regards
>=20
> Marcel


=2D-=20
pozdrawiam
Szymon Janc
