Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1098654320.4635.16.camel@localhost>
References: <1098654320.4635.16.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-upjzxz2j9ddE5tkkH8JE"
Message-Id: <1098655672.4636.21.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 25 Oct 2004 11:07:53 +1300


--=-upjzxz2j9ddE5tkkH8JE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

If it would be useful, I  can get a dump of Apple OSX doing its BT stuff
on boot.

I have a Logitech MX 900 BT base station which I can connect to another
Linux box.  Will hcidump on this be able to dump the conversation if I
switch off encryption?

Cheers,

Matthew

On Mon, 2004-10-25 at 10:45, Matthew Grant wrote:
> Hi!
>=20
> Running 2.6.8 mh2, bluz-utils 2.10 on Debian Sarge.  Marcel, please
> excuse me for mailing you directly as wellas the list, as I want to send
> you a binary hcidump output so you can get maximum debug info.
>=20
> I am having problems with the keyboard not reconnecting on reboot when
> hciattach switches the internal dongle from USB HID emulation to HCI.
>=20
> The Lower level layer is definitely connected, but the keyboard events
> are not generating keyboard input at all.  I have to switch the keyboard
> off, and then switch it back on, and it renegotiates, and it all starts
> working.
>=20
> This test is not using security mode 3 yet, though I will be doing this
> to prevent people sniffing passwords.... but the same problem happens
> then.
>=20
> When I boot from OS X back into Linux, the problem does not occur.
>=20
> I have attached the hcidump binary session data so that you can all look
> at it.  If it does not turn up on the mailing list, please email me to
> send it to you.  My hcid.conf is included down the bottom.
>=20
> Here is the screen session I did when playing with keyboard, while using
> an ordinary USB keyboard:
>=20
> root@sharon:/home/grantma#
> # hcitool con
> Connections:
>         > ACL 00:0A:95:3B:0B:49 handle 46 state 1 lm MASTER
>=20
> root@sharon:/home/grantma#
> # hcitool dc 00:0A:95:3B:0B:49
> Disconnect failed: Connection timed out
>=20
> root@sharon:/home/grantma#
> # hcitool dc 00:0A:95:3B:0B:49
> Not connected.
>=20
> root@sharon:/home/grantma#
> # hcitool con
> Connections:
>=20
> root@sharon:/home/grantma#
> # hcitool con
> Connections:
>         > ACL 00:0A:95:3B:0B:49 handle 47 state 1 lm MASTER
>=20
> root@sharon:/home/grantma#
> # hcitool con
> Connections:
>         > ACL 00:0A:95:3B:0B:49 handle 47 state 1 lm MASTER
>=20
> root@sharon:/home/grantma#
> #
>=20
> This is the output of hcidump 1.12  (hcidump -X) when I start trying to
> use the keyboard:
>=20
> HCIDump - HCI packet analyzer ver 1.12
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 58 00 00 00  00 00                    ....X.....
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 58 00 00 00  00 00                    ....X.....
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 58 00 00 00  00 00                    ....X.....
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 58 00 00 00  00 00                    ....X.....
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 58 00 00 00  00 00                    ....X.....
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 58 00 00 00  00 00                    ....X.....
> > ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 0]
>       0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   0000: 2e 00 13                                          ...
> > HCI Event: Command Status (0x0f) plen 4
>   0000: 00 01 06 04                                       ....
> > HCI Event: Disconn Complete (0x05) plen 4
>   0000: 00 2e 00 16                                       ....
> > HCI Event: Connect Request (0x04) plen 10
>   0000: 49 0b 3b 95 0a 00 40 25  00 01                    I.;...@%..
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   0000: 49 0b 3b 95 0a 00 00                              I.;....
> > HCI Event: Command Status (0x0f) plen 4
>   0000: 00 01 09 04                                       ....
> > HCI Event: Role Change (0x12) plen 8
>   0000: 00 49 0b 3b 95 0a 00 00                           .I.;....
> > HCI Event: Connect Complete (0x03) plen 11
>   0000: 00 2f 00 49 0b 3b 95 0a  00 01 00                 ./.I.;.....
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   0000: 2f 00 0f 00                                       /...
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>   0000: 49 0b 3b 95 0a 00 01                              I.;....
> > ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 17 scid 0x004d
> < ACL data: handle 0x002f flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004d result 0 status 0
> > HCI Event: Command Complete (0x0e) plen 6
>   0000: 01 0d 08 00 2f 00                                 ..../.
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>   0000: 2f 00 18 cc                                       /...
> > HCI Event: Command Status (0x0f) plen 4
>   0000: 00 01 0f 04                                       ....
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>   0000: 00 2f 00 18 00                                    ./...
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> < ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x004d flags 0x0000 result 0 clen 0
> < ACL data: handle 0x002f flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x004d flags 0x0000 clen 4
>     MTU 48=20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 1
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
>     MTU 48=20
> > ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 19 scid 0x004e
> < ACL data: handle 0x002f flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x004e result 0 status 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
> < ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x004e flags 0x0000 result 0 clen 0
> < ACL data: handle 0x002f flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x004e flags 0x0000 clen 4
>     MTU 48=20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 1
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
>     MTU 48=20
> < ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0042
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x004f scid 0x0042 result 0 status 0
> < ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x004f flags 0x0000 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > HCI Event: Mode Change (0x14) plen 6
>   0000: 00 2f 00 02 14 00                                 ./....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0042 flags 0x0000 result 0 clen 0
> > ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0042 flags 0x0000 clen 0
> < ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x004f flags 0x0000 result 0 clen 0
> < ACL data: handle 0x002f flags 0x02 dlen 24
>     L2CAP(d): cid 0x004f len 20 [psm 1]
>         SDP SSA Req: tid 0x0 len 0xf
>           pat uuid-16 0x1200 (PNPInfo)
>           max 0xffff
>           aid(s) 0x0000 - 0xffff
>           cont 00=20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 15
>     L2CAP(d): cid 0x0042 len 96 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x5b
>           cnt 0x58
>           srv rec #0
>             aid 0x0000 (SrvRecHndl)
>                uint 0x10001
>             aid 0x0001 (SrvClassIDList)
>                < uuid-16 0x1200 (PNPInfo) >
>             aid 0x0004 (ProtocolDescList)
>                < < uuid-16 0x0100 (L2CAP) uint 0x1 > <
>                uuid-16 0x0001 (SDP) > >
>             aid 0x0009 (BTProfileDescList)
>                < < uuid-16 0x1200 (PNPInfo) uint 0x100 > >
>             aid 0x0200 (VersionNumList)
>                uint 0x100
>             aid 0x0201 (SrvDBState)
>                uint 0x5ac
>             aid 0x0202 (unknown)
>                uint 0x208
>             aid 0x0203 (unknown)
>                uint 0x110
>             aid 0x0204 (unknown)
>                bool 0x1
>             aid 0x0205 (unknown)
>                uint 0x2
>=20
>           cont 00=20
> < ACL data: handle 0x002f flags 0x02 dlen 24
>     L2CAP(d): cid 0x004f len 20 [psm 1]
>         SDP SSA Req: tid 0x1 len 0xf
>           pat uuid-16 0x1124 (HID)
>           max 0xffff
>           aid(s) 0x0000 - 0xffff
>           cont 00=20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > HCI Event: Mode Change (0x14) plen 6
>   0000: 00 2f 00 00 00 00                                 ./....
> > ACL data: handle 0x002f flags 0x02 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 13
>     L2CAP(d): cid 0x0042 len 128 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x7b
>           cnt 0x76
>           srv rec #0
>             aid 0x0000 (SrvRecHndl)
>                uint 0x10000
>             aid 0x0001 (SrvClassIDList)
>                < uuid-16 0x1124 (HID) >
>             aid 0x0004 (ProtocolDescList)
>                < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
>                uuid-16 0x0011 (HIDP) > >
>             aid 0x0005 (BrwGrpList)
>                < uuid-16 0x1002 (PubBrwsGrp) >
>             aid 0x0006 (LangBaseAttrIDList)
>                < uint 0x656e uint 0x6a uint 0x100 >
>             aid 0x0009 (BTProfileDescList)
>                < < uuid-16 0x1124 (HID) uint 0x100 > >
>             aid 0x000d (IconURL)
>                < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011
> (HIDP) > > >
>             aid 0x0100 (SrvName)
>                str "Apple Wireless Key=02"
>=20
>           cont=20
> < ACL data: handle 0x002f flags 0x02 dlen 26
>     L2CAP(d): cid 0x004f len 22 [psm 1]
>         SDP SSA Req: tid 0x2 len 0x11
>           pat uuid-16 0x1124 (HID)
>           max 0xffff
>           aid(s) 0x0000 - 0xffff
>           cont 02 00 76=20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 13
>     L2CAP(d): cid 0x0042 len 128 [psm 1]
>         SDP SSA Rsp: tid 0x2 len 0x7b
>           cnt 0x76
>=20
> ERROR: Unexpected syntax
>           0000: 6f 61 72 64 09 01 01 25  17 41 70 70 6c 65 20 57=20
> oard...%.Apple W
>           0010: 69 72 65 6c 65 73 73 20  4b 65 79 62 6f 61 72 64=20
> ireless Keyboard
>           0020: 09 01 02 25 14 41 70 70  6c 65 20 43 6f 6d 70 75=20
> ...%.Apple Compu
>           0030: 74 65 72 2c 20 49 6e 63  2e 09 02 00 09 01 10 09  ter,
> Inc........
>           0040: 02 01 09 01 11 09 02 02  08 40 09 02 03 08 21 09=20
> .........@....!.
>           0050: 02 04 28 01 09 02 05 28  01 09 02 06 35 69 35 67=20
> ..(....(....5i5g
>           0060: 08 22 25 63 05 01 09 06  a1 01 85 01 05 07 19 e0=20
> ."%c............
>           0070: 29 e7 15 00 25 02 00 ec                         =20
> )...%...
>           cont 6F 61 72 64 09 01 01 25 17 41 70 70 6C 65 20 57 69 72 65
> 6C 65 73 73 20 4B 65 79 62 6F 61 72 64 09 01 02 25 14 41 70 70 6C 65 20
> 43 6F 6D 70 75 74 65 72 2C 20 49 6E 63 2E 09 02 00 09 01 10 09 02 01 09
> 01 11 09 02 02 08 40 09 02 03 08 21 09 02 04 28 01 09 02 05 28 01 09 02
> 06 35 69 35 67 08 22 25 63 05 01 09 06 A1 01 85 01 05 07 19 E0 29 E7 15
> 00 25 02 00 EC=20
> < ACL data: handle 0x002f flags 0x02 dlen 26
>     L2CAP(d): cid 0x004f len 22 [psm 1]
>         SDP SSA Req: tid 0x3 len 0x11
>           pat uuid-16 0x1124 (HID)
>           max 0xffff
>           aid(s) 0x0000 - 0xffff
>           cont 02 00 EC=20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 13
>     L2CAP(d): cid 0x0042 len 128 [psm 1]
>         SDP SSA Rsp: tid 0x3 len 0x7b
>           cnt 0x76
>=20
> ERROR: Unexpected syntax
>           0000: 75 01 95 08 81 02 75 08  95 01 81 01 75 01 95 05=20
> u.....u.....u...
>           0010: 05 08 19 01 29 05 91 02  75 03 95 01 91 01 75 08=20
> ....)...u.....u.
>           0020: 95 06 15 00 26 ff 00 05  07 19 00 2a ff 00 81 00=20
> ....&......*....
>           0030: 75 01 95 01 15 00 25 01  05 0c 09 b8 81 06 09 e2=20
> u.....%.........
>           0040: 81 06 09 e9 81 02 09 ea  81 02 75 01 95 04 81 01=20
> ..........u.....
>           0050: c0 09 02 07 35 08 35 06  09 04 09 09 01 00 09 02=20
> ....5.5.........
>           0060: 08 28 00 09 02 0a 28 01  09 02 0b 09 01 00 09 02=20
> .(....(.........
>           0070: 0c 09 1f 40 09 02 01 62                         =20
> ...@...b
>           cont 75 01 95 08 81 02 75 08 95 01 81 01 75 01 95 05 05 08 19
> 01 29 05 91 02 75 03 95 01 91 01 75 08 95 06 15 00 26 FF 00 05 07 19 00
> 2A FF 00 81 00 75 01 95 01 15 00 25 01 05 0C 09 B8 81 06 09 E2 81 06 09
> E9 81 02 09 EA 81 02 75 01 95 04 81 01 C0 09 02 07 35 08 35 06 09 04 09
> 09 01 00 09 02 08 28 00 09 02 0A 28 01 09 02 0B 09 01 00 09 02 0C 09 1F
> 40 09 02 01 62=20
> < ACL data: handle 0x002f flags 0x02 dlen 26
>     L2CAP(d): cid 0x004f len 22 [psm 1]
>         SDP SSA Req: tid 0x4 len 0x11
>           pat uuid-16 0x1124 (HID)
>           max 0xffff
>           aid(s) 0x0000 - 0xffff
>           cont 02 01 62=20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 17
> > ACL data: handle 0x002f flags 0x01 dlen 4
>     L2CAP(d): cid 0x0042 len 17 [psm 1]
>         SDP SSA Rsp: tid 0x4 len 0xc
>           cnt 0x9
>=20
> ERROR: Unexpected syntax
>           0000: 0d 28 01 09 02 0e 28 01  00                     =20
> .(....(..
>           cont 0D 28 01 09 02 0E 28 01 00=20
> < ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x004f scid 0x0042
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x004f scid 0x0042
> > HCI Event: Mode Change (0x14) plen 6
>   0000: 00 2f 00 02 14 00                                 ./....
> < ACL data: handle 0x002f flags 0x02 dlen 15
>     L2CAP(d): cid 0x004e len 11 [psm 19]
>       HIDP: Data: Output report
>       0000: 01 00 00 00 00 00 00 00  00 80                    ..........
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 2f 00 01 00                                    ./...
> > ACL data: handle 0x002f flags 0x02 dlen 5
>     L2CAP(d): cid 0x0040 len 1 [psm 17]
>       HIDP: Handshake: Unsupported request
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 58 00 00 00 00  00                       ...X.....
> > ACL data: handle 0x002f flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 01 00 00 00 00 00 00 00  00                       .........
>=20
>=20
> relevant dmesg output:
>=20
> PCI: Enabling device 0002:06:0e.0 (0000 -> 0002)
> ohci1394: fw-host0: Unexpected PCI resource length of 1000!
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[40]=20
> MMIO=3D[f5000000-f50007ff]  Max Packet=3D[4096]
> usb 3-1: new full speed USB device using address 4
> hub 3-1:1.0: USB hub found
> hub 3-1:1.0: 2 ports detected
> usb 2-1.2: new low speed USB device using address 5
> input: USB HID v1.00 Mouse [4D Mouse USB Mouse] on usb-0001:01:1b.0-1.2
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d93fffe436326]
> usb 3-1.1: new full speed USB device using address 5
> input: USB HID v1.10 Keyboard [BTC Multimedia USB Keyboard] on
> usb-0001:01:1b.1-1.1
> ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
> divert: not allocating divert_blk for non-ethernet device eth1
> ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> ip1394: eth1: Could not allocate isochronous receive context for the
> broadcast channel
> ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.=20
> http://snowman.net/projects/ipt_recent/
> PHY ID: 1410cc1, addr: 0
> eth0: Link is up at 100 Mbps, full-duplex.
> eth0: Pause is disabled
> hda: Set PIO timing for mode 0, reg: 0x08618a92
> usb 1-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0
> ret -110
> usb 1-1: USB disconnect, address 2
> drivers/usb/input/hid-core.c: can't resubmit intr,
> 0001:01:1a.0-1/input0, status -19
> drivers/usb/input/hid-core.c: can't resubmit intr,
> 0001:01:1a.0-1/input1, status -19
> usb 1-1: new full speed USB device using address 3
> drivers/usb/input/hid-input.c: event field not found
> net/bluetooth/hidp/hid.c: event field not found
>=20
>=20
> /etc/bluetooth/hcid.conf:
>=20
> #
> # HCI daemon configuration file.
> #
> # $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
> #
>=20
> # HCId options
> options {
> 	# Automatically initialize new devices
> 	autoinit yes;
>=20
> 	# Security Manager mode
> 	#   none - Security manager disabled
> 	#   auto - Use local PIN for incoming connections
> 	#   user - Always ask user for a PIN
> 	#
> 	security auto;
>=20
> 	# Pairing mode
> 	#   none  - Pairing disabled
> 	#   multi - Allow pairing with already paired devices
> 	#   once  - Pair once and deny successive attempts
> 	pairing multi;
>=20
> 	# PIN helper
> 	pin_helper /usr/local/bin/bluepin;
>=20
> 	# D-Bus PIN helper
> 	#dbus_pin_helper;
> }
>=20
> # Default settings for HCI devices
> device {
> 	# Local device name
> 	#   %d - device id
> 	#   %h - host name
> 	name "%h-%d";
>=20
> 	# Local device class
> 	class 0x100;
>=20
> 	# Default packet type
> 	#pkt_type DH1,DM1,HV1;
>=20
> 	# Inquiry and Page scan
> 	iscan enable; pscan enable;
>=20
> 	# Default link mode
> 	#   none   - no specific policy=20
> 	#   accept - always accept incoming connections
> 	#   master - become master on incoming connections,
> 	#            deny role switch on outgoing connections
> 	#
> 	#lm accept,master;
> 	#
> 	lm accept;
>=20
> 	# Default link policy
> 	#   none    - no specific policy
> 	#   rswitch - allow role switch
> 	#   hold    - allow hold mode
> 	#   sniff   - allow sniff mode
> 	#   park    - allow park mode
> 	#
> 	#lp hold,sniff;
> 	#
> 	lp rswitch,hold,sniff,park;
>=20
> 	# Authentication and Encryption
> 	#auth enable;
> 	#encrypt enable;
> }
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-upjzxz2j9ddE5tkkH8JE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBfCe4uk55Di7iAnARAtqnAJ9PdzgFFefClZ83xk+qRg91Bs0llwCaAzN/
jn0w4O7oQ5BXlGU/D+tsHO0=
=jJOR
-----END PGP SIGNATURE-----

--=-upjzxz2j9ddE5tkkH8JE--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
