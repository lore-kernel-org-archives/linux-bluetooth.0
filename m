Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8a7a8d7b1002031013n3203cb23h93d07a4f15d0304f@mail.gmail.com>
References: <8a7a8d7b1002021350o3c80c7d9p948365ea983a0d89@mail.gmail.com>
	 <1265210547.31341.118.camel@localhost.localdomain>
	 <8a7a8d7b1002031013n3203cb23h93d07a4f15d0304f@mail.gmail.com>
Date: Tue, 9 Feb 2010 20:52:44 -0600
Message-ID: <8a7a8d7b1002091852p4b76917fnd43c2346943caa6a@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth:L2CAP check FEAT success
From: Liejun Tao <liejuntao001@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Wed, Feb 3, 2010 at 12:13 PM, Liejun Tao <liejuntao001@gmail.com> wrote:
> Hi Marcel,
>
>> Hi Liejun,
>>
>> I might have an idea what is going here. Can you send me the whole
>> hcidump -X -V from the Create Connection to the Connection Refused
>> without having it mangled via your mailer.
>>
>> Regards
>>
>> Marcel
>
> In my source, function l2cap_security_cfm & l2cap_information_rsp is
> almost same as 2.6.33-rc6.
>
> Ed's log looks almost same as mine.
> There migh be minor vairaty like
>
> 1.sometimes after Info Req: type 2, there is a Info Req: type 3.
>
> HCI sniffer - Bluetooth packet analyzer ver 1.42
>
> device: hci0 snap_len: 1028 filter: 0xffffffff
>
> 2010-02-03 18:03:47.446807 < HCI Command: Create Connection
> (0x01|0x0005) plen 13
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA ptype 0xcc18 rswitch 0x01 clkoffset 0x000=
0
>
> =A0 =A0Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>
> 2010-02-03 18:03:47.455749 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Create Connection (0x01|0x0005) status 0x00 ncmd 1
>
> 2010-02-03 18:03:47.993408 > HCI Event: Link Key Request (0x17) plen 6
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA
>
> 2010-02-03 18:03:47.997131 < HCI Command: Link Key Request Reply
> (0x01|0x000b) plen 22
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA key 09F010B636EBEC8A3E0E81BBD7AE1CAA
>
> 2010-02-03 18:03:47.997802 > HCI Event: Command Complete (0x0e) plen 10
>
> =A0 =A0Link Key Request Reply (0x01|0x000b) ncmd 1
>
> =A0 =A0status 0x00 bdaddr 00:24:9F:AC:1E:EA
>
> 2010-02-03 18:03:48.014465 > HCI Event: Connect Complete (0x03) plen 11
>
> =A0 =A0status 0x00 handle 1 bdaddr 00:24:9F:AC:1E:EA type ACL encrypt 0x0=
0
>
> 2010-02-03 18:03:48.014678 < HCI Command: Read Remote Supported
> Features (0x01|0x001b) plen 2
>
> =A0 =A0handle 1
>
> 2010-02-03 18:03:48.015563 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>
> 2010-02-03 18:03:48.022430 < HCI Command: Remote Name Request
> (0x01|0x0019) plen 10
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA mode 2 clkoffset 0x0000
>
> 2010-02-03 18:03:48.023437 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>
> 2010-02-03 18:03:48.024230 > HCI Event: Max Slots Change (0x1b) plen 3
>
> =A0 =A0handle 1 slots 5
>
> 2010-02-03 18:03:48.028198 > HCI Event: Read Remote Supported Features
> (0x0b) plen 11
>
> =A0 =A0status 0x00 handle 1
>
> =A0 =A0Features: 0xbf 0xfe 0x8f 0xfe 0x98 0x19 0x00 0x80
>
> 2010-02-03 18:03:48.028320 < ACL data: handle 1 flags 0x02 dlen 10
>
> =A0 =A0L2CAP(s): Info req: type 2
>
> 2010-02-03 18:03:48.031616 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 1
>
> 2010-02-03 18:03:48.039977 > HCI Event: Remote Name Req Complete (0x07) p=
len 255
>
> =A0 =A0status 0x00 bdaddr 00:24:9F:AC:1E:EA name 'BlackBerry 8900'
>
> 2010-02-03 18:03:48.042755 > ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Info rsp: type 2 result 1
>
> =A0 =A0 =A0Not supported
>
> 2010-02-03 18:03:48.042846 < ACL data: handle 1 flags 0x02 dlen 10
>
> =A0 =A0L2CAP(s): Info req: type 3
>
> 2010-02-03 18:03:48.045226 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 1
>
> 2010-02-03 18:03:48.090545 > HCI Event: Encrypt Change (0x08) plen 4
>
> =A0 =A0status 0x00 handle 1 encrypt 0x01
>
> 2010-02-03 18:03:48.090728 < ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Connect req: psm 3 scid 0x0040
>
> 2010-02-03 18:03:48.094024 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 1
>
> 2010-02-03 18:03:48.094146 > ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Info rsp: type 3 result 1
>
> =A0 =A0 =A0Not supported
>
> 2010-02-03 18:03:48.094238 < ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Connect req: psm 3 scid 0x0040
>
> 2010-02-03 18:03:48.096618 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 1
>
> 2010-02-03 18:03:48.104003 > ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>
> =A0 =A0 =A0Connection successful
>
> 2010-02-03 18:03:48.104095 < ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>
> =A0 =A0 =A0MTU 1013
>
> 2010-02-03 18:03:48.104125 > ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>
> =A0 =A0 =A0MTU 1024
>
> 2010-02-03 18:03:48.104156 < ACL data: handle 1 flags 0x02 dlen 18
>
> =A0 =A0L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>
> =A0 =A0 =A0MTU 1024
>
> 2010-02-03 18:03:48.104339 > ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 4 status 0
>
> =A0 =A0 =A0Connection refused - no resources available
>
> 2010-02-03 18:03:48.107696 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 2
>
> 2010-02-03 18:03:48.115264 > ACL data: handle 1 flags 0x02 dlen 14
>
> =A0 =A0L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>
> =A0 =A0 =A0Success
>
> 2010-02-03 18:03:48.115386 > ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
>
> 2010-02-03 18:03:50.101531 < HCI Command: Disconnect (0x01|0x0006) plen 3
>
> =A0 =A0handle 1 reason 0x13
>
> =A0 =A0Reason: Remote User Terminated Connection
>
> 2010-02-03 18:03:50.102508 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Disconnect (0x01|0x0006) status 0x00 ncmd 1
>
> 2010-02-03 18:03:50.105438 > HCI Event: Disconn Complete (0x05) plen 4
>
> =A0 =A0status 0x00 handle 1 reason 0x16
>
> =A0 =A0Reason: Connection Terminated by Local Host
>
>
> 2. sometimes Encrypt Change is before Info Req: type 2
>
> HCI sniffer - Bluetooth packet analyzer ver 1.42
>
> 2010-02-03 17:58:29.214416 < HCI Command: Create Connection
> (0x01|0x0005) plen 13
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA ptype 0xcc18 rswitch 0x01 clkoffset 0x000=
0
>
> =A0 =A0Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>
> 2010-02-03 17:58:29.234832 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Create Connection (0x01|0x0005) status 0x00 ncmd 1
>
> 2010-02-03 17:58:30.559875 > HCI Event: Link Key Request (0x17) plen 6
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA
>
> 2010-02-03 17:58:30.563995 < HCI Command: Link Key Request Reply
> (0x01|0x000b) plen 22
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA key 09F010B636EBEC8A3E0E81BBD7AE1CAA
>
> 2010-02-03 17:58:30.564819 > HCI Event: Command Complete (0x0e) plen 10
>
> =A0 =A0Link Key Request Reply (0x01|0x000b) ncmd 1
>
> =A0 =A0status 0x00 bdaddr 00:24:9F:AC:1E:EA
>
> 2010-02-03 17:58:30.580596 > HCI Event: Connect Complete (0x03) plen 11
>
> =A0 =A0status 0x00 handle 1 bdaddr 00:24:9F:AC:1E:EA type ACL encrypt 0x0=
0
>
> 2010-02-03 17:58:30.580779 < HCI Command: Read Remote Supported
> Features (0x01|0x001b) plen 2
>
> =A0 =A0handle 1
>
> 2010-02-03 17:58:30.581634 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>
> 2010-02-03 17:58:30.587951 > HCI Event: Max Slots Change (0x1b) plen 3
>
> =A0 =A0handle 1 slots 5
>
> 2010-02-03 17:58:30.590515 > HCI Event: Read Remote Supported Features
> (0x0b) plen 11
>
> =A0 =A0status 0x00 handle 1
>
> =A0 =A0Features: 0xbf 0xfe 0x8f 0xfe 0x98 0x19 0x00 0x80
>
> 2010-02-03 17:58:30.590667 < ACL data: handle 1 flags 0x02 dlen 10
>
> =A0 =A0L2CAP(s): Info req: type 2
>
> 2010-02-03 17:58:30.593902 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 1
>
> 2010-02-03 17:58:30.600280 < HCI Command: Remote Name Request
> (0x01|0x0019) plen 10
>
> =A0 =A0bdaddr 00:24:9F:AC:1E:EA mode 2 clkoffset 0x0000
>
> 2010-02-03 17:58:30.600799 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>
> 2010-02-03 17:58:30.615020 > HCI Event: Remote Name Req Complete (0x07) p=
len 255
>
> =A0 =A0status 0x00 bdaddr 00:24:9F:AC:1E:EA name 'BlackBerry 8900'
>
> 2010-02-03 17:58:30.639282 > HCI Event: Encrypt Change (0x08) plen 4
>
> =A0 =A0status 0x00 handle 1 encrypt 0x01
>
> 2010-02-03 17:58:30.639434 < ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Connect req: psm 3 scid 0x0040
>
> 2010-02-03 17:58:30.642669 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 1
>
> 2010-02-03 17:58:30.642822 > ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Info rsp: type 2 result 1
>
> =A0 =A0 =A0Not supported
>
> 2010-02-03 17:58:30.642883 < ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Connect req: psm 3 scid 0x0040
>
> 2010-02-03 17:58:30.645141 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 1
>
> 2010-02-03 17:58:30.652862 > ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>
> =A0 =A0 =A0Connection successful
>
> 2010-02-03 17:58:30.652862 > ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>
> =A0 =A0 =A0MTU 1024
>
> 2010-02-03 17:58:30.652984 > ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 4 status 0
>
> =A0 =A0 =A0Connection refused - no resources available
>
> 2010-02-03 17:58:30.653137 < ACL data: handle 1 flags 0x02 dlen 16
>
> =A0 =A0L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>
> =A0 =A0 =A0MTU 1013
>
> 2010-02-03 17:58:30.653198 < ACL data: handle 1 flags 0x02 dlen 18
>
> =A0 =A0L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>
> =A0 =A0 =A0MTU 1024
>
> 2010-02-03 17:58:30.657653 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>
> =A0 =A0handle 1 packets 2
>
> 2010-02-03 17:58:30.665191 > ACL data: handle 1 flags 0x02 dlen 14
>
> =A0 =A0L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>
> =A0 =A0 =A0Success
>
> 2010-02-03 17:58:30.665283 > ACL data: handle 1 flags 0x02 dlen 12
>
> =A0 =A0L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
>
> 2010-02-03 17:58:32.648467 < HCI Command: Disconnect (0x01|0x0006) plen 3
>
> =A0 =A0handle 1 reason 0x13
>
> =A0 =A0Reason: Remote User Terminated Connection
>
> 2010-02-03 17:58:32.649322 > HCI Event: Command Status (0x0f) plen 4
>
> =A0 =A0Disconnect (0x01|0x0006) status 0x00 ncmd 1
>
> 2010-02-03 17:58:32.652984 > HCI Event: Disconn Complete (0x05) plen 4
>
> =A0 =A0status 0x00 handle 1 reason 0x16
>
> =A0 =A0Reason: Connection Terminated by Local Host
>
