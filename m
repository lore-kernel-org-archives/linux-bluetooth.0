Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <9c68c0a70510292205td65b49bw@mail.gmail.com>
From: liang liping <lianglip@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] pair problem
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
Date: Sun, 30 Oct 2005 13:05:18 +0800

Hi

I can't pair my usb adapter with my phone(nokia 6670).
my kernel is 2.6.11

hcid.conf:
options {
        autoinit yes;

        security auto;

        pairing multi;

        pin_helper /etc/bluetooth/mypin;
}

device {

        name "aa (%d)";

        class 0x3e0100;

        iscan enable; pscan enable;

=09lm accept;

=09lp rswitch,hold,sniff,park;
}

and the file mypin :

#!/bin/sh
echo "PIN:1234"

the print of hcidump -X -V:

CI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0E:ED:F5:E5:48 class 0x50020c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0E:ED:F5:E5:48 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:0E:ED:F5:E5:48 type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004f
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004f result 0 status 0
      Connection successful
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004f flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004f flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0E:ED:F5:E5:48
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:0E:ED:F5:E5:48 len 5 pin 'BlueZ'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:0E:ED:F5:E5:48
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:0E:ED:F5:E5:48 key 7785ACCE8DB45AEC0B972F51B5B2DD18 type 0
> HCI Event: Change Connection Link Key Complete (0x09) plen 3
    status 0x05 handle 1
    Error: Authentication Failure
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004f
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host

I uses bluez-utils-2.21.
can anyone tell me why?


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
