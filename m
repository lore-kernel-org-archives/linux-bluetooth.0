Return-Path: <cyrus@holtmann.org>
From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Question about HID proxy firmware
Date: Wed, 12 May 2010 13:14:00 +0200
MIME-Version: 1.0
Message-Id: <201005121314.01059.jkrzyszt@tis.icnet.pl>
Content-Type: text/plain;
  charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Sorry for bothering linux bluetooth developers with my problem, but I was not 
able to find any active users list.

I have this device plugged into my workstation:

# dmesg
...
usb 4-1: new full speed USB device using uhci_hcd and address 9
usb 4-1: New USB device found, idVendor=04bf, idProduct=0320
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-1: Product: Turbo Bluetooth Adapter
usb 4-1: Manufacturer: Ezurio
...
# lsusb
...
Bus 004 Device 009: ID 04bf:0320 TDK Corp. Bluetooth Adapter
...
# hciconfig hci0 version
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:80:98:97:6A:15  ACL MTU: 384:8  SCO MTU: 64:8
        HCI Version: 2.0 (0x3)  Revision: 0xa5c
        LMP Version: 2.0 (0x3)  Subversion: 0xa5c
        Manufacturer: Cambridge Silicon Radio (10)
# bccmd chiprev
Chip revision: 0x0026 (BC4-External)
# hciconfig hci0 revision
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:80:98:97:6A:15  ACL MTU: 384:8  SCO MTU: 64:8
        Unified 21c
        Chip version: BlueCore4-External
        Max key size: 128 bit
        SCO mapping:  HCI
# bccmd buildname
Build name: cyt_8unified_fl_bt2.0_21_0510281131_encr128 2005-11-07
# 
# dfutool archive /tmp/ezurio.dfu
Available devices with DFU support:

         1) Bus 004 Device 002: ID 04bf:0320 Interface 2

Select device (abort with 0): 1

Firmware upload ... 674148 bytes
vclass ~ #  dfutool verify /tmp/ezurio.dfu
Filename        ezurio.dfu
Filesize        674164
Checksum        0f26e33d

DFU suffix      52 26 20 03 bf 04 00 01 55 46 44 10 3d e3 26 0f

idVendor        04bf
idProduct       0320
bcdDevice       2652

bcdDFU          1.0
ucDfuSignature  DFU
bLength         16
dwCRC           0f26e33d

Firmware type   CSR-dfu2
Firmware check  valid checksum


AFAICT, the device firmware doesn't provide HID proxy functionality, that I 
would find rather usefull if present.

Is it possible to replace the device's firmware with one that can act as HID 
proxy? Is Apple BluetoothFirmwareUpdate2.0.1.dmg provided GenericCSR.dfu 
firmware compatible with BlueCore4? If not, what are my options?

Thanks,
Janusz
