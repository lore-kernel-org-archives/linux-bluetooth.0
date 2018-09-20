Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Nik Markovic <nik.markovic@vensi.com>
Date: Wed, 19 Sep 2018 19:32:27 -0500
Message-ID: <CABVwu2ULGcLVXwNHwn3CT4=6wemLTF21HdSQVXo_gzm7jesWsQ@mail.gmail.com>
Subject: Bluetoothd: How to receive more advertisments per second
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

One of our peripherals advertises every 300-500ms. We modified the
code to continuously increment a manufacturer data value and verified
on an Android phone that we see the value increment every 300-1000ms.

However we only see updates every 5-15 seconds when we issue a scan
with bluez service via bluetoothctl or dbus API (even with duplicates
off and setting transport to BLE only with SetDiscoveryFilter. The
same rate occurs when tracing with btmon.

We tried setting window and interval parameters with hciconfig and
btmgmt, but none seem to have any effect. When scan is started the
bluetoothd service sets its own scan parameters (see trace below),
which are even more aggressive than what we are looking for, but
obviously there is something that we don't understand.

How can we receive more results per second from BlueZ service?

Thanks,
Nik

----- scan hcidump ---
HCI sniffer - Bluetooth packet analyzer ver 5.48
device: hci0 snap_len: 1500 filter: 0xffffffff
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6
    bdaddr 3A:19:9E:16:37:17
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Random Address (0x08|0x0005) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x01 (active)
    interval 11.250ms window 11.250ms
    own address: 0x01 (Random) policy: All
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
