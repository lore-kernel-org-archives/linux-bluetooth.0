Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: =?iso-8859-1?Q?Jos=E9_S=E1nchez_S=E1nchez?= <jose.sanchez@libera.net>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Fri, 15 Jun 2007 12:33:21 +0200
Message-ID: <003101c7af38$98bf6d20$a100010a@Libera.local>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0032_01C7AF49.5C483D20"
In-Reply-To: <1181901191.6846.21.camel@aeonflux.inter-touch.com>
Subject: Re: [Bluez-devel] RV: sdp_connect don't work with some handsets
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0032_01C7AF49.5C483D20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Thanks for your support.

I have attached to this mail 3 logs using "hcidump -X -V"

Send_to_Lg.txt --> trying to send a file from my computer to one LG =
handset.

Send_to_Grungig.txt --> trying to send a file from my computer to one
GRUNDIG handset.

In these cases, there is an error in the function "connect", with result =
-1
and errno value 38 (EL2NSYNC).

Send_to_SonyEric.txt --> trying to send a file from my computer to one
Sony-Ericcsson handset. In this case, the file is sent properly.

Also I can send files to Motorola, Nokia and Samsung handsets.

Do you know why can't I send to LG and Grundig handsets with the same
application?

Thanks a lot !!
=20
Regards

Jos=E9

-----Mensaje original-----
De: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] En nombre de Marcel
Holtmann
Enviado el: viernes, 15 de junio de 2007 11:53
Para: BlueZ development
Asunto: Re: [Bluez-devel] RV: sdp_connect don't work with some handsets

Hi Jose,

>  I have been some time working with bluez, and I have problems trying
> to connect my computer with some mobile devices. I can do a connection
> with handsets form Motorola, Nokia and Sony-Ericcsson, but I can=92t
> connect with LG handsets using bluez.

show us "hcidump -X -V" for that.

Regards

Marcel



-------------------------------------------------------------------------=

This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0032_01C7AF49.5C483D20
Content-Type: text/plain;
	name="Send_to_Lg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Send_to_Lg.txt"

*************** LG *********************
[root@localhost sbin]# ./hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 255
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:19:A1:36:C5:71 mode 1 clkoffset 0x7fff class 0x500204
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:19:A1:36:C5:71 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:19:A1:36:C5:71 name 'Carlos'
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:19:A1:36:C5:71 ptype 0xcc18 rswitch 0x01 clkoffset 0x7fff =
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:19:A1:36:C5:71 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x21 handle 3 bdaddr 00:19:A1:36:C5:71 type ACL encrypt 0x00
    Error: Role Change Not Allowed
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:19:A1:36:C5:71 ptype 0xcc18 rswitch 0x01 clkoffset 0x7fff =
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:19:A1:36:C5:71 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x21 handle 4 bdaddr 00:19:A1:36:C5:71 type ACL encrypt 0x00
    Error: Role Change Not Allowed




------=_NextPart_000_0032_01C7AF49.5C483D20
Content-Type: text/plain;
	name="Send_to_SonyEric.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Send_to_SonyEric.txt"

*********** SONY ERICCSSON *********

./hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 255
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:1A:75:12:E5:D8 mode 1 clkoffset 0x6b2e class 0x5a0204
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1A:75:12:E5:D8 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1A:75:12:E5:D8 name 'Z610i'
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:1A:75:12:E5:D8 ptype 0xcc18 rswitch 0x01 clkoffset 0x6b2e =
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:1A:75:12:E5:D8 type ACL encrypt 0x00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 6
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK=20
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1105 (OBEXObjPush)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 115
    L2CAP(d): cid 0x0040 len 111 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x6a
          count 103
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000b
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0003 (SrvID)
                 uuid-16 0xe006
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x6 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX Object Push"
              aid 0x0303 (SuppFormatsList)
                 < uint 0x1 uint 0x3 uint 0x5 uint 0xff >
          cont 00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 6
    Features: 0xff 0xeb 0x8d 0xfe 0x9b 0xe9 0x00 0x00
