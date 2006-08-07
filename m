Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 7 Aug 2006 15:05:32 -0300
From: redondos <redondos@gmail.com>
To: digitalfredy@debiancolombia.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060807180532.GA5319@refinery.twat.com.ar>
References: <20060803043158.GA13259@refinery.twat.com.ar>
	<1154888079.7923.13.camel@YODA>
	<20060806203043.GA17698@refinery.twat.com.ar>
	<1154971782.4625.6.camel@YODA>
MIME-Version: 1.0
In-Reply-To: <1154971782.4625.6.camel@YODA>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1799601840=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1799601840==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07 12:29, digitalfredy wrote:
> Try get any file from the phone, for example for get any video:
>=20
> obexftp -b 00:16:20:F1:47:68 -B 6 -l -c Videos
>=20
> when you know the name of the videofile to like get made it
>=20
> obexftp -b 00:16:20:F1:47:68 -B 6 -c Videos -g videoname.3gp
>=20
> send my the log

It looks like I can download from the phone just fine, but I can't upload.=
=20

Here are some logs:

redondos@refinery.twat.com.ar ~ $ obexftp -b 00:16:20:F1:47:68 -B 6 -l Soun=
ds
Browsing 00:16:20:F1:47:68 ...   =20
Channel: 6
Connecting...done
Receiving "Sounds"...\<?xml version=3D"1.0" encoding=3D"UTF-8"?>
<!DOCTYPE folder-listing SYSTEM "obex-folder-listing.dtd">
<!--                             =20
 XML Coder, Nov 14 2005, 23:41:10, (C) 2001 Sony Ericsson Mobile Communicat=
ions AB
-->
<folder-listing version=3D"1.0"><parent-folder/>
<file name=3D"Wake Up.mp3" size=3D"28212"/>
<file name=3D"Up&apos;N&apos;Away.mp3" size=3D"115992"/>
<file name=3D"Storytelling.mp3" size=3D"41404"/>
<file name=3D"Sony Ericsson.mid" size=3D"1060"/>
<file name=3D"Robot Groove.mp3" size=3D"43494"/>
<file name=3D"Phone Party.mp3" size=3D"41535"/>
<file name=3D"Overdub.mp3" size=3D"95040"/>
<file name=3D"Nueva Instrm.mp3" size=3D"386996"/>
<file name=3D"Jungle Calling.mp3" size=3D"33567"/>
<file name=3D"Greeting.mid" size=3D"5950"/>
<file name=3D"Itch Ni San.mp3" size=3D"95472"/>
<file name=3D"Industrial Alert.mp3" size=3D"51069"/>
<file name=3D"Cruisin.mp3" size=3D"53943"/>
<file name=3D"Choo-Choo.mp3" size=3D"47020"/>
<file name=3D"Bounce.mp3" size=3D"95084"/>
<file name=3D"Block Party.mp3" size=3D"57208"/>
<file name=3D"Bells of Joy.mp3" size=3D"48718"/>
<file name=3D"@The Place.mp3" size=3D"103943"/>
<file name=3D"MusicDJ Demo.mid" size=3D"10796"/>
<file name=3D"9PM-1.mp3" size=3D"443535"/>
<file name=3D"My melody.mid" size=3D"2231"/>
<file name=3D"Train (free) - Free .dcf" size=3D"82150"/>
<folder name=3D"Videodj"/>
<folder name=3D"Ringtones"/>
</folder-listing>
done
Disconnecting...done
redondos@refinery.twat.com.ar ~ $ obexftp -b 00:16:20:F1:47:68 -B 6 -c Soun=
ds -g "Block Party.mp3"
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Sounds"... done
Receiving "Block Party.mp3"...\done
Disconnecting...done
redondos@refinery.twat.com.ar ~ $ obexftp -b 00:16:20:F1:47:68 -B 6 -c Soun=
ds -g "Train (free) - Free .dcf"
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Sounds"... done
Receiving "Train (free) - Free .dcf"...|done
Disconnecting...done

