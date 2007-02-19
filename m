Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 19 Feb 2007 09:39:07 -0800 (PST)
From: tim culwins <mail0123456789101112@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1171905529.26567.25.camel@violet>
MIME-Version: 1.0
Message-ID: <986121.73512.qm@web31703.mail.mud.yahoo.com>
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

ok i ran sudo hidd --server and it tells me 
Can't listen on HID control channel: Address already
in use

i assume that means its already running.

but now im getting a different hcidump, looks like its
connecting but then something is terminating the
connection...

Thank you.

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
    L2CAP(s): Connect req: psm 17 scid 0x0062
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0062
result 0 status 0
      Connection successful
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
> ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0062 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0062 flags 0x00 clen
4
      MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0A:94:C1:B6:12 name
'Bluetooth Mouse'
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 1 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 11250
    Delay variation: -1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0063
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0063
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:0A:94:C1:B6:12 role 0x00
    Role: Master
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen
28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0063 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0063 flags 0x00 clen
4
      MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0063 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fe 00 00                            
       .....
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x02 interval 20
    Mode: Sniff
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0063 scid 0x0041
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0062 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0062 scid 0x0040
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x00 interval 65535
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x02 interval 40
    Mode: Sniff
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host






 
____________________________________________________________________________________
Get your own web address.  
Have a HUGE year through Yahoo! Small Business.
http://smallbusiness.yahoo.com/domains/?p=BESTDEAL

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