> ACL data: handle 6 flags 0x02 dlen 38
    L2CAP(d): cid 0x0041 len 34 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x1d
          count 26
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x7 > <
                 uuid-16 0x0008 (OBEX) > >
          cont 00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> ACL data: handle 6 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 12 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1007 max_retrans 0 credits 0
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43=20
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88=20
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 0 fcs 0x89 credits 20
> ACL data: handle 6 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 6 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 33
< ACL data: handle 6 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 7 fcs 0x4f=20
        OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 1024
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 1 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 79 xoff 3 pm 0x0000
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 7 fcs 0x89 credits 1
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu =
4096
        Status 200 =3D Success
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1A:75:12:E5:D8 mode 2 clkoffset 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
< ACL data: handle 6 flags 0x02 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 3 sb 1 p 1 pt 3 xi 0 xo 0
      rtri 1 rtro 0 rtci 0 rtco 0 xon 0 xoff 181 pm 0x0010
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 56
    L2CAP(d): cid 0x0040 len 1012 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 1007 fcs 0x4f=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
< ACL data: handle 6 flags 0x02 dlen 25
    L2CAP(d): cid 0x0040 len 21 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 17 fcs 0x4f=20
        OBEX: Put cmd(c): len 1024
        Name (0x01) =3D Unicode length 18
        0000: 00 74 00 65 00 73 00 74  00 2e 00 6a 00 70 00 67  =
.t.e.s.t...j.p.g
        0010: 00 00                                             ..
        Length (0xc3) =3D 2356
        Body (0x48) =3D Sequence length 992
        0000: ff d8 ff e0 00 10 4a 46  49 46 00 01 01 01 00 60  =
......JFIF.....`
        0010: 00 60 00 00 ff ed 00 2c  50 68 6f 74 6f 73 68 6f  =
.`.....,Photosho
        0020: 70 20 33 2e 30 00 38 42  49 4d 03 ed 00 00 00 00  p =
3.0.8BIM......
        0030: 00 10 00 96 00 00 00 01  00 01 00 96 00 00 00 01  =
................
        0040: 00 01 ff e1 00 4a 45 78  69 66 00 00 49 49 2a 00  =
.....JExif..II*.
        0050: 08 00 00 00 03 00 1a 01  05 00 01 00 00 00 32 00  =
..............2.
        0060: 00 00 1b 01 05 00 01 00  00 00 3a 00 00 00 28 01  =
..........:...(.
        0070: 03 00 01 00 00 00 02 00  3f 00 00 00 00 00 00 00  =
........?.......
        0080: 96 00 00 00 01 00 00 00  96 00 00 00 01 00 ff db  =
................
        0090: 00 43 00 08 06 06 07 06  05 08 07 07 07 09 09 08  =
.C..............
        00a0: 0a 0c 14 0d 0c 0b 0b 0c  19 12 13 0f 14 1d 1a 1f  =
................
        00b0: 1e 1d 1a 1c 1c 20 24 2e  27 20 22 2c 23 1c 1c 28  ..... =
$.' ",#..(
        00c0: 37 29 2c 30 31 34 34 34  1f 27 39 3d 38 32 3c 2e  =
7),01444.'9=3D82<.
        00d0: 33 34 32 ff db 00 43 01  09 09 09 0c 0b 0c 18 0d  =
342...C.........
        00e0: 0d 18 32 21 1c 21 32 32  32 32 32 32 32 32 32 32  =
..2!.!2222222222
        00f0: 32 32 32 32 32 32 32 32  32 32 32 32 32 32 32 32  =
2222222222222222
        0100: 32 32 32 32 32 32 32 32  32 32 32 32 32 32 32 32  =
2222222222222222
        0110: 32 32 32 32 32 32 32 32  ff c0 00 11 08 00 40 00  =
22222222......@.
        0120: 4e 03 01 22 00 02 11 01  03 11 01 ff c4 00 1f 00  =
N.."............
        0130: 00 01 05 01 01 01 01 01  01 00 00 00 00 00 00 00  =
................
        0140: 00 01 02 03 04 05 06 07  08 09 0a 0b ff c4 00 b5  =
................
        0150: 10 00 02 01 03 03 02 04  03 05 05 04 04 00 00 01  =
