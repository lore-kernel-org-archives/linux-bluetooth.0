Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Chris Murphy <lists@colorremedies.com>
Date: Mon, 4 Jun 2018 15:32:17 -0600
Message-ID: <CAJCQCtQgVqYSsFOUh0JOv79kbhacUajFPwKZztZWxapy_gFqNw@mail.gmail.com>
Subject: constant bt mouse disconnects
To: Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Summary: Every 5-20 minutes, the bluetooth mouse stops working.
Unprompted, it will reconnect and start working again. There are no
bluetoothd or kernel messages at the time of the disconnect, only
after reconnecting and working again are there messages. At the time
of the reconnect, the GNOME bluetooth icon in the upper right menu bar
area vanishes for ~2 seconds and reappears. The disconnect lasts
perhaps 10-30 seconds (varies).

On the same hardware (same mouse and laptop), the problem doesn't
happen when running Windows 10. And with a different laptop (a Mac)
the problem doesn't happen when running macOS, but does happen when
running Fedora. So it seems like a bug somewhere on the Linux side of
things but getting more debug info on why this is happening is eluding
me.

Fedora 28
4.17.0-0.rc7.git1.1.fc29.x86_64 (happens with 4.16, 4.15, 4.14 kernels)
bluez-5.49-3.fc28.x86_64
gnome-bluetooth-3.28.0-1.fc28.x86_64

bluetoothd is running with -d option to get debugging info


[chris@f28h ~]$ sudo hciconfig -a
[sudo] password for chris:
hci0:    Type: Primary  Bus: USB
    BD Address: 00:C2:C6:F0:52:57  ACL MTU: 1021:4  SCO MTU: 96:6
    UP RUNNING PSCAN ISCAN
    RX bytes:1721145 acl:87464 sco:0 events:621 errors:0
    TX bytes:7108 acl:228 sco:0 commands:190 errors:0
    Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH SNIFF
    Link mode: SLAVE ACCEPT
    Name: 'f28h.local'
    Class: 0x0c010c
    Service Classes: Rendering, Capturing
    Device Class: Computer, Laptop
    HCI Version: 4.2 (0x8)  Revision: 0x100
    LMP Version: 4.2 (0x8)  Subversion: 0x100
    Manufacturer: Intel Corp. (2)

The mouse is an Apple MagicMouse.

bluetoothd and kernel except from journal:
https://drive.google.com/open?id=1V1Bxi0BIRi0z-Ck0cjTb1Yo3RApsKE8D

Full journal:
https://drive.google.com/open?id=1l-Dldi7TFpO_dtsGMBG3xTDRd0Cl3frD


Thanks


-- 
Chris Murphy
