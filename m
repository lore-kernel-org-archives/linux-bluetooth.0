Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Thu, 17 Dec 2015 16:20:36 +0000
Message-ID: <bug-100461-62941-OwYgG0IQEv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

Luka Karinja <luka.karinja@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|4.1                         |4.2.3

--- Comment #2 from Luka Karinja <luka.karinja@gmail.com> ---
I've been trying to get the bluetooth working on the T100TAF.

i've added the device ACPI BCM2E65 to hci_bcm.c
the bcm_uart_subver_table is already there for the device 0x410e,"BCM43341B0"

[pinkflozd@Bazdara-T100TAF ~]$ sudo btattach --bredr /dev/ttyS4 -P bcm
Attaching BR/EDR controller to /dev/ttyS4
Switched line discipline from 0 to 15
Device index 1 attached 

[pinkflozd@Bazdara-T100TAF ~]$ dmesg
[    4.953121] Bluetooth: Core ver 2.20
[    4.953164] NET: Registered protocol family 31
[    4.953170] Bluetooth: HCI device and connection manager initialized
[    4.953181] Bluetooth: HCI socket layer initialized
[    4.953189] Bluetooth: L2CAP socket layer initialized
[    4.953208] Bluetooth: SCO socket layer initialized
[    5.065752] Bluetooth: HCI UART driver ver 2.3
[    5.065762] Bluetooth: HCI UART protocol H4 registered
[    5.065766] Bluetooth: HCI UART protocol BCSP registered
[    5.065770] Bluetooth: HCI UART protocol LL registered
[    5.065773] Bluetooth: HCI UART protocol ATH3K registered
[    5.065777] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    5.065874] Bluetooth: HCI UART protocol Intel registered
[    5.078686] hci_bcm BCM2E65:00: BCM2E65:00 device registered.
[    5.078806] Bluetooth: HCI UART protocol BCM registered
[    5.078815] Bluetooth: HCI UART protocol QCA registered
[    5.105165] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[   56.114071] Bluetooth: hci1: BCM: chip id 82
[   56.114084] Bluetooth: hci1: BCM43341B0 (002.001.014) build 0000
[   56.638484] Bluetooth: hci1: BCM (002.001.014) build 0146 

Firmware seems to load

[pinkflozd@Bazdara-T100TAF ~]$ hciconfig -a
hci1:    Type: BR/EDR  Bus: UART
    BD Address: 43:34:1B:00:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
    UP RUNNING
    RX bytes:10413 acl:21 sco:0 events:630 errors:0
    TX bytes:44957 acl:21 sco:0 commands:553 errors:0
    Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH SNIFF
    Link mode: SLAVE ACCEPT
    Name: 'BCM43341B0 37.4 MHz Class 1 WLBGA iTR'
    Class: 0x000000
    Service Classes: Unspecified
    Device Class: Miscellaneous,
    HCI Version: 4.0 (0x6)  Revision: 0x92
    LMP Version: 4.0 (0x6)  Subversion: 0x410e
    Manufacturer: Broadcom Corporation (15)


[pinkflozd@Bazdara-T100TAF ~]$ hcitool scan
Scanning ...
    F8:E0:79:B3:C3:A7    Moto G

hcitool cc F8:E0:79:B3:C3:A7 

shows no error but doesnt connect to devices, its also not visible to other
devices

How can i further debug it?

Should i also add this device to btbcm_initialize() and btbcm_check_bdaddr()?

-- 
You are receiving this mail because:
You are the assignee for the bug.
