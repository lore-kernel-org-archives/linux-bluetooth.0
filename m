Return-Path: <cyrus@holtmann.org>
Message-ID: <000601c84639$c8ef8640$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
	<1198437472.8050.305.camel@aeonflux>
	<001001c84619$20f716d0$0200a8c0@jester>
	<1198493046.8050.311.camel@aeonflux>
Date: Mon, 24 Dec 2007 15:32:16 +0100
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Add 3 HCI commands / concurrent connections setup
	question
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

>> I'd like to add : Set_AFH_Host_Channel_Classification (OCF 0x003F),
>> Read_AFH_Channel_Assessment_Mode (OCF 0x0048) and
>> Write_AFH_Channel_Assessment_Mode (OCF 0x0049) to the supported HCI 
>> commands
> what do you wanna do with these commands? More important is, what do you
> expect what is gonna happen if you use them?

You are perfectly right I should have started with this. I have several 
bluetooth dongles and my idea was to split the frequency range between these 
devices so each one have his proper range and does not overlap with others, 
to limit interferences.
This is in the case the host is a master and tries to connect to several 
remote devices so there can be concurrent outgoing page scans from different 
dongles.
However, I realize now that maybe this HCI command is not implemented on 
device chips, so I will maybe have a look first ... no need to implement a 
command which is not supported by any hardware. By the way, don't hesitate 
to tell me if my idea does not make sense at all.

I have something to ask as well ... With CSR's chips trying to open 
concurrent connections makes the first work and others get a "Command 
Disallowed". Then I saw with hcidump that the "Create Connection" is 
re-issued automatically. However, it can be really later sometimes (more 
than several seconds). My question is : how connection requests are 
serialized by the stack ? would it be possible to make the connection 
requests be retried more quickly ? Is there something blocking that would 
explain why it's long ?

Here is a dump of trying to connect to 7 different devices concurrently, 
with a CSR bases dongle ("connect" are performed at the same time, then a 
"sleep 10 seconds", and a "close"). As you can see, times are really ... 
long !

1st device : 1.3 seconds to come back successfully from "connect" socket
2nd device : 5.5 seconds
3rd device : 9.9 seconds
4th device : 10.9 seconds
5th device : 13 seconds
6th device : 18.3 seconds
7th device : 19.8 seconds

Kernel 2.6.23.12, BlueZ 3.23

Best regards,
Oli

-----------------------

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
2007-12-24 14:53:17.426431 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:17:B0:1E:54:FD ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:17.433731 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-24 14:53:17.433752 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:19:2D:15:FF:0E ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:17.443734 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
2007-12-24 14:53:17.443754 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:16:4E:83:2D:19 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:17.454721 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
2007-12-24 14:53:17.454730 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:6E:4C:96 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:17.525718 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
2007-12-24 14:53:17.525729 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:65:27:7F ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:17.536718 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
2007-12-24 14:53:17.536727 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:1A:8A:89:3A:DA ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:17.546717 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
2007-12-24 14:53:17.546724 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:0F:DE:98:2A:DE ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:17.556717 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
2007-12-24 14:53:18.631670 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:17:B0:1E:54:FD type ACL encrypt 0x00
2007-12-24 14:53:18.631689 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-24 14:53:18.631695 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 41
2007-12-24 14:53:18.639668 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.642668 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-12-24 14:53:18.645669 > HCI Event: Page Scan Repetition Mode Change 
(0x20) plen 7
    bdaddr 00:17:B0:1E:54:FD mode 1
2007-12-24 14:53:18.651667 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
2007-12-24 14:53:18.655672 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2007-12-24 14:53:18.655685 < ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
2007-12-24 14:53:18.656672 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
2007-12-24 14:53:18.656685 < ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
2007-12-24 14:53:18.661667 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.662667 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.664668 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-12-24 14:53:18.664677 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-24 14:53:18.666677 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013
2007-12-24 14:53:18.666704 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-24 14:53:18.672666 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.675668 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
2007-12-24 14:53:18.675677 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:0F:DE:98:2A:DE ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:18.676673 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:18.676694 < ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-24 14:53:18.682665 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.686668 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 41
    Features: 0xbf 0xee 0x0f 0xc6 0x9a 0x39 0x00 0x00
