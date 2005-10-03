Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49A63@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C85A.ECC60760"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 3 Oct 2005 13:42:09 -0700

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5C85A.ECC60760
Content-Type: text/plain;
	charset="ISO-8859-2"

Hi,
 
I'm cross-compiling for an Arm processor using a Debian 2.6.10 kernel with
bluez-utils/lib 2.21, and bluez-hcidump 2.25 w/ a brainbox usb adapter for
rs-232 replacement (CSR chipset)
 
I'm having a problem communicating through the /dev/rfcomm0 device.  I
thought that once the device was connected it would be have like a serial
device and I could do this ...
 
cat /dev/rfcomm0 > myfile.dat
echo AT > /dev/rfcomm0
 
Am I assuming correctly?  If not what am I missing?  Do I need to use the
pppd or the dund to communicate?  Am I in the wrong mode (master vs slave).

 
If this should work please look at my log files, I'm executing these
commands ... 
 
hcid
sdpd
sdptool add SP
rfcomm bind 0 XX:XX ...
 
Also, I attempted to connect using Microcom because many examples used
Minicom but it was unable to create a connection.
 
I would appreciate any insight you can give me.
 
Thanks,
Robert
 
----------------------------- sys log
 
Oct  3 12:03:56 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:03:57 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:03:57 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:04:03 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:04:03 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:04:03 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:04:09 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:04:09 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:04:09 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:05:20 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:05:21 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:05:21 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:05:27 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:05:27 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:05:27 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:05:33 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:05:34 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:05:34 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:05:39 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:05:40 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:05:40 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:05:46 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:05:46 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:05:46 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
Oct  3 12:05:52 health-buddy kern.info hcid[1428]: link_key_request
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)
Oct  3 12:05:53 health-buddy user.notice root: Device /dev/rfcomm0 bound and
ready
Oct  3 12:05:53 health-buddy user.notice root: Executing script
00:A0:96:0D:3B:80.cmds
 
----------------------------- hcidump
 
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 0x29 credits 33
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0042
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 82
    L2CAP(d): cid 0x0041 len 78 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 fcs 0xef 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 8
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 0xf3 credits 3
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 0 fcs 0x7a 
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0043 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0043
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0043
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0044
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0044 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 43 flags 0x02 dlen 26
    L2CAP(d): cid 0x0044 len 22 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x11
          count 3
          handles 0x10000 0x10001 0x10002
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10000
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 43 flags 0x02 dlen 31
    L2CAP(d): cid 0x0044 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0045
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0045 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 325 
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 325 
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 0
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0045 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 3 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 fcs 0xfa 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 3 pf 1 ilen 0 fcs 0x31 
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 0x29 credits 33
> ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0044
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0044
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 82
    L2CAP(d): cid 0x0041 len 78 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 fcs 0xef 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 8
> ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 0xf3 credits 3
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 0 fcs 0x7a 
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0045 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0045
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0045
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0046
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0046 result 0 status 0
      Connection successful
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 41 flags 0x02 dlen 26
    L2CAP(d): cid 0x0046 len 22 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x11
          count 3
          handles 0x10000 0x10001 0x10002
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10000
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 31
    L2CAP(d): cid 0x0046 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0047
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0047 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 325 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 325 
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0047 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 3 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 fcs 0xfa 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 3 pf 1 ilen 0 fcs 0x31 
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0047 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0047 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 0x29 credits 33
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 15
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0046
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0046
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 4
> ACL data: handle 41 flags 0x01 dlen 78
    L2CAP(d): cid 0x0041 len 78 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 fcs 0xef 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 8
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 0xf3 credits 3
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> ACL data: handle 41 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 4
> ACL data: handle 41 flags 0x01 dlen 4
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 0 fcs 0x7a 
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0047 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0047
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0047
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0048
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 42 flags 0x02 dlen 26
    L2CAP(d): cid 0x0048 len 22 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x11
          count 3
          handles 0x10000 0x10001 0x10002
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10000
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0048 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0049
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0049 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 325 
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 325 
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 0
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0049 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 3 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 fcs 0xfa 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 3 pf 1 ilen 0 fcs 0x31 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0049 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0049 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 0x29 credits 33
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 15
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0048
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0048
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 82
    L2CAP(d): cid 0x0041 len 78 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 fcs 0xef 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 8
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 0xf3 credits 3
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 0 fcs 0x7a 
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0049 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0049
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0049
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004a
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004a result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 43 flags 0x02 dlen 26
    L2CAP(d): cid 0x004a len 22 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x11
          count 3
          handles 0x10000 0x10001 0x10002
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10000
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 43 flags 0x02 dlen 31
    L2CAP(d): cid 0x004a len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x004b
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x004b result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 325 
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 325 
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 0
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x004b len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 3 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 3 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 3]
      RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 fcs 0xfa 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 3 pf 1 ilen 0 fcs 0x31 
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x004b len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x004b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 0x29 credits 33
> ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004a
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004a
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 82
    L2CAP(d): cid 0x0041 len 78 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 fcs 0xef 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 0xf3 credits 8
