Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 24 Jul 2006 15:56:21 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060724155621.02cd5e11@localhost.localdomain>
In-Reply-To: <44C4CC37.1060308@infitsrl.com>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC> <44C4CC37.1060308@infitsrl.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] It's rfcomm connect problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabrizio,

thank your for that information. I guess your problem is just the same
you had with sdp some while ago. A single BT Device can not *start*
connecting to two different remote devices at the same time. 

To solve this you have to find a way to:

1. Create Connection to device A 
2. Wait until Connect Complete for A's bdaddr happens (no matter if failed or succ.)
3. Then continue with other Create Connection Commands

Greetings

Andy

On Mon, 24 Jul 2006 15:33:43 +0200
Fabrizio Guglielmino <guglielmino@infitsrl.com> wrote:

> Hi Andy,
> I Andy the problem I have is described in following hcidump:
> 
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:09:2D:2A:68:20 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1

-- this is too soon to connect to 00:01:E3:25:53:44....
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:01:E3:25:53:44 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x0c ncmd 1
>     Error: Command Disallowed
>  > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 42 bdaddr 00:09:2D:2A:68:20 type ACL encrypt 0x00
-- after this changes are much better....

> < ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 42 slots 5
>  > ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 0 status 0
>       Connection successful
> < ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
>       MTU 1024
>  > ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 1691
> < ACL data: handle 42 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
>       Success
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 42 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0044 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 42 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0044 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 4 frame_type 0 credit_flow 15 pri 7 ack_timer 0
>       frame_size 1019 max_retrans 0 credits 7
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 4 frame_type 0 credit_flow 14 pri 0 ack_timer 0
>       frame_size 1019 max_retrans 0 credits 7
> < ACL data: handle 42 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0044 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d
> < ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0044 len 8 [psm 3]
>       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0040 len 8 [psm 3]
>       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
>  > ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0040 len 8 [psm 3]
>       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0044 len 8 [psm 3]
>       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 42 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0044 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 33
> < ACL data: handle 42 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0044 len 21 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 17 fcs 0x65
>       0000: 80 00 11 10 00 08 00 00  00 00 00 00 00 00 00 00  
> ................
>       0010: 00                                                .
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 23
> 
> As You can see the second Create Connection fails with a Command 
> disallowed.....
> In my case I've no see any hci_reset.....
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
