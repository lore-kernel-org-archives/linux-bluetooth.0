Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20605030611y62ca1bejf69012ea7bf0e162@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Resource temporarily unavailable
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 3 May 2006 18:41:41 +0530

Hi guys,
Please provide me with a solution for this problem.... its high time
it gets resolved. Everytime I do a rfcomm connect frequently, I get
this
Resource temporarily unavailable error.


Client side::
root@bluetooth:~# hcidump -X -V &
[1] 3558
root@bluetooth:~# HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
./rfcomm-cl-o
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:09:DD:10:00:CC ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:09:DD:10:00:CC type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
uh oh: Resource temporarily unavailable
root@bluetooth:~# < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host


Server side:
root@bluetooth:~# ./rfcomm-ser-o
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:09:DD:10:00:CC ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:09:DD:10:00:CC type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host



ne ideas please help me out......  !!


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