2007-12-24 14:53:18.688676 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-24 14:53:18.688688 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:17:B0:1E:54:FD mode 2 clkoffset 0x0000
2007-12-24 14:53:18.699664 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-24 14:53:18.699670 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 0
2007-12-24 14:53:18.699714 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
2007-12-24 14:53:18.725665 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.742667 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-24 14:53:18.742688 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:18.752662 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:17:B0:1E:54:FD name 'Nokia 6234'
2007-12-24 14:53:18.752968 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 41
2007-12-24 14:53:18.761663 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.761669 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:18.761696 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:18.762663 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-24 14:53:18.764666 > ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 9
2007-12-24 14:53:18.765666 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:18.765682 < ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33
2007-12-24 14:53:18.786663 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:18.794662 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 41
    LMP Version: 2.0 (0x3) LMP Subversion: 0x6cc
    Manufacturer: Cambridge Silicon Radio (10)
2007-12-24 14:53:18.808666 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:22.405505 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 44 bdaddr 00:0F:DE:98:2A:DE type ACL encrypt 0x00
2007-12-24 14:53:22.405524 < ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-24 14:53:22.405529 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 44
2007-12-24 14:53:22.415504 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:22.416502 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-12-24 14:53:22.466502 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 44 slots 5
2007-12-24 14:53:22.472499 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-12-24 14:53:22.472506 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 44 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-24 14:53:22.482499 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 44
2007-12-24 14:53:22.482508 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:1A:8A:89:3A:DA ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:22.483501 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 44
    Features: 0xff 0x3b 0x01 0x00 0x00 0x00 0x00 0x00
2007-12-24 14:53:22.492499 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-24 14:53:22.492509 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:0F:DE:98:2A:DE mode 2 clkoffset 0x0000
2007-12-24 14:53:22.503498 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-24 14:53:22.552495 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:0F:DE:98:2A:DE name 'V800'
2007-12-24 14:53:22.552731 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 44
2007-12-24 14:53:22.564497 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-24 14:53:22.571495 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 44
    LMP Version: 1.1 (0x1) LMP Subversion: 0x9240
    Manufacturer: Philips Semiconductors (37)
2007-12-24 14:53:22.632497 > ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0040 result 0 status 0
      Connection successful
2007-12-24 14:53:22.632510 < ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
      MTU 1013
2007-12-24 14:53:22.649491 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:22.821487 > ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 674
2007-12-24 14:53:22.843487 > ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674
2007-12-24 14:53:22.843499 < ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 4
      Success
      MTU 674
2007-12-24 14:53:22.843511 < ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-24 14:53:22.880482 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:22.900480 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:22.922484 > ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:22.922500 < ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(d): cid 0x0045 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 669 max_retrans 0 credits 7
2007-12-24 14:53:22.945480 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:22.966483 > ACL data: handle 44 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 12 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
2007-12-24 14:53:22.966499 < ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43
2007-12-24 14:53:22.986479 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:23.008484 > ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88
2007-12-24 14:53:23.008502 < ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:23.028480 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:23.037481 > ACL data: handle 44 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
2007-12-24 14:53:23.037502 < ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:23.041478 > ACL data: handle 44 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
2007-12-24 14:53:23.041494 < ACL data: handle 44 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 33
2007-12-24 14:53:23.060474 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:23.079472 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:23.102476 > ACL data: handle 44 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 0 fcs 0x89 credits 13
2007-12-24 14:53:25.861352 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 47 bdaddr 00:1A:8A:89:3A:DA type ACL encrypt 0x00
2007-12-24 14:53:25.861369 < ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-24 14:53:25.861375 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 47
2007-12-24 14:53:25.869350 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:25.873351 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-12-24 14:53:25.876354 > HCI Event: Page Scan Repetition Mode Change 
(0x20) plen 7
    bdaddr 00:1A:8A:89:3A:DA mode 1
