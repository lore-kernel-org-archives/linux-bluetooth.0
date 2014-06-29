Return-Path: <cyrus@holtmann.org>
From: andrea <mariofutire@gmail.com>
Message-ID: <53B06189.20401@googlemail.com>
Date: Sun, 29 Jun 2014 19:57:13 +0100
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Subject: PS3 sixaxis BT 4.0 vs 2.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I would like to know if there is any chance of running a PS3 sixaxis controller with a BT dongle 2.0

I know it works well with BT 4.0 and bluez 5.18.
My hope that it works with a dongle 2.0 is because when I used to run sixad (before bluez 5.xx) it
worked well.

I've logged some data with 2 dongles hoping some of you guys can find what the difference is.
Basically the controller is paired well in both cases, it gets connected and creates a
/dev/input/js0 device.

The problem with 2.0 is that /dev/input/js0 does not produce much data. Just a few lines at the
begin and then nothing else. With 4.0 whenever I touch the buttons, more data is read from it.

I've logged data with

hcidump -X -w /tmp/b2.0.txt
and then processed it with
btmon -r b2.0.txt > b2.0.out.txt

I've uploaded the 4 files here

http://utente.xoom.it/depo/scambio/b2.0.txt
http://utente.xoom.it/depo/scambio/b2.0.out.txt
http://utente.xoom.it/depo/scambio/b4.0.txt
http://utente.xoom.it/depo/scambio/b4.0.out.txt

I've running these tests with

Linux thinkpad 3.14.8-200.fc20.i686 #1 SMP Mon Jun 16 22:36:56 UTC 2014 i686 i686 i386 GNU/Linux

and bluez 5.18

BT 2.0:

Bus 003 Device 010: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:15:83:0C:BF:EB  ACL MTU: 339:8  SCO MTU: 128:2
        HCI Version: 2.0 (0x3)  Revision: 0xc5c
        LMP Version: 2.0 (0x3)  Subversion: 0xc5c
        Manufacturer: Cambridge Silicon Radio (10)



BT 4.0

Bus 003 Device 011: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:1A:7D:DA:71:0B  ACL MTU: 310:10  SCO MTU: 64:8
        HCI Version: 4.0 (0x6)  Revision: 0x22bb
        LMP Version: 4.0 (0x6)  Subversion: 0x22bb
        Manufacturer: Cambridge Silicon Radio (10)

nothing strange (or different) is logged.
