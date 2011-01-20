Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110119180107.GE11083@joana>
References: <1295443329-26860-1-git-send-email-tim.bao@gmail.com>
	<20110119180107.GE11083@joana>
Date: Thu, 20 Jan 2011 10:31:11 +0800
Message-ID: <AANLkTimGdeu17sn8bxtp5TNd8i_0hpwpsmRy0wc98y8v@mail.gmail.com>
Subject: Re: [PATCH] Set connection state to BT_DISCONN to avoid multiple responses
From: Liang Bao <tim.bao@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/1/20 Gustavo F. Padovan <padovan@profusion.mobi>:
> Hi Bao,
>
> * tim.bao@gmail.com <tim.bao@gmail.com> [2011-01-19 21:22:09 +0800]:
>
>> From: Bao Liang <tim.bao@gmail.com>
>>
>> This patch fixes a minor issue that two connection responses will be sent
>> for one L2CAP connection request. If the L2CAP connection request is first
>> blocked due to security reason and responded with reason "security block",
>> the state of the connection remains BT_CONNECT2. If a pairing procedure
>> completes successfully before the ACL connection is down, local host will
>> send another connection complete response. See the following packets
>> captured by hcidump.
>>
>> 2010-12-07 22:21:24.928096 < ACL data: handle 12 flags 0x00 dlen 16
>>     0000: 0c 00 01 00 03 19 08 00  41 00 53 00 03 00 00 00  ........A.S.....
>> ... ...
>>
>> 2010-12-07 22:21:35.791747 > HCI Event: Auth Complete (0x06) plen 3
>>     status 0x00 handle 12
>> ... ...
>>
>> 2010-12-07 22:21:35.872372 > ACL data: handle 12 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0040 result 0 status 0
>>       Connection successful
>
> Please provide a more helpful hcidump showing at least the connection request
> and the two connection response.
Sure, here's the full log of one try with the following steps:
- Unpair from the host side while KB is connected.(2010-12-07 22:21:13.133047)
- Press the "Connect" button of Logitech V470, the mouse will try to
connect back although it's put into discoverable mode
meanwhile(2010-12-07 22:21:24.459891).
- HID control channel will be asked to UNPLUG but the HID interrupt
channel will be refused for reason security block. See 2010-12-07
22:21:24.928096 - no idea why it's not decoded into ASCII format by
hcidump but FTS4BT can decode it as  "Result: Refused - Security
block"
- Quickly start pair from phone side before the ACL link is down. For
dev purpose, the ACL timeout is increased but the phenomenon is still
observable with a starndard version if start pair quickly enough.
Pairing will complete without error. See 2010-12-07 22:21:35.791747
- Immediately after "auth complete", host side will respond to the
V470 with "connection successful". See 2010-12-07 22:21:35.872372

I also post log of multiple tries (including this) to
http://pastebin.com/TPHgNUKd for your reference.

It's not a big issue and connection can be finally made by a second
try in most cases. However, removing this will set the state to closed
because the host actually declined the connection request and hence a
second rsp to the l2cap_conn_req shall not be sent. Just my two cents.

2010-12-07 22:21:13.099872 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x16
    Reason: Connection Terminated by Local Host
2010-12-07 22:21:13.125585 < HCI Command: Delete Stored Link Key
(0x03|0x0012) plen 7
    bdaddr 00:1F:20:01:C9:B8 all 0
2010-12-07 22:21:13.133047 > HCI Event: Command Complete (0x0e) plen 6
    Delete Stored Link Key (0x03|0x0012) ncmd 1
    status 0x00 deleted 0
2010-12-07 22:21:24.459891 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:1F:20:01:C9:B8 class 0x002580 type ACL
2010-12-07 22:21:24.460063 < HCI Command: Accept Connection Request
(0x01|0x0009) plen 7
    bdaddr 00:1F:20:01:C9:B8 role 0x00
    Role: Master
2010-12-07 22:21:24.470041 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2010-12-07 22:21:24.629984 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:1F:20:01:C9:B8 role 0x00
    Role: Master
2010-12-07 22:21:24.780008 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:1F:20:01:C9:B8 type ACL encrypt 0x00
2010-12-07 22:21:24.780135 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 12
2010-12-07 22:21:24.792511 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2010-12-07 22:21:24.792546 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
2010-12-07 22:21:24.815529 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0052
2010-12-07 22:21:24.815727 < ACL data: handle 12 flags 0x00 dlen 16
    0C 00 01 00 03 17 08 00 40 00 52 00 01 00 00 00
2010-12-07 22:21:24.815848 < ACL data: handle 12 flags 0x00 dlen 10
    06 00 01 00 0A 01 02 00 02 00
2010-12-07 22:21:24.822141 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
    bdaddr 00:1F:20:01:C9:B8 mode 2 clkoffset 0x0000
2010-12-07 22:21:24.832574 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:24.832597 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2010-12-07 22:21:24.832602 > ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
        Bi-directional QoS
2010-12-07 22:21:24.832756 < ACL data: handle 12 flags 0x00 dlen 16
    0C 00 01 00 03 17 08 00 40 00 52 00 00 00 00 00
