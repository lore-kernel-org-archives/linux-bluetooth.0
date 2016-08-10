Return-Path: <alex.coplan@starleaf.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Change LE advertising interval via D-Bus API
From: Alex Coplan <alex.coplan@starleaf.com>
In-Reply-To: <4ADDE98F-C561-415B-AFA7-D407B21EFFCD@holtmann.org>
Date: Wed, 10 Aug 2016 16:45:34 +0100
Cc: linux-bluetooth@vger.kernel.org,
 rdl@starleaf.com
Message-Id: <13AF5DC1-C9E7-4EB0-A1DA-F63ACB63F614@starleaf.com>
References: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com> <14FF3F29-1C6E-41F9-B41D-850772B758B3@holtmann.org> <FB35544E-8D8B-48B1-825A-E0A5BC8D92C3@starleaf.com> <581A4CCB-9778-4C48-9075-7CFCC1C95884@holtmann.org> <E954B4D5-5952-4935-8B8D-D618C7C693DC@starleaf.com> <4ADDE98F-C561-415B-AFA7-D407B21EFFCD@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>>>>>> There doesn=E2=80=99t currently appear to be an obvious way to =
change the advertising interval via the D-Bus API.
>>>>>>=20
>>>>>> Are there plans to add this as an option to the =
RegisterAdvertisement method, or perhaps a property of the =
LEAdvertisement1 interface?
>>>>>=20
>>>>> what do you want to change it to? There are certain limits that =
make sense. For example fine control over the advertising interval from =
an application makes no sense. It might however make sense to have some =
low, medium, high interval adjectives so that bluetoothd can pick the =
right options. Even the mgmt API into the kernel for setting advertising =
has no control over advertising internal at the moment.
>>>>=20
>>>> Currently it=E2=80=99s using the default value of 0x0800 (=3D 1.28 =
seconds), as set in net/bluetooth/hci_core.c:2950. This is too =
infrequent for e.g. iBeacons on iOS to be able to perform the =
=E2=80=9Cranging=E2=80=9D function which does distance estimation etc. =
Perhaps 0x0200 (around 250ms) would be sensible as a more frequent =
option?
>>>=20
>>> for me this sounds like we should be adding a "low latency" flag to =
the Add Advertising flags parameters that picks a short advertising =
interval. In general this is similar to what we have done with "fast =
connectable" option that we have. However in this case it is not just =
fast connectable since we also have non-connectable advertising.
>>=20
>> Yes, that sounds reasonable.
>>=20
>>>=20
>>> I also have the feeling that for the general Set Advertising, the =
setting of Set Fast Connectable should be honored and results in using =
the other advertising interval. That would also mean that the Set Fast =
Connectable setting becomes available for LE controllers.
>>>=20
>>> Does iOS beacon guide give some advise on what is the best =
advertising interval for the iBeacons?
>>=20
>> The iBeacon specification recommends an advertising interval of =
100ms, but that is quite low (the minimum allowed by the spec for =
ADV_NONCONN_IND packets). In my tests, 200ms works just fine.
>=20
> and even that 100ms requirement for ADV_NONCONN_IND will be removed =
soon from the specification. This does not mean we should go with a =
smaller interval. Mainly since most 4.x controllers will just reject it =
anyway.
>=20
> Anyway, we can test a few values and then fine tune it. We can add a =
debugfs file that allows us to test out different values. And in the =
long run we can add a Set Fast Connectable Parameters mgmt command to =
allow changing these via bluetoothd if needed.
>=20
> Now the question is who works out the patch to doc/mgmt-api.txt and =
does the implementation for it. So it needs this:
>=20
> 1) Changes to Set Fast Connectable to allow it for LE only devices as =
well
> 2) Changes to Set Advertising to honor Set Fast Connectable
> 3) New flag for Read Advertising Features and Add Advertising
>=20
> I propose to name the new flag like this:
>=20
> 	7	Use Fast Connectable advertising interval
>=20
> My reason to stick with name Fast Connectable is that we already used =
it. The mgmt-api.txt should however reflect that it also applies to =
non-connectable advertising.
>=20
> One thing we need to check is that Set Fast Connectable is independent =
from Set Connectable. I think we already did it that way, but if not, =
then we need to decouple these two.
>=20
> Eventually we can rename Fast Connectable to something more =
appropriate, but lets leave that for some other time. Since I would =
worry right now to get the feature implemented correctly. It also means =
to add extra test cases to tools/mgmt-tester to ensure correct behavior =
in conjunction with Set Connectable etc.
>=20
> Are you planning to send patches for this? I think the todo items are =
pretty clear.

In principle, I would be happy to do this. However, I am currently =
experiencing issues with the management interface that would be =
prohibitive to working on it. In particular, running tools/mgmt-tester =
results in three tests failing:
 - Set Powered On - Privacy and Advertising
 - Add UUID - UUID-16 partial 1
 - Remove Device - Success 3

I am particularly concerned about the first test regarding privacy and =
advertising. In my initial email about the advertising interval and =
iBeacons, I was under the impression that iOS devices could not range =
the iBeacon packets produced via the D-Bus API because the advertising =
interval was too high. I have since determined that this is not the =
case; using code to generate advertising packets manually with HCI =
commands, I increased the advertising interval to that used by the D-Bus =
API / management interface (1.28 seconds), and iOS *could* still range =
these packets. The only difference between them was that advertising via =
D-Bus made use of the LE Privacy feature (address randomisation), and =
the HCI code didn=E2=80=99t.

Although the advertising interval turned out not to be the problem here, =
that it is not to say that this removes the need for a Fast Connectable =
advertising interval in the management interface / D-Bus API; this would =
still be a useful feature.

However, these two observations (the failing test and ineffective =
advertisements produced via the D-Bus API) lead me to believe that there =
is a problem to do with the Privacy feature here. Do you have any ideas =
on how to proceed? Is this a known issue? I=E2=80=99m using the latest =
BlueZ from the repository on kernel.org and kernel 4.4.0-34. I wrote a =
lengthy email about the issues I was having in great detail to the =
mailing list a while ago =
(http://marc.info/?l=3Dlinux-bluetooth&m=3D146703031223846&w=3D2) =E2=80=94=
 apologies for any inaccuracies in this; at the time I was not =
particularly familiar with the BlueZ stack.=20

Regards,
Alex
