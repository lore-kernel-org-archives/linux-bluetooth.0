Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 8 May 2012 16:19:52 -0700
Message-ID: <CAPzrtORUXpjZqdHwEBg+X0rrs06-ji7KwWh552KLG7yxMqiu7A@mail.gmail.com>
Subject: bring up bluetooth on a MIPS embedded platform
From: LK Rashinkar <lk.rashinkar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: LK Rashinkar <lk.rashinkar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to bring up bluetooth on a MIPS embedded platform running
Linux Kernel 2.6.29.6-22. bluetooth has been enabled in the kernel
(not as modules).

Here is the bluetooth log when my system boots up

tangox[sbin]# dmesg | grep -i blue
Bluetooth: Core ver 2.14
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI UART driver ver 2.2
Bluetooth: Generic Bluetooth USB driver ver 0.4
Bluetooth: L2CAP ver 2.11
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.10
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast

Next, I manually (without using configure) built *just* bluez-4.99
library (i.e libbluetooth.so) and a simple test program. When I plug
in a USB BT adapter and run my sample program, hci_get_route(NULL)
always fails with ENODEV.

The same thing happens when I use bluez-libs-3.36. My USB BT adapter
works fine on a Linux desktop running Linux 2.6.31-14

Googled for a solution but came up with nothing.

Any suggestions on how I should proceed?

thanks for your help
L.K