> HCI Event: Disconn Complete (0x05) plen 4
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
 
----------------------------- part of ps
 
 1428 root        368 S   hcid: processing events
 1439 root        408 S   /usr/sbin/sdpd 
 
----------------------------- part of dmesg
 
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
Bluetooth: VHCI driver ver 1.1
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
usbcore: registered new driver bcm203x
Bluetooth: BlueFRITZ! USB driver ver 1.1
usbcore: registered new driver bfusb
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53
2004 UTC).
s3c2410_pcm1748_map_registers: mapped dev s3c2410-iis registers to
0xc4e80000
s3c2410_pcm1748_init_hardware 
pclk rate: 50700000 
snd_card_pcm1748_setup_irq tcon=00590900, tcnt 041f, tcfg 00000200,00000030
TIMER_HZ: 8000
snd_card_pcm1748_probe: sound card registered!
ALSA device list:
  #0: pcm1748 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.6
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.0
 
----------------------------- stdout/stderrs
 
Read from rfcomm0
/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create /dev/rfcomm0:
Connection reset by peer
Reading from rfcomm0
Read from rfcomm0
/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create /dev/rfcomm0:
Connection reset by peer
Reading from rfcomm0
Read from rfcomm0
/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create /dev/rfcomm0:
Connection reset by peer
Reading from rfcomm0
Read from rfcomm0
/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create /dev/rfcomm0:
Connection reset by peer
Reading from rfcomm0
Read from rfcomm0
/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create /dev/rfcomm0:
Connection reset by peer
Reading from rfcomm0
Read from rfcomm0
/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create /dev/rfcomm0:
Host is down
 
----------------------------- hciconfig
 
hciconfig
hci0:   Type: USB
        BD Address: 00:0A:4F:00:41:84 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:47592 acl:1364 sco:0 events:2726 errors:0
        TX bytes:36502 acl:2022 sco:0 commands:304 errors:0
 
----------------------------- ls of ...
 
crw-rw-rw-    1 root     root     216,   0 Oct  3 11:08 /dev/rfcomm0
crw-rw-r--    1 root     root      10, 250 Oct  3 10:23 /dev/vhci
 

------_=_NextPart_001_01C5C85A.ECC60760
Content-Type: text/html;
	charset="ISO-8859-2"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-2">
<TITLE>[Bluez-users] Trouble communicating to a non-discoverable BT device</TITLE>