................
        0160: 7d 01 02 03 00 04 11 05  12 21 31 41 06 13 51 61  =
}........!1A..Qa
        0170: 07 22 71 14 32 81 91 a1  08 23 42 b1 c1 15 52 d1  =
."q.2....#B...R.
        0180: f0 24 33 62 72 82 09 0a  16 17 18 19 1a 25 26 27  =
.$3br........%&'
        0190: 28 29 2a 34 35 36 37 38  39 3a 43 44 45 46 47 48  =
()*456789:CDEFGH
        01a0: 49 4a 53 54 55 56 57 58  59 5a 63 64 65 66 67 68  =
IJSTUVWXYZcdefgh
        01b0: 69 6a 73 74 75 76 77 78  79 7a 83 84 85 86 87 88  =
ijstuvwxyz......
        01c0: 89 8a 92 93 94 95 96 97  98 99 9a a2 a3 a4 a5 a6  =
................
        01d0: a7 a8 a9 aa b2 b3 b4 b5  b6 b7 b8 b9 ba c2 c3 c4  =
................
        01e0: c5 c6 c7 c8 c9 ca d2 d3  d4 d5 d6 d7 d8 d9 da e1  =
................
        01f0: e2 e3 e4 e5 e6 e7 e8 e9  ea f1 f2 f3 f4 f5 f6 f7  =
................
        0200: f8 f9 fa ff c4 00 1f 01  00 03 01 01 01 01 01 01  =
................
        0210: 01 01 01 00 00 00 00 00  00 01 02 03 04 05 06 07  =
................
        0220: 08 09 0a 0b ff c4 00 b5  11 00 02 01 02 04 04 03  =
................
        0230: 04 07 05 04 04 00 01 02  77 00 01 02 03 11 04 05  =
........w.......
        0240: 21 31 06 12 41 51 07 61  71 13 22 32 81 08 14 42  =
!1..AQ.aq."2...B
        0250: 91 a1 b1 c1 09 23 33 52  f0 15 62 72 d1 0a 16 24  =
.....#3R..br...$
        0260: 34 e1 25 f1 17 18 19 1a  26 27 28 29 2a 35 36 37  =
4.%.....&'()*567
        0270: 38 39 3a 43 44 45 46 47  48 49 4a 53 54 55 56 57  =
89:CDEFGHIJSTUVW
        0280: 58 59 5a 63 64 65 66 67  68 69 6a 73 74 75 76 77  =
XYZcdefghijstuvw
        0290: 78 79 7a 82 83 84 85 86  87 88 89 8a 92 93 94 95  =
xyz.............
        02a0: 96 97 98 99 9a a2 a3 a4  a5 a6 a7 a8 a9 aa b2 b3  =
................
        02b0: b4 b5 b6 b7 b8 b9 ba c2  c3 c4 c5 c6 c7 c8 c9 ca  =
................
        02c0: d2 d3 d4 d5 d6 d7 d8 d9  da e2 e3 e4 e5 e6 e7 e8  =
................
        02d0: e9 ea f2 f3 f4 f5 f6 f7  f8 f9 fa ff da 00 0c 03  =
................
        02e0: 01 00 02 11 03 11 00 3f  00 f7 dc d7 11 e2 df 89  =
.......?........
        02f0: 7a 17 86 66 92 c5 ee 63  9b 50 55 3f b9 04 90 8c  =
z..f...c.PU?....
        0300: 00 20 39 50 4a 93 91 8e  3f 11 4c f1 bf 8f bf e1  . =
9PJ...?.L.....
        0310: 19 95 2c ad 20 49 ef 5d  77 9f 33 3b 23 5e d9 c7  ..,. =
I.]w.3;#^..
        0320: 24 9f 4e 2b c4 75 08 4e  bd ab 4d a8 43 a3 42 2e  =
$.N+.u.N..M.C.B.
        0330: a4 90 c9 27 d9 22 72 ac  c7 ae 50 92 3f 4a ee c3  =
...'."r...P.?J..
        0340: e0 e5 35 cf 25 a1 c5 5b  19 08 49 c5 3d 4e e2 c7  =
