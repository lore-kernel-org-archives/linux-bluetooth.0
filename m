Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <461C85DB.4030209@gmail.com>
Date: Wed, 11 Apr 2007 10:53:15 +0400
From: Sergey Smirnov <svs1957@gmail.com>
MIME-Version: 1.0
To: Mayank BATRA <mayank.batra@st.com>
References: <004401c77c04$66bcef80$9d0cc70a@dlh.st.com>
In-Reply-To: <004401c77c04$66bcef80$9d0cc70a@dlh.st.com>
Cc: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco: Operation not supported
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

svs-zaurus:~# hcidump -V
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0F:DE:3E:AE:12 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 4
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0F:DE:3E:AE:12
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0F:DE:3E:AE:12 key 5200129BC988A7B6F83756A822D3B174
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 4
    status 0x00 bdaddr 00:0F:DE:3E:AE:12
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:0F:DE:3E:AE:12 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0051 flags 0x00 clen 0
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 454
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0051 flags 0x00 result 0 clen 4
      Success
      MTU 454
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 4
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 4
    status 0x00 handle 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0F:DE:3E:AE:12 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x0c ncmd 4
    Error: Command Disallowed
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 454
< ACL data: handle 1 flags 0x02 dlen 24
    L2CAP(d): cid 0x0051 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 4
    L2CAP(d): cid 0x0040 len 102 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x61
          count 94
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "SonyEricsson Headset Service"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0051 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0040
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 4
    status 0x00 voice setting 0x0060
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 4
      MTU 1013
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 454
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 4
      Success
      MTU 454
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 17
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 454
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0052 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 449 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 449 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 7
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 7
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0052 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 8
    L2CAP(d): cid 0x0040 len 21 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 16 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
< HCI Command: Sniff Mode (0x02|0x0003) plen 10
    handle 1 max 800 min 80 attempt 4 timeout 1
> HCI Event: Command Status (0x0f) plen 4
    Sniff Mode (0x02|0x0003) status 0x23 ncmd 4
    Error: LMP Error Transaction Collision
< ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(d): cid 0x0052 len 16 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 12 fcs 0x9a
< ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(d): cid 0x0052 len 16 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 12 fcs 0x9a
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 1 ptype 0x0020
    Packet type: HV1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x02 interval 2048
    Mode: Sniff
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Add SCO Connection (0x01|0x0007) status 0x11 ncmd 4
    Error: Unsupported Feature or Parameter Value
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2

Mayank BATRA wrote:
>> Sorry for stupid question.
>> Part of what you want to see?
> 
> Actually, I wanted to see Add SCO connection command on hcidump.
> Not the source code! Just wanted to see what packet types are going
> in the command.
> 
> [...]
>>>> Here is some part of hcidump while sco connect:
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>     handle 1 packets 1
>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>     Add SCO Connection (0x01|0x0007) status 0x11 ncmd 4
>>>>     Error: Unsupported Feature or Parameter Value
>>> Can you provide the part showing the Add SCO connection command?
>>> You might have to try different packet types.
> 
> Best Regards,
> 
> Mayank
> 
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
