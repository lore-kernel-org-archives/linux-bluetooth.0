Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] adapter: Add CreateDevice method
Date: Thu, 18 Jan 2018 11:30:14 +0100
Message-ID: <2439708.yFJDkdrmWr@ix>
In-Reply-To: <A8D2C45F-7004-407A-A071-6FE72310A2E7@holtmann.org>
References: <20180111110423.14498-1-szymon.janc@codecoup.pl> <740C529E-266F-4791-96A8-80E65ADD163D@holtmann.org> <A8D2C45F-7004-407A-A071-6FE72310A2E7@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thursday, 18 January 2018 11:20:03 CET Marcel Holtmann wrote:
> Hi Szymon,
>=20
> >>>> This allows to create Device1 object without discovery. This is need=
ed
> >>>> for
> >>>> some of qualification tests where there is no general discovery upfr=
ont
> >>>> and we need to do connection to device with provided address.
> >>>>=20
> >>>> Another usecase is for scenario where scanning happen on one control=
ler
> >>>> but
> >>>> connection handling on another.
> >>>>=20
> >>>> Implementation wide this results in new temporary device object being
> >>>> created that if unused will be cleanup just like it would be if found
> >>>> during discovery session.
> >>>=20
> >>> so what are the rules around the cleanup? On next discovery it is gone
> >>> again, then that might needs to be mentioned.
> >>=20
> >> Those are same rules so it will be gone only if it is left temporary (=
ie
> >> Connect() or Pair() was never called). I'll document that.
> >>=20
> >>>> This patch implements bare minimum properties needed for connection -
> >>>> address and address type. If needed eg. for non-NFC based OOB it cou=
ld
> >>>> be
> >>>> extended with more options.
> >>>> ---
> >>>> doc/adapter-api.txt | 29 ++++++++++++++++
> >>>> src/adapter.c       | 96
> >>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++ 2 files change=
d,
> >>>> 125 insertions(+)
> >>>>=20
> >>>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> >>>> index 0533b674a..c8f3ce26e 100644
> >>>> --- a/doc/adapter-api.txt
> >>>> +++ b/doc/adapter-api.txt
> >>>> @@ -145,6 +145,35 @@ Methods		void StartDiscovery()
> >>>>=20
> >>>> 			Possible errors: None
> >>>>=20
> >>>> +		void CreateDevice(dict properties) [experimental]
> >>>> +
> >>>> +			Creates new temporary device with defined properties.
> >>>=20
> >>> Why is this not returning the device object path that gets created?
> >>> Seems a
> >>> waste time cycles to wait for a device showing up later.
> >>=20
> >> I was thinking about that too. I'll make it return object path.
> >>=20
> >>>> +
> >>>> +			Parameters that may be set in the filter dictionary
> >>>> +			include the following:
> >>>> +
> >>>> +			string Address
> >>>> +
> >>>> +				The Bluetooth device address of the remote
> >>>> +				device. This parameter is mandatory.
> >>>> +
> >>>> +			string AddressType
> >>>> +
> >>>> +				The Bluetooth device Address Type. This is
> >>>> +				address type that should be used for initial
> >>>> +				connection. If this parameter is not present
> >>>> +				BR/EDR device is created.
> >>>> +
> >>>> +				Possible values:
> >>>> +					"public" - Public address
> >>>> +					"random" - Random address
> >>>> +
> >>>> +			Possible errors: org.bluez.Error.InvalidArguments
> >>>> +					 org.bluez.Error.AlreadyExists
> >>>> +					 org.bluez.Error.NotSupported
> >>>> +					 org.bluez.Error.NotReady
> >>>> +					 org.bluez.Error.Failed
> >>>> +
> >>>=20
> >>> Now what I wonder is that in case of LE, this should actually trigger=
 a
> >>> quick scan for that device so that you get advertising data and other
> >>> information about the device. We are missing a kernel API for such a
> >>> targeted case and that might need fixing as well.
> >>>=20
> >>> In case of BR/EDR, this might should trigger a connection and SDP
> >>> discovery.
> >>>=20
> >>> Otherwise this is not an API and just a hack to create a device path
> >>> object. So you are essentially just doing an =E2=80=9CInjectDevice=E2=
=80=9D instead of
> >>> anything real.
> >>=20
> >> Maybe we should just implicitly make it connect to device? That would
> >> keep
> >> things simple and wouldn't require any additional kernel work. If conn=
ect
> >> failed we remove device.
> >=20
> > that would work as well and since for LE we always scan first, we get t=
he
> > advertising data as well. Now the question is if just call it
> > DiscoverDevice instead. I am reluctant to call it ConnectDevice since
> > that is a bit overlapping with Device.Connect. And CreateDevice is bad =
as
> > well since this is temporary connection in most cases.
> actually just trying to connect really only works for BR/EDR. With LE that
> would not help us with non-connectable devices. So I am leaning towards
> DiscoverDevice that does BR/EDR connect and SDP. And on LE it does an
> active scan for that specific device. No connection attempt required on L=
E.

This is explicitly meant for connectable devices so I'd now bother with non-
connectable devices as those are by definition discovered with observation=
=20
procedure.=20

I'm now thinking on method name (was going initially with ConnectDevice but=
=20
you already mentioned that you don't like it:P)

=2D-=20
pozdrawiam
Szymon Janc