2007-12-24 14:53:25.881354 > ACL data: handle 47 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
2007-12-24 14:53:25.882353 > ACL data: handle 47 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0040 result 0 status 0
      Connection successful
2007-12-24 14:53:25.882364 < ACL data: handle 47 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
      MTU 1013
2007-12-24 14:53:25.890349 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:25.891350 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 47 slots 5
2007-12-24 14:53:25.895351 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-12-24 14:53:25.895359 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 47 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-24 14:53:25.896356 > ACL data: handle 47 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 336
2007-12-24 14:53:25.902349 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 47
2007-12-24 14:53:25.902357 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:65:27:7F ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:25.907352 > ACL data: handle 47 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 336
2007-12-24 14:53:25.907365 < ACL data: handle 47 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 4
      Success
      MTU 336
2007-12-24 14:53:25.907382 < ACL data: handle 47 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-24 14:53:25.914349 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:25.915350 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:25.919348 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-24 14:53:25.919355 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:1A:8A:89:3A:DA mode 2 clkoffset 0x0000
2007-12-24 14:53:25.929347 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 47
    Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
2007-12-24 14:53:25.930356 > ACL data: handle 47 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:25.930377 < ACL data: handle 47 flags 0x02 dlen 18
    L2CAP(d): cid 0x0045 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 331 max_retrans 0 credits 7
2007-12-24 14:53:25.931348 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-24 14:53:25.955348 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:25.965351 > ACL data: handle 47 flags 0x02 dlen 17
2007-12-24 14:53:25.966350 > ACL data: handle 47 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 8 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
2007-12-24 14:53:25.966368 < ACL data: handle 47 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xc9
2007-12-24 14:53:25.989345 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:26.017343 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:1A:8A:89:3A:DA name 'SAMSUNG SGH-E360'
2007-12-24 14:53:26.017591 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 47
2007-12-24 14:53:26.027344 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-24 14:53:26.123340 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 47
    LMP Version: 1.2 (0x2) LMP Subversion: 0x512
    Manufacturer: Cambridge Silicon Radio (10)
2007-12-24 14:53:26.935306 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 50 bdaddr 00:12:D1:65:27:7F type ACL encrypt 0x00
2007-12-24 14:53:26.935320 < ACL data: handle 50 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-24 14:53:26.935326 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 50
2007-12-24 14:53:26.938305 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 41 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:26.940302 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 44 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:26.943302 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 47 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:26.945304 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:26.947301 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 50 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:26.950303 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-12-24 14:53:26.958310 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 50 slots 5
2007-12-24 14:53:26.962303 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-12-24 14:53:26.962310 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 50 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-24 14:53:26.968306 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 50
2007-12-24 14:53:26.968314 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:6E:4C:96 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:26.975303 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-24 14:53:26.975312 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:12:D1:65:27:7F mode 2 clkoffset 0x0000
2007-12-24 14:53:26.989301 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-24 14:53:26.998309 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 50
    Features: 0xff 0xff 0x2d 0xf8 0x1b 0x18 0x00 0x80
2007-12-24 14:53:27.046298 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:12:D1:65:27:7F name 'SAGEM my401X'
2007-12-24 14:53:27.046527 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 50
2007-12-24 14:53:27.057300 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-24 14:53:27.101297 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 50
    LMP Version: 1.2 (0x2) LMP Subversion: 0xe1b
    Manufacturer: Texas Instruments Inc. (13)
2007-12-24 14:53:27.124300 > ACL data: handle 50 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0600 scid 0x0040 result 0 status 0
      Connection successful
