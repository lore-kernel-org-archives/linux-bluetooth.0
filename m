Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 21 Aug 2006 17:26:22 +0530
Message-ID: <004b01c6c518$d298e400$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_004C_01C6C546.EC512000"
In-Reply-To: <1156167261.3956.20.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_004C_01C6C546.EC512000
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> please use "hcidump -X -V"=20

Here is the log with hcidump -X -V

> and if the HCI shows a wrong behavior with
> any of the new commands, please fix it.

There is no wrong behaviour as such. Just that Host Number of completed
packets is being sent as soon as we get ACL Data on any connection =
handle.

Do you think that the attached patch is decent enough for sending Host
Number of completed packets to the raw queue? (or is there a better way =
than
this?)

Regards,
Mayank

------=_NextPart_000_004C_01C6C546.EC512000
Content-Type: application/octet-stream;
	name="controller_to_host"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="controller_to_host"

HCI sniffer - Bluetooth packet analyzer ver 1.31=0A=
device: hci0 snap_len: 1028 filter: 0xffffffff=0A=
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Unknown (0x00|0x0000) status 0x00 ncmd 1=0A=
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0=0A=
> HCI Event: Command Complete (0x0e) plen 12=0A=
    Read Local Supported Features (0x04|0x0003) ncmd 1=0A=
    status 0x00=0A=
    Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00=0A=
< HCI Command: Host Buffer Size (0x03|0x0033) plen 7=0A=
  0000: 00 04 ff 08 00 08 00                              .......=0A=
> HCI Event: Command Complete (0x0e) plen 11=0A=
    Read Buffer Size (0x04|0x0005) ncmd 1=0A=
    status 0x00=0A=
    ACL MTU 192:8 SCO MTU 64:8=0A=
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Host Buffer Size (0x03|0x0033) ncmd 1=0A=
    0000: 00                                                .=0A=
< HCI Command: Set Event Filter (0x03|0x0005) plen 1=0A=
    type 0 condition 0=0A=
    Clear all filters=0A=
> HCI Event: Command Complete (0x0e) plen 10=0A=
    Read BD ADDR (0x04|0x0009) ncmd 1=0A=
    status 0x00 bdaddr 00:60:63:35:6D:5C=0A=
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2=0A=
    timeout 32768=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Set Event Filter (0x03|0x0005) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2=0A=
    timeout 32000=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Page Timeout (0x03|0x0018) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Set Host Controller To Host Flow Control (0x03|0x0031) =
plen 1=0A=
  0000: 01                                                .=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Connection Accept Timeout (0x03|0x0016) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1=0A=
    enable 3=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Set Host Controller To Host Flow Control (0x03|0x0031) ncmd 1=0A=
    0000: 00                                                .=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Scan Enable (0x03|0x001a) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1=0A=
    enable 3=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Scan Enable (0x03|0x001a) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7=0A=
    bdaddr 00:00:00:00:00:00 all 1=0A=
> HCI Event: Command Complete (0x0e) plen 8=0A=
    Read Stored Link Key (0x03|0x000d) ncmd 1=0A=
    status 0x00 max 16 num 0=0A=
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0=0A=
> HCI Event: Command Complete (0x0e) plen 5=0A=
    Read Scan Enable (0x03|0x0019) ncmd 1=0A=
    status 0x00 enable 3=0A=
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1=0A=
    enable 0=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Authentication Enable (0x03|0x0020) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0=0A=
> HCI Event: Command Complete (0x0e) plen 5=0A=
    Read Scan Enable (0x03|0x0019) ncmd 1=0A=
    status 0x00 enable 3=0A=
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1=0A=
    enable 0=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Authentication Enable (0x03|0x0020) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Encryption Mode (0x03|0x0022) plen 1=0A=
    mode 0=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Encryption Mode (0x03|0x0022) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Local Name (0x03|0x0013) plen 248=0A=
    name 'BlueZ (0)'=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Local Name (0x03|0x0013) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Class of Device (0x03|0x0024) plen 3=0A=
    class 0x3e0100=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Class of Device (0x03|0x0024) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Read Local Name (0x03|0x0014) plen 0=0A=
> HCI Event: Command Complete (0x0e) plen 252=0A=
    Read Local Name (0x03|0x0014) ncmd 1=0A=
    status 0x00 name 'BlueZ (0)'=0A=
< HCI Command: Create Connection (0x01|0x0005) plen 13=0A=
    bdaddr 00:13:E0:0D:03:99 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000=0A=
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 =0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Create Connection (0x01|0x0005) status 0x00 ncmd 1=0A=
> HCI Event: Connect Complete (0x03) plen 11=0A=
    status 0x00 handle 40 bdaddr 00:13:E0:0D:03:99 type ACL encrypt 0x00=0A=
< ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(s): Connect req: psm 3 scid 0x0040=0A=
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4=0A=
    handle 40 policy 0x0f=0A=
    Link policy: RSWITCH HOLD SNIFF PARK =0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Command Complete (0x0e) plen 6=0A=
    Write Link Policy Settings (0x02|0x000d) ncmd 1=0A=
    status 0x00 handle 40=0A=
> HCI Event: Max Slots Change (0x1b) plen 3=0A=
    handle 40 slots 5=0A=
> HCI Event: QoS Setup Complete (0x0d) plen 21=0A=
    status 0x00 handle 40 flags 0=0A=
    Service type: 1=0A=
    Token rate: 0=0A=
    Peak bandwith: 0=0A=
    Latency: 0=0A=
    Delay variation: 0=0A=
> ACL data: handle 40 flags 0x02 dlen 16=0A=
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 0 status 0=0A=
      Connection successful=0A=
< ACL data: handle 40 flags 0x02 dlen 16=0A=
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4=0A=
      MTU 1024 =0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0=0A=
< ACL data: handle 40 flags 0x02 dlen 14=0A=
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0=0A=
      Success=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 16=0A=
> ACL data: handle 40 flags 0x01 dlen 2=0A=
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4=0A=
      Success=0A=
      MTU 672 =0A=
< ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0047 len 4 [psm 3]=0A=
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c =0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0040 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 =0A=
< ACL data: handle 40 flags 0x02 dlen 18=0A=
    L2CAP(d): cid 0x0047 len 14 [psm 3]=0A=
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8=0A=
      dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0=0A=
      frame_size 667 max_retrans 0 credits 7=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 16=0A=
> ACL data: handle 40 flags 0x01 dlen 2=0A=
    L2CAP(d): cid 0x0040 len 14 [psm 3]=0A=
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8=0A=
      dlci 18 frame_type 0 credit_flow 14 pri 0 ack_timer 0=0A=
      frame_size 667 max_retrans 0 credits 3=0A=
< ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0047 len 4 [psm 3]=0A=
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32 =0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0040 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9 =0A=
< ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0047 len 8 [psm 3]=0A=
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2=0A=
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0047 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33=0A=
< ACL data: handle 40 flags 0x02 dlen 15=0A=
    L2CAP(d): cid 0x0047 len 11 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 7 fcs 0xce =0A=
      0000: 80 00 07 10 00 04 00                              .......=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 2=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A=
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
< ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0047 len 8 [psm 3]=0A=
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2=0A=
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A=
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
> ACL data: handle 40 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0040 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 4=0A=
> ACL data: handle 40 flags 0x02 dlen 16=0A=
    L2CAP(d): cid 0x0040 len 12 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 7 fcs 0x8 credits 1=0A=
      0000: a0 00 07 10 00 0f a0                              .......=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 01 00 19 00 6f  00 62 00 65 00 78 00 73  =
.......o.b.e.x.s=0A=
      0010: 00 65 00 72 00 76 00 65  00 72 00 00 c3 00 01 1d  =
.e.r.v.e.r......=0A=
      0020: 72 48 03 df 7f 45 4c 46  01 01 01 61 00 00 00 00  =
rH...ELF...a....=0A=
      0030: 00 00 00 00 02 00 28 00  01 00 00 00 18 89 00 00  =
