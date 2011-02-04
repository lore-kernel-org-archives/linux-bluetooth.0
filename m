Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Feb 2011 17:29:32 +0530
Message-ID: <AANLkTi=652bHGqL841fp1ufO1_7C3iTq+tZ4eBcGtEiO@mail.gmail.com>
Subject: Not able to test GATT on ubuntu
From: Vijayalakshmi N <vijayalakshmi.nk@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all,

I have taken the bluetooth code with BLE changes  (net/bluetooth and
include/net/bluetooth) from

http://git.infradead.org/users/vcgomes/linux-2.6.git/tree/refs/heads/le-l2cap
to my 2.6.35 kernel and built the kernel.

and also built bluez 4.84 on ubuntu 10.10.

Tried testing GATT with the gatttool that is available with the bluez.

gatttool --primary -b <bd-address>

gives me the following error:

 hci_acl_tx_to: hci0 ACL tx timeout
 hci_acl_tx_to: hci0 killing stalled ACL connection F5:61:0D:28:00:08
 hci_acl_tx_to: hci0 ACL tx timeout

This error occurs in both cases where there is an existing ACL
connection and no connection.

Other commands related to LE through hciconfig and hcitool work fine,
like hciconfig hciX leadv,
hcitool lescan, hcitool lecc, hcitool ledc.

But it seems like the GATT connection is not happening and thereby not
fetching me the required data.

Please let me know if anyone has come accross this problem and how to
get through this.

Please see the log (hcidump) of the Master BT device below followed by
the hcidump of Slave (GATT Server).

Thanks,
Vijayalakshmi

root@ubuntu-desktop:/home/ubuntu# hcitool lescan
LE Scan ...
08:00:28:0D:61:56
08:00:28:0D:61:56
08:00:28:0D:61:56
08:00:28:0D:61:56
^C
root@ubuntu-desktop:/home/ubuntu# hcidump -XVt &
[1] 9999
root@ubuntu-desktop:/home/ubuntu# HCI sniffer - Bluetooth packet
analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff

