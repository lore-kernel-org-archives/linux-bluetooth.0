Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <eb18cd220706081620l7d270e03mcef1d32f8e51aadb@mail.gmail.com>
Date: Sat, 9 Jun 2007 01:20:37 +0200
From: "=?ISO-8859-1?Q?Jonas_H=E4ggqvist?=" <rasher@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problems pairing with phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I'm having problems pairing my phone and laptop (eventually to be used with
gammu). I'm using the version of bluez and utils currently in Ubuntu
"Gutsy" (development version). I installed bluez-gnome, dependencies and
some other bluez-related packages such as hcidump. I set up the dongle
using the GNOME bluetooth-applet and everything looks fine so far.

However, when I attempt to search for devices from my phone, it finds
nothing, and hcidump sees nothing during the search.

Any help would be appreciated. The phone and dongle has previously been
paired in Windows (using MS bt stack), so the hardware should not be the
problem.

-------------------------------------------------------------------------
The device is set up as follows:

jonas@isjtar:~$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:0D:18:01:11:AF ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2651 acl:0 sco:0 events:79 errors:0
        TX bytes:542 acl:0 sco:0 commands:48 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ISJTAR'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x36f LMP Ver: 1.1 (0x1) LMP Subver: 0x=
36f
        Manufacturer: Cambridge Silicon Radio (10)

jonas@isjtar:~$ hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0D:18:01:11:AF ACL MTU: 192:8 SCO MTU: 64:8
        Build 879

-------------------------------------------------------------------------
This is what the phone tells me:

jonas@isjtar:~$ sudo hcitool info 00:18:C5:88:FC:0A
Requesting information ...
        BD Address:  00:18:C5:88:FC:0A
        Device Name: Rasher
        LMP Version: 2.0 (0x3) LMP Subversion: 0x6cc
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbf 0xee 0x0f 0xc6 0x9a 0x39 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV3 packets> <u-law log>
                <A-law log> <CVSD> <paging scheme> <power control>
                <transparent SCO> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps>
                <inquiry with RSSI> <extended SCO> <EV5 packets>
                <AFH cap. slave> <AFH class. slave> <3-slot EDR ACL>
                <5-slot EDR ACL> <AFH cap. master> <AFH class. master>
                <EDR eSCO 2 Mbps>

-------------------------------------------------------------------------
While running "sudo hcitool cc 00:18:C5:88:FC:0A" I get the following
output from hcidump. The phone briefly flashes "ISJTAR" as an active
connection, then disconnects (I can't quite figure out what cc is
supposed to do - maybe it's not expected to do anything):

jonas@isjtar:~$ sudo hcidump -V -i hci0
HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:18:C5:88:FC:0A ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:18:C5:88:FC:0A type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:18:C5:88:FC:0A mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:18:C5:88:FC:0A mode 2 clkoffset 0x0000
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xbf 0xee 0x0f 0xc6 0x9a 0x39 0x00 0x00
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:18:C5:88:FC:0A name 'Rasher'
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host
-------------------------------------------------------------------------

I have the following related packages installed:
bluez-cups                                 3.9-0ubuntu4
bluez-gnome                                0.6-2ubuntu1
bluez-hcidump                              1.33-0ubuntu1
bluez-pin                                  0.30-2.1ubuntu3
bluez-utils                                3.9-0ubuntu4
libbluetooth2                              3.10-1

I'm running the stock Ubuntu kernel (2.6.22-6-generic)

-- =

Jonas H=E4ggqvist
rasher(at)rasher(dot)dk

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