2007-12-24 14:53:27.124314 < ACL data: handle 50 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0600 flags 0x00 clen 4
      MTU 1013
2007-12-24 14:53:27.151294 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:27.178301 > ACL data: handle 50 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2007-12-24 14:53:27.204295 > ACL data: handle 50 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1700
2007-12-24 14:53:27.204307 < ACL data: handle 50 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0600 flags 0x00 result 0 clen 4
      Success
      MTU 1700
2007-12-24 14:53:27.204321 < ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-24 14:53:27.230290 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:27.259288 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:27.286293 > ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:27.286310 < ACL data: handle 50 flags 0x02 dlen 18
    L2CAP(d): cid 0x0600 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-24 14:53:27.314288 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:27.340289 > ACL data: handle 50 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 8 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1003 max_retrans 0 credits 0
2007-12-24 14:53:27.340305 < ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xc9
2007-12-24 14:53:27.368288 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:27.394288 > ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
2007-12-24 14:53:27.394306 < ACL data: handle 50 flags 0x02 dlen 12
    L2CAP(d): cid 0x0600 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:27.424287 > ACL data: handle 50 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:27.424311 < ACL data: handle 50 flags 0x02 dlen 12
    L2CAP(d): cid 0x0600 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:27.425285 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:27.453286 > ACL data: handle 50 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:27.453303 < ACL data: handle 50 flags 0x02 dlen 9
    L2CAP(d): cid 0x0600 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 0 fcs 0x46 credits 33
2007-12-24 14:53:27.454282 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:27.480283 > ACL data: handle 50 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c credits 255
2007-12-24 14:53:27.481281 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:28.343246 > ACL data: handle 47 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
2007-12-24 14:53:28.343267 < ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:28.397242 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:28.422242 > ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:28.422265 < ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:28.449240 > ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:28.449257 < ACL data: handle 47 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 0 fcs 0x46 credits 33
2007-12-24 14:53:28.450238 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:28.475238 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:28.743356 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3
2007-12-24 14:53:28.762223 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:28.786227 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-24 14:53:28.786250 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
2007-12-24 14:53:28.786257 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2007-12-24 14:53:28.815222 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:28.843224 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:28.844220 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 41 packets 1
2007-12-24 14:53:28.870221 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2007-12-24 14:53:29.957174 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 53 bdaddr 00:12:D1:6E:4C:96 type ACL encrypt 0x00
2007-12-24 14:53:29.957191 < ACL data: handle 53 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-24 14:53:29.957197 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 53
2007-12-24 14:53:29.960169 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 41 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:29.962169 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 44 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:29.964170 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 47 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:29.967169 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 50 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:29.968174 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:29.971169 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 53 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:29.972171 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-12-24 14:53:29.986172 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 53 slots 5
2007-12-24 14:53:29.989169 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-12-24 14:53:29.989176 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 53 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-24 14:53:29.999169 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 53
2007-12-24 14:53:29.999178 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:16:4E:83:2D:19 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:30.013169 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 53
    Features: 0xff 0xff 0x2d 0xf8 0x1b 0x18 0x00 0x80
2007-12-24 14:53:30.014174 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-24 14:53:30.014188 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:12:D1:6E:4C:96 mode 2 clkoffset 0x0000
2007-12-24 14:53:30.031168 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-24 14:53:30.093164 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:12:D1:6E:4C:96 name 'my501X'
2007-12-24 14:53:30.093406 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 53
2007-12-24 14:53:30.107166 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-24 14:53:30.110168 > ACL data: handle 53 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0600 scid 0x0040 result 0 status 0
      Connection successful
2007-12-24 14:53:30.110182 < ACL data: handle 53 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0600 flags 0x00 clen 4
      MTU 1013
2007-12-24 14:53:30.149162 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.158169 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 53
    LMP Version: 1.2 (0x2) LMP Subversion: 0xe1b
    Manufacturer: Texas Instruments Inc. (13)
