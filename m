Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DB6PR0201MB2197B885638BD4A61D50D85FE75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>
References: <AM4PR0201MB2196BB85B60661BDEA615EFEE75F0@AM4PR0201MB2196.eurprd02.prod.outlook.com>
 <CABBYNZK3YcGK-qONbFbZEhM5xRnRAuXeQUtPVj9OUgzqLzgszg@mail.gmail.com>
 <DB6PR0201MB219730A45D69A9EC0163B0B5E75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>
 <CABBYNZKvh6kc7QnS=8Y-i-vHODPheYpqRJ-EzGbB1kqo=+y8oQ@mail.gmail.com> <DB6PR0201MB2197B885638BD4A61D50D85FE75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Nov 2017 12:50:53 +0200
Message-ID: <CABBYNZKHqfUEwuqV0GR9S6xcnqPQ6qQ1TkN7W8iYEXA76jrTYg@mail.gmail.com>
Subject: Re: Runtime retrieval of bluetoothd version
To: Alex Blasche <alexander.blasche@qt.io>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, Nov 2, 2017 at 12:03 PM, Alex Blasche <alexander.blasche@qt.io> wro=
te:
>
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> > I was fearing that. Such is life ... I will find some heuristics here.=
 Thank you.
>>
>> You can check how d-feet does to retrieve the pid and binary path,
>> than you can issue a --version to it and parse the output.
>
> Thank you for the hint. I will check it out.
>
>> >> Btw, if you are looking for other hints you could try bind/listen on =
GATT cid,
>> as
>> >> far GATT goes this should indicate bluetoothd is listening on it.
>> >
>> > That's what my existing alternative backend connects to and where I ra=
n an
>> entire (G)ATT stack. Obviously, this completely bypasses bluetoothd (tha=
t's the
>> stack I want to swap out if bluetoothd is recent enough). What I don't
>> understand is how this could help me to figure out what version of bluet=
oothd is
>> running. The test to check whether Bluetooth is running is doable via db=
us
>> already and less of a problem. I there a correlation between bluetoothd =
version
>> and bluetoothd always being connected to the GATT cid? What am I missing=
?
>>
>> Which an application was never supposed to do, specially when we are
>> talking about a fixed channel, but I guess you are know learning it
>> the hard way.
>
 e> I knew that from the beginning. Problem is that Qt had to support BTLE =
from
> Bluez 4.101 onwards. Only now that Bluez is finally catching up (still no=
t there yet)
> I can consider shifting the burden.

Web Bluetooth has been supported for quite a while, had Qt
communicated the intent to use these APIs and actually test them we
wouldn't be in this situation in the first place. You can check the
status of Web Bluetooth:

https://github.com/WebBluetoothCG/web-bluetooth/blob/master/implementation-=
status.md

>> What I was suggesting is detect if bluetoothd is already
>> handling the ATT cid but perhaps that is not enough given there are
>> many versions where the GATT implementation may not be fully
>> operational or is still marked experimental.
>
> From what I can tell this is only true if a connection to a remote device=
 exists, right?
> At least my tests show that the socket connection is not always open.

BlueZ always listen on GATT cid, this is actually mandatory since GATT
server is mandatory for qualification. There can only be one process
listening on a given L2CAP cid, when that happen EADDRINUSE is
returned.

>> If I where to make this changes I would just remove any implementation
>> of GATT/ATT and start over depending on the upcoming BlueZ release
>> which should cover both central and peripheral roles, but perhaps you
>> cannot do that because that would leave systems that cannot update
>> BlueZ unable to update Qt as well.
>
> If life would always this easy... You guessed right. I cannot cut support=
 for Bluez versions
> below 5.42 (first version of Bluez that had non-experimental BTLE APIs). =
Second reason is
> that especially on the peripheral side Bluez is still experimental and so=
me things such as
> various advertising parameters (e.g. white lists & intervals) are not ava=
ilable yet. Especially
> the intervals are a big problems (hint hint =F0=9F=98=89). For the time b=
eing I have to run both stacks -
> but Bluez and Qt will get there.

The so-called auto-connect, passive scanning + connecting, is in fact
supported. It is not always possible to use the white list since the
device may be using privacy and the resolving list is not always
available since that afaik is optional, in a way both white list and
resolving list is controller specific feature and the kernel may need
to rotate entries since there are normally limited in size so exposing
this to the end user is probably not a good idea. By default any
device that has been connected is programmed is added to the
auto-connect list, if the user application call Device.Disconnect that
will remove it from the the auto-connect list.

Regarding intervals, we do have support for timeout and duration in
the management interface, though these 2 are not exposed yet in D-Bus,
not sure if is that what you want?

--=20
Luiz Augusto von Dentz
