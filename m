Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 19 Feb 2007 08:47:15 -0800 (PST)
From: tim culwins <mail0123456789101112@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1171874409.26567.3.camel@violet>
MIME-Version: 1.0
Message-ID: <575664.66074.qm@web31705.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] mouse wont connect...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

cool really appreciate the help. 
Looks like the mouse is connecting but the connection
is being refused...
I played around with hciconfig but no dice. 

here are my settings and hcidump:
hci0:   Type: USB
        BD Address: 00:11:67:4F:EE:F9 ACL MTU: 678:8
SCO MTU: 64:10
        UP RUNNING PSCAN ISCAN 
        RX bytes:50753 acl:439 sco:0 events:1486
errors:0
        TX bytes:7768 acl:125 sco:0 commands:530
errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'arc-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering,
Capturing, Object Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2
(0x2) LMP Subver: 0x1fe
        Manufacturer: Integrated System Solution Corp.
(57)

HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0A:94:C1:B6:12 class 0x002580 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
    bdaddr 00:0A:94:C1:B6:12 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status
0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:0A:94:C1:B6:12 type
ACL encrypt 0x00
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
< HCI Command: Change Connection Packet Type
(0x01|0x000f) plen 4
    handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status
0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen
10
    bdaddr 00:0A:94:C1:B6:12 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd
1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x008c
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x008c
result 2 status 0
      Connection refused - PSM not supported
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0A:94:C1:B6:12 name
'Bluetooth Mouse'
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 1 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 11250
    Delay variation: -1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection






--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Tim
> 
> > so after uninstalling and reinstalling bluez-utils
> 3.7
> > i can connect using sudo hidd --search
> > but i cant auto reconnect. im in discoverable
> mode.
> > and when i move the mouse the little light on the
> > dongle flashes like its trying to connect but the
> > mouse pointer just wont move...
> 
> you don't have to be discoverable for re-connect.
> That is a
> misconception. You only have to be connectable.
> Check with hciconfig.
> You also should run "hcidump -X -V" to see if the
> mouse actually
> connects back or not.
> 
> Regards
> 
> Marcel
> 
> 
> 
>
-------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get
> the chance to share your
> opinions on IT & business topics through brief
> surveys-and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