2007-12-24 14:53:30.181165 > ACL data: handle 53 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2007-12-24 14:53:30.214164 > ACL data: handle 53 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1700
2007-12-24 14:53:30.214176 < ACL data: handle 53 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0600 flags 0x00 result 0 clen 4
      Success
      MTU 1700
2007-12-24 14:53:30.214192 < ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-24 14:53:30.280157 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.314156 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.348161 > ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:30.348177 < ACL data: handle 53 flags 0x02 dlen 18
    L2CAP(d): cid 0x0600 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-24 14:53:30.414152 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.447156 > ACL data: handle 53 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 8 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1003 max_retrans 0 credits 0
2007-12-24 14:53:30.447174 < ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xc9
2007-12-24 14:53:30.480148 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.514962 > ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
2007-12-24 14:53:30.514986 < ACL data: handle 53 flags 0x02 dlen 12
    L2CAP(d): cid 0x0600 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:30.549149 > ACL data: handle 53 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:30.549172 < ACL data: handle 53 flags 0x02 dlen 12
    L2CAP(d): cid 0x0600 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:30.550146 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.584144 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.584150 > ACL data: handle 53 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-24 14:53:30.584171 < ACL data: handle 53 flags 0x02 dlen 9
    L2CAP(d): cid 0x0600 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 0 fcs 0x46 credits 33
2007-12-24 14:53:30.619145 > ACL data: handle 53 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c credits 255
2007-12-24 14:53:30.620143 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:30.864956 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-24 14:53:30.880131 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-12-24 14:53:30.953128 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host
2007-12-24 14:53:30.956137 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 44 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:30.959125 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 47 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:30.961125 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 50 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:30.963126 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 53 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:33.009089 < ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2
2007-12-24 14:53:33.020037 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:33.049038 > ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88
2007-12-24 14:53:33.049060 < ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
2007-12-24 14:53:33.049068 < ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0045 scid 0x0040
2007-12-24 14:53:33.073035 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:33.100033 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 44 packets 1
2007-12-24 14:53:33.101038 > ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:33.129034 > ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0045 scid 0x0040
2007-12-24 14:53:34.013995 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 56 bdaddr 00:16:4E:83:2D:19 type ACL encrypt 0x00
2007-12-24 14:53:34.014011 < ACL data: handle 56 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-24 14:53:34.014016 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 56
2007-12-24 14:53:34.015991 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 44 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:34.017994 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 47 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:34.020991 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 50 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:34.022992 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:34.025991 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 53 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:34.027994 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 56 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:34.029992 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-12-24 14:53:34.037999 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 56 slots 5
2007-12-24 14:53:34.048995 > ACL data: handle 56 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2007-12-24 14:53:34.049006 < ACL data: handle 56 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
2007-12-24 14:53:34.049995 > ACL data: handle 56 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
2007-12-24 14:53:34.050008 < ACL data: handle 56 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
2007-12-24 14:53:34.054991 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-12-24 14:53:34.054998 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 56 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-24 14:53:34.055993 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:34.064992 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 56
    Features: 0xbf 0xee 0x0f 0x40 0x18 0x18 0x00 0x00
2007-12-24 14:53:34.065995 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 56
2007-12-24 14:53:34.066010 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:19:2D:15:FF:0E ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-24 14:53:34.069995 > ACL data: handle 56 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013
2007-12-24 14:53:34.070017 < ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-24 14:53:34.070991 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:34.076990 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:34.083991 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-24 14:53:34.083999 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:16:4E:83:2D:19 mode 2 clkoffset 0x0000
2007-12-24 14:53:34.095990 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-24 14:53:34.099993 > ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:34.100012 < ACL data: handle 56 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-24 14:53:34.136989 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:34.168985 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:16:4E:83:2D:19 name 'Nokia 6021'
2007-12-24 14:53:34.168990 > ACL data: handle 56 flags 0x02 dlen 17
2007-12-24 14:53:34.169247 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 56
2007-12-24 14:53:34.180986 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-24 14:53:34.182991 > ACL data: handle 56 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 0
2007-12-24 14:53:34.183015 < ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
2007-12-24 14:53:34.217988 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:34.226987 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 56
    LMP Version: 1.2 (0x2) LMP Subversion: 0x4db
    Manufacturer: Cambridge Silicon Radio (10)
