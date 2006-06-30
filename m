Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Fri, 30 Jun 2006 11:45:52 +0200
Message-Id: <1151660752.7416.12.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: [Bluez-users] a2play will not work
Reply-To: listen@kapune.de, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,
I think I need a little help.

When I try to play a mp3 on my headphone:

mpg123 --au - Din_Tei.mp3 | ./a2play 00:0A:94:A0:59:3b
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
Title  : Dragostea Din Tei               Artist: Haiducii
Album  :                                 Year  : 2004
Comment: I&T okay                        Genre : Blues

Playing MPEG stream from Din_Tei.mp3 ...
MPEG 1.0 layer III, 192 kbit/s, 44100 Hz stereo
subbands = 8 blocks = 16 bitpool = 32
len=2048
Header size=28
Sample Rate:44100
Channels:2
Using address: 00:0A:94:A0:59:3b
Found A2DP Sink
Found A2DP Sink at the destination
Can't connect to 3B:59:A0:94:0A:00. Connection refused(111)
cannot open psm_cmd = 25


I see on the screen of hcidump -X -V this output:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:94:A0:59:3B ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0A:94:A0:59:3B type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 3b 59 a0 94 0a 00 01                              ;Y.....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 05                                          *..
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0048 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 18
< ACL data: handle 42 flags 0x02 dlen 26
    L2CAP(d): cid 0x0048 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 18
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1b
          count 24
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
                 uuid-16 0x0019 (AVDTP) uint 0x100 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
              aid 0x0311 (unknown)
                 uint 0x1
          cont 00
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0048 len 20 [psm 1]
        SDP SSA Req: tid 0x2 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:94:A0:59:3B
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:0A:94:A0:59:3B
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0A:94:A0:59:3B
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0A:94:A0:59:3B
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:0A:94:A0:59:3B
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:0A:94:A0:59:3B
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Teminated Connection
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00


When I reed this output I think the first steps are Ok but near the end
I get a "Link Key Request Negative Reply" and later a "Pin Code Request
Negative Reply".

What is wron with my configuration? Where I can start to search? 

Johannes

Ps you need more / other informations?


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
