Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sandro Weiser <sandro.weiser@gmx.de>
Reply-To: sandro.weiser@gmx.de
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200406201934.30037.sandro.weiser@gmx.de>
Cc: 
Content-Type: text/plain;
  charset="iso-8859-1"
Subject: [Bluez-users] BT mouse disconnect
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
Date: Sun, 20 Jun 2004 19:34:28 +0200

When I don't use my BT Mouse, the mouse disconnects after a certain period
when I use the hidp Module. After that the mouse isn't detectable anymore!
No reboot, no Linux or Windoof can detect the mouse anymore. Only removing
the batterys helps and after that the mouse works like before.
Note: the mouse is an Epox and switches completely of when it's not used.
I've to press one or more buttons to reenable the mouse. But when using the
hid-proxy of the adapter, that's no problem.

Can somebody please explain what I'm doing wrong or simply help?

hidd --show
00:04:61:81:76:D9 CSR HIDEngine Three Button Mouse [0000:0000] connected

hcitool info `cat /etc/bluetooth/Bluetooth-Mouse\ 8176D9`
Requesting information ...
        BD Address:  00:04:61:81:76:d9
        Device Name: Bluetooth-Mouse 8176D9
        LMP Version: 1.1 (0x1) LMP Subversion: 0x356
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <transparent SCO>

hciconfig -a
hci0:   Type: USB
        BD Address: 00:04:61:81:28:16 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:808820 acl:51762 sco:0 events:3379 errors:0
        TX bytes:5097 acl:228 sco:0 commands:51 errors:0
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'A31'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x360 LMP Ver: 1.1 (0x1) LMP Subver:
0x360
        Manufacturer: Cambridge Silicon Radio (10)

hcidump -x
> ACL data: handle 0x002d flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 0]
      A1 02 00 00 FF 00
> ACL data: handle 0x002d flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 0]
      A1 02 00 00 FF 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 14 00
> ACL data: handle 0x002d flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 0]
      A1 02 00 00 01 00
> ACL data: handle 0x002d flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 0]
      A1 02 00 00 01 00
> ACL data: handle 0x002d flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 0]
      A1 02 00 00 01 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 28 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 3C 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 50 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 64 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 78 00
> ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0044
< ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0044
< ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 14 00
> ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0043
< ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0043
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
> ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0040
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 00 00 00
> HCI Event: Mode Change(0x14) plen 6
  00 2D 00 02 78 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2D 00 13
> HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete(0x05) plen 4
  00 2D 00 16

--
Sandro Weiser <Sandro.Weiser@gmx.de>
Fingerprint: 77E0 7C87 4DB2 6BBB 5419  343C 7995 1C67 25B9 CBF1


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
