Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1129927260.4359525c08ece@cubmail.cc.columbia.edu>
From: mv2147@columbia.edu
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] BT007si and BT400 G5
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
Date: Fri, 21 Oct 2005 16:41:00 -0400


Dear Bluez users,

   I am trying to get the Bluetake BT400 G5 headset working with the
BT007si bluetake usb dongle on linux 2.6.11.. First of all I am
interested to know if full support exists for the two? I am able to
discover the headset and am able to l2ping other devices but am not
able to establish a SCO connection with the headset..
My HCI dump looks as below:

HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:3A:06:CA:78 ptype 0xcc18 rswitch 0x01 clkoffset
0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6

& hciconfig hci0 revision was returning "unsupported manufacturer"
instead of "SCO mapping : HCI"

Can somebody please help me out with useful information?

Below is the complete log which may help somebody in helping me
out.............................................................
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
[root@localhost ~]# hciconfig hci0 up
[root@localhost ~]# /etc/init.d/bluetooth start
Starting Bluetooth services:                               [  OK  ]
[root@localhost ~]# hciconfig hci0 voice 0x0060
[root@localhost ~]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:0D:06:9B:3B ACL MTU: 120:20 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:390 acl:0 sco:0 events:18 errors:0
        TX bytes:69 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: ''
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP
Subver: 0x757
        Manufacturer: Silicon Wave (11)
[root@localhost ~]# hcitool scan
Scanning ...
        00:0A:3A:06:CA:78       BT400 G5
[root@localhost ~]# sdptool add HS
Headset service registered
[root@localhost ~]# btsco 00:0A:3A:06:CA:78
Error: Failed to connect to SDP server: Connection timed out
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable

kernel messages in /var/log/messages

Oct 16 01:18:39 localhost kernel: usb 4-2: new full speed USB device
using uhci_hcd and address 16
on inserting the dongle***
Oct 16 01:25:35 localhost hcid[10285]: Bluetooth HCI daemon
Oct 16 01:25:35 localhost sdpd[10287]: Bluetooth SDP daemon
Oct 16 01:25:35 localhost hcid[10285]: Starting security manager 0
on running hcid & sdpd daemons***

I will be very glad if someone can inform me what could be going
wrong by seeing the hcidump I have shown in the beginning or if the
devices are not fully supported, please tell me some dongles and
headset which work on linux 2.6

Thanks a lot.

Manmohan Voniyadka


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
