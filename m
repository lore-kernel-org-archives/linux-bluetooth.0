Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK7i7ohoR_KbqW+u52rf3V-M6YX8BCE5PO82r3r5QOJ_w@mail.gmail.com>
References: <CAO+8wm_qbHMA8RZmiGQUw-55TDWCXvm+f2zrLCCYXXv7CcL08g@mail.gmail.com>
	<CABBYNZKbPeq9Xxr57EVOqLcY-TTLr6gM2a4yOxP_vBpukM+hqQ@mail.gmail.com>
	<CAO+8wm84JUdm4r5zY_eA5jZ1VjQKT94MdjEU0gQiHMekEiP3QA@mail.gmail.com>
	<CAO+8wm8f2HTLGWZ64jBtTXRQ+PhBzFXtjBncYQDnG7QXR38HHg@mail.gmail.com>
	<CABBYNZK7i7ohoR_KbqW+u52rf3V-M6YX8BCE5PO82r3r5QOJ_w@mail.gmail.com>
Date: Fri, 5 Sep 2014 00:21:11 -0700
Message-ID: <CAO+8wm_85d+bOgw0dz=h4jTb+iWK+Xkg4VDoijvRKkSvozHx6w@mail.gmail.com>
Subject: Re: connecting to a Motion 2in1 wiimote clone
From: Kameron Larsen <kroylar@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 1, 2014 at 12:48 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Kameron,
>
> On Sat, Aug 30, 2014 at 6:14 AM, Kameron Larsen <kroylar@gmail.com> wrote:
>> On Fri, Aug 29, 2014 at 6:23 PM, Kameron Larsen <kroylar@gmail.com> wrote:
>>> On Fri, Aug 29, 2014 at 3:51 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Kameron,
>>>>
>>>> On Fri, Aug 29, 2014 at 1:47 AM, Kameron Larsen <kroylar@gmail.com> wrote:
>>>>> Hello all,
>>>>>
>>>>> I'm having some difficulty in scanning and connecting to a device
>>>>> using bluetoothctl. The device in question is a Motion 2in1 Wiimote.
>>>>> Its basically a cheap chinese wiimote clone.
>>>>>
>>>>> When I try to scan using bluetoothctl the device never shows up. When
>>>>> I try to scan using "hcitool scan --iac=liac", the device shows up as:
>>>>>
>>>>> 2A:04:84:80:13:41 Nintendo RVL-CNT-01
>>>>
>>>> That is strange bluetoothctl should see the device as well.
>>>>
>>>>> The device cannot be connected to in bluetoothctl but I can connect
>>>>> using "hcitool cc 2A:04:84:80:13:41". If I connect using hctitool and
>>>>> then immediately use "pair 2A:04:84:80:13:41" in bluetoothctl. It
>>>>> looks like the device pairs but the wiimote disconnects before
>>>>> finishing the process. If I then run "trust 2A:04:84:80:13:41",
>>>>> bluetoothctl will show that the device connects anytime I press any
>>>>> button, and then shortly disconnects.
>>>>>
>>>>> hcidump reveals that the something is wating for additional data but
>>>>> it is not receiving what it expects.  Because this data was never
>>>>> received the pairing process is left incomplete. However I can
>>>>> reconnect by pressing any button on the remote. Whenever I do, it will
>>>>> automatically disconnect after several seconds.
>>>>
>>>> Have to register an agent to do the pairing? You should be able to do
>>>> that with bluetoothctl:
>>>>
>>>> agent on
>>>> default-agent
>>>>
>>>>> Scouring the code, I've come to realize that this remote is not
>>>>> responding to sdp queries and therefore bluez does not know what
>>>>> services it supports. My logs show this error:
>>>>>
>>>>> 2A:04:84:80:13:41: error updating services: Input/output error (5)
>>>>>
>>>>> Without knowing the services (ie, HID) it fails in connect_event_cb
>>>>> with the following error:
>>>>>
>>>>> Refusing input device connect: No such file or directory (2)
>>>>
>>>> It seems some, or perhaps most, gaming controllers do not have SDP
>>>> working properly but first check if you are really able to pair
>>>> properly because if you don't we wont be able to discover what service
>>>> the remote device support.
>>>
>>> I believe it has paired properly. At least bluetoothctl lists it as paired.
>>>
>>> [bluetooth]# power on
>>> Changing power on succeeded
>>> [bluetooth]# agent
>>> Missing on/off/capability argument
>>> [bluetooth]# default-agent
>>> No agent is registered
>>
>> So I didn't actually turn the agent on in that test. Oops! But without
>> an agent why did it seem to work? Or maybe its not actually working
>> either with or without the agent. It just appears to be.
>>
>> I repeated the test with actually turning the agent on and registering
>> the default agent but it does exactly the same thing.
>
> Try capturing the HCI traces and paste the relevant parts here it
> should tell us if pairing is really succeeding and where it fails to
> resolve the services.

I don't know what was going on before, but it looks like the other
dumps I posted are incomplete. There were no ACL data packets, and its
in those packets that we can see the failure to discover the hid input
service. Here are the complete dumps.

Initial pairing:
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 2A:04:84:80:13:41 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 2A:04:84:80:13:41 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 2A:04:84:80:13:41 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 2A:04:84:80:13:41 name 'Nintendo RVL-CNT-01'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 2A:04:84:80:13:41
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 2A:04:84:80:13:41
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 2A:04:84:80:13:41
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 2A:04:84:80:13:41
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 2A:04:84:80:13:41 len 6 pin ':
'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 2A:04:84:80:13:41
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 2A:04:84:80:13:41 key 8384F6074158145D7DC19E82699A252A type 0
    Type: Combination Key
< ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 12
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 12 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 12 encrypt 0x01
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 48
< ACL data: handle 12 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1

I believe the line,

> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 12

shows that the authentication/pairing was succesful. And the line,

< ACL data: handle 12 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00

shows that service discovery failed.

And subsequently connecting:
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 2A:04:84:80:13:41 class 0x002504 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 2A:04:84:80:13:41 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 2A:04:84:80:13:41 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 2A:04:84:80:13:41 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 2A:04:84:80:13:41 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 2A:04:84:80:13:41 name 'Nintendo RVL-CNT-01'
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 185
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 3 status 0
      Connection refused - security block
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 11 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x16
    Reason: Connection Terminated by Local Host

So I guess my question is, what are the available callbacks that I can
use to manually insert the correct SDP record as you described?
