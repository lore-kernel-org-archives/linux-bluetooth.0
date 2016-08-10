Return-Path: <alex.coplan@starleaf.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Change LE advertising interval via D-Bus API
From: Alex Coplan <alex.coplan@starleaf.com>
In-Reply-To: <581A4CCB-9778-4C48-9075-7CFCC1C95884@holtmann.org>
Date: Wed, 10 Aug 2016 12:42:26 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E954B4D5-5952-4935-8B8D-D618C7C693DC@starleaf.com>
References: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com> <14FF3F29-1C6E-41F9-B41D-850772B758B3@holtmann.org> <FB35544E-8D8B-48B1-825A-E0A5BC8D92C3@starleaf.com> <581A4CCB-9778-4C48-9075-7CFCC1C95884@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On 9 Aug 2016, at 14:50, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Alex,
>=20
>>>> There doesn=E2=80=99t currently appear to be an obvious way to =
change the advertising interval via the D-Bus API.
>>>>=20
>>>> Are there plans to add this as an option to the =
RegisterAdvertisement method, or perhaps a property of the =
LEAdvertisement1 interface?
>>>=20
>>> what do you want to change it to? There are certain limits that make =
sense. For example fine control over the advertising interval from an =
application makes no sense. It might however make sense to have some =
low, medium, high interval adjectives so that bluetoothd can pick the =
right options. Even the mgmt API into the kernel for setting advertising =
has no control over advertising internal at the moment.
>>=20
>> Currently it=E2=80=99s using the default value of 0x0800 (=3D 1.28 =
seconds), as set in net/bluetooth/hci_core.c:2950. This is too =
infrequent for e.g. iBeacons on iOS to be able to perform the =
=E2=80=9Cranging=E2=80=9D function which does distance estimation etc. =
Perhaps 0x0200 (around 250ms) would be sensible as a more frequent =
option?
>=20
> for me this sounds like we should be adding a "low latency" flag to =
the Add Advertising flags parameters that picks a short advertising =
interval. In general this is similar to what we have done with "fast =
connectable" option that we have. However in this case it is not just =
fast connectable since we also have non-connectable advertising.

Yes, that sounds reasonable.

>=20
> I also have the feeling that for the general Set Advertising, the =
setting of Set Fast Connectable should be honored and results in using =
the other advertising interval. That would also mean that the Set Fast =
Connectable setting becomes available for LE controllers.
>=20
> Does iOS beacon guide give some advise on what is the best advertising =
interval for the iBeacons?

The iBeacon specification recommends an advertising interval of 100ms, =
but that is quite low (the minimum allowed by the spec for =
ADV_NONCONN_IND packets). In my tests, 200ms works just fine.

>=20
> Regards
>=20
> Marcel
>=20

Best,
Alex=
