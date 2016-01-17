Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Jan 2016 11:42:04 +0200
Message-ID: <CAPGkfYGEjsnkxJS7sM8JjUeZc0nHmsEb42ypx-Mc70+Z4bcvig@mail.gmail.com>
Subject: Possibly Bug in recent Bluez
From: Andrey Aleksandrovich <andrey.aleksandrovich@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I have Gentoo Linux, KDE on laptop with Bluetooth.
And I find out that it doesn't working after some time ago.

# dmesg | grep 4-1.5
[  475.204004] usb 4-1.5: New USB device found, idVendor=8086, idProduct=0189
[  475.204014] usb 4-1.5: New USB device strings: Mfr=0, Product=0,
SerialNumber=0

# lsusb | grep 009
Bus 004 Device 009: ID 8086:0189 Intel Corp.

# cat /var/log/everything/current | grep bluetoothd
Jan 16 18:52:51 [bluetoothd] Bluetooth daemon 5.37
Jan 16 18:52:51 [bluetoothd] Starting SDP server
Jan 16 18:52:51 [bluetoothd] Bluetooth management interface 1.9 initialized
Jan 16 18:52:51 [bluetoothd] Failed to obtain handles for "Service
Changed" characteristic
Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
Jan 16 18:52:51 [bluetoothd] Error adding Link Loss service
Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
Jan 16 18:52:51 [bluetoothd] Current Time Service could not be registered
Jan 16 18:52:51 [bluetoothd] gatt-time-server: Input/output error (5)
Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
Jan 16 18:52:51 [bluetoothd] Sap driver initialization failed.
Jan 16 18:52:51 [bluetoothd] sap-server: Operation not permitted (1)

It doesn't affect only me, here is some links:
https://bugzilla.redhat.com/show_bug.cgi?id=1259827
https://bugs.gentoo.org/show_bug.cgi?id=566004
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1499858