root@ubuntu-desktop:/home/ubuntu# hcitool lecc 08:00:28:0D:61:56
2000-01-01 05:41:44.057189 < HCI Command: Unknown (0x08|0x000d) plen 25
  0000: 04 00 04 00 00 00 56 61  0d 28 00 08 00 0f 00 0f  ......Va.(......
  0010: 00 00 00 80 0c 01 00 01  00                       .........
2000-01-01 05:41:44.098845 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x08|0x000d) status 0x00 ncmd 1
Connection handle 1025
2000-01-01 05:41:44.676970 > HCI Event: code 0x3e plen 19
  0000: 01 00 01 04 00 00 56 61  0d 28 00 08 0f 00 00 00  ......Va.(......
  0010: 80 0c 01                                          ...
root@ubuntu-desktop:/home/ubuntu# hcitool con
Connections:
        < LE 08:00:28:0D:61:56 handle 1025 state 1 lm MASTER
root@ubuntu-desktop:/home/ubuntu#
root@ubuntu-desktop:/home/ubuntu# gatttool --primary -b 08:00:28:0D:61:56
2000-01-01 05:42:37.480315 < HCI Command: Create Connection
(0x01|0x0005) plen 13
    bdaddr 08:00:28:0D:61:56 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2000-01-01 05:42:37.512938 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2000-01-01 05:42:41.114531 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 08:00:28:0D:61:56 type ACL encrypt 0x00
2000-01-01 05:42:41.114562 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2000-01-01 05:42:41.114653 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 1
2000-01-01 05:42:41.130370 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2000-01-01 05:42:41.130400 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
2000-01-01 05:42:41.130461 < HCI Command: Read Remote Extended
Features (0x01|0x001c) plen 3
    handle 1 page 1
2000-01-01 05:42:41.146117 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
2000-01-01 05:42:41.169188 > HCI Event: Read Remote Extended Features
(0x23) plen 13
    status 0x00 handle 1 page 1 max 1
    Features: 0x07 0x00 0x00 0x00 0x00 0x00 0x00 0x00
2000-01-01 05:42:41.169219 < HCI Command: Authentication Requested
(0x01|0x0011) plen 2
    handle 1
2000-01-01 05:42:41.184813 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2000-01-01 05:42:41.184844 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 08:00:28:0D:61:56
2000-01-01 05:42:41.185362 < HCI Command: Link Key Request Reply
(0x01|0x000b) plen 22
    bdaddr 08:00:28:0D:61:56 key 60CD21545C338F83BA01C22A9076D385
2000-01-01 05:42:41.202361 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 08:00:28:0D:61:56
2000-01-01 05:42:41.238310 > HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 1
2000-01-01 05:42:41.238371 < HCI Command: Set Connection Encryption
(0x01|0x0013) plen 3
    handle 1 encrypt 0x01
2000-01-01 05:42:41.254698 > HCI Event: Command Status (0x0f) plen 4
    Set Connection Ehci_acl_tx_to: hci0 ACL tx timeout
ncryption (0x01|hci_acl_tx_to: hci0 killing stalled ACL connection
56:61:0D:28:00:08
0x0013) status 0x00 ncmd 1
2000-01-01 05:42:41.294249 > HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
2000-01-01 05:42:41.294hci_acl_tx_to: hci0 ACL tx timeout
310 < ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2000-01-01 05:42:41.306822 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
2000-01-01 05:42:41.319548 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2000-01-01 05:42:41.319579 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2000-01-01 05:42:41.319609 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
Software caused connection abort (103)
root@ubuntu-desktop:/home/ubuntu#


-----------------------------------------------------SLAVE----------------------------------------

2000-01-01 08:34:45.474151 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 08:00:28:0D:61:F5 class 0x100100 type ACL
2000-01-01 08:34:45.474212 < HCI Command: Accept Connection Request
(0x01|0x0009) plen 7
    bdaddr 08:00:28:0D:61:F5 role 0x01
    Role: Slave
2000-01-01 08:34:45.489776 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2000-01-01 08:34:45.489806 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 08:00:28:0D:61:F5 type ACL encrypt 0x00
2000-01-01 08:34:45.489806 > HCI Event: Page Scan Repetition Mode
Change (0x20) plen 7
    bdaddr 08:00:28:0D:61:F5 mode 1
2000-01-01 08:34:45.489867 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 1
2000-01-01 08:34:45.505980 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2000-01-01 08:34:45.520995 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2000-01-01 08:34:45.520995 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
2000-01-01 08:34:45.521056 < HCI Command: Read Remote Extended
Features (0x01|0x001c) plen 3
    handle 1 page 1
2000-01-01 08:34:45.536590 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
2000-01-01 08:34:45.536620 > HCI Event: Read Remote Extended Features
(0x23) plen 13
    status 0x00 handle 1 page 1 max 1
    Features: 0x07 0x00 0x00 0x00 0x00 0x00 0x00 0x00
2000-01-01 08:34:45.615569 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 08:00:28:0D:61:F5
2000-01-01 08:34:45.615996 < HCI Command: Link Key Request Reply
(0x01|0x000b) plen 22
    bdaddr 08:00:28:0D:61:F5 key 60CD21545C338F83BA01C22A9076D385
2000-01-01 08:34:45.629546 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 08:00:28:0D:61:F5
2000-01-01 08:34:45.692809 > HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection F5:61:0D:28:00:08
2000-01-01 08:34:45.716308 > ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2000-01-01 08:34:45.716338 < ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
2000-01-01 08:34:45.726195 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
2000-01-01 08:34:45.740600 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2000-01-01 08:34:45.809996 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x02 handle 1 reason 0x00
    Error: Unknown Connection Identifier
2000-01-01 08:34:45.809996 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection
