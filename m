Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: L2CAP_INFO_REQ Command rejected by remote side and disconnect
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5629E44C.4000807@rie.eu>
Date: Fri, 23 Oct 2015 09:54:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8D50C87D-3481-41BB-AEAD-D03759EA449D@holtmann.org>
References: <5628D38B.6000808@rie.eu> <1F3BA345-9FE7-4237-B271-056CF1BA80A3@holtmann.org> <5629E44C.4000807@rie.eu>
To: =?windows-1252?Q?J=FCrgen_Benjamin_Ronshausen?= <b.r@rie.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juergen,

>>> i am working with Bluez 4.96, kernel 3.2 on embedded ARM.
>>> 
>>> Our embedded system is passive (discoverable, connectable) and gets contacted by bluetooth Access Points. With the older model Access Point the connection is disconnected from the Access Point. It seems to me that the Access Point doesn't implement L2CAP_INFO_REQ and L2CAP_INFO_RSP.
>>> 
>>> I used hcidump to investigate. Here is the part that i believe is the problem:
>>> 
>>> < ACL data: handle 1 flags 0x00 dlen 10
>>>    L2CAP(s): Info req: type 2
>>>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>>>    status 0x00 handle 1
>>>    Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>>    bdaddr 00:0B:53:20:04:09 mode 2 clkoffset 0x0000
>>>> HCI Event: Command Status (0x0f) plen 4
>>>    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>    handle 1 packets 2
>>>> ACL data: handle 1 flags 0x02 dlen 10
>>>    L2CAP(s): Command rej: reason 0
>>>      Command not understood
>>> 
>>> So after the L2CAP connection is established the module asks the AP for the Extended Features Mask via Info req. The AP responds with command not understood.
>>> 
>>> Could i be right about that the AP doesn't implement the L2CAP_INFO_REQ and L2CAP_INFO_RSP? Or is this a timing issue, where the AP state machine doesn't expect to be asked about Extended Features Mask at this time?
>>> 
>>> The Access Point is a Sena Parani MSP 101/102 with software from Initium on it.
>> I have no idea what the AP state machine might be, but we handle gracefully a remote devices that does not support the L2CAP_INFO_REQ and will still succeed with the connection.
>> 
>>> Full dump:
>>> 
>>>> HCI Event: Connect Request (0x04) plen 10
>>>    bdaddr 00:0B:53:20:04:09 class 0x020300 type ACL
>>> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>>>    bdaddr 00:0B:53:20:04:09 role 0x00
>>>    Role: Master
>>>> HCI Event: Command Status (0x0f) plen 4
>>>    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>>>> HCI Event: Role Change (0x12) plen 8
>>>    status 0x21 bdaddr 00:0B:53:20:04:09 role 0x01
>>>    Error: Role Change Not Allowed
>>>> HCI Event: Connect Complete (0x03) plen 11
>>>    status 0x00 handle 1 bdaddr 00:0B:53:20:04:09 type ACL encrypt 0x00
>>> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>>>    handle 1
>>>> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>>>    bdaddr 00:0B:53:20:04:09 mode 1
>>>> HCI Event: Command Status (0x0f) plen 4
>>>    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>>>> HCI Event: Max Slots Change (0x1b) plen 3
>>>    handle 1 slots 5
>>>> ACL data: handle 1 flags 0x02 dlen 12
>>>    L2CAP(s): Connect req: psm 1 scid 0x0086
>>> < ACL data: handle 1 flags 0x00 dlen 16
>>>    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0086 result 1 status 0
>>>      Connection pending - No futher information available
>>> < ACL data: handle 1 flags 0x00 dlen 10
>>>    L2CAP(s): Info req: type 2
>>>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>>>    status 0x00 handle 1
>>>    Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>>    bdaddr 00:0B:53:20:04:09 mode 2 clkoffset 0x0000
>>>> HCI Event: Command Status (0x0f) plen 4
>>>    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>    handle 1 packets 2
>>>> ACL data: handle 1 flags 0x02 dlen 10
>>>    L2CAP(s): Command rej: reason 0
>>>      Command not understood
>>>> HCI Event: Remote Name Req Complete (0x07) plen 255
>>>    status 0x00 bdaddr 00:0B:53:20:04:09 name 'Promi-MSP_200409'
>>> < ACL data: handle 1 flags 0x00 dlen 16
>>>    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0086 result 0 status 0
>>>      Connection successful
>> And that is what you can see here. We accept the connection even if the info req is not understood.
>> 
>>> < ACL data: handle 1 flags 0x00 dlen 12
>>>    L2CAP(s): Config req: dcid 0x0086 flags 0x00 clan 0
>> Now we start the configuration procedure of the L2CAP channel and the remote side just does nothing.
>> 
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>    handle 1 packets 2
>>>> HCI Event: Disconn Complete (0x05) plen 4
>>>    status 0x00 handle 1 reason 0x13
>>>    Reason: Remote User Terminated Connection
>> Run this with timestamps and see how much time in between it really takes until the AP devices to drop the connection altogether.
>> 
> 
> it takes 4 seconds after the AP sends is Name until the connection is reported successful. Other Access Points don't cause this delay. It could be that the module reaches timeout on the Access Point.
> 
> 2015-10-21 17:19:05.164208 > ACL data: handle 1 flags 0x02 dlen 10
>    L2CAP(s): Command rej: reason 0
>      Command not understood
> 2015-10-21 17:19:05.185143 > HCI Event: Remote Name Req Complete (0x07) plen 255
>    status 0x00 bdaddr 00:0B:53:20:04:09 name 'Promi-MSP_200409'
> 2015-10-21 17:19:09.139794 < ACL data: handle 1 flags 0x00 dlen 16
>    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00d5 result 0 status 0
>      Connection successful

waiting for 4 seconds to continue here is something odd on our side. We should continue right away if the other tells us that it does not support the info request. Can you actually run a bluetooth-next kernel to see if this issue might already has been fixed. The 3.2 kernel is way too old.

> 2015-10-21 17:19:09.139916 < ACL data: handle 1 flags 0x00 dlen 12
>    L2CAP(s): Config req: dcid 0x00d5 flags 0x00 clen 0
> 2015-10-21 17:19:09.147973 > HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 1 packets 2
> 2015-10-21 17:19:09.224023 > HCI Event: Disconn Complete (0x05) plen 4
>    status 0x00 handle 1 reason 0x13
>    Reason: Remote User Terminated Connection

Regards

Marcel

