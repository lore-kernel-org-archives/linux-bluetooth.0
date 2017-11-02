Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DB6PR0201MB219730A45D69A9EC0163B0B5E75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>
References: <AM4PR0201MB2196BB85B60661BDEA615EFEE75F0@AM4PR0201MB2196.eurprd02.prod.outlook.com>
 <CABBYNZK3YcGK-qONbFbZEhM5xRnRAuXeQUtPVj9OUgzqLzgszg@mail.gmail.com> <DB6PR0201MB219730A45D69A9EC0163B0B5E75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Nov 2017 11:15:34 +0200
Message-ID: <CABBYNZKvh6kc7QnS=8Y-i-vHODPheYpqRJ-EzGbB1kqo=+y8oQ@mail.gmail.com>
Subject: Re: Runtime retrieval of bluetoothd version
To: Alex Blasche <alexander.blasche@qt.io>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, Nov 2, 2017 at 10:47 AM, Alex Blasche <alexander.blasche@qt.io> wro=
te:
> Hi Luiz,
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>
>> While I understand what you are at adding the version would only affect
>> upcoming releases so I don't how it would fix the problem.
>
> Ok, there is nothing. Might I ask for a new version tag somewhere? After =
all API's will always be added or changed. It would be an investment into t=
he future.
>
>> > The only reliable way I have seen so far is bluetoothd --version which=
 assumes
>> that one knows where bluetoothd is located. At least in source I could n=
ot find
>> any other way.
>
> I was fearing that. Such is life ... I will find some heuristics here. Th=
ank you.

You can check how d-feet does to retrieve the pid and binary path,
than you can issue a --version to it and parse the output.

>> Btw, if you are looking for other hints you could try bind/listen on GAT=
T cid, as
>> far GATT goes this should indicate bluetoothd is listening on it.
>
> That's what my existing alternative backend connects to and where I ran a=
n entire (G)ATT stack. Obviously, this completely bypasses bluetoothd (that=
's the stack I want to swap out if bluetoothd is recent enough). What I don=
't understand is how this could help me to figure out what version of bluet=
oothd is running. The test to check whether Bluetooth is running is doable =
via dbus already and less of a problem. I there a correlation between bluet=
oothd version and bluetoothd always being connected to the GATT cid? What a=
m I missing?

Which an application was never supposed to do, specially when we are
talking about a fixed channel, but I guess you are know learning it
the hard way. What I was suggesting is detect if bluetoothd is already
handling the ATT cid but perhaps that is not enough given there are
many versions where the GATT implementation may not be fully
operational or is still marked experimental.

If I where to make this changes I would just remove any implementation
of GATT/ATT and start over depending on the upcoming BlueZ release
which should cover both central and peripheral roles, but perhaps you
cannot do that because that would leave systems that cannot update
BlueZ unable to update Qt as well.

> --
> Alex
>
>



--=20
Luiz Augusto von Dentz
