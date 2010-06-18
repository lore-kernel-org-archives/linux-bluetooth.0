Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 18 Jun 2010 15:29:41 +0300
Message-ID: <AANLkTin25xCMcVDCzbeXO-ZZfxhS4O0foXU8wl4h3tds@mail.gmail.com>
Subject: hci_scodata_packet: hci1 SCO packet for unknown connection handle 42
From: Andrei Moraru <andrei.moraru.n@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

the machine is running CentOS and Asterisk 1.4.32

there are installed bluez-4.66 and asterisk module chan_mobile

The Asterisk crashes sometimes when is using FXO over the bluetooth
connection via chan_mobile

uname -a:
2.6.18-164.el5 #1 SMP Thu Sep 3 03:33:56 EDT 2009 i686 athlon i386 GNU/Linux

[root@voip ~]# lsusb
Bus 001 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
Dongle (HCI mode)
Bus 004 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
Dongle (HCI mode)

the /var/log/messages
Jun 18 15:14:45 voip kernel: hci_scodata_packet: hci1 SCO packet for unknown
connection handle 42
Jun 18 15:14:45 voip kernel: hci_scodata_packet: hci1 SCO packet for unknown
connection handle 42
Jun 18 15:21:05 voip kernel: hci_scodata_packet: hci0 SCO packet for unknown
connection handle 42
Jun 18 15:21:05 voip last message repeated 2 times
Jun 18 15:21:21 voip kernel: hci_scodata_packet: hci0 SCO packet for unknown
connection handle 43
Jun 18 15:21:21 voip kernel: hci_scodata_packet: hci0 SCO packet for unknown
connection handle 43
Jun 18 15:22:02 voip kernel: hci_scodata_packet: hci0 SCO packet for unknown
connection handle 42
Jun 18 15:25:16 voip last message repeated 3 times


Please suggest your opinion.
