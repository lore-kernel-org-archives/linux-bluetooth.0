Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <BE6EC190-160F-4895-82D0-B31D7CB3DB18@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
 <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com>
 <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com> <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
 <AFC130A9-CBDF-4DC3-BACD-69CF3ADBA1C6@gmail.com> <CAAu3APaLf-fEj61fA4UD1JDLipbgC72K2WWtUzLKypT2LJAErw@mail.gmail.com>
 <A4055AB1-FBEC-48D9-81BB-54FAFDB73744@gmail.com> <BE6EC190-160F-4895-82D0-B31D7CB3DB18@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Sep 2016 17:41:39 +0300
Message-ID: <CABBYNZLux+k_cMH+7xdOewu2dfKA2p_m6q+U5ZoJjzSYAmc63w@mail.gmail.com>
Subject: Re: StopNotify not firing? (was: Query BLE connected status?)
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Mon, Sep 12, 2016 at 8:49 PM, Travis Griggs <travisgriggs@gmail.com> wro=
te:
>
>> On Sep 12, 2016, at 8:52 AM, Travis Griggs <travisgriggs@gmail.com> wrot=
e:
>>
>> It seems to me though, that maybe I=E2=80=99m going about this wrong. I =
don=E2=80=99t care about the device identity, or which devices are connecte=
d or not. What I really care about is if any device is connected to my app.=
 And maybe I have this (kind of indirectly). My characteristic will get a S=
tartNotify/StopNotify event on connect/disconnect edges. I can just use tho=
se to keep track of when I=E2=80=99m active or not.
>
> So I implemented this, and now notice that while I get the StartNotify ev=
ents, I don=E2=80=99t seem to get the StopNotify events.
>
> In one case, I just shut down my iOS app (which had successfully triggere=
d the StartNotify), while the device eventually showed up as disconnected, =
it never propagated a stop notify.
>
> In the next case, I used the LightBlueLE app which allows one to explicit=
ly start listen and stop listen. Explicit stop listen commands on either di=
dn=E2=80=99t show anything.
>
> Running btmon during a start listen/stop listen cycle produced the follow=
ing output:
>
> # btmon
> Bluetooth monitor ver 5.41
> =3D New Index: 5C:F3:70:68:C1:F9 (Primary,USB,hci0)               [hci0] =
0.149811
>> ACL Data RX: Handle 64 flags 0x02 dlen 9                      [hci0] 2.6=
81703
>       ATT: Write Request (0x12) len 4
>         Handle: 0x000d
>           Data: 0100
> < ACL Data TX: Handle 64 flags 0x00 dlen 5                      [hci0] 2.=
693201
>       ATT: Write Response (0x13) len 0
>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 3.0=
36696
>         Num handles: 1
>         Handle: 64
>         Count: 1
>> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0] 11.8=
62591
>       ATT: Write Request (0x12) len 4
>         Handle: 0x000d
>           Data: 0000
> < ACL Data TX: Handle 64 flags 0x00 dlen 5                     [hci0] 11.=
864894
>       ATT: Write Response (0x13) len 0
>> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 12.1=
61577
>         Num handles: 1
>         Handle: 64
>         Count: 1
>
>
> (also, having btmon running when connected caused btmon to buffer overflo=
w and die)--

We did have some fixes recently to btmon, please check with upstream
version. Regarding StopNotify we are currently using refcount to track
when to disable the notifications so I suspect this is not working
properly. Also we are not stopping the notification when there is no
peer connected, so there is a couple of things to fix.

--=20
Luiz Augusto von Dentz