..5.%..[..I.=3DN..
        0350: c7 9a b7 89 43 48 7c 69  a6 68 aa 71 fe 8f e4 90  =
....CH|i.h.q....
        0360: cb ff 00 02 75 e7 d3 86  3d 2a f6 75 65 25 c7 c5  =
....u...=3D*.ue%..
        0370: 9d 3b 9e c2 48 db f4 cd  79 e3 58 6b b2 a9 54 d0  =
.;..H...y.Xk..T.
        0380: 49 ff 00 ae 7a 4a 03 fa  25 40 74 7f 12 21 ca e8  =
I...zJ..%@t..!..
        0390: 37 63 1f f5 0d ff 00 ec  2b a5 d1 4b b2 f9 23 91  =
7c......+..K..#.
        03a0: 55 6f 5d 7e f6 7a 15 a7  c4 5d 73 44 d4 e3 b7 bf  =
Uo]~.z...]sD....
        03b0: d6 74 8d 76 d1 98 6f 96  24 92 37 40 7b e5 63 da  =
.t.v..o.$.7@{.c.
        03c0: 7e 80 1e bd ab d3 f4 0f  13 69 9e 23 b7 32 58 cd  =
~........i.#.2X.
        03d0: 96 5e 5a 26 e1 d4 64 8c  91 e8 71 5f 35 cd 1f 8a  =
.^Z&..d...q_5...
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1A:75:12:E5:D8 name 'Z610i'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 2
        OBEX: Put rsp(f): status 100 len 3< ACL data: handle 6 flags =
0x02 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 56
    L2CAP(d): cid 0x0040 len 1012 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 1007 fcs 0x4f=20
< ACL data: handle 6 flags 0x02 dlen 25
    L2CAP(d): cid 0x0040 len 21 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 17 fcs 0x4f=20
        OBEX: Put cmd(c): len 1024 (continue)
        Body (0x48) =3D Sequence length 1018
        0000: 7c b3 1f f6 3c cb c6 38  d2 94 1f cc 26 6a 6d 07  =
|...<..8....&jm.
        0010: e2 0e ab e0 eb b2 d1 e9  16 46 62 a1 25 69 e3 90  =
.........Fb.%i..
        0020: 48 cb 9c 91 f7 b0 a4 e3  b0 fc 2b 2a b8 7a 6e 1e  =
H.........+*.zn.
        0030: ef c4 6f 46 b5 5e 6d 6d  6f c4 fa a6 8a e5 fc 11  =
..oF.^mmo.......
        0040: e3 0b 5f 1a f8 79 35 1b  64 30 ca 8d e5 5c 40 dc  =
.._..y5.d0...\@.
        0050: 98 e4 00 12 01 ee 08 20  83 ef ea 08 ae a2 bc e6  ....... =
........
        0060: 9a 76 67 a0 9d d5 c2 8a  64 92 24 48 5d d9 55 47  =
.vg.....d.$H].UG
        0070: 52 c7 00 54 56 f7 56 f7  40 b5 bd c4 52 aa 92 09  =
R..TV.V.@...R...
        0080: 47 0d 83 e9 c7 d2 8b 3d  c5 cc af 63 c7 7c 51 e1  =
G......=3D...c.|Q.
        0090: 5d 23 50 f1 05 ce ab 67  f1 18 d8 4d 3b 13 24 6a  =
]#P....g...M;.$j
        00a0: ca e0 7a 28 28 cb 80 3a  73 93 ea 6b 90 93 c1 70  =
