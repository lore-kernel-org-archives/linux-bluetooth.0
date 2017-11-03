Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87796201-DEA7-4158-8822-F461BAF68B78@gmail.com>
References: <87796201-DEA7-4158-8822-F461BAF68B78@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Nov 2017 10:52:59 +0200
Message-ID: <CABBYNZLnnausCF9ERTQrNQqbODSG5Yt7cuiMzysS22iOddd1MA@mail.gmail.com>
Subject: Re: Get Name in Scan Response?
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Fri, Nov 3, 2017 at 12:35 AM, Travis Griggs <travisgriggs@gmail.com> wro=
te:
> We=E2=80=99ve been developing products using BlueNRG chips, that act as B=
LE peripherals and are connected via Android/iOS devices acting as centrals=
 to control/configure them. It is desirable to be able to discover nearby d=
evices and then connect to them. Because of heinous caching strategies in b=
oth Android and iOS just using a previously connected devices name (derived=
 from the name characteristic). The most reliable thing to do at the iOS/Dr=
oid level is capture the name from the advertising data and associate that =
with the device. This is the only reliable way to have a device determine i=
ts name programmatically and advertise that reliably.
>
> I=E2=80=99m trying to do a product with a Pi like SBC that runs BlueZ wit=
h a BLE dongle. I set the device=E2=80=99s alias with:
>
>     adapterProperties.Set('org.bluez.Adapter1', 'Alias', bleName())
>
> Where bleName() returns the string I want to use for the device. If I con=
nect a time or two and reboot a time or two, this will eventually show up a=
s the name property in Android/iOS. But if I try to get it from the adverti=
sing data, there doesn=E2=80=99t seem to be a name in there. Is this name n=
ot set as part of either the advertisement or scan response packet? I know =
that when doing a custom service UUID, there is not enough room in the adve=
rtisement packet to have both service UUID and name, so it has to go in the=
 scan response packet. Can any bluez developers confirm what I should be ex=
pecting to happen with setting the Alias property?
>
> Is there a way to achieve what I want to do? I have an Advertisement inte=
rface that I worked up from the examples that I use to do the solicitID in.=
 Do I need to shove the name in there somehow additionally?
>

You actually need to set the include option in the advertisement,
otherwise the kernel won't include the name on the scan response:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-api=
.txt#n147
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-api=
.txt#n64

You can check how it works with:
bluetoothctl> set-advertise-name on

Alternatively, you can set a local name for the advertisement:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-api=
.txt#n72
