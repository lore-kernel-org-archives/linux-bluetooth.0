Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Query BLE connected status?
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
Date: Wed, 7 Sep 2016 14:14:52 -0700
Message-Id: <AFC130A9-CBDF-4DC3-BACD-69CF3ADBA1C6@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com> <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com> <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com> <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Sep 7, 2016, at 12:37 AM, Tobias Svehagen =
<tobias.svehagen@gmail.com> wrote:
>=20
> The property is not on the Adapter1 interface but it is found on the
> Device1 interface. Also note that you have to check for every object
> under /org/bluez/hci0 if that one is connected. I don't think there is
> a way to see if an adapter is connected or not. Here is an example of
> getting the Connected property of all the devices.

<snip>

Thank you very much, your code example worked nicely. Now I have =
additional questions of course. :)

What is the difference between and adapter and device in the lingo here? =
I=E2=80=99m using a usb bluetooth dongle. Can I assume that that is an =
adapter? That if I had two dongles, I would have 2 adapters?

But what then does the =E2=80=9Cdevice=E2=80=9D represent? And why would =
I have more than one of them? Or is it just that they are arbitrarily =
named? The values shown don=E2=80=99t seem to correspond to the addr =
numbers I see when I run hciconfig.

Running the code you graciously shared, I saw some interesting results.

<reboot linux device>
# ./connected
(no output)
<ble connect from iphone>
# ./connected=20
/org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 1
<terminate iOS app, should disconnect>
# ./connected=20
/org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
<wait a minute or so>
# ./connected=20
/org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
<reconnect iOs app>
./connected=20
/org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
/org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
<disconnect>
./connected=20
/org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
/org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 0
<reconnect>
./connected=20
/org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
/org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
<reboot linux device>
# ./connected
(no output)
<ble connect from iphone>
./connected
/org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
<disconnect, pretty soon after connection, 5s maybe>
./connected
/org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
<wait 30s or so>
./connected
/org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
<after a minute or so>
./connected
(no response)


If I continued, I think I=E2=80=99d say more variations on the theme. =
The basic patterns I see are that a disconnected/reconnect cycle behaves =
in a couple of different ways
1) the device shows up immediately as not connected, and stays listed as =
not connected, on reconnect is reused and again shows as connected
2) the device shows up immediately as not connected, stays listed as not =
connected, on reconnect a NEW device shows up
3) no device is listed any more (connected or not connected), on =
reconnect the same device again shows up as connected
4) no device is listed any more (connected or not connected), on =
reconnect a NEW device shows up

I would love to understand this.

Running the sample you shared takes 1200-800 ms on my paltry ARM board. =
I don=E2=80=99t know if that is all python/dbus setup or, or query time. =
That=E2=80=99s a long time. Is there a way to register something more =
event based so I could be notified when it changes? Seems like a catch =
22 since I don=E2=80=99t know what the device name will be before hand.

