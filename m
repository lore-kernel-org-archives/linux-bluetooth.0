Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Abraham J <coolguy8t0@gmail.com>
Date: Tue, 3 Apr 2018 02:10:40 +0530
Message-ID: <CALaCp02+sepRJnao5Uj0KmYcQ1fx2JEtLzemo-zEKhBZDyeRKg@mail.gmail.com>
Subject: RTL8723DE Bluetooth - hci0 didn't find patch for chip id 2
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is on a HP laptop (15-BS576TX) which has RTL8723DE Wifi/Bluetooth
module with lsusb listing hardware id as 0bda:b009 .WiFi is working
with recent rtl8723de module available through rtlwiifi-new (Larry
Fingers). Bluetooth is not working. Below is the error:

:~$ dmesg | egrep -i 'blue|firm'
[    0.069713] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.549796] [drm] Finished loading DMC firmware
i915/kbl_dmc_ver1_01.bin (v1.1)
[   11.785968] Bluetooth: Core ver 2.22
[   11.785983] Bluetooth: HCI device and connection manager initialized
[   11.785986] Bluetooth: HCI socket layer initialized
[   11.785989] Bluetooth: L2CAP socket layer initialized
[   11.785993] Bluetooth: SCO socket layer initialized
[   12.063954] Bluetooth: hci0: rtl: examining hci_ver=08 hci_rev=000d
lmp_ver=08 lmp_subver=8723
[   12.063955] Bluetooth: hci0: rtl: loading rtl_bt/rtl8723b_config.bin
[   12.256349] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[   12.256532] bluetooth hci0: Direct firmware load for
rtl_bt/rtl8723b_config.bin failed with error -2
[   12.256535] Bluetooth: hci0: rtl: loading rtl_bt/rtl8723b_fw.bin
[   12.260948] Bluetooth: hci0: rom_version status=0 version=2
[   12.260950] Bluetooth: hci0: didn't find patch for chip id 2
[   12.995106] rtl8723de: Using firmware rtlwifi/rtl8723defw.bin
[   23.841405] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   23.841406] Bluetooth: BNEP filters: protocol multicast
[   23.841409] Bluetooth: BNEP socket layer initialized


The firmware for RTL8723D is now available in
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=6d5131107f2ba67a13f469ac770a55f101ba654d

and the 3 firmware files downloaded through git are placed in:

/lib/firmware/rtl_bt/rtl8723d_fw.bin
/lib/firmware/rtl_bt/rtl8723d_config.bin
/lib/firmware/rtlwifi/rtl8723defw.bin

Besides, rtl8723b firmware also in the directory.

However, still, the error is showing that rtl8723b_config.bin is
missing. I am totally clueless regarding how to fix this. Kindly,
provide a solution for this chip id, as there are many new laptops now
carrying RTL8723D module.

Detailed lsusb -v -d 0bda:b009 https://pastebin.ca/3998303

The device is not soft locked, and hciconfig -a shows below:
:~$ hciconfig -a
hci0:    Type: Primary  Bus: USB
    BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
    DOWN
    RX bytes:21 acl:0 sco:0 events:2 errors:0
    TX bytes:6 acl:0 sco:0 commands:2 errors:0
    Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
    Packet type: DM1 DH1 HV1
    Link policy:
    Link mode: SLAVE ACCEPT



Thanks,
Abraham
