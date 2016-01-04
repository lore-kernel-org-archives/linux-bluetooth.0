Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 4 Jan 2016 11:16:03 -0700
Message-ID: <CAASrBQ=XtvLXLp7xJuUN7pfN6ZN3sEZGU-6LtBhz-isdmpujxQ@mail.gmail.com>
Subject: Failed to obtain handles for "Service Changed" characteristic, etc.
From: Mark Rages <markrages@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to use git bluetoothd in Ubuntu.  When I start it I get the
following errors:

root@qountdown:~/src/bluez/src# ./bluetoothd -En
bluetoothd[23921]: Bluetooth daemon 5.37
bluetoothd[23921]: Starting SDP server
bluetoothd[23921]: Bluetooth management interface 1.6 initialized
bluetoothd[23921]: Failed to obtain handles for "Service Changed" characteristic
bluetoothd[23921]: Not enough free handles to register service
bluetoothd[23921]: Error adding Link Loss service
bluetoothd[23921]: Not enough free handles to register service
bluetoothd[23921]: Not enough free handles to register service
bluetoothd[23921]: Not enough free handles to register service
bluetoothd[23921]: Current Time Service could not be registered
bluetoothd[23921]: gatt-time-server: Input/output error (5)
bluetoothd[23921]: Not enough free handles to register service
bluetoothd[23921]: Not enough free handles to register service
bluetoothd[23921]: Failed to read advertising features: Unknown Command (0x01)
bluetoothd[23921]: hci0 Load Connection Parameters failed: Unknown
Command (0x01)

Where should I look to diagnose these?
-- 
Regards,
Mark
markrages@gmail
