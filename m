Return-Path: <cyrus@holtmann.org>
From: kjonca@o2.pl (Kamil =?iso-8859-2?Q?Jo=F1ca?=)
To: linux-bluetooth@vger.kernel.org
Subject: Re: How to pair device from CLI?
References: <871uebt47d.fsf@alfa.kjonca>
	<20121228080842.GA28814@x220.P-661HNU-F1> <87wqw2s3qm.fsf@alfa.kjonca>
	<20121228135423.GA14448@x220.P-661HNU-F1>
Date: Fri, 28 Dec 2012 16:25:45 +0100
In-Reply-To: <20121228135423.GA14448@x220.P-661HNU-F1> (Johan Hedberg's
	message of "Fri, 28 Dec 2012 15:54:23 +0200")
Message-ID: <87pq1uryfa.fsf@alfa.kjonca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
writes:

> Hi Kamil,
>
>> > HCI Event: IO Capability Request (0x31) plen 6
>>     bdaddr D4:E8:B2:AA:15:FA
>> < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
>>     bdaddr D4:E8:B2:AA:15:FA capability 0x04 oob 0x00 auth 0x03
>>     Capability: Reserved (OOB data not present)
>>     Authentication: Dedicated Bonding (MITM Protection)
>
> Here's the problem. The kernel is respoding with an invalid IO
> capability value. The same issue was discussed here just a week ago:
>
> http://marc.info/?l=linux-bluetooth&m=135599627517032&w=2
Do I understand correctly, that I have too old kernel version? 
> The quick fix is to change "KeyboardDisplay" to "DisplayYesNo" in the
> simple-agent script.

After that change I can pair my phone (thanks), but cannot use obexftp.

--8<---------------cut here---------------start------------->8---
obexftp -b D4:E8:B2:AA:15:FA -l .
Browsing D4:E8:B2:AA:15:FA ...
Connecting...failed: connect
Tried to connect for 3ms
error on connect(): Invalid argument
Still trying to connect
Connecting...failed: connect
Tried to connect for 2ms
error on connect(): Invalid argument
Still trying to connect
Connecting...failed: connect
Tried to connect for 2ms
error on connect(): Invalid argument
Still trying to connect
--8<---------------cut here---------------end--------------->8---

hcidump in attachment 

--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=hcidump.txt

HCI sniffer - Bluetooth packet analyzer ver 2.4
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr D4:E8:B2:AA:15:FA ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr D4:E8:B2:AA:15:FA type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr D4:E8:B2:AA:15:FA mode 2 clkoffset 0x0000
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 256 
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      MTU 256 
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 12 flags 0x00 dlen 36
    L2CAP(d): cid 0x0048 len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 00005005-0000-1000-8000-0002ee000001
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr D4:E8:B2:AA:15:FA name 'theta'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
< ACL data: handle 12 flags 0x00 dlen 22
    L2CAP(d): cid 0x0048 len 18 [psm 1]
        SDP SSA Req: tid 0x1 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 256 
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 4
      MTU 256 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 12 flags 0x00 dlen 36
    L2CAP(d): cid 0x0049 len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 00005005-0000-1000-8000-0002ee000001
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 12 flags 0x00 dlen 22
    L2CAP(d): cid 0x0049 len 18 [psm 1]
        SDP SSA Req: tid 0x1 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0049 scid 0x0041
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004a scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 256 
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 4
      MTU 256 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 12 flags 0x00 dlen 36
    L2CAP(d): cid 0x004a len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 00005005-0000-1000-8000-0002ee000001
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 12 flags 0x00 dlen 22
    L2CAP(d): cid 0x004a len 18 [psm 1]
        SDP SSA Req: tid 0x1 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x004a scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004a scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004b scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 256 
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 4
      MTU 256 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 12 flags 0x00 dlen 36
    L2CAP(d): cid 0x004b len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 00005005-0000-1000-8000-0002ee000001
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 12 flags 0x00 dlen 22
    L2CAP(d): cid 0x004b len 18 [psm 1]
        SDP SSA Req: tid 0x1 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x004b scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004b scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 12 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host

--=-=-=
Content-Type: text/plain

KJ
-- 
http://modnebzdury.wordpress.com/2009/10/01/niewiarygodny-list-prof-majewskiej-wprowadzenie/
This fortune would be seven words long if it were six words shorter.

--=-=-=--
