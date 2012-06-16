Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMk70DCvRsuq7SN4dxY4Qo+saSzY8vsK1=5nDtuWA3cLGkcJWw@mail.gmail.com>
References: <CAMk70DBgaYSK5bMLPUR1c7Gf1xFO8px4fgtqqnQ1-qMXUOq3PA@mail.gmail.com>
	<CAFsbExJZd6w4-o4YZ82oeVLdRDr-tWhrNwN+zQv2WbJb6cKqUg@mail.gmail.com>
	<CAMk70DBXqUnXNkOSx9Cct7ATbCWWwXzbV1jFWNyBkULzNZ6dHA@mail.gmail.com>
	<CAMk70DCvRsuq7SN4dxY4Qo+saSzY8vsK1=5nDtuWA3cLGkcJWw@mail.gmail.com>
Date: Sat, 16 Jun 2012 15:56:53 -0500
Message-ID: <CAMk70DD7-wN9AdgoBsAcuQtCOGDL_wBa2YbYDOFaW0Xtgu8TYA@mail.gmail.com>
Subject: Re: Question For Devs: Is Headset Connection Automatic?
From: bubba junk <junkbubba2@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attached below is the output from the hcidump package after attempting
to connect by powering on the BT headset. By the way, I also ran the
hcidump command to capture the output from a successful connection
using the bt panel applet. The output was too huge to capture. It
filled up the entire terminal window such that I could not even see
the top of the output in the terminal window after scrolling up. There
were hundreds and hundreds of lines with the same text "SCO data:
handle 6 flags 0x00 dlen 48". I thought it unusual that a successful
connection spooled out hundreds of lines and the unsuccessful
connection was such a short output comparatively (below).  Let me know
if there is any additional information I can provide. Thanks again.

HCI sniffer - Bluetooth packet analyzer ver 2.2
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 68:EB:AE:10:82:F3 class 0x200404 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 68:EB:AE:10:82:F3 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 68:EB:AE:10:82:F3 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 68:EB:AE:10:82:F3 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xff 0xfe 0x0f 0xc6 0x9b 0xbf 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 11 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 11 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 68:EB:AE:10:82:F3 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 48
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 11 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-32 0x111f (Handsfree AG)
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 68:EB:AE:10:82:F3 name 'HM1000'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
< ACL data: handle 11 flags 0x00 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x18
          count 21
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xd > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 68:EB:AE:10:82:F3
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 68:EB:AE:10:82:F3 key 1A1EB6FF15700D58290D93134B117E0F
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 68:EB:AE:10:82:F3
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 11 encrypt 0x01
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x13
    Reason: Remote User Terminated Connection


On Sat, Jun 16, 2012 at 3:39 PM, bubba junk <junkbubba2@gmail.com> wrote:
> I think I figured out how to get the requested information. The
> following is the output from the list-devices script. I'll create a
> separate response with the output of the hcidump. Let me know if this
> is correct and if you need any further details.
>
> python list-devices output
> [ /org/bluez/741/hci0 ]
>    Name = milano-0
>    Powered = 1
>    Devices = dev_68_EB_AE_10_82_F3
>    DiscoverableTimeout = 0
>    PairableTimeout = 0
>    Discoverable = 0
>    Address = 00:02:76:17:B9:C9
>    Discovering = 0
>    Pairable = 1
>    Class = 7209216
>    UUIDs = 0x1000 0x1001 0x112d 0x1112 0x111f 0x111e 0x110a 0x110b
> 0x110c 0x110e 0x1103
>    [ /org/bluez/741/hci0/dev_68_EB_AE_10_82_F3 ]
>        Name = HM1000
>        Paired = 1
>        Adapter = /org/bluez/741/hci0
>        Alias = HM1000
>        Connected = 0
>        UUIDs = 0x1108 0x111e
>        Address = 68:EB:AE:10:82:F3
>        Services = dbus.Array([], signature=dbus.Signature('o'),
> variant_level=1)
>        Blocked = 0
>        Class = 0x200404
>        Trusted = 1
>        Icon = audio-card
>
> On Sat, Jun 16, 2012 at 3:32 PM, bubba junk <junkbubba2@gmail.com> wrote:
>> Gustavo,
>>
>>  Thank you so much for responding. It is encouraging to hear that the
>>  expected behavior is for the headset to connect automatically. Until
>>  recently I was not able to reconnect at all until the patch "[PATCH]
>>  Bluetooth: Fix l2cap connfailures for ssp devices" made it into the
>>  linux kernel released with Ubuntu 12.04 LTS. Since that patch, I am
>>  able to successfully connect and disconnect the headset without issue.
>>
>>  Regarding the requested information hcidump and output from
>>  list-devices script, I would be more than happy to provide the
>>  information, but not sure exactly how to go about it given I've never
>>  done either. If there is some basic documentation on
>>  downloading/installing the package and script and running each that I
>>  can review, I'm sure I can figure it out. I will try to google search
>>  for instructions. Also, assuming I can figure out how to run the
>>  scripts, do you want me to provide the output as text pasted into the
>>  email, or as attachments?
>>
>>  Thanks in advance for any help you can provide.
>>
>> On Thu, Jun 14, 2012 at 10:24 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
>>> Hi Bubba,
>>>
>>> On Thu, Jun 14, 2012 at 6:31 PM, bubba junk <junkbubba2@gmail.com> wrote:
>>>> I am non-developer with a basic question about basic BlueZ
>>>> functionality. I have a BT headset (Samsung HM1000) that I have paired
>>>> with BlueZ. I am able to successfully connect / disconnect the headset
>>>> using the bluetooth panel applet (in Ubuntu 12.04 lastest patches). My
>>>> question is should the headset automatically connect to BlueZ after it
>>>> is powered on or after pressing the talk button?
>>>>
>>>> My BT Logitech mouse automatically connects to BlueZ after it has been
>>>> powered on or after a long period of inactivity. I expected the
>>>> headset to do the same, connect automatically. Is there a way to have
>>>> the headset connect automatically without having to select 'Connect'
>>>> from the panel applet?
>>>
>>> It is supposed to connect automatically. Can you provide a hcidump
>>> (usually bluez-hcidump package) of a connection attempt from the
>>> headset. Also run the test list-devices script (present in bluez
>>> sources under the test dir) and tell us the result.
>>>
>>> Gustavo