2010-12-07 22:21:24.879811 > ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185
2010-12-07 22:21:24.879871 < ACL data: handle 12 flags 0x00 dlen 18
    0E 00 01 00 05 18 0A 00 52 00 00 00 00 00 01 02 B9 00
2010-12-07 22:21:24.879960 < ACL data: handle 12 flags 0x00 dlen 12
    08 00 01 00 04 02 04 00 52 00 00 00
2010-12-07 22:21:24.899815 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:24.899828 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1F:20:01:C9:B8 name 'Bluetooth Laser Travel Mouse'
2010-12-07 22:21:24.919852 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 185
2010-12-07 22:21:24.919865 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0053
2010-12-07 22:21:24.919951 < ACL data: handle 12 flags 0x00 dlen 16
    0C 00 01 00 03 19 08 00 41 00 53 00 01 00 02 00
2010-12-07 22:21:24.920192 < ACL data: handle 12 flags 0x00 dlen 5
    01 00 52 00 15
2010-12-07 22:21:24.920308 < ACL data: handle 12 flags 0x00 dlen 12
    08 00 01 00 06 03 04 00 52 00 40 00
2010-12-07 22:21:24.928096 < ACL data: handle 12 flags 0x00 dlen 16
    0C 00 01 00 03 19 08 00 41 00 53 00 03 00 00 00
2010-12-07 22:21:24.929844 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:24.929857 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:24.939857 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0052 scid 0x0040
2010-12-07 22:21:25.109941 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 1
2010-12-07 22:21:27.273753 < HCI Command: Authentication Requested
(0x01|0x0011) plen 2
    handle 12
2010-12-07 22:21:27.290059 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2010-12-07 22:21:27.290081 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:1F:20:01:C9:B8
2010-12-07 22:21:27.291243 < HCI Command: Link Key Request Negative
Reply (0x01|0x000c) plen 6
    bdaddr 00:1F:20:01:C9:B8
2010-12-07 22:21:27.300072 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:1F:20:01:C9:B8
2010-12-07 22:21:27.300101 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:1F:20:01:C9:B8
2010-12-07 22:21:35.678564 < HCI Command: PIN Code Request Reply
(0x01|0x000d) plen 23
    bdaddr 00:1F:20:01:C9:B8 len 4 pin '0000'
2010-12-07 22:21:35.692679 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:1F:20:01:C9:B8
2010-12-07 22:21:35.791738 > HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:1F:20:01:C9:B8 key EFA3DFDFC773E2B4C5D5C3E409DA84A9 type 0
2010-12-07 22:21:35.791747 > HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 12
2010-12-07 22:21:35.791829 < ACL data: handle 12 flags 0x00 dlen 16
    0C 00 01 00 03 19 08 00 41 00 53 00 00 00 00 00
2010-12-07 22:21:35.817243 < ACL data: handle 12 flags 0x00 dlen 12
    08 00 01 00 02 04 04 00 01 00 40 00
2010-12-07 22:21:35.832388 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:35.872372 > ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0040 result 0 status 0
      Connection successful
2010-12-07 22:21:35.872429 < ACL data: handle 12 flags 0x00 dlen 12
    08 00 01 00 04 05 04 00 54 00 00 00
2010-12-07 22:21:35.902318 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 185
2010-12-07 22:21:35.902330 > ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185
2010-12-07 22:21:35.902407 < ACL data: handle 12 flags 0x00 dlen 18
    0E 00 01 00 05 1A 0A 00 54 00 00 00 00 00 01 02 B9 00
2010-12-07 22:21:35.902707 < ACL data: handle 12 flags 0x00 dlen 24
    14 00 54 00 06 00 00 00 0F 35 03 19 01 00 FF FF 35 05 0A 00
    00 FF FF 00
2010-12-07 22:21:35.923249 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:36.042451 > ACL data: handle 12 flags 0x02 dlen 27
2010-12-07 22:21:36.042480 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.042487 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.052466 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.052485 > ACL data: handle 12 flags 0x01 dlen 24
    L2CAP(d): cid 0x0040 len 128 [psm 0]
      07 00 00 00 7B 00 76 36 01 C0 36 01 60 09 00 00 0A 00 01 00
      00 09 00 01 35 03 19 11 24 09 00 04 35 0D 35 06 19 01 00 09
      00 11 35 03 19 00 11 09 00 05 35 03 19 10 02 09 00 06 35 09
      09 65 6E 09 00 6A 09 01 00 09 00 09 35 08 35 06 19 11 24 09
      01 00 09 00 0D 35 0F 35 0D 35 06 19 01 00 09 00 13 35 03 19
      00 11 09 01 00 25 22 4C 6F 67 69 74 65 63 68 20 56 34 37 30
      20 43 6F 72 64 02 00 76
2010-12-07 22:21:36.053674 < ACL data: handle 12 flags 0x00 dlen 26
    16 00 54 00 06 00 01 00 11 35 03 19 01 00 FF FF 35 05 0A 00
    00 FF FF 02 00 76
