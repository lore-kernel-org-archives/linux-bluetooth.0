Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Mark Coetser" <mark@thummb.com>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000101c4b9b7$4332e860$f500000a@citadel>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: [Bluez-users] Using my linux box as an internet gateway for my i-mate/xda
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
Date: Sun, 24 Oct 2004 12:50:23 +0200

Hi Ppl

System info

Debian woody

Uname -a
Linux fw1.mid 2.6.7 #1 SMP Sat Oct 23 12:41:48 SAST 2004 i686 unknown

dpkg -l | grep bluez
ii  bluez-hcidump  1.5-2          Analyses Bluetooth HCI packets
ii  bluez-pan      1.1rel-1       Personal area networking for Bluetooth
devic
ii  bluez-sdp      1.1-1          BlueZ Bluetooth SDP daemon and tool
ii  bluez-utils    2.3-1.woody.1  Utilities for controlling Bluetooth
devices

Lsmod
Module                  Size  Used by
tun                    10624  1
rfcomm                 39704  4
l2cap                  27264  5 rfcomm
cls_u32                 9860  1
sch_prio                7424  0
sch_sfq                 7680  0
sch_tbf                 8704  1
sch_cbq                19840  1
ipt_LOG                 8064  6
ipt_REJECT              8192  22
ipt_limit               4352  9
ipt_state               3840  8
ipt_TOS                 4224  2
iptable_mangle          4480  1
ipt_MASQUERADE          5632  10
ipt_REDIRECT            3840  6
iptable_filter          4480  1
ppp_deflate             7424  0
zlib_deflate           22944  1 ppp_deflate
bsd_comp                7424  0
ppp_async              13824  5
af_packet              23684  20
ipv6                  260288  30
ppp_generic            32268  23 ppp_deflate,bsd_comp,ppp_async
slhc                    8704  1 ppp_generic
hci_usb                15488  2
bluetooth              51200  7 rfcomm,l2cap,hci_usb
uhci_hcd               32776  0
usbcore               111956  4 hci_usb,uhci_hcd
ip_nat_ftp              6912  0
iptable_nat            28836  4 ipt_MASQUERADE,ipt_REDIRECT,ip_nat_ftp
ip_tables              20112  10
ipt_LOG,ipt_REJECT,ipt_limit,ipt_state,ipt_TOS,iptable_mangle,ipt_MASQUE
RADE,ipt_REDIRECT,iptable_filter,iptable_nat
ip_conntrack_ftp       73632  1 ip_nat_ftp
ip_conntrack           38560  6
ipt_state,ipt_MASQUERADE,ipt_REDIRECT,ip_nat_ftp,iptable_nat,ip_conntrac
k_ftp
natsemi                26208  0
crc32                   5760  1 natsemi
e100                   33536  0
mii                     6656  1 e100
rtc                    14816  0
ext3                  117504  1
jbd                    64024  1 ext3
mbcache                11396  1 ext3
ide_disk               18944  3
ide_generic             3200  0
piix                   14364  1
ide_core              139472  3 ide_disk,ide_generic,piix
unix                   31012  54

Hcid.conf
options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /bin/bluepin;
}
device {
        name "Thummb";
        class 0x100;
        iscan enable; pscan enable;
        lm accept,master;
        lp hold,sniff,park;
}

Bluez-pan
DUND_ENABLED=1
DUND_OPTIONS="--listen --persist"
PAND_ENABLED=0
PAND_OPTIONS="--listen --role NAP"

Hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:AC:E8:90:A1 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3048 acl:119 sco:0 events:127 errors:0
        TX bytes:2029 acl:90 sco:0 commands:22 errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'Thummb'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20e LMP Ver: 1.1 (0x1) LMP Subver:
0x20e
        Manufacturer: Cambridge Silicon Radio (10)

I am trying to use my linux machine as a gateway for my pda, when trying
to create a new connection on my i-mate/xda, it finds the server and
gets to the last menu where you click finish, then it drops you back to
the menu where you create a new connection without the newly created
bond?

When running hcidump I get the following

Hcidump
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Role Change(0x12) plen 8
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x007c
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x007c result 0 status 0
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x007c flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x007c flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1102 (LAN)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 91
    L2CAP(d): cid 0x7c len 87 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x52
          cnt 0x4f
 len 0x4f frm->len 0x4e n 0x4d
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x804f960
            aid 0x0001 (SrvClassIDList)
               uuid-16 0x1102 (LAN)
            aid 0x0004 (ProtocolDescList)
               uuid-16 0x0100 (L2CAP)
               uuid-16 0x0003 (RFCOMM) uint 0x1
            aid 0x0005 (BrwGrpList)
               uuid-16 0x1002 (PubBrwsGrp)
            aid 0x0009 (BTProfileDescList)
               uuid-16 0x1102 (LAN) uint 0x100
            aid 0x0100 (SrvName)
               str "LAN Access Point"

          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x007c
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x007c
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x007d
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x007d result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x007d flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x007d flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1103 (DUN)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x7d len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x007d
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x007d
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x007e
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x007e result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x007e flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x007e flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1105 (OBEXObjPush)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x7e len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x007e
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x007e
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x007f
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x007f result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x007f flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x007f flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1106 (OBEXObjTrnsf)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x7f len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x007f
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x007f
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0080
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0080 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0080 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0080 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1112 (AG)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x80 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0080
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0080
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0081
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0081 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0081 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0081 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1124
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x81 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0081
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0081
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0082
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0082 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0082 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0082 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1108 (Headset)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x82 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0082
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0082
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0083
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0083 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0083 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0083 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1101 (SP)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x83 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0083
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0083
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0084
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0084 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0084 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0084 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x350278f
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x84 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
 len 0x2 frm->len 0x1 n 0x0
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0084
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0084
> HCI Event: Number of Completed Packets(0x13) plen 5
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4


As I am new to bluetooth I am not too sure what I am looking for and the
dund/pand programs don't have enough debugging info, any help or
pointers would be great, I have found a link
http://wiki.xda-developers.com/wiki/bluetoothnetworking but there seems
to be a problem with the backend mysql database and this seems to be the
only article on the net that relates to what I am trying to achieve.


Mark Adrian Coetser
http://www.thummb.com
Cel: 0833046633



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
