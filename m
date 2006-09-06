Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060906193158.36725.qmail@web51413.mail.yahoo.com>
Date: Wed, 6 Sep 2006 12:31:57 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200609062040.14856.cijoml@volny.cz>
MIME-Version: 1.0
Subject: [Bluez-users] Issue with connecting with RFCOMM channel
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

Hi All,

I am using DBT120 dongel and Motorola HS850. I am able
to connect with RFCOMM and SCO channels. But sometimes
i get following errors when i switch headset off and
on.
    
    Can't connect: Resource temporarily unavailable
(11)
Can't connect: Function not implemented (38)


 After this i have to remove the dongle and restart
the machine to get it to connect again.
Pls help.

thanks, Manoj

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 2
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:13:17:03:46:88
< HCI Command: Link Key Request Reply (0x01|0x000b)
plen 22
    bdaddr 00:13:17:03:46:88 key
21DE14F9AF754D7A12397056DE65F9AD
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:13:17:03:46:88
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
