Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Michaels <nathan@humanyze.com>
Date: Mon, 31 Jul 2017 13:57:10 -0400
Message-ID: <CAA-8RaURbC=BziuWi1cZ6gjapVjC_KUL7dqPE288naG_uoz-Og@mail.gmail.com>
Subject: PAN on Raspberry Pi with BlueZ 5.23
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to set up a PAN between two Raspberry Pi 3s running
Raspbian. Packages and versions are below[1]. When I run the
test-network script on one of them, I get this error message:

dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with
signature "s" on interface "org.bluez.Network1" doesn't exist

I've also tried to run "bt-network -c $MASTER_ADDR panu" on the same
system, and gotten this output:

**
ERROR:lib/bluez/device.c:165:device_get_dbus_object_path: assertion
failed: (DEVICE_IS(self))
Aborted

I have set the link mode on the NAP to "master,accept" and on the PANU
to "slave,accept" and I've set both interfaces to up using hciconfig.

Does anyone know what could be going on? I don't see any packets in
btmon. My hciconfig for the slave[2] and master[3] are below. I did
briefly try with an external bluetooth module from a different
manufacturer, but it didn't seem to do anything different.




[1]
ii  bluez                                 5.23-2+rpi2
             armhf        Bluetooth tools and daemons
ii  bluez-firmware                        1.2-3+rpi1
             all          Firmware for Bluetooth devices
ii  bluez-hcidump                         5.23-2+rpi2
             armhf        Analyses Bluetooth HCI packets
ii  bluez-obexd                           5.23-2+rpi2
             armhf        bluez obex daemon
ii  bluez-test-scripts                    5.23-2+rpi2
             all          BlueZ test scripts
ii  bluez-tools                           0.2.0~20140808-3
             armhf        Set of tools to manage Bluetooth devices for
linux
ii  python-bluez                          0.20-1
             armhf        Python wrappers around BlueZ for rapid
bluetooth development


[2]
hci0:   Type: BR/EDR  Bus: UART
        BD Address: B8:27:EB:6C:CE:26  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING PSCAN
        RX bytes:8330 acl:36 sco:0 events:294 errors:0
        TX bytes:7029 acl:36 sco:0 commands:213 errors:0
        Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH SNIFF
        Link mode: SLAVE ACCEPT
        Name: 'raspberrypi'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Version: 4.1 (0x7)  Revision: 0xb6
        LMP Version: 4.1 (0x7)  Subversion: 0x2209
        Manufacturer: Broadcom Corporation (15)

[3]
hci0:   Type: BR/EDR  Bus: UART
        BD Address: B8:27:EB:99:1C:22  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING PSCAN ISCAN
        RX bytes:2582 acl:0 sco:0 events:99 errors:0
        TX bytes:2406 acl:0 sco:0 commands:98 errors:0
        Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH SNIFF
        Link mode: ACCEPT MASTER
        Name: 'raspberrypi'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Version: 4.1 (0x7)  Revision: 0xb6
        LMP Version: 4.1 (0x7)  Subversion: 0x2209
        Manufacturer: Broadcom Corporation (15)
