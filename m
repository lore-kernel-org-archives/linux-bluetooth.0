Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 5 May 2015 19:29:18 +0200
Message-ID: <CANzaTi53ZQ+J0KoH_DaN1hv9L68y0HQAPgjC0nYqXpFHTsxEmg@mail.gmail.com>
Subject: example-gatt-server connection error (GAT ERROR 0x85)
From: dogan yazar <doganyazar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

To try test/example-gatt-server, I have cloned the latest bluez code
and compiled it in my beaglebone (Debian kernel 3.17).

When I run example-gatt-server, it works fine, I see the bluetoothd
registering services and with "hciconfig hci0 leadv" I also advertise
and see the device on my android.

However, whenever I want to connect to the device, I get a 0x85 GATT
error back (at least that is what NRF Master Control Panel -Nordic
Semiconductor's BLE client- says on my Android 5.0 device). Tried it
with different Android devices and different ble clients and result is
same. bluetoothd does not print any error logs either.
Any idea what may be the problem?


Funny thing is that when I try to connect with Texas Instrument's BLE
Device Monitor tool on windows, it usually works fine. I can access
the characteristics and read their values.

Dogan