2007-12-24 14:53:34.951953 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:19:2D:15:FF:0E type ACL encrypt 0x00
2007-12-24 14:53:34.951967 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-24 14:53:34.951973 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 42
2007-12-24 14:53:34.954950 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 42 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 43750
    Delay variation: -1
2007-12-24 14:53:34.956950 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 44 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 43750
    Delay variation: -1
2007-12-24 14:53:34.958950 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 47 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 43750
    Delay variation: -1
2007-12-24 14:53:34.959951 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:34.961951 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 50 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 43750
    Delay variation: -1
2007-12-24 14:53:34.963949 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 53 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 43750
    Delay variation: -1
2007-12-24 14:53:34.965950 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 56 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 43750
    Delay variation: -1
2007-12-24 14:53:34.970950 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-12-24 14:53:34.975953 > HCI Event: Page Scan Repetition Mode Change 
(0x20) plen 7
    bdaddr 00:19:2D:15:FF:0E mode 1
2007-12-24 14:53:34.981952 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
2007-12-24 14:53:34.995951 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-12-24 14:53:34.995959 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-24 14:53:35.007953 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
2007-12-24 14:53:35.007961 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:19:2D:15:FF:0E mode 2 clkoffset 0x0000
2007-12-24 14:53:35.023949 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 42
    Features: 0xbf 0xee 0x0f 0x46 0x98 0x19 0x00 0x00
2007-12-24 14:53:35.024953 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-24 14:53:35.050946 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:19:2D:15:FF:0E name 'Nokia N70'
2007-12-24 14:53:35.051175 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 42
2007-12-24 14:53:35.056948 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-24 14:53:35.060951 > ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2007-12-24 14:53:35.060963 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
2007-12-24 14:53:35.061951 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2007-12-24 14:53:35.061962 < ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
2007-12-24 14:53:35.068946 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:35.070947 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:35.072950 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-12-24 14:53:35.072960 < ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
2007-12-24 14:53:35.075950 > ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
2007-12-24 14:53:35.075972 < ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-24 14:53:35.081946 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:35.083946 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:35.109948 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:35.109966 < ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
2007-12-24 14:53:35.110945 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 42
    LMP Version: 2.0 (0x3) LMP Subversion: 0x6cc
    Manufacturer: Cambridge Silicon Radio (10)
2007-12-24 14:53:35.117952 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:35.120949 > ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
2007-12-24 14:53:35.120968 < ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
2007-12-24 14:53:35.125041 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 44 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-24 14:53:35.130943 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:35.135945 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-12-24 14:53:35.195943 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 44 reason 0x16
    Reason: Connection Terminated by Local Host
2007-12-24 14:53:35.198941 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 42 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:35.200939 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 47 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:35.202939 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 50 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:35.205939 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 53 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:35.207942 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 56 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 37500
    Delay variation: -1