(hcidump: upload_picture.log)
redondos@refinery.twat.com.ar ...imedia/Graphic/Images $ obexftp -b 00:16:2=
0:F1:47:68 -B 6 -c Pictures -p offthenet1zn.jpg
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Pictures"... done
Sending "offthenet1zn.jpg"...\failed: offthenet1zn.jpg
Disconnecting...failed: disconnect

(hcidump: upload_theme.log)
redondos@refinery.twat.com.ar .../z520/Themes/Abstract $ obexftp -b 00:16:2=
0:F1:47:68 -B 6 -c Themes -p Spider.thm
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Themes"... done
Sending "Spider.thm"...\failed: Spider.thm
Disconnecting...failed: disconnect

Any ideas. Please remember to check the attached dumps. Thanks.

--=20
redondos

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="upload_picture.log"
Content-Transfer-Encoding: quoted-printable

HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:20:F1:47:68 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:20:F1:47:68
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:20:F1:47:68 key E0FBDF5E3EF4241A247AAFCD6331E97E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:20:F1:47:68
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:20:F1:47:68 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0e
    Link policy: HOLD SNIFF PARK=20
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x1d
          count 26
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x6 > <
                 uuid-16 0x0008 (OBEX) > >
          cont 00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013=20
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 12 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 329 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88=20
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 0 fcs 0x89 credits 20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 33
< ACL data: handle 1 flags 0x02 dlen 34
    L2CAP(d): cid 0x0040 len 30 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 26 fcs 0x4f=20
        OBEX: Connect cmd(f): len 26 version 1.0 flags 0 mtu 1024
        Target (0x46) =3D Sequence length 16
        0000: f9 ec 7b c4 95 3c 11 d2  98 4e 52 54 00 dc 9e 09  ..{..<...NR=
T....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 1 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 70 xoff 0 pm 0xf913
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 0 p 0 pt 0 xi 1 xo 0
      rtri 0 rtro 0 rtci 1 rtco 0 xon 19 xoff 127 pm 0x703f
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(d): cid 0x0041 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 31 fcs 0x89 credits 1
        OBEX: Connect rsp(f): status 200 len 31 version 1.0 flags 0 mtu 4096
        Status 200 =3D Success
        Connection ID (0xcb) =3D 1
        Who (0x4a) =3D Sequence length 16
        0000: f9 ec 7b c4 95 3c 11 d2  98 4e 52 54 00 dc 9e 09  ..{..<...NR=
T....
< ACL data: handle 1 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 31 fcs 0x4f=20
        OBEX: SetPath cmd(f): len 31 flags 2 constants 0
        Connection ID (0xcb) =3D 1
        Name (0x01) =3D Unicode length 18
        0000: 00 50 00 69 00 63 00 74  00 75 00 72 00 65 00 73  .P.i.c.t.u.=
r.e.s
        0010: 00 00                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
        OBEX: SetPath rsp(f): status 200 len 3
        Status 200 =3D Success
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
< ACL data: handle 1 flags 0x02 dlen 45
    L2CAP(d): cid 0x0040 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 37 fcs 0x4f=20
        OBEX: Put cmd(c): len 1024
        Connection ID (0xcb) =3D 1
        Name (0x01) =3D Unicode length 34
        0000: 00 6f 00 66 00 66 00 74  00 68 00 65 00 6e 00 65  .o.f.f.t.h.=
e.n.e
        0010: 00 74 00 31 00 7a 00 6e  00 2e 00 6a 00 70 00 67  .t.1.z.n...=
j.p.g
        0020: 00 00                                             ..
        Length (0xc3) =3D 50727
        Body (0x48) =3D Sequence length 971
        0000: ff d8 ff e0 00 10 4a 46  49 46 00 01 01 01 00 48  ......JFIF.=
=2E...H
        0010: 00 48 00 00 ff db 00 43  00 05 03 04 04 04 03 05  .H.....C...=
=2E....
        0020: 04 04 04 05 05 05 06 07  0c 08 07 07 07 07 0f 0b  ...........=
=2E....
        0030: 0b 09 0c 11 0f 12 12 11  0f 11 11 13 16 1c 17 13  ...........=
=2E....
        0040: 14 1a 15 11 11 18 21 18  1a 1d 1d 1f 1f 1f 13 17  ......!....=
=2E....
        0050: 22 24 22 1e 24 1c 1e 1f  1e ff db 00 43 01 05 05  "$".$......=
=2EC...
        0060: 05 07 06 07 0e 08 08 0e  1e 14 11 14 1e 1e 1e 1e  ...........=
=2E....
        0070: 1e 1e 1e 1e 1e 1e 1e 1e  1e 1e 1e 1e 1e 1e 1e 1e  ...........=
=2E....
        0080: 1e 1e 1e 1e 1e 1e 1e 1e  1e 1e 1e 1e 1e 1e 1e 1e  ...........=
=2E....
        0090: 1e 1e 1e 1e 1e 1e 1e 1e  1e 1e 1e 1e 1e 1e ff c0  ...........=
=2E....
        00a0: 00 11 08 01 d0 01 5e 03  01 22 00 02 11 01 03 11  ......^..".=
=2E....
        00b0: 01 ff c4 00 1f 00 00 01  05 01 01 01 01 01 01 00  ...........=
=2E....
        00c0: 00 00 00 00 00 00 00 01  02 03 04 05 06 07 08 09  ...........=
=2E....
        00d0: 0a 0b ff c4 00 b5 10 00  02 01 03 03 02 04 03 05  ...........=
=2E....
        00e0: 05 04 04 00 00 01 7d 01  02 03 00 04 11 05 12 21  ......}....=
=2E...!
        00f0: 31 41 06 13 51 61 07 22  71 14 32 81 91 a1 08 23  1A..Qa."q.2=
=2E...#
        0100: 42 b1 c1 15 52 d1 f0 24  33 62 72 82 09 0a 16 17  B...R..$3br=
=2E....
        0110: 18 19 1a 25 26 27 28 29  2a 34 35 36 37 38 39 3a  ...%&'()*45=
6789:
        0120: 43 44 45 46 47 48 49 4a  53 54 55 56 57 58 59 5a  CDEFGHIJSTU=
VWXYZ
        0130: 63 64 65 66 67 68 69 6a  73 74 75 76 77 78 79 7a  cdefghijstu=
vwxyz
        0140: 83 84 85 86 87 88 89 8a  92 93 94 95 96 97 98 99  ...........=
=2E....
        0150: 9a a2 a3 a4 a5 a6 a7 a8  a9 aa b2 b3 b4 b5 b6 b7  ...........=
=2E....
        0160: b8 b9 ba c2 c3 c4 c5 c6  c7 c8 c9 ca d2 d3 d4 d5  ...........=
=2E....
        0170: d6 d7 d8 d9 da e1 e2 e3  e4 e5 e6 e7 e8 e9 ea f1  ...........=
=2E....
        0180: f2 f3 f4 f5 f6 f7 f8 f9  fa ff c4 00 1f 01 00 03  ...........=
=2E....
        0190: 01 01 01 01 01 01 01 01  01 00 00 00 00 00 00 01  ...........=
=2E....
        01a0: 02 03 04 05 06 07 08 09  0a 0b ff c4 00 b5 11 00  ...........=
=2E....
        01b0: 02 01 02 04 04 03 04 07  05 04 04 00 01 02 77 00  ...........=
=2E..w.
        01c0: 01 02 03 11 04 05 21 31  06 12 41 51 07 61 71 13  ......!1..A=
Q.aq.
        01d0: 22 32 81 08 14 42 91 a1  b1 c1 09 23 33 52 f0 15  "2...B.....=
#3R..
        01e0: 62 72 d1 0a 16 24 34 e1  25 f1 17 18 19 1a 26 27  br...$4.%..=
=2E..&'
        01f0: 28 29 2a 35 36 37 38 39  3a 43 44 45 46 47 48 49  ()*56789:CD=
EFGHI
        0200: 4a 53 54 55 56 57 58 59  5a 63 64 65 66 67 68 69  JSTUVWXYZcd=
efghi
        0210: 6a 73 74 75 76 77 78 79  7a 82 83 84 85 86 87 88  jstuvwxyz..=
=2E....
        0220: 89 8a 92 93 94 95 96 97  98 99 9a a2 a3 a4 a5 a6  ...........=
=2E....
        0230: a7 a8 a9 aa b2 b3 b4 b5  b6 b7 b8 b9 ba c2 c3 c4  ...........=
=2E....
        0240: c5 c6 c7 c8 c9 ca d2 d3  d4 d5 d6 d7 d8 d9 da e2  ...........=
=2E....
        0250: e3 e4 e5 e6 e7 e8 e9 ea  f2 f3 f4 f5 f6 f7 f8 f9  ...........=
=2E....
        0260: fa ff da 00 0c 03 01 00  02 11 03 11 00 3f 00 f4  ...........=
=2E.?..
        0270: 08 f7 d3 f7 ff 00 05 74  7a 37 82 35 6b dd 8f 37  .......tz7.=
5k..7
        0280: ee 62 7f e2 ae 8d 7c 17  e1 dd 2a df ce d5 b5 1f  .b....|...*=
=2E....
        0290: fb fd 38 85 2b d3 9d 78  47 76 79 d0 c3 b3 cf 71  ..8.+..xGvy=
=2E...q
        02a0: ff 00 4d 6a 68 12 69 a4  d8 91 48 ed fd c4 ae d2  ..Mjh.i...H=
=2E....
        02b0: 2d 73 e1 3d 9c be 4b eb  1a 1f 99 ff 00 5d fc cf  -s.=3D..K..=
=2E...]..
        02c0: d6 bb 8d 3e 0d 39 6d d2  6d 3e 2b 7f 25 d3 72 bc  ...>.9m.m>+=
