Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Jeroen Massar <jeroen@unfix.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9mEkd49/QvrBNjHmcu1k"
Message-Id: <1143969010.12604.10.camel@firenze.zurich.ibm.com>
Mime-Version: 1.0
Subject: [Bluez-devel] Broadcom + SCO MTU patch, only beeps, raises noiselevel but no
 sound...
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
Date: Sun, 02 Apr 2006 11:10:10 +0200


--=-9mEkd49/QvrBNjHmcu1k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[it looks a lot lot like the mailman web+smtp signups are deadish]

As the subject says:
- Broadcom chip in the adapter (headset has CSR ;)
- SCO MTU patch applied which seems to does it's job
- when playing it beeps and raises noiselevel
- volume buttons on headset trigget BTSCO events.

As it seems the problem is really with the Broadcom chip and it's driver
source availability, thus I guess a better and easier question than
asking why it doesn't work etc, is to simply ask which one of the
following adapters is a CSR and is supposed to work:
http://www.digitec.ch/ProdukteAuswahl2.aspx?knr=3D470
(click Bluetooth to get a nice list ;)

Google google and I found straight of the bluez site:
http://www.holtmann.org/linux/bluetooth/features.html
(reading is a good thing ;) the Targus is not on it, but see the info
below for the details about it. The MSI's listed there only have a
modelnumber, while MSI has spiffy names only. The D-Link is now DBT-122
thus they might have changed chip.

Linksys USBBT100 USB 0xff 0xff 0x0f 0x00 1.1  (0x020d) 1.1  (0x020d) CSR
seems to match up ;)

But taking a look in another site (german, thus 'suche' =3D 'search' ;) :
http://www.heise.de/mobil/bluetooth/db/

According to which the MSI Starkey 2.0 can do A2DP-SRC and it's BT2.0,
while the Linksys is BT1.2, thus which one is better to get? (Having a
stack of BT dongles is not very useful IMHO ;) Also this MSI is halve
the price of the Linksys dongle. Thus what should I do....

Greets,
 Jeroen

=3D=3D

as for the issue caused by my current setup:

The checklist:
- directly attached to internal USB port
- adapter: Targus ACB20EU (thus Broadcom)
   headset: Logitech HS01-V16 (Mobile Pro blabla)

Outputs, note that the SCO MTU patch is applied to a 2.6.16.1 kernel:

hci0: Type: USB
BD Address: 00:0E:A1:34:1C:80 ACL MTU: 377:10 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN=20
RX bytes:3070 acl:50 sco:0 events:131 errors:0
TX bytes:1553 acl:45 sco:0 commands:58 errors:0
Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
Link policy: RSWITCH HOLD SNIFF PARK=20
Link mode: SLAVE ACCEPT=20
Name: 'firenze-0'
Class: 0x3e0100
Service Classes: Networking, Rendering, Capturing
Device Class: Computer, Uncategorized
HCI Ver: 1.2 (0x2) HCI Rev: 0x107 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
Manufacturer: Broadcom Corporation (15)


# hciconfig hci0 revision
hci0: Type: USB
BD Address: 00:0E:A1:34:1C:80 ACL MTU: 377:10 SCO MTU: 64:8
Firmware 263.3 / 9
# hciconfig hci0 features
hci0: Type: USB
BD Address: 00:0E:A1:34:1C:80 ACL MTU: 377:10 SCO MTU: 64:8
Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
<3-slot packets> <5-slot packets> <encryption> <slot offset>=20
<timing accuracy> <role switch> <hold mode> <sniff mode>=20
<RSSI> <channel quality> <SCO link> <HV2 packets>=20
<HV3 packets> <u-law log> <A-law log> <CVSD> <power control>=20
<transparent SCO> <enhanced iscan> <interlaced iscan>=20
<interlaced pscan> <AFH cap. slave> <AFH cap. master>=20

