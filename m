Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date: Sun, 12 Feb 2017 21:44:55 +0530
Message-ID: <CAEd-yTTD0TAE86Ts=Doa0QFcMk2_FARQmxVr5zia8eaJ=NZNDA@mail.gmail.com>
Subject: Bluez5.43 stack for bcm4334x chipset
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am working on Bluez5.43 stack, cross compiled for ARM v7 and
successfully compiled. also ported into the target device. I am using
Broadcom bluetooth chip (BCM4334x)The problem is when i do a hciconfig
i am getting the following result

# hciconfig
hci0: Type: Primary  Bus: UART
BD Address: 72:8E:6C:AB:DD:A4  ACL MTU: 1021:8  SCO MTU: 64:1
DOWN
RX bytes:647 acl:0 sco:0 events:32 errors:0
TX bytes:407 acl:0 sco:0 commands:32 errors:0

1)  I am not able to scan any devices.  what could be the possible
causes ? In my other bluetooth device it is detected as Bluetooth USB
Host Controller

2) But I am expecting the following result
# hciconfig
hci0:   Type: BR/EDR  Bus: UART
        BD Address: C4:00:49:00:06:D9  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING PSCAN ISCAN
        RX bytes:3640 acl:0 sco:0 events:317 errors:0
        TX bytes:43776 acl:0 sco:0 commands:311 errors:

What modifications I need to be done in hciattach_bcm4334x.c code
inorder to get the above output or I need to modify in some other
files of Bluez?

3) Is there any thing to do with this HCI type for scanning?

With Regards
Raja
