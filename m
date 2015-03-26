Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 25 Mar 2015 22:56:58 -0600
Message-ID: <CALdogvEPfgXMB78dp0NjuSicGoGHOET1icdurmpSXpn4MphtrQ@mail.gmail.com>
Subject: CSR Radio Becomes Unresponsive
From: daron anderson <daronanderson7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am experiencing a Bluetooth radio failure on a CSR Bluetooth module
using kernel 3.10 and Bluez 5.29.  The radio I am using is a Bluegiga
WT21 USB radio which is hardwired to an internal USB bus inside an
Intermec CV61 mobile computer.  The failure results in the Bluetooth
radio being unresponsive after a reboot until the unit is powered down
and powered up again.  I have worked out a concise test case that
causes the failure to appear with details below.  There appears to be
other scenarios where the radio failure occurs, but this is the
simplest repeatable test case I have found.



lsusb reports:

Bus 005 Device 002: ID 0a12:0002 Cambridge Silicon Radio, Ltd
Frontline Test Equipment Bluetooth Device



I have a minimal RedHat RHEL 7 installed.  No GNOME or other desktop
is installed.  I removed the Bluez 4.101 rpms and built Bluez 5.29
from the raw source as follows:


[root@localhost ~]#  yum update
[root@localhost ~]#  reboot
….
[root@localhost ~]#  yum -y install readline-devel libical-devel
dbus-devel glib2-devel gcc kernel-headers kernel-devel
[root@localhost ~]#  yum erase "bluedevil*" "bluez*"
[root@localhost ~]#  wget
http://www.kernel.org/pub/linux/bluetooth/bluez-5.29.tar.xz
[root@localhost ~]#  tar xf bluez-5.29.tar.xz
[root@localhost ~]#  cd bluez-5.29
[root@localhost ~]#  ./configure --prefix=/usr --mandir=/usr/share/man
--sysconfdir=/etc --localstatedir=/var --disable-udev
[root@localhost ~]#  make
[root@localhost ~]#  make install


---------------------------------------------------

To reproduce the issue, I execute the following commands, then I set
up another Bluetooth device to attempt connections with the Intermec
CV61 device.  The peer device in the following test is an Intermec
SF61 barcode scanner, which uses a Bluegiga WT41 bluetooth module.
This device defaults to connect to its host and use SPP.  In this
test, I have disabled security on the SF61 unit so that no agent is
required.  The CV61 and SF61 both support Bluetooth 2.1+EDR.



[root@localhost ~]# hcidump > hcidump_$(date +%Y%m%d_%H%M%S_%N).txt &
[root@localhost ~]# /usr/libexec/bluetooth/bluetoothd --compat &
[root@localhost ~]# hciconfig hci0 up
[root@localhost ~]# sleep 2
[root@localhost ~]# hciconfig hci0 class 0x4a010c
[root@localhost ~]# hciconfig hci0 sspmode 0
[root@localhost ~]# sdptool add SP

[root@localhost ~]# hciconfig –a hci0
hci0:       Type: BR/EDR  Bus: USB
                BD Address: 00:10:40:57:B4:CA  ACL MTU: 310:10  SCO MTU: 64:8
                UP RUNNING PSCAN
                RX bytes:1582 acl:0 sco:0 events:55 errors:0
                TX bytes:1421 acl:0 sco:0 commands:53 errors:0
                Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
                Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
                Link policy: RSWITCH HOLD SNIFF PARK
                Link mode: SLAVE ACCEPT
                Name: 'localhost.localdomain-0'
                Class: 0x4a010c
                Service Classes: Networking, Capturing, Telephony
                Device Class: Computer, Laptop
                HCI Version: 2.1 (0x4)  Revision: 0x12e9
                LMP Version: 2.1 (0x4)  Subversion: 0x12e9
                Manufacturer: Cambridge Silicon Radio (10)


The SF61 attempts about 4 connections to the CV61 computer, but I have
no application listening to accept the connection attempts.  After
waiting several seconds, I run hciconfig hci0 down, then reboot.


[root@localhost ~]# hciconfig hci0 down
[root@localhost ~]# reboot

After rebooting the WT21 bluetooth module is unresponsive:

[root@localhost ~]# hciconfig –a hci0
hci0:       Type: BR/EDR  Bus: USB
                BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
                DOWN
                RX bytes:0 acl:0 sco:0 events:0 errors:0
                TX bytes:15 acl:0 sco:0 commands:5 errors:0
                Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
                Packet type: DM1 DH1 HV1
                Link policy:
                Link mode: SLAVE ACCEPT

[root@localhost ~]# hciconfig hci0 up

Can't init device hci0: Connection timed out (110)

After reboot, hcidump does not show any activity.

-----------------------------------------------------------


Below is an excerpt from hcidump before the failure occurs, which
shows the activity during a single connection attempt from the SF61
device to the CV61 device.  I have the full hcidump for all activity
between the “hciconfig hci0 up” and “hciconfig hci0 down” commands, if
it would be useful.





> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:07:80:73:2C:3D class 0x080500 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:07:80:73:2C:3D role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:07:80:73:2C:3D role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 37 bdaddr 00:07:80:73:2C:3D type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 37
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:07:80:73:2C:3D mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 37 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> ACL data: handle 37 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0380
< ACL data: handle 37 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0380 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 37 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 37
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
> ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0228
        Enhanced Retransmission mode
        FCS Option
        Unicast Connectless Data Reception
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 37 page 1
< ACL data: handle 37 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0380 result 0 status 0
      Connection successful
< ACL data: handle 37 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0380 flags 0x00 clen 11
      RFC 0x00 (Basic)
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 37 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 37 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0380 flags 0x00 result 0 clen 4
      MTU 48
> ACL data: handle 37 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> ACL data: handle 37 flags 0x02 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SSA Req: tid 0x1 len 0x1b
          pat uuid-128 00001101-0000-1000-8000-00805f9b34fb
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 37 flags 0x00 dlen 33
   L2CAP(d): cid 0x0380 len 29 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x18
          count 21
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> ACL data: handle 37 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x03c1
< ACL data: handle 37 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x03c1 result 2 status 0
      Connection refused - PSM not supported
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> ACL data: handle 37 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0380
< ACL data: handle 37 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0380
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 37 reason 0x13
    Reason: Remote User Terminated Connection

Thank you,
Daron
