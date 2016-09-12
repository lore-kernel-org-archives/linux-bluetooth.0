Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: StopNotify not firing? (was: Query BLE connected status?)
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <A4055AB1-FBEC-48D9-81BB-54FAFDB73744@gmail.com>
Date: Mon, 12 Sep 2016 10:49:37 -0700
Message-Id: <BE6EC190-160F-4895-82D0-B31D7CB3DB18@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com> <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com> <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com> <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com> <AFC130A9-CBDF-4DC3-BACD-69CF3ADBA1C6@gmail.com> <CAAu3APaLf-fEj61fA4UD1JDLipbgC72K2WWtUzLKypT2LJAErw@mail.gmail.com> <A4055AB1-FBEC-48D9-81BB-54FAFDB73744@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Sep 12, 2016, at 8:52 AM, Travis Griggs <travisgriggs@gmail.com> =
wrote:
>=20
> It seems to me though, that maybe I=E2=80=99m going about this wrong. =
I don=E2=80=99t care about the device identity, or which devices are =
connected or not. What I really care about is if any device is connected =
to my app. And maybe I have this (kind of indirectly). My characteristic =
will get a StartNotify/StopNotify event on connect/disconnect edges. I =
can just use those to keep track of when I=E2=80=99m active or not.

So I implemented this, and now notice that while I get the StartNotify =
events, I don=E2=80=99t seem to get the StopNotify events.

In one case, I just shut down my iOS app (which had successfully =
triggered the StartNotify), while the device eventually showed up as =
disconnected, it never propagated a stop notify.

In the next case, I used the LightBlueLE app which allows one to =
explicitly start listen and stop listen. Explicit stop listen commands =
on either didn=E2=80=99t show anything.

Running btmon during a start listen/stop listen cycle produced the =
following output:

# btmon
Bluetooth monitor ver 5.41
=3D New Index: 5C:F3:70:68:C1:F9 (Primary,USB,hci0)               [hci0] =
0.149811
> ACL Data RX: Handle 64 flags 0x02 dlen 9                      [hci0] =
2.681703
      ATT: Write Request (0x12) len 4
        Handle: 0x000d
          Data: 0100
< ACL Data TX: Handle 64 flags 0x00 dlen 5                      [hci0] =
2.693201
      ATT: Write Response (0x13) len 0
> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] =
3.036696
        Num handles: 1
        Handle: 64
        Count: 1
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0] =
11.862591
      ATT: Write Request (0x12) len 4
        Handle: 0x000d
          Data: 0000
< ACL Data TX: Handle 64 flags 0x00 dlen 5                     [hci0] =
11.864894
      ATT: Write Response (0x13) len 0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] =
12.161577
        Num handles: 1
        Handle: 64
        Count: 1


(also, having btmon running when connected caused btmon to buffer =
overflow and die)=
