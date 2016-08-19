Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1471542372.3849.1.camel@toniob.net>
References: <1471515072.4976.10.camel@toniob.net> <CABBYNZKvqrbF7XzW4yShJyM2wXWckJX7X5PD6gU=mT7Pg6HUGw@mail.gmail.com>
 <1471531954.4976.13.camel@toniob.net> <CABBYNZKDS1HU2_1hGdbDemNyX7xcRxOUM-ZV1fRVd8UkENEP4w@mail.gmail.com>
 <1471542372.3849.1.camel@toniob.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Aug 2016 11:43:00 +0300
Message-ID: <CABBYNZLWEmt95bD0GQri8qesXeNRC8cUE4+xPfYv19q20GYX2A@mail.gmail.com>
Subject: Re: Can't connect a Xbox one controller
To: Anthony Bourguignon <contact@toniob.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anthony,

On Thu, Aug 18, 2016 at 8:46 PM, Anthony Bourguignon <contact@toniob.net> w=
rote:
> Le jeudi 18 ao=C3=BBt 2016 =C3=A0 19:20 +0300, Luiz Augusto von Dentz a =
=C3=A9crit :
>> Hi Anthony,
>>
>> On Thu, Aug 18, 2016 at 5:52 PM, Anthony Bourguignon <contact@toniob.
>> net> wrote:
>> >
>> > Le jeudi 18 ao=C3=BBt 2016 =C3=A0 16:56 +0300, Luiz Augusto von Dentz =
a =C3=A9crit
>> > :
>> > >
>> > > Hi Anthony,
>> > >
>> > > On Thu, Aug 18, 2016 at 1:11 PM, Anthony Bourguignon <contact@ton
>> > > iob.
>> > > net> wrote:
>> > > >
>> > > >
>> > > > Hi,
>> > > >
>> > > > I've recently bought a new xbox one controller as the 2016
>> > > > version
>> > > > has
>> > > > bluetooth connectivity.
>> > > >
>> > > > The controller is pairing and connecting well on a windows 10
>> > > > computer
>> > > > and an android 4.4 tablet. But I can"t make it connect under
>> > > > linux
>> > > > (Debian unstable, kernel 4.6 and 4.7-rc7, bluez 5.40 from
>> > > > experimental). The pairing is ok but when I try to connect to
>> > > > controller, it stays connected for less than one second, then
>> > > > disconnects, then connects again and so one until the
>> > > > controller
>> > > > goes
>> > > > to sleep, because of the lack of a remote connection.
>> > > >
>> > > > Any idea ?
>> > >
>> > > It seems there is some problem configuring the L2CAP connection
>> > > (probably for SDP):
>> > >
>> > > >
>> > > >
>> > > > ACL data: handle 256 flags 0x02 dlen 15
>> > >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 3 clen 1
>> > >       Failure - unknown options
>> > >       RFC
>> > > < ACL data: handle 256 flags 0x00 dlen 12
>> > >     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
>> >
>> > So, is it a bug of bluez or of the controller firmware ? Why is it
>> > possible to make a connection with an android tablet ?
>> >
>> > Is there something more I can do to help ?
>>
>> Well perhaps we can compare to what other stacks are responding, but
>> this seem quite weird given L2CAP_Config request is an essential part
>> of setting up L2CAP connections so a response with unknown options
>> sounds kind broken, but perhaps other stacks are ignoring it.
>
> I've juste made a capture with my android tablet. Maybe it'll help.
> Association failed two times and succeded on the third one.

It seems the configuration request works just fine here:

< ACL Data TX: Handle 13 flags 0x02 dlen 12

                                                           83.379233
      L2CAP: Connection Request (0x02) ident 15 len 4
        PSM: 17 (0x0011)
        Source CID: 75
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                           =
                                                   83.381502
        Num handles: 1
        Handle: 13
        Count: 1
> ACL Data RX: Handle 13 flags 0x02 dlen 16                                =
                                                                           =
                                                   83.383358
      L2CAP: Connection Response (0x03) ident 15 len 8
        Destination CID: 64
        Source CID: 75
        Result: Connection pending (0x0001)
        Status: No further information available (0x0000)
> ACL Data RX: Handle 13 flags 0x02 dlen 16                                =
                                                                           =
                                                   83.384600
      L2CAP: Connection Response (0x03) ident 15 len 8
        Destination CID: 64
        Source CID: 75
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 13 flags 0x02 dlen 16

                                                           83.385274
      L2CAP: Configure Request (0x04) ident 16 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 640
> ACL Data RX: Handle 13 flags 0x02 dlen 16                                =
                                                                           =
                                                   83.385939
      L2CAP: Configure Request (0x04) ident 5 len 8
        Destination CID: 75
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 1480
< ACL Data TX: Handle 13 flags 0x02 dlen 14

                                                           83.386624
      L2CAP: Configure Response (0x05) ident 5 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                           =
                                                   83.387708
        Num handles: 1
        Handle: 13
        Count: 1
> ACL Data RX: Handle 13 flags 0x02 dlen 14                                =
                                                                           =
                                                   83.388425
      L2CAP: Configure Response (0x05) ident 16 len 6
        Source CID: 75
        Flags: 0x0000
        Result: Success (0x0000)

There is another difference here is that the connection to PSM 17 is
started by the Android device while in our case it is started by the
controller without doing any SDP(?) which sounds like the controller
has been connected before or it is not behaving like a HID device. Is
there a way to reset the controller to a state that it clears the
paired devices?


--=20
Luiz Augusto von Dentz