2010-12-07 22:21:36.062537 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:36.180597 > ACL data: handle 12 flags 0x02 dlen 27
2010-12-07 22:21:36.180613 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.180621 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.180625 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.192515 > ACL data: handle 12 flags 0x01 dlen 24
    L2CAP(d): cid 0x0040 len 128 [psm 0]
      07 00 01 00 7B 00 76 6C 65 73 73 20 4C 61 73 65 72 20 4D 6F
      75 73 65 09 01 01 25 0F 42 6C 75 65 74 6F 6F 74 68 20 4D 6F
      75 73 65 09 01 02 25 08 4C 6F 67 69 74 65 63 68 09 02 00 09
      01 00 09 02 01 09 01 11 09 02 02 08 80 09 02 03 08 21 09 02
      04 28 01 09 02 05 28 01 09 02 06 35 68 35 66 08 22 25 62 05
      01 09 02 A1 01 85 02 09 01 A1 00 05 09 19 01 29 08 15 00 25
      01 75 01 95 08 02 00 EC
2010-12-07 22:21:36.193599 < ACL data: handle 12 flags 0x00 dlen 26
    16 00 54 00 06 00 02 00 11 35 03 19 01 00 FF FF 35 05 0A 00
    00 FF FF 02 00 EC
2010-12-07 22:21:36.300605 > ACL data: handle 12 flags 0x02 dlen 27
2010-12-07 22:21:36.300622 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.312521 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.312539 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.312543 > ACL data: handle 12 flags 0x01 dlen 24
    L2CAP(d): cid 0x0040 len 128 [psm 0]
      07 00 02 00 7B 00 76 81 02 05 01 09 30 09 31 16 01 F8 26 FF
      07 75 0C 95 02 81 06 09 38 15 81 25 7F 75 08 95 01 81 06 05
      0C 0A 38 02 75 08 95 01 81 06 C0 C0 06 00 FF 09 01 A1 01 85
      10 75 08 95 06 15 00 26 FF 00 09 01 81 00 09 01 91 00 C0 09
      02 07 35 08 35 06 09 04 09 09 01 00 09 02 08 28 00 09 02 09
      28 01 09 02 0A 28 01 09 02 0B 09 01 00 09 02 0C 09 0C 80 09
      02 0D 28 00 09 02 01 62
2010-12-07 22:21:36.313630 < ACL data: handle 12 flags 0x00 dlen 26
    16 00 54 00 06 00 03 00 11 35 03 19 01 00 FF FF 35 05 0A 00
    00 FF FF 02 01 62
2010-12-07 22:21:36.322432 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:36.440618 > ACL data: handle 12 flags 0x02 dlen 27
2010-12-07 22:21:36.440635 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.440639 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.440643 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.452517 > ACL data: handle 12 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 105 [psm 0]
      07 00 03 00 64 00 61 02 0E 28 01 36 00 5A 09 00 00 0A 00 01
      00 01 09 00 01 35 03 19 12 00 09 00 04 35 0D 35 06 19 01 00
      09 00 01 35 03 19 00 01 09 00 05 35 03 19 10 02 09 00 09 35
      08 35 06 19 12 00 09 01 00 09 02 00 09 01 00 09 02 01 09 04
      6D 09 02 02 09 B0 08 09 02 03 09 03 17 09 02 04 28 01 09 02
      05 09 00 02 00
2010-12-07 22:21:36.484591 < ACL data: handle 12 flags 0x00 dlen 24
    14 00 54 00 06 00 04 00 0F 35 03 19 12 00 FF FF 35 05 0A 00
    00 FF FF 00
2010-12-07 22:21:36.592512 > ACL data: handle 12 flags 0x02 dlen 27
2010-12-07 22:21:36.592536 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.592540 > ACL data: handle 12 flags 0x01 dlen 27
2010-12-07 22:21:36.592550 > ACL data: handle 12 flags 0x01 dlen 27
    L2CAP(d): cid 0x0040 len 104 [psm 0]
      07 00 04 00 63 00 60 36 00 5D 36 00 5A 09 00 00 0A 00 01 00
      01 09 00 01 35 03 19 12 00 09 00 04 35 0D 35 06 19 01 00 09
      00 01 35 03 19 00 01 09 00 05 35 03 19 10 02 09 00 09 35 08
      35 06 19 12 00 09 01 00 09 02 00 09 01 00 09 02 01 09 04 6D
      09 02 02 09 B0 08 09 02 03 09 03 17 09 02 04 28 01 09 02 05
      09 00 02 00
2010-12-07 22:21:36.666846 < ACL data: handle 12 flags 0x00 dlen 12
    08 00 01 00 02 06 04 00 11 00 42 00
2010-12-07 22:21:36.672425 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 2
2010-12-07 22:21:36.702399 > ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0042 result 4 status 0
      Connection refused - no resources available
2010-12-07 22:21:38.422526 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0054
2010-12-07 22:21:38.422675 < ACL data: handle 12 flags 0x00 dlen 12
    08 00 01 00 07 1B 04 00 40 00 54 00
2010-12-07 22:21:38.602501 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 12 packets 1
2010-12-07 22:21:38.602523 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>
