Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Nigel Kukard <nkukard@lbsd.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040312112320.GE16237@lbsd.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Subject: [Bluez-users] trouble with qtek i-mate (pocketpc) and linux
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
Date: Fri, 12 Mar 2004 13:23:20 +0200


--ieNMXl1Fr3cevapt
Content-Type: multipart/mixed; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi guys,

wondering if anyone can point me in the right direction...
I have a QTek I-Mate poket pc (might be a 2020).

Once i've started the bluetooth service on my pc (downlaoded all the
bluez-* packages & installed them), i then start dund --listen --master
--msdun.=20

All up to here is fine, i then proceed to create a connection to my
laptop (my laptop has internet access and i would like to share  that
over bluetooth).=20

It creates a bonded device, but refuses to allow me to even list it in
the options to create a dialup connection.

I've attached the hcidumps of the conversation between the laptop and
i-mate. Notice that when i don't have dund running the LAN section is
not returning anything, but when i have it running it returns stuff.

any ideas?

-Nigel


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log.withdund"
Content-Transfer-Encoding: quoted-printable

HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Role Change(0x12) plen 8
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0161
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0161 result 0 status 0
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0161 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0161 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1102 (LAN)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 91
    L2CAP(d): cid 0x161 len 87 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x52
          cnt 0x4f
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x804d838
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1102 (LAN) >
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x1 > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x1102 (LAN) uint 0x100 > >
            aid 0x0100 (SrvName)
               str "LAN Access Point"

          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0161
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0161
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0162
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0162 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0162 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0162 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1103 (DUN)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x162 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0162
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0162
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0163
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0163 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0163 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0163 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1105 (OBEXObjPush)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x163 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0163
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0163
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0164
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0164 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0164 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0164 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1106 (OBEXObjTrnsf)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x164 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0164
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0164
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0165
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0165 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0165 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0165 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1112 (AG)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x165 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0165
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0165
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0166
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0166 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0166 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0166 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1124 (HID)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x166 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0166
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0166
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0167
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0167 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0167 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0167 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1108 (Headset)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x167 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0167
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0167
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0168
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0168 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0168 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0168 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1101 (SP)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x168 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0168
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0168
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0169
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0169 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0169 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0169 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x350278f
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x169 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0169
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0169
> HCI Event: Number of Completed Packets(0x13) plen 5
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4

--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log.withoutdund"
Content-Transfer-Encoding: quoted-printable

HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Role Change(0x12) plen 8
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0158
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0158 result 0 status 0
> HCI Event: Max Slots Change(0x1b) plen 3
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0158 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0158 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1102 (LAN)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x158 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0158
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0158
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0159
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0159 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0159 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0159 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1103 (DUN)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x159 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0159
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0159
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x015a
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x015a result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x015a flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x015a flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1105 (OBEXObjPush)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x15a len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x015a
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x015a
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x015b
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x015b result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x015b flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x015b flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1106 (OBEXObjTrnsf)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x15b len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x015b
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x015b
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x015c
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x015c result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x015c flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x015c flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1112 (AG)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x15c len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x015c
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x015c
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x015d
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x015d result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x015d flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x015d flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1124 (HID)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x15d len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x015d
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x015d
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x015e
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x015e result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x015e flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x015e flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1108 (Headset)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x15e len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x015e
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x015e
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x015f
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x015f result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x015f flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x015f flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x1101 (SP)
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x15f len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x015f
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x015f
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0160
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0160 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0160 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0160 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 38
    L2CAP(d): cid 0x40 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0x350278f
          max 0xff8
          aid(s) 0x0000 - 0xffff
          cont 00=20
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x160 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00=20
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0160
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0160
> HCI Event: Number of Completed Packets(0x13) plen 5
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4

--CblX+4bnyfN0pR09--

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAUZ2oKoUGSidwLE4RAin5AKC9wXSBqSrNL+44I1JG9lUp5nIL/ACgiGZO
2A7fa6Oh0x0h0NJBr+rjTkk=
=Aa7u
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