..z((..:s..k...p
        00b0: e9 ae 6e 6c 3c 7f 60 6e  0e 72 f9 96 32 7f 15 dc  =
..nl<.`n.r..2...
        00c0: 6b af 6f 84 da a9 42 4c  ff 00 36 3a 04 53 ff 00  =
k.o...BL..6:.S..
        00d0: b3 d5 09 fe 14 6b 40 7e  ee 29 dc fd 21 03 ff 00  =
.....k@~.)..!...
        00e0: 46 d7 af 6a 31 56 f6 97  3c 9e 7a f2 ff 00 97 76  =
F..j1V..<.z....v
        00f0: 32 34 bd 3f c5 37 f7 cb  a7 e9 7e 37 fb 44 e4 64  =
24.?.7....~7.D.d
        0100: 24 17 b7 58 c7 ae 76 00  07 b9 ae 95 7c 09 f1 34  =
$..X..v.....|..4
        0110: 75 f1 24 c7 fe e2 73 53  74 7f 07 78 cf 43 86 e2  =
u.$...sSt..x.C..
        0120: 3d 3e 3b 9b 67 90 83 e6  a7 d9 f7 71 d8 93 21 ca  =
=3D>;.g......q..!.
        0130: e3 b7 ae 0f 1c 83 6a 2d  3b e2 c0 ff 00 59 71 2f  =
......j-;....Yq/
        0140: fe 04 43 fe 35 9b e5 72  f7 65 1b 79 97 aa 5e fc  =
..C.5..r.e.y..^.
        0150: 5f c8 8c 7c 39 f1 f4 c7  33 f8 89 0f 3f c7 7f 33  =
_..|9...3...?..3
        0160: 1f fd 06 ad 59 fc 23 d5  61 98 4a 7c 40 21 91 be  =
....Y.#.a.J|@!..
        0170: f3 c4 8c 4f e7 91 9a 95  34 cf 89 2e 31 25 cc c3  =
...O....4...1%..
        0180: df ed 11 8f e4 69 0f 86  be 20 4a d9 3a 8d ca 7f  =
.....i... J.:...
        0190: db f9 03 f4 35 a2 e6 4b  4a b1 46 0d c5 bf e1 49  =
....5..KJ.F....I
        01a0: 9d 5f 84 7c 13 0f 84 de  ea 64 be 7b 89 6e b0 66  =
._.|.....d.{.n.f
        01b0: 3e 5a a0 63 9c ee 3d 49  3c 9e a7 b9 f5 ad 1d 4b  =
>Z.c..=3DI<......K
        01c0: c5 ba 0e 8e 0f db 35 38  55 f1 9f 2d 0e f7 fc 97  =
......58U..-....
        01d0: 27 f3 af 3d 6f 87 fe 2e  d4 49 17 da a2 94 3c 37  =
'..=3Do....I....<7
        01e0: 9b 72 f2 12 3e 98 39 ab  d6 5f 07 62 0e 1a ff 00  =
.r..>.9.._.b....
        01f0: 56 79 17 ba 43 10 5f fc  78 93 fc ab 09 d2 a1 cd  =
Vy..C._.x.......
        0200: cd 52 a5 df 92 3a 61 5a  bf 2f 2d 3a 76 5e 6c e6  =
.R...:aZ./-:v^l.
        0210: ac 7c 31 ae f8 c2 7b 8b  9f b7 c5 2b 45 29 49 5a  =
.|1...{....+E)IZ
        0220: e2 66 25 0e 7a 74 23 f2  e2 bd 0b c2 3e 01 b7 f0  =
.f%.zt#.....>...
        0230: f1 9e 5b a9 52 f2 e2 51  b7 26 30 15 17 d0 0f 5f  =
..[.R..Q.&0...._
        0240: 7a e8 b4 8d 22 cf 45 b4  5b 6b 38 ca c6 00 19 2c  =
z...".E.[k8....,
        0250: 59 8e 3d 49 e7 f0 e8 2b  48 56 15 31 53 92 70 8b  =
Y.=3DI...+HV.1S.p.
        0260: f7 4e 98 61 a3 75 39 af  78 f9 a6 f0 78 99 0b 1b  =
.N.a.u9.x...x...
        0270: 8b bf 10 82 0f 3e 65 d5  c0 c1 fc 5a b2 7f b4 af  =
.....>e....Z....
        0280: e3 38 3a 85 fb 10 7a 35  ec df 97 df af 47 f1 ff  =
.8:...z5.....G..
        0290: 00 8c bc 6b a4 eb 57 b6  56 17 9a 75 8d bc 7b 5e  =
...k..W.V..u..{^
        02a0: db f7 25 e6 95 08 eb 96  0c 9d 72 39 c7 4a e3 a3  =
..%.......r9.J..
        02b0: f1 67 c4 6b c7 56 93 5f  81 03 f7 6b 8b 58 c0 fa  =
.g.k.V._...k.X..
        02c0: 81 8c 7e 55 e8 c6 a3 94  6f ec d2 4f fa ec 70 3a  =
..~U....o..O..p:
        02d0: 76 76 f6 ad bf 3f f8 73  2b fe 12 2d 42 33 91 3c  =
vv...?.s+..-B3.<
        02e0: ed ec d7 73 9f fd 9e ba  0f 09 ea 4f ae 6a 66 d6  =
...s.......O.jf.
        02f0: f7 57 8e c7 23 11 89 2e  27 1e 6b 1e 00 0c 5c 80  =
.W..#...'.k...\.
        0300: 72 47 1d ea 4f b3 f8 c6  e5 94 c9 e3 fd 3d 49 ec  =
rG..O........=3DI.
        0310: ba e6 cf d1 4d 4f fd 97  e2 b5 1c fc 43 b0 3e df  =
....MO......C.>.
        0320: db cf 59 ba 9d b4 fe bd  01 43 be bf 2f f8 27 68  =
..Y......C../.'h
        0330: 7e 1d eb 8c 4b 0d 78 a8  27 21 43 49 81 ed c9 cd  =
~...K.x.'!CI....
        0340: 55 97 e1 df 8a 95 c1 83  5c 8c 8f 56 b8 95 4f e8  =
U.......\..V..O.
        0350: 0d 72 82 f3 c5 16 11 97  5f 1d 69 d3 11 fc 3f db  =
.r......_.i...?.
        0360: 29 21 3f f7 d1 aa af f1  13 c4 da 72 86 9b c4 70  =
)!?........r...p
        0370: 15 73 8c ab c1 3e 3f 05  0c 47 e5 57 19 57 7b 4e  =
.s...>?..G.W.W{N
        0380: 3f 77 fc 02 1d 3a 09 fc  32 fb d9 d5 dc f8 53 e2  =
?w...:..2.....S.
        0390: 05 92 93 06 a7 71 38 5f  e1 82 f9 bf 93 11 5a be  =
.....q8_......Z.
        03a0: 0a 6f 1c a6 b2 53 55 49  9f 4f c6 25 37 4c 32 a7  =
.o...SUI.O.%7L2.
        03b0: 19 05 3b 93 fa 7e 95 6b  e1 bf 8b 75 2f 15 35 eb  =
..;..~.k...u/.5.
        03c0: 5c 49 05 d5 9d b0 55 5b  b8 a2 68 f7 48 79 2b 83  =
\I....U[..h.Hy+.
        03d0: 8e 83 04 fc a3 a8 af 40  ae 4a f8 99 59 d3 9c 62  =
.......@.J..Y..b
        03e0: fc d2 3b 68 61 52 6a 71  94 97 93 16 97 bd 25 2f  =
..;haRjq......%/
        03f0: 7a e0 3b ce 7b c4 be 13  d3 7c                    =
z.;.{....|
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 2
        OBEX: Put rsp(f): status 100 len 3< ACL data: handle 6 flags =
0x02 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 120
< ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 357 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 352 fcs 0x4f=20
        OBEX: Put cmd(f): len 352 (continue)
        End of Body (0x49) =3D Sequence length 346
        0000: 51 6e 91 df 2c 88 f1 9c  a4 d1 10 1d 47 71 92 08  =
Qn..,.......Gq..
        0010: c7 d4 57 cf 3e 26 b6 8b  c3 fe 23 ba d3 ef ad 75  =
..W.>&....#....u
        0020: 3b 5b 58 dc a4 33 bc 4a  e6 6c 0c ee 1c aa e3 90  =
;[X..3.J.l......
        0030: 78 27 af 3c f1 5f 53 e2  a8 6a 3a 55 a6 a7 03 47  =
x'.<._S..j:U...G
        0040: 75 08 73 b4 a8 70 4a ba  e7 ae d6 1c 8f c2 ba 68  =
u.s..pJ........h
        0050: 62 67 4b 4b e8 72 d5 c3  53 a8 f9 ad a9 f2 ad b5  =
bgKK.r..S.......
        0060: a4 fa ac 84 69 56 77 f7  8b 9d a4 a5 b1 24 1f 70  =
....iVw......$.p
        0070: a5 aa eb f8 2f c4 7e 5e  ff 00 ec 5d 47 1e 9f 63  =
..../.~^...]G..c
        0080: 97 3f fa 0d 7b 44 9f 0e  75 4b 42 06 87 e2 fd 46  =
.?..{D..uKB....F
        0090: ca 05 18 4b 79 09 91 17  d0 0c 30 00 7e 06 a3 6f  =
...Ky.....0.~..o
        00a0: 05 f8 e6 45 08 7c 74 ea  be ab 6f cf e7 9a ea 78  =
...E.|t...o....x
        00b0: a4 f6 6b f1 39 56 19 af  b2 ff 00 03 c2 86 88 63  =
..k.9V.........c
        00c0: 9c c3 a9 35 cd 9b 63 3b  7e cf 96 fc 99 96 ba df  =
...5..c;~.......
        00d0: 04 fc 2f b2 f1 35 d4 e2  fa 4d 4d 2d 11 43 47 71  =
../..5...MM-.CGq
        00e0: 12 24 61 bb 63 e6 dd cf  d3 3d 2b d4 b4 9f 86 ef  =
.$a.c....=3D+.....
        00f0: 05 dc 77 5a df 89 35 6d  62 58 9b 74 69 25 c3 c7  =
..wZ..5mbX.ti%..
        0100: 12 9f 5d a1 89 e9 c7 5c  1c 9c 8a ed ed ed a1 b4  =
..]....\........
        0110: 85 61 b7 89 21 89 46 15  23 50 aa 3e 80 56 75 71  =
.a..!.F.#P.>.Vuq
        0120: 71 e5 b4 56 bd cd 69 61  ea 29 5e 4f 4e c5 3d 17  =
q..V..ia.)^ON.=3D.
        0130: 45 b1 f0 fe 93 06 99 a6  c0 21 b5 84 61 57 a9 27  =
E........!..aW.'
        0140: a9 24 f7 24 f7 ad 2a 5c  51 8a e1 6e fa b3 bd 2b  =
.$.$..*\Q..n...+
        0150: 09 4b de 8c 50 05 20 3f  ff d9                    .K..P. =
?..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
        OBEX: Put rsp(f): status 200 len 3< ACL data: handle 6 flags =
0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 3 fcs 0x4f=20
        OBEX: Disconnect cmd(f): len 3> ACL data: handle 6 flags 0x02 =
dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
        OBEX: Disconnect rsp(f): status 200 len 3< ACL data: handle 6 =
flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2=20
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88=20
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd=20
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 6 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x16
    Reason: Connection Terminated by Local Host

------=_NextPart_000_0032_01C7AF49.5C483D20
Content-Type: text/plain;
	name="Send_to_Grundig.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Send_to_Grundig.txt"

************ GRUNDIG ******************

[root@localhost sbin]# ./hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 255
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 9A:BC:56:78:12:34 mode 1 clkoffset 0x7ff9 class 0x520204
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 9A:BC:56:78:12:34 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 9A:BC:56:78:12:34 name 'Jose Sanchez'
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 9A:BC:56:78:12:34 ptype 0xcc18 rswitch 0x01 clkoffset 0x7ff9 =
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 9A:BC:56:78:12:34 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x21 handle 3 bdaddr 9A:BC:56:78:12:34 type ACL encrypt 0x00
    Error: Role Change Not Allowed
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 9A:BC:56:78:12:34 ptype 0xcc18 rswitch 0x01 clkoffset 0x7ff9 =
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 9A:BC:56:78:12:34 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x21 handle 4 bdaddr 9A:BC:56:78:12:34 type ACL encrypt 0x00
    Error: Role Change Not Allowed

------=_NextPart_000_0032_01C7AF49.5C483D20
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------=_NextPart_000_0032_01C7AF49.5C483D20
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0032_01C7AF49.5C483D20--
