Return-Path: <vit@mifki.ru>
Subject: Re: [Bluez-users] Re: help me
From: Vitaliy Pronkin <vit@mifki.ru>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1085326200.8309.22.camel@pegasus>
References: <loom.20040523T164826-243@post.gmane.org>
	 <1085324502.8309.19.camel@pegasus>
	 <loom.20040523T170840-699@post.gmane.org>
	 <1085326200.8309.22.camel@pegasus>
Content-Type: text/plain
Message-Id: <1085327326.29252.169.camel@n-vit>
Mime-Version: 1.0
Date: Sun, 23 May 2004 19:48:46 +0400
List-ID: <bluez-users.lists.sourceforge.net>

Yes, I know about 2.7, I'll try to install it.

# hcid
# sdpd
# sdptool add SP
Serial Port service registered
# sdptool add LAN
LAN Access service registered
# hcidump
HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004d
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004d result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 512 FlushTO 65535
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004d flags 0x0000 result 0 clen 0
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004d flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x002a flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0x14
          cont 00
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004d
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004d
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004e
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004e result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 512 FlushTO 65535
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004e flags 0x0000 result 0 clen 0
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004e flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x002a flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0x14
          cont 00
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004e
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004e
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Disconn Complete(0x05) plen 4

And at this moment PDA says it can't find any usable service.


# cat /etc/bluetooth/hcid.conf
options {
 autoinit yes;
 security auto;
 pairing multi;
 pin_helper /usr/lib/kdebluetooth/kbluepin;
}
 
device {
 name "%h";
 class 0x10C;
 #pkt_type DH1,DM1,HV1;
 iscan enable; pscan enable;
 lm accept,master;
 lp none;
#       auth enable;
#       encrypt enable;
}
