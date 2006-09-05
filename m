Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1157449810.4206.0.camel@localhost>
References: <1157355863.18992.42.camel@localhost>
	<1157366293.32195.41.camel@aeonflux.holtmann.net>
	<1157361100.18992.49.camel@localhost>
	<1157449810.4206.0.camel@localhost>
Date: Tue, 05 Sep 2006 16:02:43 +0200
Message-Id: <1157464964.18992.83.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] What's going on here? RFCOMM on
	OPP	always	gets	disconnected
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

Hi marcel,

> > > in case please to "hcidump -X -V --obex=9". I am not going to decide
> > > OBEX by hand if I don't have to.
> 
> please check that their OPP service is still on channel 9. The channel
> numbers might have changed and you connect to the wrong channel.

I just checked, but it is not the case: OPP is still on the channel 9. I
get the prompt to accept the incoming object, but past that point it
always does behave like in the log I posted earlier. If I was on the
wrong channel, how could I get this as I do?


> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 7 fcs 0x8 credits 1
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu
2044
        Status 200 = Success


I did the same test on another phone (SE k750i), and the log looks alike
(with the endless list of 0's at the end too). Here it is:


HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 2b 53 01 6d                                       +S.m
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 2b 73 01 47                                       +s.G
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 03 00                                    .....
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 0c 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 0c 00 16                                       ....
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 0b bf 2c 20 16 00 18 cc  02 00 00 00 01           .., .........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 0c 00 0b bf 2c 20 16  00 01 00                 ....., ....
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 0c 00 0f 00                                       ....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 0c 00                                 ......
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 0b bf 2c 20 16 00 02 00  00 00                    .., ......
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 0c 00 05                                          ...
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 0b bf 2c 20 16 00 4b  37 35 30 69 00 00 00
00  ..., ..K750i....
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
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
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00     ...............
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013 
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013 
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 04 00                                    .....
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> ACL data: handle 12 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 10 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 329 max_retrans 0 credits 0
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 10 pf 1 ilen 0 fcs 0x8c 
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47 
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 0 fcs 0x76 credits 20
> ACL data: handle 12 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 12 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 1 ilen 0 fcs 0xac credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 04 00                                    .....
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 10 br 170 db 2 sb 0 p 1 pt 2 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 73 xoff 1 pm 0x0000
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 10 br 170 db 0 sb 0 p 0 pt 0 xi 1 xo 0
      rtri 0 rtro 0 rtci 1 rtco 0 xon 19 xoff 127 pm 0x703f
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 03 00                                    .....
< ACL data: handle 12 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 7 fcs 0xb0 
        OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 8192
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 01 00                                    .....
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 7 fcs 0x76 credits 1
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu
4096
< ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
        OBEX: Connect rsp(f): status 200 len 0 version 0.0 flags 0 mtu
8192
        Count (0x00) = Unicode length 65533
        0000: 00 00 11 00 00 00 00 00  00 00 00 10 00 00 00
00  ................
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
        0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
        0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................

(and it does go on the same way)


Any hint will be very welcome.

Best Regards,
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