=2E%.r.
        02d0: 4a 30 e0 fb d6 1f 5a 5f  64 de 18 7f 33 c2 7c 69  J0....Z_d..=
=2E3.|i
        02e0: e0 8f 12 6b d6 16 a9 61  07 93 2a 3f f1 cf e5 f1  ...k...a..*=
?....
        02f0: 59 1a 37 c0 cf 12 dc cf  1f db e5 b5 86 2f e3 fd  Y.7........=
=2E./..
        0300: fb b7 f4 af a7 32 3d ab  07 c4 7a 8d dd b4 90 59  .....2=3D..=
=2Ez....Y
        0310: da 00 92 4f bf f7 cd fc  00 56 53 ad cf d0 ea 84  ...O.....VS=
=2E....
        0320: 14 4f 30 b7 f8 13 a3 db  27 9d 7b ac b5 bf fd 72  .O0.....'.{=
=2E...r
        0330: 8f 67 eb 9a cd d7 74 fd  07 c0 76 13 4d a5 5e 6a  .g....t...v=
=2EM.^j
        0340: 5a db 27 fa cd d2 6f 82  dc 0f 7f f0 ad df 1d d8  Z.'...o....=
=2E....
        0350: f8 bb 5c bb fe ca d1 23  f2 ac be 4f 32 fe 69 f6  ..\....#...=
