Return-Path: <cyrus@holtmann.org>
Message-ID: <4CA0E800.4000000@sergej.pp.ru>
Date: Mon, 27 Sep 2010 22:52:48 +0400
From: Sergej Pupykin <ml@sergej.pp.ru>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Another "hci0 command tx timeout"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hello, All.

How can I help to debug this issue? BT works without userspace, but does 
not work if I enable it in udev rules (ACTION=="add", 
SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev") or do 
"/etc/rc.d/bluetooth start".

(Probably related to
https://bugzilla.redhat.com/show_bug.cgi?id=519176
and
https://bugs.launchpad.net/linux/+bug/268502)

Packages:
kernel26 2.6.35.5-1
bluez 4.72-1

Devices:
Bus 007 Device 005: ID 0a5c:3503 Broadcom Corp.
Bus 007 Device 004: ID 0a5c:3502 Broadcom Corp.
Bus 007 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth 
Dongle (HCI mode)
Bus 007 Device 002: ID 0a5c:3500 Broadcom Corp.

Without userspace:
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
 > HCI Event: Command Complete (0x0e) plen 11
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
 > HCI Event: Command Complete (0x0e) plen 10
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Local Name (0x03|0x0014) plen 0
 > HCI Event: Command Complete (0x0e) plen 252
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Inquiry (0x01|0x0001) plen 5
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Inquiry Result (0x02) plen 15
 > HCI Event: Inquiry Complete (0x01) plen 1


With userspace:
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
 > HCI Event: Command Complete (0x0e) plen 11
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
 > HCI Event: Command Complete (0x0e) plen 10
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Local Name (0x03|0x0014) plen 0
 > HCI Event: Command Complete (0x0e) plen 252
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
 > HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
 > HCI Event: Command Complete (0x0e) plen 8
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Default Link Policy Settings (0x02|0x000e) plen 0
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1