......(.........=0A=
      0040: 34 00 00 00 b4 f7 00 00  02 00 00 00 34 00 20 00  =
4...........4. .=0A=
      0050: 06 00 28 00 1d 00 1a 00  06 00 00 00 34 00 00 00  =
..(.........4...=0A=
      0060: 34 80 00 00 34 80 00 00  c0 00 00 00 c0 00 00 00  =
4...4...........=0A=
      0070: 05 00 00 00 04 00 00 00  03 00 00 00 f4 00 00 00  =
................=0A=
      0080: f4 80 00 00 f4 80 00 00  13 00 00 00 13 00 00 00  =
................=0A=
      0090: 04 00 00 00 01 00 00 00  01 00 00 00 00 00 00 00  =
................=0A=
      00a0: 00 80 00 00 00 80 00 00  8c 52 00 00 8c 52 00 00  =
.........R...R..=0A=
      00b0: 05 00 00 00 00 80 00 00  01 00 00 00 8c 52 00 00  =
.............R..=0A=
      00c0: 8c 52 01 00 8c 52 01 00  5c 01 00 00 68 01 00 00  =
.R...R..\...h...=0A=
      00d0: 06 00 00 00 00 80 00 00  02 00 00 00 48 53 00 00  =
............HS..=0A=
      00e0: 48 53 01 00 48 53 01 00  a0 00 00 00 a0 00 00 00  =
HS..HS..........=0A=
      00f0: 06 00 00 00 04 00 00 00  04 00 00 00 10 01 00 00  =
................=0A=
      0100: 10 81 00 00 10 81 00 00  20 00 00 00 20 00 00 00  ........ =
... ...=0A=
      0110: 04 00 00 00 10 00 00 00  2f 6c 69 62 2f 6c 64 2d  =
......../lib/ld-=0A=
      0120: 6c 69 6e 75 78 2e 73 6f  2e 32 00 00 00 00 00 00  =
linux.so.2......=0A=
      0130: 00 00 00 00 04 00 00 00  10 00 00 00 01 00 00 00  =
................=0A=
      0140: 47 4e 55 00 00 00 00 00  02 00 00 00 00 00 00 00  =
GNU.............=0A=
      0150: 00 00 00 00 11 00 00 00  24 00 00 00 00 00 00 00  =
........$.......=0A=
      0160: 00 00 00 00 20 00 00 00  18 00 00 00 12 00 00 00  .... =
...........=0A=
      0170: 00 00 00 00 1d 00 00 00  21 00 00 00 1c 00 00 00  =
........!.......=0A=
      0180: 05 00 00 00 1f 00 00 00  00 00 00 00 23 00 00 00  =
............#...=0A=
      0190: 1e 00 00 00 16 00 00 00  22 00 00 00 00 00 00 00  =
........".......=0A=
      01a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  =
................=0A=
      01b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  =
................=0A=
      01c0: 02 00 00 00 07 00 00 00  00 00 00 00 03 00 00 00  =
................=0A=
      01d0: 09 00 00 00 0b 00 00 00  01 00 00 00 0d 00 00 00  =
................=0A=
      01e0: 00 00 00 00 08 00 00 00  10 00 00 00 0a 00 00 00  =
................=0A=
      01f0: 00 00 00 00 0f 00 00 00  06 00 00 00 0c 00 00 00  =
................=0A=
      0200: 04 00 00 00 15 00 00 00  00 00 00 00 11 00 00 00  =
................=0A=
      0210: 17 00 00 00 14 00 00 00  1b 00 00 00 19 00 00 00  =
................=0A=
      0220: 0e 00 00 00 13 00 00 00  00 00 00 00 1a 00 00 00  =
................=0A=
      0230: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  =
................=0A=
      0240: b1 00 00 00 18 87 00 00  b4 00 00 00 12 00 00 00  =
................=0A=
      0250: 0f 01 00 00 28 87 00 00  e8 00 00 00 12 00 00 00  =
....(...........=0A=
      0260: 70 00 00 00 38 87 00 00  10 00 00 00 12 00 00 00  =
p...8...........=0A=
      0270: 16 01 00 00 48 87 00 00  10 00 00 00 12 00 00 00  =
....H...........=0A=
      0280: 3f 00 00 00 58 87 00 00  dc 00 00 00 12 00 00 00  =
?...X...........=0A=
      0290: 76 00 00 00 68 87 00 00  20 00 00                 v...h... ..=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 362 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 357 fcs 0xce =0A=
      0000: 00 12 00 00 00 8e 00 00  00 78 87 00 00 ec 00 00  =
.........x......=0A=
      0010: 00 12 00 00 00 54 00 00  00 88 87 00 00 1c 00 00  =
.....T..........=0A=
      0020: 00 12 00 00 00 61 00 00  00 98 87 00 00 24 00 00  =
.....a.......$..=0A=
      0030: 00 12 00 00 00 aa 00 00  00 a8 87 00 00 24 00 00  =
.............$..=0A=
      0040: 00 12 00 00 00 46 00 00  00 b8 87 00 00 88 02 00  =
.....F..........=0A=
      0050: 00 12 00 00 00 30 00 00  00 c8 87 00 00 3c 01 00  =
.....0.......<..=0A=
      0060: 00 12 00 00 00 cf 00 00  00 d8 87 00 00 24 00 00  =
.............$..=0A=
      0070: 00 12 00 00 00 c8 00 00  00 e8 53 01 00 04 00 00  =
..........S.....=0A=
      0080: 00 11 00 16 00 5b 00 00  00 e8 87 00 00 ec 01 00  =
.....[..........=0A=
      0090: 00 12 00 00 00 da 00 00  00 f8 87 00 00 80 03 00  =
................=0A=
      00a0: 00 12 00 00 00 83 00 00  00 08 88 00 00 24 00 00  =
.............$..=0A=
      00b0: 00 12 00 00 00 03 01 00  00 18 88 00 00 60 00 00  =
.............`..=0A=
      00c0: 00 12 00 00 00 f1 00 00  00 28 88 00 00 08 01 00  =
.........(......=0A=
      00d0: 00 12 00 00 00 a2 00 00  00 38 88 00 00 ac 02 00  =
.........8......=0A=
      00e0: 00 12 00 00 00 21 00 00  00 48 88 00 00 40 00 00  =
.....!...H...@..=0A=
      00f0: 00 12 00 00 00 7e 00 00  00 58 88 00 00 24 00 00  =
.....~...X...$..=0A=
      0100: 00 12 00 00 00 38 00 00  00 68 88 00 00 a4 00 00  =
.....8...h......=0A=
      0110: 00 12 00 00 00 68 00 00  00 78 88 00 00 4c 00 00  =
.....h...x...L..=0A=
      0120: 00 12 00 00 00 0a 01 00  00 88 88 00 00 10 00 00  =
................=0A=
      0130: 00 12 00 00 00 1c 01 00  00 98 88 00 00 0c 01 00  =
................=0A=
      0140: 00 12 00 00 00 b9 00 00  00 a8 88 00 00 9c 00 00  =
................=0A=
      0150: 00 12 00 00 00 28 00 00  00 b8 88 00 00 24 00 00  =
.....(.......$..=0A=
      0160: 00 12 00 00 00                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 48 03 fd 9a 00  00 00 c8 88 00 00 d8 00  =
...H............=0A=
      0010: 00 00 12 00 00 00 e2 00  00 00 14 cf 00 00 04 00  =
................=0A=
      0020: 00 00 11 00 0f 00 c0 00  00 00 d8 88 00 00 20 00  =
.............. .=0A=
      0030: 00 00 12 00 00 00 4d 00  00 00 e8 88 00 00 24 00  =
......M.......$.=0A=
      0040: 00 00 12 00 00 00 95 00  00 00 f8 88 00 00 10 00  =
................=0A=
      0050: 00 00 12 00 00 00 01 00  00 00 00 00 00 00 00 00  =
................=0A=
      0060: 00 00 20 00 00 00 1a 00  00 00 08 89 00 00 28 00  .. =
...........(.=0A=
      0070: 00 00 12 00 00 00 00 5f  5f 67 6d 6f 6e 5f 73 74  =
.......__gmon_st=0A=
      0080: 61 72 74 5f 5f 00 6c 69  62 63 2e 73 6f 2e 36 00  =
art__.libc.so.6.=0A=
      0090: 73 74 72 63 70 79 00 70  72 69 6e 74 66 00 63 6f  =
strcpy.printf.co=0A=
      00a0: 6e 6e 65 63 74 00 6d 65  6d 6d 6f 76 65 00 6d 65  =
nnect.memmove.me=0A=
      00b0: 6d 63 70 79 00 70 65 72  72 6f 72 00 6d 61 6c 6c  =
mcpy.perror.mall=0A=
      00c0: 6f 63 00 73 6f 63 6b 65  74 00 73 65 6c 65 63 74  =
oc.socket.select=0A=
      00d0: 00 61 62 6f 72 74 00 61  63 63 65 70 74 00 73 74  =
.abort.accept.st=0A=
      00e0: 72 72 63 68 72 00 77 72  69 74 65 00 66 70 72 69  =
rrchr.write.fpri=0A=
      00f0: 6e 74 66 00 62 69 6e 64  00 73 65 74 73 6f 63 6b  =
ntf.bind.setsock=0A=
      0100: 6f 70 74 00 73 69 67 6e  61 6c 00 72 65 61 64 00  =
opt.signal.read.=0A=
      0110: 73 74 72 6e 63 70 79 00  72 65 61 6c 6c 6f 63 00  =
strncpy.realloc.=0A=
      0120: 6c 69 73 74 65 6e 00 73  74 72 6e 63 61 74 00 6d  =
listen.strncat.m=0A=
      0130: 65 6d 73 65 74 00 73 70  72 69 6e 74 66 00 73 74  =
emset.sprintf.st=0A=
      0140: 64 65 72 72 00 67 65 74  73 6f 63 6b 6f 70 74 00  =
derr.getsockopt.=0A=
      0150: 5f 5f 78 73 74 61 74 00  5f 49 4f 5f 73 74 64 69  =
__xstat._IO_stdi=0A=
      0160: 6e 5f 75 73 65 64 00 5f  5f 6c 69 62 63 5f 73 74  =
n_used.__libc_st=0A=
      0170: 61 72 74 5f 6d 61 69 6e  00 73 74 72 6c 65 6e 00  =
art_main.strlen.=0A=
      0180: 6f 70 65 6e 00 73 74 72  63 68 72 00 63 6c 6f 73  =
open.strchr.clos=0A=
      0190: 65 00 66 72 65 65 00 47  4c 49 42 43 5f 32 2e 30  =
e.free.GLIBC_2.0=0A=
      01a0: 00 00 00 00 02 00 02 00  02 00 02 00 02 00 02 00  =
................=0A=
      01b0: 02 00 02 00 02 00 02 00  02 00 02 00 02 00 02 00  =
................=0A=
      01c0: 02 00 02 00 02 00 02 00  02 00 02 00 02 00 02 00  =
................=0A=
      01d0: 02 00 02 00 02 00 02 00  02 00 02 00 02 00 01 00  =
................=0A=
      01e0: 02 00 02 00 02 00 00 00  02 00 01 00 01 00 10 00  =
................=0A=
      01f0: 00 00 10 00 00 00 00 00  00 00 10 69 69 0d 00 00  =
...........ii...=0A=
      0200: 02 00 21 01 00 00 00 00  00 00 44 53 01 00 15 22  =
..!.......DS..."=0A=
      0210: 00 00 e8 53 01 00 14 0e  00 00 c4 52 01 00 16 01  =
...S.......R....=0A=
      0220: 00 00 c8 52 01 00 16 02  00 00 cc 52 01 00 16 03  =
...R.......R....=0A=
      0230: 00 00 d0 52 01 00 16 04  00 00 d4 52 01 00 16 05  =
...R.......R....=0A=
      0240: 00 00 d8 52 01 00 16 06  00 00 dc 52 01 00 16 07  =
...R.......R....=0A=
      0250: 00 00 e0 52 01 00 16 08  00 00 e4 52 01 00 16 09  =
...R.......R....=0A=
      0260: 00 00 e8 52 01 00 16 0a  00 00 ec 52 01 00 16 0b  =
...R.......R....=0A=
      0270: 00 00 f0 52 01 00 16 0c  00 00 f4 52 01 00 16 0d  =
...R.......R....=0A=
      0280: 00 00 f8 52 01 00 16 0f  00 00 fc 52 01 00 16 10  =
...R.......R....=0A=
      0290: 00 00 00 53 01 00 16 11  00 00 04                 ...S.......=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 362 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 357 fcs 0xce =0A=
      0000: 53 01 00 16 12 00 00 08  53 01 00 16 13 00 00 0c  =
S.......S.......=0A=
      0010: 53 01 00 16 14 00 00 10  53 01 00 16 15 00 00 14  =
S.......S.......=0A=
      0020: 53 01 00 16 16 00 00 18  53 01 00 16 17 00 00 1c  =
S.......S.......=0A=
      0030: 53 01 00 16 18 00 00 20  53 01 00 16 19 00 00 24  S...... =
S......$=0A=
      0040: 53 01 00 16 1a 00 00 28  53 01 00 16 1b 00 00 2c  =
S......(S......,=0A=
      0050: 53 01 00 16 1c 00 00 30  53 01 00 16 1d 00 00 34  =
S......0S......4=0A=
      0060: 53 01 00 16 1f 00 00 38  53 01 00 16 20 00 00 3c  =
S......8S... ..<=0A=
      0070: 53 01 00 16 21 00 00 40  53 01 00 16 23 00 00 0d  =
S...!..@S...#...=0A=
      0080: c0 a0 e1 00 d8 2d e9 04  b0 4c e2 92 00 00 eb ec  =
.....-...L......=0A=
      0090: 11 00 eb 00 a8 1b e9 04  e0 2d e5 10 e0 9f e5 0e  =
.........-......=0A=
      00a0: e0 8f e0 08 f0 be e5 04  c0 9f e5 0c c0 8f e0 00  =
................=0A=
      00b0: f0 9c e5 a0 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
................=0A=
      00c0: f0 9c e5 94 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
................=0A=
      00d0: f0 9c e5 88 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
................=0A=
      00e0: f0 9c e5 7c cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...|............=0A=
      00f0: f0 9c e5 70 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...p............=0A=
      0100: f0 9c e5 64 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...d............=0A=
      0110: f0 9c e5 58 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...X............=0A=
      0120: f0 9c e5 4c cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...L............=0A=
      0130: f0 9c e5 40 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...@............=0A=
      0140: f0 9c e5 34 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...4............=0A=
      0150: f0 9c e5 28 cb 00 00 04  c0 9f e5 0c c0 8f e0 00  =
...(............=0A=
      0160: f0 9c e5 1c cb                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 48 03 fd 00 00  04 c0 9f e5 0c c0 8f e0  =
...H............=0A=
      0010: 00 f0 9c e5 10 cb 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0020: 00 f0 9c e5 04 cb 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0030: 00 f0 9c e5 f8 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0040: 00 f0 9c e5 ec ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0050: 00 f0 9c e5 e0 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0060: 00 f0 9c e5 d4 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0070: 00 f0 9c e5 c8 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0080: 00 f0 9c e5 bc ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      0090: 00 f0 9c e5 b0 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      00a0: 00 f0 9c e5 a4 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      00b0: 00 f0 9c e5 98 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      00c0: 00 f0 9c e5 8c ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      00d0: 00 f0 9c e5 80 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
................=0A=
      00e0: 00 f0 9c e5 74 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
....t...........=0A=
      00f0: 00 f0 9c e5 68 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
....h...........=0A=
      0100: 00 f0 9c e5 5c ca 00 00  04 c0 9f e5 0c c0 8f e0  =
....\...........=0A=
      0110: 00 f0 9c e5 50 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
....P...........=0A=
      0120: 00 f0 9c e5 44 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
....D...........=0A=
      0130: 00 f0 9c e5 38 ca 00 00  04 c0 9f e5 0c c0 8f e0  =
....8...........=0A=
      0140: 00 f0 9c e5 2c ca 00 00  00 b0 a0 e3 02 00 bd e8  =
....,...........=0A=
      0150: 0d 20 a0 e1 01 00 2d e9  10 00 9f e5 01 00 2d e9  . =
....-.......-.=0A=
      0160: 0c 00 9f e5 0c 30 9f e5  ba ff ff eb a9 ff ff eb  =
.....0..........=0A=
      0170: 00 cf 00 00 04 8a 00 00  f0 86 00 00 0d c0 a0 e1  =
................=0A=
      0180: 00 dc 2d e9 20 a0 9f e5  20 30 9f e5 0a a0 8f e0  ..-. ... =
0......=0A=
      0190: 03 30 9a e7 04 b0 4c e2  00 00 53 e3 00 ac 1b 09  =
.0....L...S.....=0A=
      01a0: 0f e0 a0 e1 03 f0 a0 e1  00 ac 1b e9 54 c9 00 00  =
............T...=0A=
      01b0: 8c 00 00 00 0d c0 a0 e1  30 d8 2d e9 58 20 9f e5  =
........0.-.X ..=0A=
      01c0: 04 b0 4c e2 00 30 92 e5  02 50 a0 e1 00 00 53 e3  =
..L..0...P....S.=0A=
      01d0: 30 a8 1b 19 44 10 9f e5  00 30 91 e5 00 20 93 e5  =
0...D....0... ..=0A=
      01e0: 00 00 52 e3 09 00 00 0a  01 40 a0 e1 00 30 94 e5  =
..R......@...0..=0A=
      01f0: 04 30 83 e2 00 30 84 e5  0f e0 a0 e1 04 f0 13 e5  =
.0...0..........=0A=
      0200: 00 20 94 e5 00 30 92 e5  00 00 53 e3 f6 ff ff 1a  . =
...0....S.....=0A=
      0210: 01 30 a0 e3 00 30 85 e5  30 a8 1b e9 94 52 01 00  =
.0...0..0....R..=0A=
      0220: 90 52 01 00 0d c0 a0 e1  00 d8 2d e9 04 b0 4c e2  =
.R........-...L.=0A=
      0230: 00 a8 1b e9 0d c0 a0 e1  00 d8 2d e9 04 b0 4c e2  =
..........-...L.=0A=
      0240: 0c d0 4d e2 10 00 0b e5  14 10 0b e5 00 00 00 ea  =
..M.............=0A=
      0250: 28 00 00 ea 04 00 a0 e3  88 10 9f e5 00 20 a0 e3  =
(............ ..=0A=
      0260: 0e 02 00 eb 00 30 a0 e1  7c 20 9f e5 00 30 82 e5  .....0..| =
...0..=0A=
      0270: 10 30 1b e5 01 00 53 e3  13 00 00 1a 68 30 9f e5  =
.0....S.....h0..=0A=
      0280: 00 00 93 e5 00 10 a0 e3  03 20 a0 e3 d3 04 00 eb  ......... =
......=0A=
      0290: 58 00 9f e5 77 ff ff eb  4c 30 9f                 X...w...L0.=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 362 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 357 fcs 0xce =0A=
      0000: e5 00 00 93 e5 35 0f 00  eb 48 30 9f e5 00 20 93  =
.....5...H0... .=0A=
      0010: e5 00 00 52 e3 00 00 00  0a 04 00 00 ea 2c 30 9f  =
...R.........,0.=0A=
      0020: e5 00 00 93 e5 01 10 a0  e3 27 03 00 eb f5 ff ff  =
.........'......=0A=
      0030: ea 20 30 9f e5 00 20 a0  e3 00 20 83 e5 0c 30 9f  . 0... ... =
...0.=0A=
      0040: e5 00 00 93 e5 49 02 00  eb d8 ff ff ea 1c 8d 00  =
.....I..........=0A=
      0050: 00 9c 52 01 00 18 cf 00  00 98 52 01 00 00 a8 1b  =
..R.......R.....=0A=
      0060: e9 0d c0 a0 e1 f0 df 2d  e9 04 b0 4c e2 00 a0 a0  =
.......-...L....=0A=
      0070: e3 18 d0 4d e2 3c a0 0b  e5 38 00 0b e5 0a 80 a0  =
...M.<...8......=0A=
      0080: e1 0a 40 a0 e1 d8 90 9f  e5 29 70 4b e2 30 60 4b  =
..@......)pK.0`K=0A=
      0090: e2 34 50 4b e2 24 00 00  ea 29 30 5b e5 48 00 53  =
.4PK.$...)0[.H.S=0A=
      00a0: e3 03 10 a0 e1 08 00 00  0a 02 00 00 ca 01 00 53  =
...............S=0A=
      00b0: e3 09 00 00 0a 1a 00 00  ea c3 00 53 e3 12 00 00  =
...........S....=0A=
      00c0: 0a cf 00 53 e3 12 00 00  0a 15 00 00 ea 30 30 1b  =
...S.........00.=0A=
      00d0: e5 34 a0 1b e5 3c 30 0b  e5 13 00 00 ea 34 00 1b  =
.4...<0......4..=0A=
      00e0: e5 a0 0f 80 e0 c0 00 a0  e1 17 ff ff eb 00 40 50  =
..............@P=0A=
      00f0: e2 0d 00 00 0a 30 10 1b  e5 04 00 a0 e1 34 20 1b  =
.....0.......4 .=0A=
      0100: e5 04 80 a0 e1 e2 03 00  eb 07 00 00 ea 54 00 9f  =
.............T..=0A=
      0110: e5 00 00 00 ea 50 00 9f  e5 30 10 1b e5 2e ff ff  =
.....P...0......=0A=
      0120: eb 01 00 00 ea 44 00 9f  e5 2b ff ff eb 00 50 8d  =
.....D...+....P.=0A=
      0130: e5 38 10 1b e5 07 20 a0  e1 00 00 99 e5 06 30 a0  .8.... =
.......0.=0A=
      0140: e1 6f 03 00 eb 00 00 50  e3 d2 ff ff 1a 3c 30 1b  =
.o.....P.....<0.=0A=
      0150: e5 00 00 53 e3 07 00 00  1a 14 00 9f e5 1e ff ff  =
...S............=0A=
      0160: eb 13 00 00 ea                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 2=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 48 03 fd 9c 52  01 00 34 cf 00 00 48 cf  =
...H...R..4...H.=0A=
      0010: 00 00 5c cf 00 00 7c cf  00 00 00 00 58 e3 03 00  =
..\...|.....X...=0A=
      0020: 00 1a 24 00 9f e5 08 10  a0 e1 20 80 9f e5 12 ff  ..$....... =
.....=0A=
      0030: ff eb 08 00 a0 e1 3c 10  1b e5 0a 20 a0 e1 61 01  =
......<.... ..a.=0A=
      0040: 00 eb 04 00 a0 e1 20 ff  ff eb 01 00 00 ea 98 cf  ...... =
.........=0A=
      0050: 00 00 c8 cf 00 00 f0 af  1b e9 0d c0 a0 e1 10 d8  =
................=0A=
      0060: 2d e9 04 b0 4c e2 00 40  a0 e1 02 10 a0 e1 05 00  =
-...L..@........=0A=
      0070: 51 e3 01 f1 9f 97 19 00  00 ea 94 8c 00 00 a0 8c  =
Q...............=0A=
      0080: 00 00 78 8c 00 00 ac 8c  00 00 ac 8c 00 00 5c 8c  =
..x...........\.=0A=
      0090: 00 00 64 00 9f e5 f8 fe  ff eb 04 00 a0 e1 10 10  =
..d.............=0A=
      00a0: a0 e3 20 20 a0 e3 66 03  00 eb 10 a8 1b e9 04 00  ..  =
..f.........=0A=
      00b0: a0 e1 10 10 a0 e3 20 20  a0 e3 61 03 00 eb 04 00  ......  =
..a.....=0A=
      00c0: a0 e1 8e ff ff eb 10 a8  1b e9 04 00 a0 e1 20 10  =
.............. .=0A=
      00d0: a0 e3 f2 ff ff ea 04 00  a0 e1 20 10 a0 e3 ef ff  .......... =
.....=0A=
      00e0: ff ea 18 00 9f e5 e4 fe  ff eb 04 00 a0 e1 51 10  =
..............Q.=0A=
      00f0: a0 e3 01 20 a0 e1 52 03  00 eb 10 a8 1b e9 e0 cf  ... =
..R.........=0A=
      0100: 00 00 fc cf 00 00 0d c0  a0 e1 00 d8 2d e9 04 b0  =
............-...=0A=
      0110: 4c e2 01 00 51 e3 04 30  9f 05 00 10 83 05 00 a8  =
L...Q..0........=0A=
      0120: 1b e9 98 52 01 00 0d c0  a0 e1 00 d8 2d e9 14 30  =
...R........-..0=0A=
      0130: 9f e5 00 20 83 e5 04 b0  4c e2 0c 20 9f e5 01 30  ... =
....L.. ...0=0A=
      0140: a0 e3 00 30 82 e5 00 a8  1b e9 a0 52 01 00 98 52  =
...0.......R...R=0A=
      0150: 01 00 0d c0 a0 e1 70 d8  2d e9 04 b0 4c e2 01 40  =
......p.-...L..@=0A=
      0160: a0 e1 02 60 a0 e1 03 10  a0 e1 04 50 9b e5 04 00  =
...`.......P....=0A=
      0170: 51 e3 01 f1 9f 97 2c 00  00 ea 58 8d 00 00 98 8d  =
Q.....,...X.....=0A=
      0180: 00 00 d0 8d 00 00 64 8d  00 00 e0 8d 00 00 a4 00  =
......d.........=0A=
      0190: 9f e5 b9 fe ff eb 70 a8  1b e9 9c 00 9f e5 b6 fe  =
......p.........=0A=
      01a0: ff eb 00 00 56 e3 04 00  00 1a 04 00 a0 e1 08 20  =
....V.......... =0A=
      01b0: 9b e5 05 10 a0 e1 da ff  ff eb 70 a8 1b e9 04 00  =
..........p.....=0A=
      01c0: a0 e1 05 10 a0 e1 ce ff  ff eb 70 a8 1b e9 02 00  =
..........p.....=0A=
      01d0: 55 e3 06 00 00 ca 00 00  55 e3 04 00 00 ba 04 00  =
U.......U.......=0A=
      01e0: a0 e1 10 10 a0 e3 20 20  a0 e3 15 03 00 eb 70 a8  ......  =
......p.=0A=
      01f0: 1b e9 04 00 a0 e1 51 10  a0 e3 01 20 a0 e1 10 03  =
......Q.... ....=0A=
      0200: 00 eb 70 a8 1b e9 04 00  a0 e1 05 20 a0 e1 91 ff  =
..p........ ....=0A=
      0210: ff eb 70 a8 1b e9 24 00  9f e5 97 fe ff eb 20 20  =
..p...$.......  =0A=
      0220: 9f e5 01 30 a0 e3 00 30  82 e5 70 a8 1b e9 14 00  =
...0...0..p.....=0A=
      0230: 9f e5 91 fe ff eb 70 a8  1b e9 24 d0 00 00 28 d0  =
......p...$...(.=0A=
      0240: 00 00 2c d0 00 00 98 52  01 00 60 d0 00 00 0d c0  =
..,....R..`.....=0A=
      0250: a0 e1 30 d8 2d e9 40 20  9f e5 00 30 92 e5 04 b0  ..0.-.@ =
...0....=0A=
      0260: 4c e2 00 00 53 e3 09 00  00 1a 02 50 a0 e1 2c 40  =
L...S......P..,@=0A=
      0270: 9f e5 00 00 94 e5 0a 10  a0 e3 3b 02 00 eb 00 00  =
..........;.....=0A=
      0280: 50 e3 30 a8 1b b9 00 30  95 e5 00 00 53 e3 f7 ff  =
P.0....0....S...=0A=
      0290: ff 0a 0c 30 9f e5 00 00  93 e5 30                 ...0......0=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 362 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 357 fcs 0xce =0A=
      0000: a8 1b e9 98 52 01 00 9c  52 01 00 a0 52 01 00 0d  =
....R...R...R...=0A=
      0010: c0 a0 e1 00 d8 2d e9 04  b0 4c e2 6c 02 00 eb e3  =
.....-...L.l....=0A=
      0020: ff ff eb 08 20 9f e5 00  30 a0 e3 00 30 82 e5 00  .... =
...0...0...=0A=
      0030: a8 1b e9 98 52 01 00 0d  c0 a0 e1 00 d8 2d e9 04  =
....R........-..=0A=
      0040: b0 4c e2 00 10 a0 e1 03  00 a0 e3 64 20 4b e2 58  =
.L.........d K.X=0A=
      0050: d0 4d e2 4e fe ff eb 38  00 1b e5 00 a8 1b e9 0d  =
.M.N...8........=0A=
      0060: c0 a0 e1 f0 d8 2d e9 04  b0 4c e2 00 40 a0 e1 01  =
.....-...L..@...=0A=
      0070: 70 a0 e1 ef ff ff eb 00  20 a0 e1 00 20 87 e5 64  p....... =
... ..d=0A=
      0080: 00 9f e5 04 10 a0 e1 55  fe ff eb 04 00 a0 e1 00  =
.......U........=0A=
      0090: 10 a0 e3 01 20 a0 e1 61  fe ff eb 00 60 a0 e1 01  .... =
..a....`...=0A=
      00a0: 00 76 e3 00 00 a0 e3 f0  a8 1b 09 00 00 97 e5 27  =
.v.............'=0A=
      00b0: fe ff eb 00 50 50 e2 09  00 00 0a 06 00 a0 e1 00  =
....PP..........=0A=
      00c0: 20 97 e5 05 10 a0 e1 71  fe ff eb 00 40 a0 e1 06   =
......q....@...=0A=
      00d0: 00 a0 e1 02 fe ff eb 05  00 a0 e1 00 40 87 e5 f0  =
............@...=0A=
      00e0: a8 1b e9 05 00 a0 e1 f0  a8 1b e9 70 d0 00 00 0d  =
...........p....=0A=
      00f0: c0 a0 e1 f0 dd 2d e9 04  b0 4c e2 00 70 a0 e1 01  =
.....-...L..p...=0A=
      0100: 60 a0 e1 06 00 a0 e1 f0  10 4b e2 d4 d0 4d e2 d2  =
`........K...M..=0A=
      0110: ff ff eb 00 80 50 e2 08  00 a0 01 7e 00 00 0a 06  =
.....P.....~....=0A=
      0120: 00 a0 e1 2e 10 a0 e3 e5  fd ff eb 00 00 50 e3 d8  =
.............P..=0A=
      0130: a0 9f e5 4b 00 00 0a 01  30 f0 e5 76 20 43 e2 76  =
...K....0..v C.v=0A=
      0140: 00 53 e3 07 00 00 1a 01  30 d0 e5 63 20 43 e2 63  =
.S......0..c C.c=0A=
      0150: 00 53 e3 03 00 00 1a 02  30 d0 e5 66 20 43 e2 66  =
.S......0..f C.f=0A=
      0160: 00 53 e3 03 20                                    .S.. =0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 48 03 fd d0 05  00 00 52 e3 03 00 00 1a  =
...H......R.....=0A=
      0010: 9c 00 9f e5 9c a0 9f e5  19 fe ff eb 39 00 00 ea  =
............9...=0A=
      0020: 00 30 d0 e5 76 20 43 e2  76 00 53 e3 03 10 a0 e1  .0..v =
C.v.S.....=0A=
      0030: 07 00 00 1a 01 30 d0 e5  63 20 43 e2 63 00 53 e3  .....0..c =
C.c.S.=0A=
      0040: 03 00 00 1a 02 30 d0 e5  73 20 43 e2 73 00 53 e3  .....0..s =
C.s.S.=0A=
      0050: 03 20 d0 05 00 00 52 e3  03 00 00 1a 58 00 9f e5  . =
....R.....X...=0A=
      0060: 58 a0 9f e5 06 fe ff eb  26 00 00 ea 74 20 41 e2  =
X.......&...t A.=0A=
      0070: 74 00 51 e3 07 00 00 1a  01 30 d0 e5 78 20 43 e2  =
t.Q......0..x C.=0A=
      0080: 78 00 53 e3 03 00 00 1a  02 30 d0 e5 74 20 43 e2  =
x.S......0..t C.=0A=
      0090: 74 00 53 e3 03 20 d0 05  00 00 52 e3 09 00 00 1a  t.S.. =
....R.....=0A=
      00a0: 1c 00 9f e5 04 a0 9f e5  f5 fd ff eb 15 00 00 ea  =
................=0A=
      00b0: 6f 6d 65 6d 88 d0 00 00  72 64 64 61 ac d0 00 00  =
omem....rdda....=0A=
      00c0: 65 74 61 64 cc d0 00 00  70 20 41 e2 70 00 51 e3  etad....p =
A.p.Q.=0A=
      00d0: 07 00 00 1a 01 30 d0 e5  72 20 43 e2 72 00 53 e3  .....0..r =
C.r.S.=0A=
      00e0: 03 00 00 1a 02 30 d0 e5  63 20 43 e2 63 00 53 e3  .....0..c =
C.c.S.=0A=
      00f0: 03 20 d0 05 00 00 52 e3  02 00 00 1a bc 00 9f e5  . =
....R.........=0A=
      0100: bc a0 9f e5 de fd ff eb  07 00 a0 e1 02 10 a0 e3  =
................=0A=
      0110: f4 01 00 eb 00 50 a0 e1  ec 40 4b e2 04 00 a0 e1  =
.....P...@K.....=0A=
      0120: 06 10 a0 e1 c8 20 a0 e3  b0 02 00 eb 00 00 8d e5  ..... =
..........=0A=
      0130: 00 60 a0 e3 04 60 8d e5  07 00 a0 e1 05 10 a0 e1  =
.`...`..........=0A=
      0140: 01 20 a0 e3 04 30 a0 e1  08 02 00 eb 04 40 a0 e3  . =
...0.......@..=0A=
      0150: 50 00 8d e8 07 00 a0 e1  05 10 a0 e1 f0 30 1b e5  =
P............0..=0A=
      0160: c3 20 a0 e3 01 02 00 eb  58 30 9f e5 00 20 93 e5  . =
......X0... ..=0A=
      0170: 01 00 52 e3 05 00 00 0a  50 00 8d e8 07 00 a0 e1  =
..R.....P.......=0A=
      0180: 05 10 a0 e1 cf 20 a0 e3  0a 30 a0 e1 f7 01 00 eb  ..... =
...0......=0A=
      0190: 04 60 8d e5 f0 30 1b e5  00 30 8d e5 07 00 a0 e1  =
.`...0...0......=0A=
      01a0: 05 10 a0 e1 48 20 a0 e3  08 30 a0 e1 ef 01 00 eb  ....H =
...0......=0A=
      01b0: 08 00 a0 e1 c6 fd ff eb  05 00 a0 e1 02 00 00 ea  =
................=0A=
      01c0: ec d0 00 00 68 63 6e 6c  a4 52 01 00 f0 ad 1b e9  =
....hcnl.R......=0A=
      01d0: 0d c0 a0 e1 f0 d9 2d e9  04 b0 4c e2 00 50 a0 e1  =
......-...L..P..=0A=
      01e0: 12 4e 4b e2 04 00 a0 e1  01 80 a0 e1 00 10 a0 e3  =
.NK.............=0A=
      01f0: 02 70 a0 e1 ff 20 a0 e3  01 dc 4d e2 b8 fd ff eb  .p... =
....M.....=0A=
      0200: 88 00 9f e5 05 10 a0 e1  9d fd ff eb 80 10 9f e5  =
................=0A=
      0210: 04 00 a0 e1 be fd ff eb  05 00 a0 e1 2f 10 a0 e3  =
............/...=0A=
      0220: a3 fd ff eb 00 10 50 e2  04 60 a0 e1 05 10 a0 01  =
......P..`......=0A=
      0230: 01 10 81 12 06 00 a0 e1  fa 20 a0 e3 44 fd ff eb  ......... =
..D...=0A=
      0240: 06 00 a0 e1 42 10 a0 e3  6d 2f a0 e3 02 20 82 e2  =
....B...m/... ..=0A=
      0250: 9b fd ff eb 00 50 50 e2  0f 00 00 ba 05 00 a0 e1  =
.....PP.........=0A=
      0260: 08 10 a0 e1 07 20 a0 e1  41 fd ff eb 00 40 a0 e1  ..... =
..A....@..=0A=
      0270: 05 00 a0 e1 42 fd ff eb  06 10 a0 e1 14 00 9f e5  =
....B...........=0A=
      0280: 04 20 a0 e1 7e fd ff eb  04 00 a0 e1 05 00 00 ea  . =
..~...........=0A=
      0290: 0c d1 00 00 1c d1 00 00  24 d1 00                 ........$..=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 362 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 357 fcs 0xce =0A=
      0000: 00 06 00 a0 e1 3b fd ff  eb 00 00 e0 e3 f0 a9 1b  =
.....;..........=0A=
      0010: e9 0d c0 a0 e1 f0 d8 2d  e9 04 b0 4c e2 00 70 a0  =
.......-...L..p.=0A=
      0020: e1 02 50 a0 e1 00 60 51  e2 00 00 a0 e3 f0 a8 1b  =
..P...`Q........=0A=
      0030: 09 a4 00 80 e2 47 fd ff  eb 00 40 50 e2 04 00 a0  =
.....G....@P....=0A=
      0040: 01 f0 a8 1b 09 04 00 a0  e1 00 10 a0 e3 a4 20 a0  =
.............. .=0A=
      0050: e3 7c fd ff eb 30 60 84  e5 a5 30 a0 e1 01 30 03  =
.|...0`...0...0.=0A=
      0060: e2 18 30 84 e5 25 21 a0  e1 01 20 02 e2 1c 20 84  ..0..%!... =
... .=0A=
      0070: e5 a5 31 a0 e1 01 30 03  e2 20 30 84 e5 00 20 e0  ..1...0.. =
0... .=0A=
      0080: e3 08 20 84 e5 0c 20 84  e5 10 20 84 e5 80 30 a0  .. ... ... =
...0.=0A=
      0090: e3 14 30 84 e5 34 70 84  e5 00 50 a0 e3 38 50 84  =
..0..4p...P..8P.=0A=
      00a0: e5 01 0b a0 e3 65 0d 00  eb 05 00 50 e1 28 00 84  =
.....e.....P.(..=0A=
      00b0: e5 13 00 00 0a 01 0b a0  e3 60 0d 00 eb 05 00 50  =
.........`.....P=0A=
      00c0: e1 24 00 84 e5 0e 00 00  0a 01 3b a0 e3 03 20 a0  =
.$........;... .=0A=
      00d0: e1 02 20 c4 e5 43 34 a0  e1 03 30 c4 e5 ff 20 a0  .. =
..C4...0... .=0A=
      00e0: e3 00 20 c4 e5 01 50 c4  e5 04 50 c4 e5 05 30 c4  .. =
...P...P...0.=0A=
      00f0: e5 0d 00 a0 e3 01 10 a0  e3 06 fd ff eb 04 00 a0  =
................=0A=
      0100: e1 f0 a8 1b e9 24 00 94  e5 00 00 50 e3 00 00 00  =
.....$.....P....=0A=
      0110: 0a 7f 0d 00 eb 28 00 94  e5 00 00 50 e3 00 00 00  =
.....(.....P....=0A=
      0120: 0a 7b 0d 00 eb 04 00 a0  e1 42 fd ff eb 00 00 a0  =
.{.......B......=0A=
      0130: e3 f0 a8 1b e9 0d c0 a0  e1 00 d8 2d e9 04 b0 4c  =
...........-...L=0A=
      0140: e2 00 c0 50 e2 00 00 e0  03 00 a8 1b 09 00 00 51  =
...P...........Q=0A=
      0150: e3 07 00 00 0a 01 e0 a0  e1 0f 00 be e8 88 c0 8c  =
................=0A=
      0160: e2 0f 00 ac e8                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 2=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 48 03 fd 03 00  9e e8 03 00 8c e8 01 00  =
...H............=0A=
      0010: a0 e3 00 a8 1b e9 00 00  e0 e3 00 a8 1b e9 0d c0  =
................=0A=
      0020: a0 e1 10 d8 2d e9 04 b0  4c e2 00 40 50 e2 10 a8  =
....-...L..@P...=0A=
      0030: 1b 09 04 00 a0 e1 9d 08  00 eb 04 00 a0 e1 e2 08  =
................=0A=
      0040: 00 eb 24 00 94 e5 00 00  50 e3 00 00 00 0a 58 0d  =
..$.....P.....X.=0A=
      0050: 00 eb 28 00 94 e5 00 00  50 e3 00 00 00 0a 54 0d  =
..(.....P.....T.=0A=
      0060: 00 eb 04 00 a0 e1 1b fd  ff eb 10 a8 1b e9 0d c0  =
................=0A=
      0070: a0 e1 00 d8 2d e9 04 b0  4c e2 00 00 50 e3 a0 10  =
....-...L...P...=0A=
      0080: 80 15 00 a8 1b e9 0d c0  a0 e1 00 d8 2d e9 04 b0  =
............-...=0A=
      0090: 4c e2 00 00 50 e3 a0 00  90 15 00 a8 1b 19 00 00  =
L...P...........=0A=
      00a0: a0 e3 00 a8 1b e9 0d c0  a0 e1 00 d8 2d e9 04 b0  =
............-...=0A=
      00b0: 4c e2 00 00 50 e3 00 a8  1b 09 00 00 51 e3 00 a8  =
L...P.......Q...=0A=
      00c0: 1b 09 00 00 52 e3 30 10  80 e5 a0 20 80 15 00 a8  =
....R.0.... ....=0A=
      00d0: 1b e9 0d c0 a0 e1 10 d8  2d e9 04 b0 4c e2 01 18  =
........-...L...=0A=
      00e0: a0 e1 21 18 a0 e1 02 28  a0 e1 22 28 a0 e1 00 40  =
..!....(.."(...@=0A=
      00f0: 50 e2 0d 00 e0 03 10 a8  1b 09 2c 30 94 e5 00 00  =
P.........,0....=0A=
      0100: 53 e3 0f 00 e0 e3 10 a8  1b 19 7f 0c a0 e3 01 00  =
S...............=0A=
      0110: 80 e2 ff 30 41 e2 03 38  a0 e1 23 08 50 e1 01 c0  =
...0A..8..#.P...=0A=
      0120: a0 e1 01 00 00 2a 06 00  e0 e3 10 a8 1b e9 ff 30  =
.....*.........0=0A=
      0130: 42 e2 03 38 a0 e1 23 08  50 e1 02 00 a0 e1 f8 ff  =
B..8..#.P.......=0A=
      0140: ff 3a 02 c0 c4 e5 41 34  a0 e1 03 30 c4 e5 04 00  =
.:....A4...0....=0A=
      0150: c4 e5 42 34 a0 e1 05 30  c4 e5 02 20 d4 e5 03 10  =
..B4...0... ....=0A=
      0160: d4 e5 28 00 94 e5 01 14  82 e1 f7 0c 00 eb 00 00  =
..(.............=0A=
      0170: 50 e3 28 00 84 e5 0a 00  00 0a 04 30 d4 e5 05 10  =
P.(........0....=0A=
      0180: d4 e5 24 00 94 e5 01 14  83 e1 ef 0c 00 eb 00 30  =
..$............0=0A=
      0190: a0 e1 00 00 53 e3 0b 00  e0 03 00 00 a0 13 24 30  =
....S.........$0=0A=
      01a0: 84 e5 10 a8 1b e9 0b 00  e0 e3 10 a8 1b e9 0d c0  =
................=0A=
      01b0: a0 e1 10 d8 2d e9 04 b0  4c e2 00 40 50 e2 00 00  =
....-...L..@P...=0A=
      01c0: e0 03 10 a8 1b 09 00 00  51 e3 00 30 a0 13 01 30  =
........Q..0...0=0A=
      01d0: a0 03 00 00 52 e3 00 30  a0 03 00 00 53 e3 04 00  =
....R..0....S...=0A=
      01e0: 00 1a 40 00 84 e2 af fc  ff eb 04 00 a0 e1 54 08  =
..@...........T.=0A=
      01f0: 00 eb 10 a8 1b e9 00 00  e0 e3 10 a8 1b e9 0d c0  =
................=0A=
      0200: a0 e1 f0 d9 2d e9 04 b0  4c e2 01 70 a0 e1 02 80  =
....-...L..p....=0A=
      0210: a0 e1 00 60 50 e2 01 00  00 1a 00 00 a0 e3 f0 a9  =
...`P...........=0A=
      0220: 1b e9 08 30 96 e5 00 00  53 e3 fa ff ff ba 0c 30  =
...0....S......0=0A=
      0230: 96 e5 00 00 53 e3 f7 ff  ff ba 2c 40 96 e5 00 00  =
....S.....,@....=0A=
      0240: a0 e3 00 00 54 e1 f0 a9  1b 19 a4 00 80 e2 69 fc  =
....T.........i.=0A=
      0250: ff eb 00 50 50 e2 ef ff  ff 0a 05 00 a0 e1 04 10  =
...PP...........=0A=
      0260: a0 e1 a4 20 a0 e3 9f fc  ff eb 00 00 57 e3 30 70  ... =
........W.0p=0A=
      0270: 85 15 30 30 96 05 30 30  85 05 00 00 58 e3 a0 80  =
..00..00....X...=0A=
      0280: 85 15 a0 30 96 05 a0 30  85 05 18 30 96 e5 18 30  =
...0...0...0...0=0A=
      0290: 85 e5 34 00 85 e2 34 10  86 e2 54                 ..4...4...T=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
=0A=
**************************File Transfer in =
between****************************=0A=
=0A=
=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 48 03 fd 73 65  74 72 73 70 00 63 6c 6f  =
...H..setrsp.clo=0A=
      0010: 73 65 40 40 47 4c 49 42  43 5f 32 2e 30 00 70 65  =
se@@GLIBC_2.0.pe=0A=
      0020: 72 72 6f 72 40 40 47 4c  49 42 43 5f 32 2e 30 00  =
rror@@GLIBC_2.0.=0A=
      0030: 49 6e 4f 42 45 58 5f 53  65 72 76 65 72 52 65 67  =
InOBEX_ServerReg=0A=
      0040: 69 73 74 65 72 00 6f 62  65 78 5f 64 65 6c 69 76  =
ister.obex_deliv=0A=
      0050: 65 72 5f 65 76 65 6e 74  00 66 70 72 69 6e 74 66  =
er_event.fprintf=0A=
      0060: 40 40 47 4c 49 42 43 5f  32 2e 30 00 73 69 67 6e  =
@@GLIBC_2.0.sign=0A=
      0070: 61 6c 40 40 47 4c 49 42  43 5f 32 2e 30 00 69 6e  =
al@@GLIBC_2.0.in=0A=
      0080: 73 65 72 74 5f 75 62 79  74 65 5f 68 65 61 64 65  =
sert_ubyte_heade=0A=
      0090: 72 00 49 6e 4f 42 45 58  5f 54 72 61 6e 73 70 6f  =
r.InOBEX_Transpo=0A=
      00a0: 72 74 43 6f 6e 6e 65 63  74 00 73 65 6c 65 63 74  =
rtConnect.select=0A=
      00b0: 40 40 47 4c 49 42 43 5f  32 2e 30 00 63 6c 69 65  =
@@GLIBC_2.0.clie=0A=
      00c0: 6e 74 5f 64 6f 6e 65 00  6f 62 65 78 5f 64 61 74  =
nt_done.obex_dat=0A=
      00d0: 61 5f 72 65 71 75 65 73  74 00 6f 62 65 78 5f 64  =
a_request.obex_d=0A=
      00e0: 61 74 61 5f 69 6e 64 69  63 61 74 69 6f 6e 00 4f  =
ata_indication.O=0A=
      00f0: 42 45 58 5f 47 65 74 43  75 73 74 6f 6d 44 61 74  =
BEX_GetCustomDat=0A=
      0100: 61 00 5f 5f 62 73 73 5f  73 74 61 72 74 5f 5f 00  =
a.__bss_start__.=0A=
      0110: 4f 42 45 58 5f 47 65 74  52 65 73 70 6f 6e 73 65  =
OBEX_GetResponse=0A=
      0120: 4d 65 73 73 61 67 65 00  6f 62 65 78 5f 6f 62 6a  =
Message.obex_obj=0A=
      0130: 65 63 74 5f 72 65 70 61  72 73 65 68 65 61 64 65  =
ect_reparseheade=0A=
      0140: 72 73 00 6f 62 65 78 5f  6f 62 6a 65 63 74 5f 73  =
rs.obex_object_s=0A=
      0150: 65 6e 64 00 67 65 74 5f  66 69 6c 65 73 69 7a 65  =
end.get_filesize=0A=
      0160: 00 6f 62 65 78 5f 74 72  61 6e 73 70 6f 72 74 5f  =
.obex_transport_=0A=
      0170: 64 69 73 63 6f 6e 6e 65  63 74 5f 72 65 71 75 65  =
disconnect_reque=0A=
      0180: 73 74 00 67 5f 6e 65 74  62 75 66 5f 74 61 69 6c  =
st.g_netbuf_tail=0A=
      0190: 72 6f 6f 6d 00 6f 62 65  78 5f 6f 62 6a 65 63 74  =
room.obex_object=0A=
      01a0: 5f 73 65 74 63 6d 64 00  61 63 63 65 70 74 40 40  =
_setcmd.accept@@=0A=
      01b0: 47 4c 49 42 43 5f 32 2e  30 00 6f 62 65 78 5f 73  =
GLIBC_2.0.obex_s=0A=
      01c0: 65 72 76 65 72 00 5f 69  6e 69 74 00 67 5f 6e 65  =
erver._init.g_ne=0A=
      01d0: 74 62 75 66 5f 66 72 65  65 00 6f 62 65 78 5f 63  =
tbuf_free.obex_c=0A=
      01e0: 61 6e 63 65 6c 72 65 71  75 65 73 74 00 6c 69 73  =
ancelrequest.lis=0A=
      01f0: 74 65 6e 40 40 47 4c 49  42 43 5f 32 2e 30 00 4f  =
ten@@GLIBC_2.0.O=0A=
      0200: 42 45 58 5f 43 68 61 72  54 6f 55 6e 69 63 6f 64  =
BEX_CharToUnicod=0A=
      0210: 65 00 42 74 4f 42 45 58  5f 54 72 61 6e 73 70 6f  =
e.BtOBEX_Transpo=0A=
      0220: 72 74 43 6f 6e 6e 65 63  74 00 69 6e 6f 62 65 78  =
rtConnect.inobex=0A=
      0230: 5f 70 72 65 70 61 72 65  5f 63 6f 6e 6e 65 63 74  =
_prepare_connect=0A=
      0240: 00 4f 42 45 58 5f 4f 62  6a 65 63 74 52 65 50 61  =
.OBEX_ObjectRePa=0A=
      0250: 72 73 65 48 65 61 64 65  72 73 00 6d 61 6c 6c 6f  =
rseHeaders.mallo=0A=
      0260: 63 40 40 47 4c 49 42 43  5f 32 2e 30 00 69 72 6f  =
c@@GLIBC_2.0.iro=0A=
      0270: 62 65 78 5f 70 72 65 70  61 72 65 5f 6c 69 73 74  =
bex_prepare_list=0A=
      0280: 65 6e 00 67 5f 6e 65 74  62 75 66 5f 70 75 73 68  =
en.g_netbuf_push=0A=
      0290: 00 69 72 6f 62 65 78 5f  61 63 63                 .irobex_acc=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 362 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 357 fcs 0xce =0A=
      0000: 65 70 74 00 62 74 6f 62  65 78 5f 63 6f 6e 6e 65  =
ept.btobex_conne=0A=
      0010: 63 74 5f 72 65 71 75 65  73 74 00 6d 65 6d 6d 6f  =
ct_request.memmo=0A=
      0020: 76 65 40 40 47 4c 49 42  43 5f 32 2e 30 00 6f 62  =
ve@@GLIBC_2.0.ob=0A=
      0030: 65 78 5f 74 72 61 6e 73  70 6f 72 74 5f 72 65 61  =
ex_transport_rea=0A=
      0040: 64 00 67 5f 6e 65 74 62  75 66 5f 70 75 6c 6c 00  =
d.g_netbuf_pull.=0A=
      0050: 69 6e 6f 62 65 78 5f 61  63 63 65 70 74 00 67 65  =
inobex_accept.ge=0A=
      0060: 74 73 6f 63 6b 6f 70 74  40 40 47 4c 49 42 43 5f  =
tsockopt@@GLIBC_=0A=
      0070: 32 2e 30 00 73 74 64 65  72 72 40 40 47 4c 49 42  =
2.0.stderr@@GLIB=0A=
      0080: 43 5f 32 2e 30 00 61 62  6f 72 74 40 40 47 4c 49  =
C_2.0.abort@@GLI=0A=
      0090: 42 43 5f 32 2e 30 00 4f  42 45 58 5f 4f 62 6a 65  =
BC_2.0.OBEX_Obje=0A=
      00a0: 63 74 44 65 6c 65 74 65  00 5f 5f 64 65 72 65 67  =
ctDelete.__dereg=0A=
      00b0: 69 73 74 65 72 5f 66 72  61 6d 65 5f 69 6e 66 6f  =
ister_frame_info=0A=
      00c0: 00 5f 5f 78 73 74 61 74  40 40 47 4c 49 42 43 5f  =
.__xstat@@GLIBC_=0A=
      00d0: 32 2e 30 00 6f 62 65 78  5f 6f 62 6a 65 63 74 5f  =
2.0.obex_object_=0A=
      00e0: 67 65 74 6e 65 78 74 68  65 61 64 65 72 00 73 65  =
getnextheader.se=0A=
      00f0: 74 73 6f 63 6b 6f 70 74  40 40 47 4c 49 42 43 5f  =
tsockopt@@GLIBC_=0A=
      0100: 32 2e 30 00 69 6e 6f 62  65 78 5f 64 69 73 63 6f  =
2.0.inobex_disco=0A=
      0110: 6e 6e 65 63 74 5f 73 65  72 76 65 72 00 62 74 6f  =
nnect_server.bto=0A=
      0120: 62 65 78 5f 6c 69 73 74  65 6e 00 4f 42 45 58 5f  =
bex_listen.OBEX_=0A=
      0130: 53 65 74 54 72 61 6e 73  70 6f 72 74 4d 54 55 00  =
SetTransportMTU.=0A=
      0140: 4f 42 45 58 5f 49 6e 69  74 00 6f 62 65 78 5f 6f  =
OBEX_Init.obex_o=0A=
      0150: 62 6a 65 63 74 5f 64 65  6c 65 74 65 00 5f 5f 62  =
bject_delete.__b=0A=
      0160: 73 73 5f 65 6e                                    ss_en=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 02 04 00 48 03 fd 64 5f  5f 00 6f 62 65 78 5f 64  =
...H..d__.obex_d=0A=
      0010: 65 62 75 67 00 73 6c 69  73 74 5f 61 70 70 65 6e  =
ebug.slist_appen=0A=
      0020: 64 00 73 65 72 76 65 72  5f 64 6f 6e 65 00 5f 73  =
d.server_done._s=0A=
      0030: 74 61 72 74 00 73 61 66  65 5f 73 61 76 65 5f 66  =
tart.safe_save_f=0A=
      0040: 69 6c 65 00 67 5f 6e 65  74 62 75 66 5f 70 72 69  =
ile.g_netbuf_pri=0A=
      0050: 6e 74 00 69 6e 6f 62 65  78 5f 63 6f 6e 6e 65 63  =
nt.inobex_connec=0A=
      0060: 74 5f 72 65 71 75 65 73  74 00 67 5f 6e 65 74 62  =
t_request.g_netb=0A=
      0070: 75 66 5f 70 75 74 00 68  61 6e 64 6c 65 00 6f 62  =
uf_put.handle.ob=0A=
      0080: 65 78 5f 74 72 61 6e 73  70 6f 72 74 5f 6c 69 73  =
ex_transport_lis=0A=
      0090: 74 65 6e 00 73 74 72 6c  65 6e 40 40 47 4c 49 42  =
ten.strlen@@GLIB=0A=
      00a0: 43 5f 32 2e 30 00 69 6e  73 65 72 74 5f 62 79 74  =
C_2.0.insert_byt=0A=
      00b0: 65 5f 73 74 72 65 61 6d  5f 68 65 61 64 65 72 00  =
e_stream_header.=0A=
      00c0: 6f 62 65 78 5f 65 76 65  6e 74 00 62 74 6f 62 65  =
obex_event.btobe=0A=
      00d0: 78 5f 70 72 65 70 61 72  65 5f 6c 69 73 74 65 6e  =
x_prepare_listen=0A=
      00e0: 00 62 74 6f 62 65 78 5f  64 69 73 63 6f 6e 6e 65  =
.btobex_disconne=0A=
      00f0: 63 74 5f 73 65 72 76 65  72 00 4f 42 45 58 5f 53  =
ct_server.OBEX_S=0A=
      0100: 65 74 55 73 65 72 43 61  6c 6c 42 61 63 6b 00 73  =
etUserCallBack.s=0A=
      0110: 6c 69 73 74 5f 72 65 6d  6f 76 65 00 42 74 4f 42  =
list_remove.BtOB=0A=
      0120: 45 58 5f 53 65 72 76 65  72 52 65 67 69 73 74 65  =
EX_ServerRegiste=0A=
      0130: 72 00 4f 42 45 58 5f 52  65 71 75 65 73 74 00 69  =
r.OBEX_Request.i=0A=
      0140: 6e 6f 62 65 78 5f 64 69  73 63 6f 6e 6e 65 63 74  =
nobex_disconnect=0A=
      0150: 5f 72 65 71 75 65 73 74  00 4f 42 45 58 5f 54 72  =
_request.OBEX_Tr=0A=
      0160: 61 6e 73 70 6f 72 74 43  6f 6e 6e 65 63 74 00 4f  =
ansportConnect.O=0A=
      0170: 42 45 58 5f 52 65 67 69  73 74 65 72 43 54 72 61  =
BEX_RegisterCTra=0A=
      0180: 6e 73 70 6f 72 74 00 69  72 6f 62 65 78 5f 64 69  =
nsport.irobex_di=0A=
      0190: 73 63 6f 6e 6e 65 63 74  5f 73 65 72 76 65 72 00  =
sconnect_server.=0A=
      01a0: 46 64 4f 42 45 58 5f 54  72 61 6e 73 70 6f 72 74  =
FdOBEX_Transport=0A=
      01b0: 53 65 74 75 70 00 5f 5f  62 73 73 5f 73 74 61 72  =
Setup.__bss_star=0A=
      01c0: 74 00 4f 42 45 58 5f 43  61 6e 63 65 6c 52 65 71  =
t.OBEX_CancelReq=0A=
      01d0: 75 65 73 74 00 6d 61 69  6e 00 67 5f 6e 65 74 62  =
uest.main.g_netb=0A=
      01e0: 75 66 5f 6e 65 77 00 5f  5f 6c 69 62 63 5f 73 74  =
uf_new.__libc_st=0A=
      01f0: 61 72 74 5f 6d 61 69 6e  40 40 47 4c 49 42 43 5f  =
art_main@@GLIBC_=0A=
      0200: 32 2e 30 00 69 72 6f 62  65 78 5f 63 6f 6e 6e 65  =
2.0.irobex_conne=0A=
      0210: 63 74 5f 72 65 71 75 65  73 74 00 6f 62 65 78 5f  =
ct_request.obex_=0A=
      0220: 6f 62 6a 65 63 74 5f 61  64 64 68 65 61 64 65 72  =
object_addheader=0A=
      0230: 00 64 6f 5f 73 79 6e 63  5f 72 65 71 75 65 73 74  =
.do_sync_request=0A=
      0240: 00 4f 42 45 58 5f 53 65  74 55 73 65 72 44 61 74  =
.OBEX_SetUserDat=0A=
      0250: 61 00 5f 5f 65 6e 64 5f  5f 00 72 65 61 6c 6c 6f  =
a.__end__.reallo=0A=
      0260: 63 40 40 47 4c 49 42 43  5f 32 2e 30 00 6f 62 65  =
c@@GLIBC_2.0.obe=0A=
      0270: 78 5f 74 72 61 6e 73 70  6f 72 74 5f 68 61 6e 64  =
x_transport_hand=0A=
      0280: 6c 65 5f 69 6e 70 75 74  00 4f 42 45 58 5f 47 65  =
le_input.OBEX_Ge=0A=
      0290: 74 55 73 65 72 44 61 74  61 00 64                 tUserData.d=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 362 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 357 fcs 0xce =0A=
      0000: 61 74 61 5f 73 74 61 72  74 00 67 5f 6e 65 74 62  =
ata_start.g_netb=0A=
      0010: 75 66 5f 70 75 74 5f 64  61 74 61 00 4f 42 45 58  =
uf_put_data.OBEX=0A=
      0020: 5f 54 72 61 6e 73 70 6f  72 74 44 69 73 63 6f 6e  =
_TransportDiscon=0A=
      0030: 6e 65 63 74 00 70 72 69  6e 74 66 40 40 47 4c 49  =
nect.printf@@GLI=0A=
      0040: 42 43 5f 32 2e 30 00 6f  62 65 78 5f 6f 62 6a 65  =
BC_2.0.obex_obje=0A=
      0050: 63 74 5f 72 65 61 64 73  74 72 65 61 6d 00 62 69  =
ct_readstream.bi=0A=
      0060: 6e 64 40 40 47 4c 49 42  43 5f 32 2e 30 00 5f 66  =
nd@@GLIBC_2.0._f=0A=
      0070: 69 6e 69 00 69 72 6f 62  65 78 5f 6c 69 73 74 65  =
ini.irobex_liste=0A=
      0080: 6e 00 6d 65 6d 63 70 79  40 40 47 4c 49 42 43 5f  =
n.memcpy@@GLIBC_=0A=
      0090: 32 2e 30 00 4f 42 45 58  5f 4f 62 6a 65 63 74 4e  =
2.0.OBEX_ObjectN=0A=
      00a0: 65 77 00 73 74 72 72 63  68 72 40 40 47 4c 49 42  =
ew.strrchr@@GLIB=0A=
      00b0: 43 5f 32 2e 30 00 6f 62  65 78 5f 63 6c 69 65 6e  =
C_2.0.obex_clien=0A=
      00c0: 74 00 4f 42 45 58 5f 52  65 73 70 6f 6e 73 65 54  =
t.OBEX_ResponseT=0A=
      00d0: 6f 53 74 72 69 6e 67 00  4f 42 45 58 5f 53 65 74  =
oString.OBEX_Set=0A=
      00e0: 43 75 73 74 6f 6d 44 61  74 61 00 4f 42 45 58 5f  =
CustomData.OBEX_=0A=
      00f0: 55 6e 69 63 6f 64 65 54  6f 43 68 61 72 00 69 6e  =
UnicodeToChar.in=0A=
      0100: 6f 62 65 78 5f 70 72 65  70 61 72 65 5f 6c 69 73  =
obex_prepare_lis=0A=
      0110: 74 65 6e 00 4f 42 45 58  5f 4f 62 6a 65 63 74 47  =
ten.OBEX_ObjectG=0A=
      0120: 65 74 4e 65 78 74 48 65  61 64 65 72 00 6f 62 65  =
etNextHeader.obe=0A=
      0130: 78 5f 69 6e 73 65 72 74  5f 63 6f 6e 6e 65 63 74  =
x_insert_connect=0A=
      0140: 66 72 61 6d 65 00 49 72  4f 42 45 58 5f 54 72 61  =
frame.IrOBEX_Tra=0A=
      0150: 6e 73 70 6f 72 74 43 6f  6e 6e 65 63 74 00 6f 70  =
nsportConnect.op=0A=
      0160: 65 6e 40 40 47                                    en@@G=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: 90 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 192=0A=
< ACL data: handle 40 flags 0x01 dlen 100=0A=
    L2CAP(d): cid 0x0047 len 672 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 667 fcs 0xce =0A=
      0000: 82 03 40 49 03 3d 4c 49  42 43 5f 32 2e 30 00 67  =
..@I.=3DLIBC_2.0.g=0A=
      0010: 5f 6e 65 74 62 75 66 5f  70 72 65 70 65 6e 64 5f  =
_netbuf_prepend_=0A=
      0020: 68 64 72 00 67 5f 6e 65  74 62 75 66 5f 74 72 69  =
hdr.g_netbuf_tri=0A=
      0030: 6d 00 4f 42 45 58 5f 48  61 6e 64 6c 65 49 6e 70  =
m.OBEX_HandleInp=0A=
      0040: 75 74 00 65 61 73 79 5f  72 65 61 64 66 69 6c 65  =
ut.easy_readfile=0A=
      0050: 00 67 5f 6e 65 74 62 75  66 5f 68 65 61 64 72 6f  =
.g_netbuf_headro=0A=
      0060: 6f 6d 00 4f 42 45 58 5f  4f 62 6a 65 63 74 53 65  =
om.OBEX_ObjectSe=0A=
      0070: 74 4e 6f 6e 48 64 72 44  61 74 61 00 4f 42 45 58  =
tNonHdrData.OBEX=0A=
      0080: 5f 47 65 74 46 44 00 62  74 6f 62 65 78 5f 64 69  =
_GetFD.btobex_di=0A=
      0090: 73 63 6f 6e 6e 65 63 74  5f 72 65 71 75 65 73 74  =
sconnect_request=0A=
      00a0: 00 5f 65 64 61 74 61 00  5f 47 4c 4f 42 41 4c 5f  =
._edata._GLOBAL_=0A=
      00b0: 4f 46 46 53 45 54 5f 54  41 42 4c 45 5f 00 66 72  =
OFFSET_TABLE_.fr=0A=
      00c0: 65 65 40 40 47 4c 49 42  43 5f 32 2e 30 00 5f 65  =
ee@@GLIBC_2.0._e=0A=
      00d0: 6e 64 00 66 69 6e 69 73  68 65 64 00 77 61 69 74  =
nd.finished.wait=0A=
      00e0: 5f 66 6f 72 5f 72 73 70  00 6d 65 6d 73 65 74 40  =
_for_rsp.memset@=0A=
      00f0: 40 47 4c 49 42 43 5f 32  2e 30 00 63 6f 6e 6e 65  =
@GLIBC_2.0.conne=0A=
      0100: 63 74 40 40 47 4c 49 42  43 5f 32 2e 30 00 73 74  =
ct@@GLIBC_2.0.st=0A=
      0110: 72 6e 63 70 79 40 40 47  4c 49 42 43 5f 32 2e 30  =
rncpy@@GLIBC_2.0=0A=
      0120: 00 6f 62 65 78 5f 74 72  61 6e 73 70 6f 72 74 5f  =
.obex_transport_=0A=
      0130: 63 6f 6e 6e 65 63 74 5f  72 65 71 75 65 73 74 00  =
connect_request.=0A=
      0140: 69 72 6f 62 65 78 5f 70  72 65 70 61 72 65 5f 63  =
irobex_prepare_c=0A=
      0150: 6f 6e 6e 65 63 74 00 69  6e 6f 62 65 78 5f 6c 69  =
onnect.inobex_li=0A=
      0160: 73 74 65 6e 00 4f 42 45  58 5f 43 6c 65 61 6e 75  =
sten.OBEX_Cleanu=0A=
      0170: 70 00 4f 42 45 58 5f 4f  62 6a 65 63 74 47 65 74  =
p.OBEX_ObjectGet=0A=
      0180: 4e 6f 6e 48 64 72 44 61  74 61 00 62 75 69 6c 64  =
NonHdrData.build=0A=
      0190: 5f 6f 62 6a 65 63 74 5f  66 72 6f 6d 5f 66 69 6c  =
_object_from_fil=0A=
      01a0: 65 00 70 75 74 5f 64 6f  6e 65 00 6f 62 65 78 5f  =
e.put_done.obex_=0A=
      01b0: 72 65 73 70 6f 6e 73 65  5f 72 65 71 75 65 73 74  =
response_request=0A=
      01c0: 00 5f 49 4f 5f 73 74 64  69 6e 5f 75 73 65 64 00  =
._IO_stdin_used.=0A=
      01d0: 6f 62 65 78 5f 6f 62 6a  65 63 74 5f 6e 65 77 00  =
obex_object_new.=0A=
      01e0: 49 72 4f 42 45 58 5f 53  65 72 76 65 72 52 65 67  =
IrOBEX_ServerReg=0A=
      01f0: 69 73 74 65 72 00 73 70  72 69 6e 74 66 40 40 47  =
ister.sprintf@@G=0A=
      0200: 4c 49 42 43 5f 32 2e 30  00 5f 5f 64 61 74 61 5f  =
LIBC_2.0.__data_=0A=
      0210: 73 74 61 72 74 00 6c 61  73 74 5f 72 73 70 00 62  =
start.last_rsp.b=0A=
      0220: 74 6f 62 65 78 5f 61 63  63 65 70 74 00 73 6f 63  =
tobex_accept.soc=0A=
      0230: 6b 65 74 40 40 47 4c 49  42 43 5f 32 2e 30 00 6f  =
ket@@GLIBC_2.0.o=0A=
      0240: 62 65 78 5f 70 72 6f 74  6f 63 6f 6c 5f 74 79 70  =
bex_protocol_typ=0A=
      0250: 65 00 73 65 72 76 65 72  5f 72 65 71 75 65 73 74  =
e.server_request=0A=
      0260: 00 6f 62 65 78 5f 72 65  73 70 6f 6e 73 65 5f 74  =
.obex_response_t=0A=
      0270: 6f 5f 73 74 72 69 6e 67  00 67 5f 6e 65 74 62 75  =
o_string.g_netbu=0A=
      0280: 66 5f 72 65 73 65 72 76  65 00 6f 62 65 78 5f 64  =
f_reserve.obex_d=0A=
      0290: 65 6c 65 74 65 5f 73 6f  63 6b 65                 elete_socke=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 174=0A=
    L2CAP(d): cid 0x0047 len 170 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 165 fcs 0xce =0A=
      0000: 74 00 4f 42 45 58 5f 4f  62 6a 65 63 74 41 64 64  =
t.OBEX_ObjectAdd=0A=
      0010: 48 65 61 64 65 72 00 5f  5f 72 65 67 69 73 74 65  =
Header.__registe=0A=
      0020: 72 5f 66 72 61 6d 65 5f  69 6e 66 6f 00 4f 42 45  =
r_frame_info.OBE=0A=
      0030: 58 5f 4f 62 6a 65 63 74  53 65 74 48 64 72 4f 66  =
X_ObjectSetHdrOf=0A=
      0040: 66 73 65 74 00 67 5f 6e  65 74 62 75 66 5f 72 65  =
fset.g_netbuf_re=0A=
      0050: 63 79 63 6c 65 00 72 65  61 64 40 40 47 4c 49 42  =
cycle.read@@GLIB=0A=
      0060: 43 5f 32 2e 30 00 6f 62  65 78 5f 64 75 6d 70 00  =
C_2.0.obex_dump.=0A=
      0070: 5f 5f 67 6d 6f 6e 5f 73  74 61 72 74 5f 5f 00 6f  =
__gmon_start__.o=0A=
      0080: 62 65 78 5f 6f 62 6a 65  63 74 5f 72 65 63 65 69  =
bex_object_recei=0A=
      0090: 76 65 00 73 74 72 63 70  79 40 40 47 4c 49 42 43  =
ve.strcpy@@GLIBC=0A=
      00a0: 5f 32 2e 30 00                                    _2.0.=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 2=0A=
      0000: a0 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 11=0A=
    L2CAP(d): cid 0x0047 len 7 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 3 fcs 0xce =0A=
      0000: 81 00 03                                          ...=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 3 fcs 0x8 credits 1=0A=
      0000: a0 00 03                                          ...=0A=
< ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0047 len 4 [psm 3]=0A=
      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3 =0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0040 len 4 [psm 3]=0A=
      RFCOMM(s): DISC: cr 0 dlci 18 pf 1 ilen 0 fcs 0xb2 =0A=
< ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0047 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 0 dlci 18 pf 1 ilen 0 fcs 0x98 =0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 28 00 01 00                                    .(...=0A=
< ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0047 len 4 [psm 3]=0A=
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd =0A=
< ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn req: dcid 0x0047 scid 0x0040=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 40 packets 1=0A=
> ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0040 len 4 [psm 3]=0A=
      RFCOMM(s): DM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x18 =0A=
> ACL data: handle 40 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0040 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 =0A=
> ACL data: handle 40 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0040=0A=
< HCI Command: Disconnect (0x01|0x0006) plen 3=0A=
    handle 40 reason 0x13=0A=
    Reason: Remote User Terminated Connection=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Disconnect (0x01|0x0006) status 0x00 ncmd 1=0A=
> HCI Event: Disconn Complete (0x05) plen 4=0A=
    status 0x00 handle 40 reason 0x16=0A=
    Reason: Connection Terminated by Local Host=0A=

------=_NextPart_000_004C_01C6C546.EC512000
Content-Type: application/octet-stream;
	name="hci_core.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hci_core.c.diff"

--- C:\Copy of hci_core.c	2003-03-14 03:53:16.000000000 +-0530
+++ C:\hci_core.c	2006-08-21 17:23:36.000000000 +-0530
@@ -73,12 +73,13 @@
 #define HCI_MAX_PROTO	2
 struct hci_proto *hci_proto[HCI_MAX_PROTO];
=20
 /* HCI notifiers list */
 static struct notifier_block *hci_notifier;
=20
+extern int __controller_to_host_fc;
=20
 /* ---- HCI notifications ---- */
=20
 int hci_register_notifier(struct notifier_block *nb)
 {
 	return notifier_chain_register(&hci_notifier, nb);
@@ -221,24 +222,22 @@
 	/* Read Local Supported Features */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_LOCAL_FEATURES, 0, NULL);
=20
 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BUFFER_SIZE, 0, NULL);
=20
-#if 0
 	/* Host buffer size */
 	{
 		host_buffer_size_cp bs;
 		bs.acl_mtu =3D __cpu_to_le16(HCI_MAX_ACL_SIZE);
 		bs.sco_mtu =3D HCI_MAX_SCO_SIZE;
-		bs.acl_max_pkt =3D __cpu_to_le16(0xffff);
-		bs.sco_max_pkt =3D __cpu_to_le16(0xffff);
+		bs.acl_max_pkt =3D __cpu_to_le16(0x0008);
+		bs.sco_max_pkt =3D __cpu_to_le16(0x0008);
 		hci_send_cmd(hdev, OGF_HOST_CTL, OCF_HOST_BUFFER_SIZE,
 				HOST_BUFFER_SIZE_CP_SIZE, &bs);
 	}
-#endif
=20
 	/* Read BD Address */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BD_ADDR, 0, NULL);
=20
 	/* Optional initialization */
=20
@@ -1031,13 +1030,16 @@
 		memcpy(skb_put(skb, plen), param, plen);
=20
 	BT_DBG("skb len %d", skb->len);
=20
 	skb->pkt_type =3D HCI_COMMAND_PKT;
 	skb->dev =3D (void *) hdev;
-	skb_queue_tail(&hdev->cmd_q, skb);
+	if(ocf !=3D OCF_HOST_NUM_OF_COMPLETED_PACKETS)
+		skb_queue_tail(&hdev->cmd_q, skb);
+	else
+		skb_queue_tail(&hdev->raw_q, skb);
 	hci_sched_cmd(hdev);
=20
 	return 0;
 }
=20
 /* Get data from the previously sent command */
@@ -1273,12 +1275,13 @@
 /* ACL data packet */
 static inline void hci_acldata_packet(struct hci_dev *hdev, struct =
sk_buff *skb)
 {
 	hci_acl_hdr *ah =3D (void *) skb->data;
 	struct hci_conn *conn;
 	__u16 handle, flags;
+	host_num_of_completed_packets_cp cp;
=20
 	skb_pull(skb, HCI_ACL_HDR_SIZE);
=20
 	handle =3D __le16_to_cpu(ah->handle);
 	flags  =3D acl_flags(handle);
 	handle =3D acl_handle(handle);
@@ -1287,12 +1290,26 @@
=20
 	hdev->stat.acl_rx++;
=20
 	hci_dev_lock(hdev);
 	conn =3D conn_hash_lookup_handle(hdev, handle);
 	hci_dev_unlock(hdev);
+
+	/* If flow control has been enabled from Controller to Host
+	 * send Host Number of Completed Packets Command
+	 * Note that there is no event generated for this command
+	 */
+
+	if(__controller_to_host_fc) {
+		cp.num_of_handles =3D 0x01;
+		cp.handle =3D handle;
+		cp.host_num_of_completed_packets =3D 0x01;
+		hci_send_cmd(hdev, OGF_HOST_CTL, OCF_HOST_NUM_OF_COMPLETED_PACKETS,=20
+				OCF_HOST_NUM_OF_COMPLETED_PACKETS_CP_SIZE, &cp);
+		printk(KERN_INFO "Sending Host No of Completed Packets:\n");
+	}
 =09
 	if (conn) {
 		register struct hci_proto *hp;
=20
 		/* Send to upper protocol */
 		if ((hp =3D hci_proto[HCI_PROTO_L2CAP]) && hp->recv_acldata) {

------=_NextPart_000_004C_01C6C546.EC512000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_NextPart_000_004C_01C6C546.EC512000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_004C_01C6C546.EC512000--
