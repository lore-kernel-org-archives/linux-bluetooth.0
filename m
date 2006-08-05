Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 5 Aug 2006 12:37:37 +0200
From: Jimmi <jimmi@libero.it>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060805103737.GB6035@jimmi.home>
MIME-Version: 1.0
Subject: [Bluez-users] Again down with Jabra BT250V
Reply-To: jimmi@libero.it, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi everybody,

It happened already, but the previous  times I found always some "magic"
procedure to get out. This time it seems I cannot :(

I'm using  almost the same  configuration of Sweta (bluez-devel)  with a
dongle DLink DBT120 Rev  B4 and a Jabra BT250v, the OS  is a Debian Sid,
and I use btsco 0.42. My  error is slightly different: "Error: Failed to
connect to SDP Iserver: Permission denied"

I  got  the  same  problem  several  times  in  past,  almost  everytime
the  kernel  changed (actual  is  a  2.6.16-2-k7)  but by  deleting  the
/var/lib/bluetooth/00:11:95:7D:83:E9 and restarting the bluetooth daemon
(sometimes several times  in different order) I could  always obtain the
headset  working. This  time it  seems  not anymore  possible. I  attach
herebelow some output:

$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:95:7D:83:E9 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:413 acl:0 sco:0 events:19 errors:0
        TX bytes:320 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'Titanic-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

$ hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:11:95:7D:83:E9 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

$ hcitool scan
Scanning ...
        00:07:A4:14:0F:BF       Jabra BT 250v

$ hcitool info 00:07:A4:14:0F:BF
Requesting information ...
Can't create connection: Input/output error

The corresponding output of $hcidump -X -V -i hci0 is:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:A4:14:0F:BF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:07:A4:14:0F:BF
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:07:A4:14:0F:BF
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:07:A4:14:0F:BF
> HCI Event: Connect Complete (0x03) plen 11
    status 0x18 handle 41 bdaddr 00:07:A4:14:0F:BF type ACL encrypt 0x00
    Error: Pairing Not Allowed

$btsco 00:07:A4:14:0F:BF
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Can't connect RFCOMM channel: Permission denied

The corresponding output of $hcidump -X -V -i hci0 is:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:A4:14:0F:BF ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:07:A4:14:0F:BF
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:07:A4:14:0F:BF
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:07:A4:14:0F:BF
> HCI Event: Connect Complete (0x03) plen 11
    status 0x18 handle 41 bdaddr 00:07:A4:14:0F:BF type ACL encrypt 0x00
    Error: Pairing Not Allowed
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:A4:14:0F:BF ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:07:A4:14:0F:BF
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:07:A4:14:0F:BF
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:07:A4:14:0F:BF
> HCI Event: Connect Complete (0x03) plen 11
    status 0x18 handle 42 bdaddr 00:07:A4:14:0F:BF type ACL encrypt 0x00
    Error: Pairing Not Allowed
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 2

I didn't  change anything  in my  configuration, and  I also  many times
send  in  different  orders  "esdctl stop"  and  "hciconfig  hci0  voice
0x0060", together with deleting the /var/lib/bluetooth/00:11:95:7D:83:E9
directory and restaring the bluetooth daemon, of course with the headset
in pairing mode. Is there anything else I may try ?

Thanks for everything ;)
-- 
   ---         _   o       |   Ho fatto l'amore con Control, domani    |
   / immi   ---  _/\_>     |         provo anche con Alt-Canc.         |
(_/          -  O,> / O    |                                           |

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
