Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073392659.2508.43.camel@pegasus>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus>  <1073388369.8729.164.camel@saag>
	 <1073392659.2508.43.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073394683.8730.225.camel@saag>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 13:11:23 +0000
List-ID: <bluez-users.lists.sourceforge.net>

On Tue, 2004-01-06 at 12:37, Marcel Holtmann wrote:
> this only happens when rfcomm_connect_ind() returns false and this means
> that we can't create the new socket. In most cases this is because there
> is no listen socket for it. Do /proc/bluetooth/rfcomm show the listen
> socket on that channel? Do you use the same channel number in your SDP
> record as for dund?

sdptool browse ff:ff:ff ....

Service Name: Serial Port
Service RecHandle: 0x804ee30
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Serial Port" (0x1101)
    Version: 0x0100


strace dund --listen --persist --channel 3 --nodetach

socket(0x1f /* PF_??? */, SOCK_STREAM, 3) = 5
bind(5, {sa_family=0x1f /* AF_??? */,
sa_data="\0\0\0\0\0\0\3\243\20@\6\0\0\0"}, 10) = 0
listen(5, 10)                           = 0
accept(5,

cat /proc/bluetooth/rfcomm

sk  00:00:00:00:00:00 00:00:00:00:00:00 4 3
sk  69:DD:D0:05:40:00 6D:15:24:98:80:00 9 4

Lastly, BlueZ<->BlueZ seems to work fine.  And OBEX from the P800 to BlueZ
works.  It's weird.

-- Edd

Here's another hcidump, which shows the SDP response...

> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0061
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0061 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0061 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0061 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x1101 (SP)
          max 0x14
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x61 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          cur 0x1 tot 0x1 hndl 0x804d838
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          hndl 0x804d838
          max 0xc8
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 22
    L2CAP(d): cid 0x61 len 18 [psm 1]
        SDP SA Rsp: tid 0x2 len 0xd
          cnt 0xa
          aid 0x0001 (SrvClassIDList)
             uuid-16 0x1101 (SP)
 
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x3 len 0xc
          hndl 0x804d838
          max 0xc8
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Max Slots Change(0x1b) plen 3
< ACL data: handle 0x0028 flags 0x02 dlen 31
    L2CAP(d): cid 0x61 len 27 [psm 1]
        SDP SA Rsp: tid 0x3 len 0x16
          cnt 0x13
          aid 0x0004 (ProtocolDescList)
             uuid-16 0x0100 (L2CAP)
             uuid-16 0x0003 (RFCOMM) uint 0x3
 
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0062
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0062 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0062 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0062 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
    MTU 672
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0062
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0062
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0061
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0061
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Disconn Complete(0x05) plen 4
