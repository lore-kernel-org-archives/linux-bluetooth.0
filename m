Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Moran" <moran@moozatech.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
In-Reply-To: <1101664326.18467.56.camel@pegasus>
Message-ID: <E1CYXHQ-0006VU-6W@sc8-sf-mx2.sourceforge.net>
Subject: [Bluez-users] Broadcomm usb dongle problems.
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
Date: Mon, 29 Nov 2004 00:10:49 +0200

Hi,
Well it looks like that from the all dongles in the world I bought the one
that is have problems.

I will appreciate any help with this issue.

Here is the info:

[root@anubis ~]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:55:FA:3E:21 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING
        RX bytes:159 acl:0 sco:0 events:23 errors:0
        TX bytes:837 acl:0 sco:0 commands:23 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
Can't read local name on hci0. Input/output error(5)
[root@anubis ~]# hcid -n
hcid[8179]: Bluetooth HCI daemon
hcid[8179]: Starting security manager 0
hcid[8181]: Can't set scan mode on hci0. Device or resource busy(16)
hcid[8181]: Can't set auth on hci0. Device or resource busy(16)
hcid[8181]: Can't set encrypt on hci0. Device or resource busy(16)
hcid[8179]: Exit.
[root@anubis ~]# lsusb
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 006: ID 0a5c:3503 Broadcom Corp.
Bus 002 Device 005: ID 0a5c:3502 Broadcom Corp.
Bus 002 Device 004: ID 0a5c:2009 Broadcom Corp.
Bus 002 Device 003: ID 0a5c:3535 Broadcom Corp.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
[root@anubis ~]# hcitool scan
Scanning ...
Inquiry failed: Connection timed out
[root@anubis ~]# hciconfig version
hci0:   Type: USB
        BD Address: 00:0C:55:FA:3E:21 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING
        RX bytes:201 acl:0 sco:0 events:30 errors:0
        TX bytes:1117 acl:0 sco:0 commands:30 errors:0



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
