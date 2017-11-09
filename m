Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: Get Name in Scan Response?
Date: Thu, 9 Nov 2017 11:41:51 -0800
References: <87796201-DEA7-4158-8822-F461BAF68B78@gmail.com>
 <CABBYNZLnnausCF9ERTQrNQqbODSG5Yt7cuiMzysS22iOddd1MA@mail.gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <CABBYNZLnnausCF9ERTQrNQqbODSG5Yt7cuiMzysS22iOddd1MA@mail.gmail.com>
Message-Id: <9DBC1F63-E158-448C-AB5E-93E0465A1CF6@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



> On Nov 3, 2017, at 1:52 AM, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
>=20
> Hi Travis,
>=20
> On Fri, Nov 3, 2017 at 12:35 AM, Travis Griggs =
<travisgriggs@gmail.com> wrote:
>> We=E2=80=99ve been developing products using BlueNRG chips, that act =
as BLE peripherals and are connected via Android/iOS devices acting as =
centrals to control/configure them. It is desirable to be able to =
discover nearby devices and then connect to them. Because of heinous =
caching strategies in both Android and iOS just using a previously =
connected devices name (derived from the name characteristic). The most =
reliable thing to do at the iOS/Droid level is capture the name from the =
advertising data and associate that with the device. This is the only =
reliable way to have a device determine its name programmatically and =
advertise that reliably.
>>=20
>> I=E2=80=99m trying to do a product with a Pi like SBC that runs BlueZ =
with a BLE dongle. I set the device=E2=80=99s alias with:
>>=20
>>    adapterProperties.Set('org.bluez.Adapter1', 'Alias', bleName())
>>=20
>> Where bleName() returns the string I want to use for the device. If I =
connect a time or two and reboot a time or two, this will eventually =
show up as the name property in Android/iOS. But if I try to get it from =
the advertising data, there doesn=E2=80=99t seem to be a name in there. =
Is this name not set as part of either the advertisement or scan =
response packet? I know that when doing a custom service UUID, there is =
not enough room in the advertisement packet to have both service UUID =
and name, so it has to go in the scan response packet. Can any bluez =
developers confirm what I should be expecting to happen with setting the =
Alias property?
>>=20
>> Is there a way to achieve what I want to do? I have an Advertisement =
interface that I worked up from the examples that I use to do the =
solicitID in. Do I need to shove the name in there somehow additionally?
>>=20
>=20
> You actually need to set the include option in the advertisement,
> otherwise the kernel won't include the name on the scan response:
>=20
> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-ap=
i.txt#n147
> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-ap=
i.txt#n64
>=20
> You can check how it works with:
> bluetoothctl> set-advertise-name on
>=20
> Alternatively, you can set a local name for the advertisement:
> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-ap=
i.txt#n72

I tried this second approach, I believe. I have an Advertisement class =
that is pretty much a direct copy of the one example-advertisement.py in =
bluez/test. I noticed that since I had last =E2=80=9Ccopied=E2=80=9D the =
class, the local_name property/add_local_name had been added. So I added =
that and then attempted to use it, just like the TestAdvertisment =
subclass in the example. When I did that, it just quit showing up at =
all. I=E2=80=99m not sure where to look to get to the bottom of that. I =
am already setting a long service UUID as part of the advertisment.

I=E2=80=99m not enough of a dbus guy to know how to interpret the first =
two links. My basic problem, is that I don=E2=80=99t really know dbus. I =
kinda get it at a high level. But I see what is likely great =
documentation in the first two links and then ask =E2=80=9Cbut what do I =
do with this?=E2=80=9D I would love the idiots guide to dbus/bluez, but =
no one has seemed interested in writing that. For application level =
programmers, who have lots of C experience, file system experience, =
command line experience, etc, trying to set up Linux as a bluetooth =
peripheral, this is likely their first exposure to dbus.

Working from the example-advertise.py file, what would the first =
suggestion look like? Or do the two alternates end up doing the same =
thing? If they=E2=80=99re two different ways of getting at the same =
thing, then the suggestion doesn=E2=80=99t work sadly.