# hcitool info 00:0D:44:0C:09:00
Requesting information ...
BD Address:  00:0D:44:0C:09:00
Device Name: Logitech HS01-V16
LMP Version: 1.2 (0x2) LMP Subversion: 0x611
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
<encryption> <slot offset> <timing accuracy> <role switch>=20
<hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>=20
<HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>=20
<paging scheme> <power control> <transparent SCO>=20
<AFH cap. slave> <AFH cap. master>=20


# hciconfig hci0 voice 0x0060
# hcitool con
Connections:
< ACL 00:0D:44:0C:09:00 handle 6 state 1 lm MASTER=20
# btsco -v  00:0D:44:0C:09:00
btsco v0.41
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
speaker volume: 13 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D13
Sending up speaker change 13
speaker volume: 13 mic volume: 1
driver is not in use
disconnected SCO channel
speaker volume: 13 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D13
Sending up speaker change 13
speaker volume: 13 mic volume: 1
driver is not in use
disconnected SCO channel


No a2dp support clearly:

# mpg123 --au - Pennywise\ -\ Surfing\ USA.mp3 | ./a2play
00:0D:44:0C:09:00
subbands =3D 8 blocks =3D 16 bitpool =3D 32
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

Directory: /
Playing MPEG stream from Pennywise - Surfing USA.mp3 ...
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
len=3D2048
Header size=3D28
Sample Rate:44100
Channels:2
Using address: 00:0D:44:0C:09:00
Found A2DP Sink at the destination
Can't connect to 00:09:0C:44:0D:00. Connection refused(111)
cannot open psm_cmd =3D 25


# aplay -B 1000000 -D plughw:Headset /usr/share/twinkle/ringtone.wav
Playing WAVE '/usr/share/twinkle/ringtone.wav' : Unsigned 8 bit, Rate
22050 Hz, Mono
Aborted by signal Interrupt...


While doing: btsco -v + the aplay

# hcidump -X=20
HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 00 09 0c 44 0d 00 18 cc  02 00 00 00 01           ...D.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 00 09 0c 44 0d 00                                 ...D..
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 00 09 0c 44 0d 00 dd 99  44 7e 6c f2 19 3e aa
db  ...D....D~l..>..
  0010: 0e da c8 56 41 df                                 ...VA.
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 00 09 0c 44  0d 00                    .......D..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 06 00 00 09 0c 44 0d  00 01 01                 ......D....
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 06 00 0f 00                                       ....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 06 00                                 ......
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48=20
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 24
    L2CAP(d): cid 0x0046 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 27
> ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 3A
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0046 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 3A
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 27
> ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 14
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0046 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 14
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 27
> ACL data: handle 6 flags 0x01 dlen 5
    L2CAP(d): cid 0x0040 len 28 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x17
          count 20
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Logitech HS01-V16"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0046 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0046 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
      MTU 1013=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013=20
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0047 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=20
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0047 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0047 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
< ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0047 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0047 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 10 fcs 0x9a=20
      0000: 41 54 2b 56 47 53 3d 31  33 0d                    AT+VGS=3D13.
< ACL data: handle 6 flags 0x02 dlen 17
    L2CAP(d): cid 0x0047 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 9 fcs 0x9a=20
      0000: 41 54 2b 56 47 4d 3d 31  0d                       AT+VGM=3D1.
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=20
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd=20
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0047 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 06 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 06 00 16                                       ....



--=-9mEkd49/QvrBNjHmcu1k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Jeroen Massar / http://unfix.org/~jeroen/

iHUEABECADUFAkQvlPIuFIAAAAAAFQAQcGthLWFkZHJlc3NAZ251cGcub3JnamVy
b2VuQHVuZml4Lm9yZwAKCRApqihSMz58I44nAJ4mgleGIB04rqO6bnJ42IgL+Jel
xgCePnyKvisA/hCPk8aMQFcBlp1LsLo=
=dWlR
-----END PGP SIGNATURE-----

--=-9mEkd49/QvrBNjHmcu1k--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
