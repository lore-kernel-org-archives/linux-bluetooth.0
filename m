Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Access Point elmeg D@VOS-44.dsl
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian <Kimpenhaus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr3y5uonaqdj9uv@mail.gmx.de>
References: <opr3xmdugiqdj9uv@mail.gmx.de>
	 <1077725935.2919.116.camel@pegasus>  <opr3xs5louqdj9uv@mail.gmx.de>
	 <1077734547.2919.147.camel@pegasus>  <opr3xydd1hqdj9uv@mail.gmx.de>
	 <1077740936.2884.2.camel@pegasus>  <opr3x23lc1qdj9uv@mail.gmx.de>
	 <1077747171.2884.5.camel@pegasus>  <opr3x77rphqdj9uv@mail.gmx.de>
	 <1077753099.2754.1.camel@pegasus>  <opr3x8uqadqdj9uv@mail.gmx.de>
	 <1077757118.2754.4.camel@pegasus>  <opr3yb4dsoqdj9uv@mail.gmx.de>
	 <1077758327.2754.9.camel@pegasus>  <opr3y5uonaqdj9uv@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1077801919.2754.38.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 26 Feb 2004 14:25:19 +0100

Hi Florian,

> sorry my fault Link mode was master. Now I get
> 
> 
> bash-2.05b# dund --nodetach --connect 00:0B:CE:00:01:8E --msdun
> dund[6848]: DUN daemon ver 1.1
> dund[6848]: Searching for LAP on 00:0B:CE:00:01:8E
> dund[6848]: Connecting to 00:0B:CE:00:01:8E channel 1
> dund[6848]: Connection established
> 
> bash-2.05b# hcid -n
> hcid[6838]: HCI daemon ver 2.3 started
> hcid[6838]: HCI dev 0 up
> hcid[6838]: Starting security manager 0
> hcid[6838]: link_key_request (sba=51:3D:23:C9:03:00, dba=8E:01:00:CE:0B:00)
> hcid[6838]: link_key_request (sba=51:3D:23:C9:03:00, dba=8E:01:00:CE:0B:00)
> 
> bash-2.05b# hcidump
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Read Local Supported Features(0x04|0x0003) plen 0
> > HCI Event: Command Complete(0x0e) plen 12
> < HCI Command: Read Buffer Size(0x04|0x0005) plen 0
> > HCI Event: Command Complete(0x0e) plen 11
> < HCI Command: Read BD ADDR(0x04|0x0009) plen 0
> > HCI Event: Command Complete(0x0e) plen 10
> < HCI Command: Read Voice Setting(0x03|0x0025) plen 0
> > HCI Event: Command Complete(0x0e) plen 6
> < HCI Command: Set Event Filter(0x03|0x0005) plen 2
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Write Page Timeout(0x03|0x0018) plen 2
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Write Connection Accept Timeout(0x03|0x0016) plen 2
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Write Scan Enable(0x03|0x001a) plen 1
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Write Authentication Enable(0x03|0x0020) plen 1
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Write Encryption Mode(0x03|0x0022) plen 1
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Write Class of Device(0x03|0x0024) plen 3
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Change Local Name(0x03|0x0013) plen 248
> > HCI Event: Command Complete(0x0e) plen 4
> < HCI Command: Create Connection(0x01|0x0005) plen 13
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Role Change(0x12) plen 8
> > HCI Event: Link Key Request(0x17) plen 6
> < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> > HCI Event: Command Complete(0x0e) plen 10
> > HCI Event: Connect Complete(0x03) plen 11
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> > HCI Event: Command Complete(0x0e) plen 6
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Max Slots Change(0x1b) plen 3
> > HCI Event: Link Key Request(0x17) plen 6
> < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> > HCI Event: Command Complete(0x0e) plen 10
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>      L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>      L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>      MTU 2016
> < ACL data: handle 0x0006 flags 0x02 dlen 14
>      L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0006 flags 0x02 dlen 14
>      L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0006 flags 0x02 dlen 22
>      L2CAP(d): cid 0x40 len 18 [psm 1]
>          SDP SSA Req: tid 0x0 len 0xd
>            pat uuid-16 0x1102 (LAN)
>            max 0xffff
>            aid(s) 0x0004 (ProtocolDescList)
>            cont 00
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0006 flags 0x02 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 1
>      L2CAP(d): cid 0x40 len 31 [psm 1]
>          SDP SSA Rsp: tid 0x0 len 0x1a
>            cnt 0x17
>   len 0x17 frm->len 0x15 n 0x14
>            srv rec #0
>              aid 0x0004 (ProtocolDescList)
>                 uuid-16 0x0100 (L2CAP)
>                 uuid-16 0x0003 (RFCOMM) uint 0x1
>              cont 00
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(s): Connect req: psm 3 scid 0x0041
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>      L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
> < ACL data: handle 0x0006 flags 0x02 dlen 16
>      L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>      MTU 1024
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>      L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
>      MTU 2016
> < ACL data: handle 0x0006 flags 0x02 dlen 14
>      L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0006 flags 0x02 dlen 14
>      L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0006 flags 0x02 dlen 8
>      L2CAP(d): cid 0x40 len 4 [psm 3]
>        RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0006 flags 0x02 dlen 8
>      L2CAP(d): cid 0x41 len 4 [psm 3]
>        RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 0x0006 flags 0x02 dlen 18
>      L2CAP(d): cid 0x40 len 14 [psm 3]
>        RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>        dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 1019 
> max_r
> etrans 0 credits 7
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0006 flags 0x02 dlen 18
>      L2CAP(d): cid 0x41 len 14 [psm 3]
>        RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>        dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 1019 
> max_r
> etrans 0 credits 0
> < ACL data: handle 0x0006 flags 0x02 dlen 8
>      L2CAP(d): cid 0x40 len 4 [psm 3]
>        RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> > ACL data: handle 0x0006 flags 0x02 dlen 8
>      L2CAP(d): cid 0x41 len 4 [psm 3]
>        RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(d): cid 0x40 len 8 [psm 3]
>        RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> > ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(d): cid 0x41 len 8 [psm 3]
>        RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(d): cid 0x40 len 8 [psm 3]
>        RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> > ACL data: handle 0x0006 flags 0x02 dlen 9
>      L2CAP(d): cid 0x41 len 5 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c
> > ACL data: handle 0x0006 flags 0x02 dlen 12
>      L2CAP(d): cid 0x41 len 8 [psm 3]
>        RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> < ACL data: handle 0x0006 flags 0x02 dlen 9
>      L2CAP(d): cid 0x40 len 5 [psm 3]
>        RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86
> < ACL data: handle 0x0006 flags 0x02 dlen 14
>      L2CAP(d): cid 0x40 len 10 [psm 3]
>        RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0006 flags 0x02 dlen 48
>      L2CAP(d): cid 0x41 len 44 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 39 fcs 0x5c
> > ACL data: handle 0x0006 flags 0x02 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 13
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 13
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 17
> > ACL data: handle 0x0006 flags 0x01 dlen 13
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 47
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 47
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 47
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 47
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 47
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> > ACL data: handle 0x0006 flags 0x02 dlen 47
>      L2CAP(d): cid 0x41 len 43 [psm 3]
>        RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 39 fcs 0x40
> 
> 
> 
> 
> looks like we are on stepp away from getting this working.
> So could you tell me what comes next or is there a nice howto
> for the next step(s)(I am getting a bad conscience writing so
> many begging mails and keep you off your work) If no howto exist
> I promise to write one if I get it running. 

you should have a working PPP over RFCOMM connection. There are many
howto's at http://www.holtmann.org/linux/bluetooth/ and now it is only a
problem of using the right PPP settings.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