O2.i.
        0360: 3c b9 4f f3 d2 a9 e9 5f  09 21 8e c2 34 bf d4 e3  <.O...._.!.=
=2E4...
        0370: 77 fe 36 78 de 4d 99 f4  c9 a9 f7 cc e7 e8 61 68  w.6x.M.....=
=2E..ah
        0380: da a3 f8 b7 cc b6 d1 fc  49 ae 59 5e a4 0f 2a 5b  ........I.Y=
^..*[
        0390: 45 a5 a2 23 e3 dc 39 3f  9d 4d f0 ce df c4 da a4  E..#..9?.M.=
=2E....
        03a0: 1a 9f da be dd 70 d0 4f  b1 12 68 f6 49 8f 5e 6b  .....p.O..h=
=2EI.^k
        03b0: d1 7c 3b f0 e3 c3 5a 64  5b 25 9e 4b cf f6 1e 4f  .|;...Zd[%.=
K...O
        03c0: 2e 3f c8 57 73 61 6d 6b  69 02 db                 .?.Wsamki..
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2=20
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x08
    Reason: Connection Timeout

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="upload_theme.log"
Content-Transfer-Encoding: quoted-printable

HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:20:F1:47:68 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:20:F1:47:68
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:20:F1:47:68 key E0FBDF5E3EF4241A247AAFCD6331E97E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:20:F1:47:68
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:20:F1:47:68 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0e
    Link policy: HOLD SNIFF PARK=20
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x1d
          count 26
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x6 > <
                 uuid-16 0x0008 (OBEX) > >
          cont 00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013=20
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 12 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 329 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88=20
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 0 fcs 0x89 credits 20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 33
< ACL data: handle 1 flags 0x02 dlen 34
    L2CAP(d): cid 0x0040 len 30 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 26 fcs 0x4f=20
        OBEX: Connect cmd(f): len 26 version 1.0 flags 0 mtu 1024
        Target (0x46) =3D Sequence length 16
        0000: f9 ec 7b c4 95 3c 11 d2  98 4e 52 54 00 dc 9e 09  ..{..<...NR=
T....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 1 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 70 xoff 0 pm 0xf913
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 0 p 0 pt 0 xi 1 xo 0
      rtri 0 rtro 0 rtci 1 rtco 0 xon 19 xoff 127 pm 0x703f
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(d): cid 0x0041 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 31 fcs 0x89 credits 1
        OBEX: Connect rsp(f): status 200 len 31 version 1.0 flags 0 mtu 4096
        Status 200 =3D Success
        Connection ID (0xcb) =3D 1
        Who (0x4a) =3D Sequence length 16
        0000: f9 ec 7b c4 95 3c 11 d2  98 4e 52 54 00 dc 9e 09  ..{..<...NR=
T....
< ACL data: handle 1 flags 0x02 dlen 35
    L2CAP(d): cid 0x0040 len 31 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 27 fcs 0x4f=20
        OBEX: SetPath cmd(f): len 27 flags 2 constants 0
        Connection ID (0xcb) =3D 1
        Name (0x01) =3D Unicode length 14
        0000: 00 54 00 68 00 65 00 6d  00 65 00 73 00 00        .T.h.e.m.e.=
s..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
        OBEX: SetPath rsp(f): status 200 len 3
        Status 200 =3D Success
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
< ACL data: handle 1 flags 0x02 dlen 45
    L2CAP(d): cid 0x0040 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 37 fcs 0x4f=20
        OBEX: Put cmd(c): len 1024
        Connection ID (0xcb) =3D 1
        Name (0x01) =3D Unicode length 22
        0000: 00 53 00 70 00 69 00 64  00 65 00 72 00 2e 00 74  .S.p.i.d.e.=
r...t
        0010: 00 68 00 6d 00 00                                 .h.m..
        Length (0xc3) =3D 28672
        Body (0x48) =3D Sequence length 983
        0000: 54 68 65 6d 65 2e 78 6d  6c 00 00 00 00 00 00 00  Theme.xml..=
=2E....
        0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0060: 00 00 00 00 30 30 30 30  36 34 34 00 30 30 30 30  ....0000644=
=2E0000
        0070: 30 30 30 00 30 30 30 30  30 30 30 00 30 30 30 30  000.0000000=
=2E0000
        0080: 30 30 30 37 31 36 34 00  31 30 33 31 34 37 34 35  0007164.103=
14745
        0090: 32 35 33 00 30 30 31 31  35 36 35 00 30 00 00 00  253.0011565=
=2E0...
        00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0100: 00 75 73 74 61 72 00 30  30 4b 37 35 30 00 00 00  .ustar.00K7=
50...
        0110: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0120: 00 00 00 00 00 00 00 00  00 6e 6f 67 72 6f 75 70  .........no=
group
        0130: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0140: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0150: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0160: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0170: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0180: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0190: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        01a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        01b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        01c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        01d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        01e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        01f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...........=
=2E....
        0200: 3c 3f 78 6d 6c 20 76 65  72 73 69 6f 6e 3d 22 31  <?xml versi=
on=3D"1
        0210: 2e 30 22 3f 3e 0d 0a 3c  21 2d 2d 20 43 72 65 61  .0"?>..<!--=
 Crea
        0220: 74 65 64 20 77 69 74 68  20 53 6f 6e 79 20 45 72  ted with So=
ny Er
        0230: 69 63 73 73 6f 6e 20 54  68 65 6d 65 73 20 43 72  icsson Them=
es Cr
        0240: 65 61 74 6f 72 20 2d 2d  3e 0d 0a 3c 53 6f 6e 79  eator -->..=
<Sony
        0250: 5f 45 72 69 63 73 73 6f  6e 5f 74 68 65 6d 65 20  _Ericsson_t=
heme=20
        0260: 76 65 72 73 69 6f 6e 3d  22 34 2e 30 22 3e 0d 0a  version=3D"=
4.0">..
        0270: 20 20 3c 42 61 63 6b 67  72 6f 75 6e 64 20 43 6f    <Backgrou=
nd Co
        0280: 6c 6f 72 3d 22 30 78 30  30 30 30 30 30 22 2f 3e  lor=3D"0x00=
0000"/>
        0290: 0d 0a 20 20 3c 42 61 63  6b 67 72 6f 75 6e 64 5f  ..  <Backgr=
ound_
        02a0: 69 6d 61 67 65 20 53 6f  75 72 63 65 3d 22 73 70  image Sourc=
e=3D"sp
        02b0: 69 64 65 72 2e 6a 70 67  22 2f 3e 0d 0a 20 20 3c  ider.jpg"/>=
=2E.  <
        02c0: 43 61 6c 65 6e 64 61 72  5f 77 65 65 6b 76 69 65  Calendar_we=
ekvie
        02d0: 77 5f 6d 61 72 6b 69 6e  67 73 20 43 6f 6c 6f 72  w_markings =
Color
        02e0: 3d 22 30 78 34 30 34 30  34 30 22 2f 3e 0d 0a 20  =3D"0x40404=
0"/>..=20
        02f0: 20 3c 44 65 73 6b 74 6f  70 20 43 6f 6c 6f 72 3d   <Desktop C=
olor=3D
        0300: 22 30 78 33 63 33 63 33  63 22 2f 3e 0d 0a 20 20  "0x3c3c3c"/=
>.. =20
        0310: 3c 44 65 73 6b 74 6f 70  5f 68 69 67 6c 69 67 68  <Desktop_hi=
gligh
        0320: 74 5f 69 6d 61 67 65 20  53 6f 75 72 63 65 3d 22  t_image Sou=
rce=3D"
        0330: 72 2e 70 6e 67 22 2f 3e  0d 0a 20 20 3c 44 65 73  r.png"/>.. =
 <Des
        0340: 6b 74 6f 70 5f 69 6d 61  67 65 20 53 6f 75 72 63  ktop_image =
Sourc
        0350: 65 3d 22 73 70 69 64 65  72 2e 6a 70 67 22 2f 3e  e=3D"spider=
=2Ejpg"/>
        0360: 0d 0a 20 20 3c 44 65 73  6b 74 6f 70 5f 74 69 74  ..  <Deskto=
p_tit
        0370: 6c 65 5f 74 65 78 74 20  43 6f 6c 6f 72 3d 22 30  le_text Col=
or=3D"0
        0380: 78 63 30 63 30 63 30 22  2f 3e 0d 0a 20 20 3c 48  xc0c0c0"/>.=
=2E  <H
        0390: 69 67 68 6c 69 67 68 74  5f 74 65 78 74 20 43 6f  ighlight_te=
xt Co
        03a0: 6c 6f 72 3d 22 30 78 63  30 63 30 63 30 22 2f 3e  lor=3D"0xc0=
c0c0"/>
        03b0: 0d 0a 20 20 3c 48 69 67  68 6c 69 67 68 74 20 43  ..  <Highli=
ght C
        03c0: 6f 6c 6f 72 3d 22 30 78  31 62 31 62 31 62 22 2f  olor=3D"0x1=
b1b1b"/
        03d0: 3e 0d 0a 20 20 3c 48                              >..  <H
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2=20

--SLDf9lqlvOQaIe6s--

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE14DsJZ/yCc25j3IRAkRBAKCiyUBiIB5feh/KMY6ijiKmm/NzAwCfSU/W
Fe1hW3G+hphl5bX1j2rA3uI=
=dNe0
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--


--===============1799601840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1799601840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1799601840==--