2007-12-24 14:53:35.771921 > ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-24 14:53:35.771951 < ACL data: handle 56 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:35.772927 > ACL data: handle 56 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:35.772959 < ACL data: handle 56 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:35.775918 > ACL data: handle 56 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 3
2007-12-24 14:53:35.779915 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:35.780915 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:35.847920 > ACL data: handle 56 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:35.847937 < ACL data: handle 56 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33
2007-12-24 14:53:35.854912 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:37.263856 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-24 14:53:37.263882 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:37.268854 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:37.268880 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:37.271849 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:37.275851 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:37.275858 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 15
2007-12-24 14:53:37.275877 < ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33
2007-12-24 14:53:37.281849 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:37.394952 < ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 8 pf 1 ilen 0 fcs 0x28
2007-12-24 14:53:37.415845 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:37.449845 > ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
2007-12-24 14:53:37.449865 < ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
2007-12-24 14:53:37.449873 < ACL data: handle 50 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0600 scid 0x0040
2007-12-24 14:53:37.460841 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:37.461842 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 50 packets 1
2007-12-24 14:53:37.466847 > ACL data: handle 50 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-24 14:53:37.507847 > ACL data: handle 50 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0600 scid 0x0040
2007-12-24 14:53:38.343832 < ACL data: handle 47 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 0]
      0000: 23 53 01 28                                       #S.(
2007-12-24 14:53:38.350803 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:38.386807 > ACL data: handle 47 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 23 73 01 02                                       #s..
2007-12-24 14:53:38.386826 < ACL data: handle 47 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
2007-12-24 14:53:38.386833 < ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0045 scid 0x0040
2007-12-24 14:53:38.387810 > ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0045
2007-12-24 14:53:38.387826 < ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0045
2007-12-24 14:53:38.399800 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:38.400801 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:38.401801 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 47 packets 1
2007-12-24 14:53:38.436804 > ACL data: handle 47 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0045 scid 0x0040
2007-12-24 14:53:38.817787 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 50 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-24 14:53:38.821781 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 42 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:38.823780 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 47 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:38.825780 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 53 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:38.827784 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 56 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 31250
    Delay variation: -1
2007-12-24 14:53:38.959776 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 47 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-24 14:53:38.962786 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 42 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 25000
    Delay variation: -1
2007-12-24 14:53:38.965774 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 53 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 25000
    Delay variation: -1
2007-12-24 14:53:38.967777 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 56 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 25000
    Delay variation: -1
2007-12-24 14:53:40.515411 < ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 0]
      0000: 23 53 01 28                                       #S.(
2007-12-24 14:53:40.532707 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:40.555712 > ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 23 73 01 02                                       #s..
2007-12-24 14:53:40.555735 < ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0600 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
2007-12-24 14:53:40.555744 < ACL data: handle 53 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0600 scid 0x0040
2007-12-24 14:53:40.561707 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:40.563706 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 53 packets 1
2007-12-24 14:53:40.588707 > ACL data: handle 53 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
2007-12-24 14:53:40.617710 > ACL data: handle 53 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0600 scid 0x0040
2007-12-24 14:53:41.741656 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 53 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-24 14:53:45.772412 < ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3
2007-12-24 14:53:45.781478 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:45.804480 > ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 4b 73 01 f9                                       Ks..
2007-12-24 14:53:45.804503 < ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
2007-12-24 14:53:45.804512 < ACL data: handle 56 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2007-12-24 14:53:45.811475 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:45.813476 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 56 packets 1
2007-12-24 14:53:45.816480 > ACL data: handle 56 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
2007-12-24 14:53:45.821479 > ACL data: handle 56 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2007-12-24 14:53:47.264731 < ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 4b 53 01 d3                                       KS..
2007-12-24 14:53:47.274412 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:47.298413 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 4b 73 01 f9                                       Ks..
2007-12-24 14:53:47.298434 < ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
2007-12-24 14:53:47.298442 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2007-12-24 14:53:47.304410 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:47.305411 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2007-12-24 14:53:47.327416 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
2007-12-24 14:53:47.335414 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2007-12-24 14:53:47.814957 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 56 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-24 14:53:47.820387 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-12-24 14:53:47.860385 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 56 reason 0x16
    Reason: Connection Terminated by Local Host
2007-12-24 14:53:49.334958 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-24 14:53:49.340321 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-12-24 14:53:49.377323 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