<META content="MSHTML 6.00.2900.2722" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>I'm 
cross-compiling for an Arm processor using a Debian 2.6.10 kernel with 
bluez-utils/lib 2.21, and bluez-hcidump 2.25 w/ a brainbox usb adapter for 
rs-232 replacement (CSR chipset)</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>I'm 
having a problem communicating through the /dev/rfcomm0 device.&nbsp; I thought 
that once the device was connected it would be have like a serial device and I 
could do this ...</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>cat 
/dev/rfcomm0 &gt; myfile.dat</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>echo 
AT &gt; /dev/rfcomm0</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>Am I 
assuming correctly?&nbsp; If not <SPAN class=299050420-03102005>what am I 
missing?&nbsp; Do I need to use the pppd or the dund to communicate?&nbsp; Am I 
in the wrong mode (master vs slave).&nbsp; </SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN>If this should work please look at my log 
files,&nbsp;I'm executing these&nbsp;commands ... </SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>hcid</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>sdpd</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>sdptool add SP</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>rfcomm 
bind 0 XX:XX ...</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><FONT 
face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>Also, I attempted 
to connect using Microcom because many examples used Minicom but it was unable 
to create a connection.</SPAN></FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><FONT 
face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT></SPAN></FONT><FONT face=Arial 
color=#0000ff size=2><SPAN class=299050420-03102005><FONT face=Arial 
color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><FONT 
face=Arial color=#0000ff size=2><SPAN class=299050420-03102005>I would 
appreciate any insight you can give me.</SPAN></FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><FONT 
face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><FONT 
face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>Thanks,</SPAN></FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><FONT 
face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>Robert</SPAN></FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>----------------------------- sys 
log</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005>Oct&nbsp; 3 12:03:56 health-buddy kern.info hcid[1428]: 
link_key_request (sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 
12:03:57 health-buddy user.notice root: Device /dev/rfcomm0 bound and 
ready<BR>Oct&nbsp; 3 12:03:57 health-buddy user.notice root: Executing script 
00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 12:04:03 health-buddy kern.info 
hcid[1428]: link_key_request (sba=00:0A:4F:00:41:84, 
dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:04:03 health-buddy user.notice root: 
Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 3 12:04:03 health-buddy 
user.notice root: Executing script 00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 
12:04:09 health-buddy kern.info hcid[1428]: link_key_request 
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:04:09 
health-buddy user.notice root: Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 
3 12:04:09 health-buddy user.notice root: Executing script 
00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 12:05:20 health-buddy kern.info 
hcid[1428]: link_key_request (sba=00:0A:4F:00:41:84, 
dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:05:21 health-buddy user.notice root: 
Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 3 12:05:21 health-buddy 
user.notice root: Executing script 00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 
12:05:27 health-buddy kern.info hcid[1428]: link_key_request 
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:05:27 
health-buddy user.notice root: Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 
3 12:05:27 health-buddy user.notice root: Executing script 
00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 12:05:33 health-buddy kern.info 
hcid[1428]: link_key_request (sba=00:0A:4F:00:41:84, 
dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:05:34 health-buddy user.notice root: 
Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 3 12:05:34 health-buddy 
user.notice root: Executing script 00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 
12:05:39 health-buddy kern.info hcid[1428]: link_key_request 
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:05:40 
health-buddy user.notice root: Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 
3 12:05:40 health-buddy user.notice root: Executing script 
00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 12:05:46 health-buddy kern.info 
hcid[1428]: link_key_request (sba=00:0A:4F:00:41:84, 
dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:05:46 health-buddy user.notice root: 
Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 3 12:05:46 health-buddy 
user.notice root: Executing script 00:A0:96:0D:3B:80.cmds<BR>Oct&nbsp; 3 
12:05:52 health-buddy kern.info hcid[1428]: link_key_request 
(sba=00:0A:4F:00:41:84, dba=00:A0:96:0D:3B:80)<BR>Oct&nbsp; 3 12:05:53 
health-buddy user.notice root: Device /dev/rfcomm0 bound and ready<BR>Oct&nbsp; 
3 12:05:53 health-buddy user.notice root: Executing script 
00:A0:96:0D:3B:80.cmds</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=299050420-03102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005>----------------------------- 
hcidump</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005>&gt; ACL data: handle 42 
flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 
fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0041 len 8 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: 
cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 
42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 
0x29 credits 33<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 
0xf3 credits 15<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): 
Disconn req: dcid 0x0040 scid 0x0042<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0042<BR>&gt; 
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 42 
flags 0x02 dlen 82<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 78 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 
fcs 0xef <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0043 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0043 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0043 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0043 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 
5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 
ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0043 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 
dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: 
handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 
[psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 
0 fcs 0xf3 credits 8<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
10<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 
0xf3 credits 3<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; ACL data: handle 42 flags 0x02 dlen 11<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0041 len 7 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0043 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 0 
fcs 0x7a <BR>&lt; ACL data: handle 42 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0043 len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 
fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 7<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0043<BR>&lt; 
ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn 
rsp: dcid 0x0041 scid 0x0043<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Disconn Complete (0x05) plen 4<BR>&gt; HCI Event: Connect 
Request (0x04) plen 10<BR>&lt; HCI Command: Accept Connection Request 
(0x01|0x0009) plen 7<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI 
Event: Link Key Request (0x17) plen 6<BR>&lt; HCI Command: Link Key Request 
Reply (0x01|0x000b) plen 22<BR>&gt; HCI Event: Command Complete (0x0e) plen 
10<BR>&gt; HCI Event: Connect Complete (0x03) plen 11<BR>&lt; HCI Command: Write 
Link Policy Settings (0x02|0x000d) plen 4<BR>&gt; HCI Event: Page Scan 
Repetition Mode Change (0x20) plen 7<BR>&gt; HCI Event: Max Slots Change (0x1b) 
plen 3<BR>&gt; HCI Event: Command Complete (0x0e) plen 6<BR>&lt; HCI Command: 
Change Connection Packet Type (0x01|0x000f) plen 4<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 
0x0044<BR>&lt; ACL data: handle 43 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0044 result 0 status 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<BR>&gt; HCI Event: 
Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Command Status 
(0x0f) plen 4<BR>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 
5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): 
Config req: dcid 0x0040 flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 
48 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: handle 43 flags 
0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0044 flags 0x00 
clen 0<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 
0x00 result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&gt; ACL data: 
handle 43 flags 0x02 dlen 19<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 15 
[psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len 
0xa<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x1101 
(SP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
40<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&lt; ACL 
data: handle 43 flags 0x02 dlen 26<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0044 
len 22 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 
len 0x11<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handles 0x10000 
0x10001 0x10002<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 
00<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL 
data: handle 43 flags 0x02 dlen 21<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 
len 17 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: tid 0x2 
len 0xc<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle 
0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
38<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
cont 00<BR>&lt; ACL data: handle 43 flags 0x02 dlen 31<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0044 len 27 [psm 
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x2 len 
0x16<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
19<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&lt; &lt; uuid-16 0x0100 (L2CAP) &gt; 
&lt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
uuid-16 0x0003 (RFCOMM) uint 0x1 &gt; 
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&gt; 
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 
0x0045<BR>&lt; ACL data: handle 43 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0045 result 0 status 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<BR>&gt; HCI Event: 
Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 
dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 
4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&lt; ACL data: handle 43 flags 
0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0045 flags 0x00 
result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: 
handle 43 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 
0x0045 flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024 <BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 
clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Success<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&gt; ACL data: handle 43 
flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 
fcs 0x1c <BR>&lt; ACL data: handle 43 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0045 len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 
credit_flow 15 pri 0 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
319 max_retrans 0 credits 0<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 
0x73 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 43 flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 
len 14 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 
pf 0 ilen 10 fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 
frame_type 0 credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
frame_size 127 max_retrans 0 credits 7<BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 14 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 0<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 
fcs 0xfa <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; 
ACL data: handle 43 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 
len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 0 dlci 3 pf 1 
ilen 0 fcs 0x31 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 
fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0041 len 8 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: 
cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 
43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 
0x29 credits 33<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 
0xf3 credits 15<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): 
Disconn req: dcid 0x0040 scid 0x0044<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0044<BR>&gt; 
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 82<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 78 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 
fcs 0xef <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0045 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0045 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0045 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0045 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 
5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 
ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0045 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 
dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 
0xf3 credits 8<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
10<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 
0xf3 credits 3<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; ACL data: handle 43 flags 0x02 dlen 11<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0041 len 7 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0045 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 0 
fcs 0x7a <BR>&lt; ACL data: handle 43 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0045 len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0045 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 
fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 7<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0045<BR>&lt; 
ACL data: handle 43 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn 
rsp: dcid 0x0041 scid 0x0045<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Disconn Complete (0x05) plen 4<BR>&gt; HCI Event: Connect 
Request (0x04) plen 10<BR>&lt; HCI Command: Accept Connection Request 
(0x01|0x0009) plen 7<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI 
Event: Link Key Request (0x17) plen 6<BR>&lt; HCI Command: Link Key Request 
Reply (0x01|0x000b) plen 22<BR>&gt; HCI Event: Command Complete (0x0e) plen 
10<BR>&gt; HCI Event: Connect Complete (0x03) plen 11<BR>&lt; HCI Command: Write 
Link Policy Settings (0x02|0x000d) plen 4<BR>&gt; HCI Event: Page Scan 
Repetition Mode Change (0x20) plen 7<BR>&gt; HCI Event: Command Complete (0x0e) 
plen 6<BR>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 
4<BR>&gt; HCI Event: Max Slots Change (0x1b) plen 3<BR>&gt; HCI Event: Command 
Status (0x0f) plen 4<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0046<BR>&lt; ACL 
data: handle 41 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: 
dcid 0x0040 scid 0x0046 result 0 status 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Connection successful<BR>&gt; HCI Event: Connection Packet Type Changed (0x1d) 
plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL 
data: handle 41 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: 
dcid 0x0040 flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 48 <BR>&lt; 
ACL data: handle 41 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config 
rsp: scid 0x0046 flags 0x00 result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Success<BR>&lt; ACL data: handle 41 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 0<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 
clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&gt; ACL data: handle 41 
flags 0x02 dlen 19<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 15 [psm 
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len 
0xa<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x1101 
(SP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
40<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&lt; ACL 
data: handle 41 flags 0x02 dlen 26<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0046 
len 22 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 
len 0x11<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handles 0x10000 
0x10001 0x10002<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 
00<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL 
data: handle 41 flags 0x02 dlen 21<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 
len 17 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: tid 0x2 
len 0xc<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle 
0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
38<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
cont 00<BR>&lt; ACL data: handle 41 flags 0x02 dlen 31<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0046 len 27 [psm 
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x2 len 
0x16<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
19<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&lt; &lt; uuid-16 0x0100 (L2CAP) &gt; 
&lt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
uuid-16 0x0003 (RFCOMM) uint 0x1 &gt; 
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&gt; 
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 41 
flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 
0x0047<BR>&lt; ACL data: handle 41 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0047 result 0 status 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<BR>&gt; HCI Event: 
Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 41 flags 0x02 
dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 
4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&lt; ACL data: handle 41 flags 
0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0047 flags 0x00 
result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: 
handle 41 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 
0x0047 flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024 <BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 
clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Success<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&gt; ACL data: handle 41 
flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 
fcs 0x1c <BR>&lt; ACL data: handle 41 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0047 len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 
credit_flow 15 pri 0 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
319 max_retrans 0 credits 0<BR>&lt; ACL data: handle 41 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 
0x73 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 41 flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 
len 14 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 
pf 0 ilen 10 fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 
frame_type 0 credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
frame_size 127 max_retrans 0 credits 7<BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 14 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 0<BR>&lt; ACL data: handle 41 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 
fcs 0xfa <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; 
ACL data: handle 41 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 
len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 0 dlci 3 pf 1 
ilen 0 fcs 0x31 <BR>&lt; ACL data: handle 41 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 
fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 41 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 41 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0041 len 8 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: 
cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 
41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 
0x29 credits 33<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 
0xf3 credits 15<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0046<BR>&lt; 
ACL data: handle 41 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn 
rsp: dcid 0x0040 scid 0x0046<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 41 flags 0x02 dlen 4<BR>&gt; ACL data: handle 41 
flags 0x01 dlen 78<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 78 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 
fcs 0xef <BR>&lt; ACL data: handle 41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0047 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 41 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0047 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 41 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0047 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 41 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0047 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 41 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 
5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 
ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&lt; ACL data: handle 41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0047 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 
dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&lt; ACL data: handle 41 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 41 
flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 
0xf3 credits 8<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
10<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 
0xf3 credits 3<BR>&lt; ACL data: handle 41 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; ACL data: handle 41 flags 0x02 dlen 11<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0041 len 7 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef <BR>&lt; ACL data: handle 41 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 41 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0047 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 41 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; ACL data: handle 41 flags 0x02 dlen 4<BR>&gt; ACL data: 
handle 41 flags 0x01 dlen 4<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 
[psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 
0 fcs 0x7a <BR>&lt; ACL data: handle 41 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0047 len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&lt; ACL data: handle 41 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 
fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 7<BR>&gt; ACL data: handle 41 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0047<BR>&lt; 
ACL data: handle 41 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn 
rsp: dcid 0x0041 scid 0x0047<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Disconn Complete (0x05) plen 4<BR>&gt; HCI Event: Connect 
Request (0x04) plen 10<BR>&lt; HCI Command: Accept Connection Request 
(0x01|0x0009) plen 7<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI 
Event: Link Key Request (0x17) plen 6<BR>&lt; HCI Command: Link Key Request 
Reply (0x01|0x000b) plen 22<BR>&gt; HCI Event: Command Complete (0x0e) plen 
10<BR>&gt; HCI Event: Connect Complete (0x03) plen 11<BR>&lt; HCI Command: Write 
Link Policy Settings (0x02|0x000d) plen 4<BR>&gt; HCI Event: Page Scan 
Repetition Mode Change (0x20) plen 7<BR>&gt; HCI Event: Command Complete (0x0e) 
plen 6<BR>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 
4<BR>&gt; HCI Event: Max Slots Change (0x1b) plen 3<BR>&gt; HCI Event: Command 
Status (0x0f) plen 4<BR>&gt; HCI Event: Connection Packet Type Changed (0x1d) 
plen 5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Connect req: psm 1 scid 0x0048<BR>&lt; ACL data: handle 42 flags 0x02 
dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 
result 0 status 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection 
successful<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; 
ACL data: handle 42 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config 
req: dcid 0x0040 flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 48 
<BR>&lt; ACL data: handle 42 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): 
Config rsp: scid 0x0048 flags 0x00 result 0 clen 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: handle 42 flags 
0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0048 flags 0x00 
clen 0<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 42 
flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 
0x00 result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&gt; ACL data: 
handle 42 flags 0x02 dlen 19<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 15 
[psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len 
0xa<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x1101 
(SP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
40<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&lt; ACL 
data: handle 42 flags 0x02 dlen 26<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0048 
len 22 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 
len 0x11<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handles 0x10000 
0x10001 0x10002<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 
00<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL 
data: handle 42 flags 0x02 dlen 21<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 
len 17 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: tid 0x2 
len 0xc<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle 
0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
38<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
cont 00<BR>&lt; ACL data: handle 42 flags 0x02 dlen 31<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0048 len 27 [psm 
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x2 len 
0x16<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
19<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&lt; &lt; uuid-16 0x0100 (L2CAP) &gt; 
&lt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
uuid-16 0x0003 (RFCOMM) uint 0x1 &gt; 
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&gt; 
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 42 
flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 
0x0049<BR>&lt; ACL data: handle 42 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0049 result 0 status 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<BR>&gt; HCI Event: 
Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 42 flags 0x02 
dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 
4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&lt; ACL data: handle 42 flags 
0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0049 flags 0x00 
result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: 
handle 42 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 
0x0049 flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024 <BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 
clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Success<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&gt; ACL data: handle 42 
flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 
fcs 0x1c <BR>&lt; ACL data: handle 42 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0049 len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 
credit_flow 15 pri 0 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
319 max_retrans 0 credits 0<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 
0x73 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 42 flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 
len 14 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 
pf 0 ilen 10 fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 
frame_type 0 credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
frame_size 127 max_retrans 0 credits 7<BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 14 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 0<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 
fcs 0xfa <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; 
ACL data: handle 42 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 
len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 0 dlci 3 pf 1 
ilen 0 fcs 0x31 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 
fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0041 len 8 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: 
cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 
42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 
0x29 credits 33<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 
0xf3 credits 15<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0048<BR>&lt; 
ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn 
rsp: dcid 0x0040 scid 0x0048<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 82<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0041 len 78 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 
dlci 3 pf 0 ilen 74 fcs 0xef <BR>&lt; ACL data: handle 42 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0049 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0049 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0049 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0049 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 
5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 
ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0049 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 
dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0041 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 
dlci 3 pf 1 ilen 0 fcs 0xf3 credits 8<BR>&gt; ACL data: handle 42 flags 0x02 
dlen 10<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 1 fcs 
0xf3 credits 3<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; ACL data: handle 42 flags 0x02 dlen 11<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0041 len 7 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 1 dlci 3 pf 0 ilen 3 fcs 0xef <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 42 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0049 len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 42 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 3 pf 1 ilen 0 
fcs 0x7a <BR>&lt; ACL data: handle 42 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x0049 len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 3 pf 1 ilen 0 fcs 0x50 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&lt; ACL data: handle 42 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 pf 0 ilen 10 
fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 7<BR>&gt; ACL data: handle 42 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0049<BR>&lt; 
ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn 
rsp: dcid 0x0041 scid 0x0049<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Disconn Complete (0x05) plen 4<BR>&gt; HCI Event: Connect 
Request (0x04) plen 10<BR>&lt; HCI Command: Accept Connection Request 
(0x01|0x0009) plen 7<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI 
Event: Link Key Request (0x17) plen 6<BR>&lt; HCI Command: Link Key Request 
Reply (0x01|0x000b) plen 22<BR>&gt; HCI Event: Command Complete (0x0e) plen 
10<BR>&gt; HCI Event: Connect Complete (0x03) plen 11<BR>&lt; HCI Command: Write 
Link Policy Settings (0x02|0x000d) plen 4<BR>&gt; HCI Event: Page Scan 
Repetition Mode Change (0x20) plen 7<BR>&gt; HCI Event: Command Complete (0x0e) 
plen 6<BR>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 
4<BR>&gt; HCI Event: Max Slots Change (0x1b) plen 3<BR>&gt; HCI Event: Command 
Status (0x0f) plen 4<BR>&gt; HCI Event: Connection Packet Type Changed (0x1d) 
plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Connect req: psm 1 scid 0x004a<BR>&lt; ACL data: handle 43 flags 0x02 
dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004a 
result 0 status 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection 
successful<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; 
ACL data: handle 43 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config 
req: dcid 0x0040 flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 48 
<BR>&lt; ACL data: handle 43 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): 
Config rsp: scid 0x004a flags 0x00 result 0 clen 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: handle 43 flags 
0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x004a flags 0x00 
clen 0<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 
0x00 result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&gt; ACL data: 
handle 43 flags 0x02 dlen 19<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 15 
[psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len 
0xa<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x1101 
(SP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
40<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&lt; ACL 
data: handle 43 flags 0x02 dlen 26<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004a 
len 22 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 
len 0x11<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handles 0x10000 
0x10001 0x10002<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 
00<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL 
data: handle 43 flags 0x02 dlen 21<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 
len 17 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: tid 0x2 
len 0xc<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle 
0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 
38<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
cont 00<BR>&lt; ACL data: handle 43 flags 0x02 dlen 31<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x004a len 27 [psm 
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x2 len 
0x16<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 
19<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&lt; &lt; uuid-16 0x0100 (L2CAP) &gt; 
&lt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
uuid-16 0x0003 (RFCOMM) uint 0x1 &gt; 
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>&gt; 
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 
0x004b<BR>&lt; ACL data: handle 43 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(s): Connect rsp: dcid 0x0041 scid 0x004b result 0 status 
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<BR>&gt; HCI Event: 
Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 
dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 
4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&lt; ACL data: handle 43 flags 
0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x004b flags 0x00 
result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: 
handle 43 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 
0x004b flags 0x00 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024 <BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 
clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Success<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 325 <BR>&gt; ACL data: handle 43 
flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 
fcs 0x1c <BR>&lt; ACL data: handle 43 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x004b len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): 
UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 <BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 
credit_flow 15 pri 0 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
319 max_retrans 0 credits 0<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 
0x73 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 43 flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b 
len 14 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 0 dlci 0 
pf 0 ilen 10 fcs 0xaa mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 
frame_type 0 credit_flow 15 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
frame_size 127 max_retrans 0 credits 7<BR>&gt; HCI Event: Number of Completed 
Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 1 dlci 0 pf 0 ilen 10 
fcs 0x70 mcc_len 8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 frame_type 0 
credit_flow 14 pri 7 ack_timer 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 
127 max_retrans 0 credits 0<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 4 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 0 dlci 3 pf 1 ilen 0 
fcs 0xfa <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; 
ACL data: handle 43 flags 0x02 dlen 8<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 
len 4 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 0 dlci 3 pf 1 
ilen 0 fcs 0x31 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 
fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 8 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 
fcs 0xaa mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 3 fc 0 rtc 1 rtr 1 ic 
0 dv 0 b1 0 b2 0 b3 0 len 0<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x0041 len 8 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: 
cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
dlci 3 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>&lt; ACL data: handle 
43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 1 ilen 0 fcs 
0x29 credits 33<BR>&gt; ACL data: handle 43 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 0 fcs 
0xf3 credits 15<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; ACL data: handle 43 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): 
Disconn req: dcid 0x0040 scid 0x004a<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004a<BR>&gt; 
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 43 
flags 0x02 dlen 82<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 78 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 0 ilen 74 
fcs 0xef <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x004b len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x004b len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x004b len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; 
L2CAP(d): cid 0x004b len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): 
UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&lt; ACL data: handle 43 flags 0x02 
dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL 
data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 
5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 
ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&lt; ACL data: handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): 
cid 0x004b len 5 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 
dlci 3 pf 0 ilen 1 fcs 0x35 <BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&lt; ACL data: handle 43 flags 0x02 dlen 
9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004b len 5 [psm 
3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 3 pf 0 ilen 1 fcs 
0x35 <BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI 
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of 
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets 
(0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 
5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: 
handle 43 flags 0x02 dlen 9<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 
[psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 3 pf 1 ilen 
0 fcs 0xf3 credits 8<BR>&gt; HCI Event: Disconn Complete (0x05) plen 4<BR>&lt; 
HCI Command: Create Connection (0x01|0x0005) plen 13<BR>&gt; HCI Event: Command 
Status (0x0f) plen 4<BR>&gt; HCI Event: Connect Complete (0x03) plen 
11</SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN 
class=299050420-03102005>----------------------------- part of 
ps</SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005>&nbsp;1428 
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 368 S&nbsp;&nbsp; hcid: 
processing events<BR>&nbsp;1439 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
408 S&nbsp;&nbsp; /usr/sbin/sdpd </SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005>----------------------------- part of 
dmesg</SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005>Bluetooth: HCI USB driver ver 2.7<BR>usbcore: 
registered new driver hci_usb<BR>Bluetooth: VHCI driver ver 1.1<BR>Bluetooth: 
HCI UART driver ver 2.1<BR>Bluetooth: HCI H4 protocol initialized<BR>Bluetooth: 
HCI BCSP protocol initialized<BR>Bluetooth: Broadcom Blutonium firmware driver 
ver 1.0<BR>usbcore: registered new driver bcm203x<BR>Bluetooth: BlueFRITZ! USB 
driver ver 1.1<BR>usbcore: registered new driver bfusb<BR>Advanced Linux Sound 
Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 
UTC).<BR>s3c2410_pcm1748_map_registers: mapped dev s3c2410-iis registers to 
0xc4e80000<BR>s3c2410_pcm1748_init_hardware <BR>pclk rate: 50700000 
<BR>snd_card_pcm1748_setup_irq tcon=00590900, tcnt 041f, tcfg 00000200,00000030 
TIMER_HZ: 8000<BR>snd_card_pcm1748_probe: sound card registered!<BR>ALSA device 
list:<BR>&nbsp; #0: pcm1748 1<BR>NET: Registered protocol family 2<BR>IP: 
routing cache hash table of 512 buckets, 4Kbytes<BR>TCP: Hash tables configured 
(established 4096 bind 8192)<BR>NET: Registered protocol family 1<BR>NET: 
Registered protocol family 17<BR>Bluetooth: L2CAP ver 2.6<BR>Bluetooth: L2CAP 
socket layer initialized<BR>Bluetooth: SCO (Voice Link) ver 0.3<BR>Bluetooth: 
SCO socket layer initialized<BR>Bluetooth: RFCOMM ver 1.3<BR>Bluetooth: RFCOMM 
socket layer initialized<BR>Bluetooth: RFCOMM TTY layer 
initialized<BR>Bluetooth: BNEP (Ethernet Emulation) ver 1.2<BR>Bluetooth: BNEP 
filters: protocol multicast<BR>Bluetooth: HIDP (Human Interface Emulation) ver 
1.0</SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN 
class=299050420-03102005>----------------------------- 
stdout/stderrs</SPAN></SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005>Read from 
rfcomm0<BR>/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create 
/dev/rfcomm0: Connection reset by peer<BR>Reading from rfcomm0<BR>Read from 
rfcomm0<BR>/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create 
/dev/rfcomm0: Connection reset by peer<BR>Reading from rfcomm0<BR>Read from 
rfcomm0<BR>/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create 
/dev/rfcomm0: Connection reset by peer<BR>Reading from rfcomm0<BR>Read from 
rfcomm0<BR>/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create 
/dev/rfcomm0: Connection reset by peer<BR>Reading from rfcomm0<BR>Read from 
rfcomm0<BR>/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create 
/dev/rfcomm0: Connection reset by peer<BR>Reading from rfcomm0<BR>Read from 
rfcomm0<BR>/var/lib/bluetooth/00:A0:96:0D:3B:80.cmds: 20: cannot create 
/dev/rfcomm0: Host is down</SPAN></SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005>----------------------------- 
hciconfig</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005>hciconfig<BR>hci0:&nbsp;&nbsp; Type: 
USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0A:4F:00:41:84 
ACL MTU: 192:8 SCO MTU: 64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
RUNNING PSCAN ISCAN <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:47592 acl:1364 sco:0 events:2726 
errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:36502 acl:2022 
sco:0 commands:304 
errors:0</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005>----------------------------- ls of 
...</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005>crw-rw-rw-&nbsp;&nbsp;&nbsp; 1 
root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; 216,&nbsp;&nbsp; 0 
Oct&nbsp; 3 11:08 /dev/rfcomm0<BR>crw-rw-r--&nbsp;&nbsp;&nbsp; 1 
root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10, 250 
Oct&nbsp; 3 10:23 
/dev/vhci</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN class=299050420-03102005><SPAN 
class=299050420-03102005><SPAN 
class=299050420-03102005></SPAN></SPAN></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C5C85A.ECC60760--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
