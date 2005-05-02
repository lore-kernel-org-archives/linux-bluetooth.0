Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <RJenster@web.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] authentication problem - link_key prevents from pairing
References: <Pine.LNX.4.30.0505011025590.18702-100000@stealth.kirenet.com> <200505012210.59716.RJenster@web.de> <1114989560.21785.82.camel@pegasus>
In-Reply-To: <1114989560.21785.82.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I6gdCKz/yTtXILU"
Message-Id: <200505021327.04496.RJenster@web.de>
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
Date: Mon, 2 May 2005 13:27:04 +0200

--Boundary-00=_I6gdCKz/yTtXILU
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 02 May 2005 01:19, Marcel Holtmann wrote:
> Hi Ruben,
>
> > I've a really enerving problem.
> >
> > On my desktop I'm not able to pair my headset without
> > deleting /etc/bluetooth/link_key. After deleting the link_key
> > the pinhelper pops up and asks for the pin. I insert them and
> > I'm able to connect.
>
> use the latest BlueZ utilities and run "hcidump -X -V" as root, so we
> can see what is going on.

Ok, I've attached the hcidump output 

test sequence:
deleting link_key (if existent)
pair with  headset (btsco2 00:0D:B5:80:21:04 )
	success -> successfull attempt (after having link_key deleted)
switching headset off
pair with  headset (btsco2 00:0D:B5:80:21:04 )
	failure -> authentication problem (when not having link_key deleted)

Regards

Ruben

>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
a bug a day keeps the boredom away

-- 
a bug a day keeps the boredom away

--Boundary-00=_I6gdCKz/yTtXILU
Content-Type: text/plain;
  charset="iso-8859-15";
  name="failure"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="failure"

HCI sniffer - Bluetooth packet analyzer ver 1.20
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:B5:80:21:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -79
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 b1                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -71
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 b9                                       ....
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:B5:80:21:04
    Link key: 3a0b633d4f2fae8b4d8df66ccee1f766
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:B5:80:21:04
    Link key: 3a0b633d4f2fae8b4d8df66ccee1f766
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:0D:B5:80:21:04 type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:B5:80:21:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -63
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 c1                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -56
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 c8                                       ....
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:B5:80:21:04
    Link key: 3a0b633d4f2fae8b4d8df66ccee1f766
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:B5:80:21:04
    Link key: 3a0b633d4f2fae8b4d8df66ccee1f766
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -48
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 d0                                       ....
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 42 bdaddr 00:0D:B5:80:21:04 type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:B5:80:21:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -25
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 e7                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -18
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 ef                                       ....
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:B5:80:21:04
    Link key: 3a0b633d4f2fae8b4d8df66ccee1f766
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:B5:80:21:04
    Link key: 3a0b633d4f2fae8b4d8df66ccee1f766
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -10
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 f6                                       ....
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 43 bdaddr 00:0D:B5:80:21:04 type ACL encrypt 0x00
    Error: Authentication Failure

--Boundary-00=_I6gdCKz/yTtXILU
Content-Type: text/plain;
  charset="iso-8859-15";
  name="success"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="success"

HCI sniffer - Bluetooth packet analyzer ver 1.20
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:B5:80:21:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -39
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 d9                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -31
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 e1                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -24
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 e9                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -16
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 f0                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -8
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 f8                                       ....
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi -1
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 ff                                       ....
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:0D:B5:80:21:04
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:B5:80:21:04
    Link key: 9e4a271a86f19fbc2574dd53cb0db94c
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0D:B5:80:21:04
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:0D:B5:80:21:04 len 4 pin '1234'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:0D:B5:80:21:04 len 4 pin '1234'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:0D:B5:80:21:04
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x02 handle 0 rssi 7
    Error: Unknown Connection Identifier
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 0
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 02 00 00 07                                       ....
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:0D:B5:80:21:04 type 0x00
    Link key: 3a0b633d4f2fae8b4d8df66ccee1f766
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0D:B5:80:21:04 type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:0D:B5:80:21:04 mode 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48=20
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0042 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 36
< ACL data: handle 41 flags 0x02 dlen 26
    L2CAP(d): cid 0x0042 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 36
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 4
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
> ACL data: handle 41 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 10
< ACL data: handle 41 flags 0x02 dlen 26
    L2CAP(d): cid 0x0042 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 10
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 28
    L2CAP(d): cid 0x0040 len 24 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x13
          count 16
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
                 str "BT808 Headset"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
      MTU 1024=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1024=20
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0043 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=20
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 4
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=20
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd=20
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0041
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..

--Boundary-00=_I6gdCKz/yTtXILU--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
