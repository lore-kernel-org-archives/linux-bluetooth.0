Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1157366293.32195.41.camel@aeonflux.holtmann.net>
References: <1157355863.18992.42.camel@localhost>
	<1157366293.32195.41.camel@aeonflux.holtmann.net>
Date: Mon, 04 Sep 2006 11:11:39 +0200
Message-Id: <1157361100.18992.49.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] What's going on here? RFCOMM on OPP always
	gets	disconnected
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

Hello Marcel,

> in case please to "hcidump -X -V --obex=9". I am not going to decide
> OBEX by hand if I don't have to.

Sorry, here it is:

HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:60:57:BB:4D:92 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:60:57:BB:4D:92 type ACL encrypt 0x00
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 12 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 12
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:60:57:BB:4D:92 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:60:57:BB:4D:92 name 'N-Gage'
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 12 flags 0
    Service type: 1
    Token rate: 44800
    Peak bandwith: 0
    Latency: 5000
    Delay variation: -1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 4
      MTU 1013 
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013 
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0052 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9 
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
< ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0052 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 3
< ACL data: handle 12 flags 0x02 dlen 15
    L2CAP(d): cid 0x0052 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 7 fcs 0xce 
        OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 8192
> ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 4
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 7 fcs 0x8 credits 1
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu
2044
        Status 200 = Success
< ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0052 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 1 fcs 0xce 
        OBEX: Connect rsp(f): status 200 len 0 version 0.0 flags 0 mtu
8192
        Status 200 = Success
        Unknown (0x20) = Unicode length 18508
        0000: 4c 44 11 00 00 00 00 00  00 00 00 07 fc 20 00 00
LD........... ..
        0010: 00 00 61 0b 02 00 00 00  00 00 00 00 00 00 00
00  ..a.............
        0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
        0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
        0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
        0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
        0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................


Then, about 8000 times (the full log including what's above is 8203
lines long) the same line full of 0's, before hcidump does crash with a
segfault

Regards,
Pierre-Yves




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
