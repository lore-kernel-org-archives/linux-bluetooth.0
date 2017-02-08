Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Simon Falsig <sfalsig@veritystudios.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Reading manufacturer-specific advertisement data from BLE device
Date: Wed, 8 Feb 2017 16:23:15 +0000
Message-ID: <d01aae99bbca4803aa34ab90ba3f080b@veritystudios.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm currently trying to read manufacturer-specific data from an advertisement from a custom BLE device, using the BlueZ D-Bus API, but can't seem to get it working.

I can see my device when doing a scan in bluetoothctl, but haven't figured out how to get to the actual advertisement data. I've tried modifying bluetoothctl to get the "ManufacturerData" property, but this is not found (g_dbus_proxy_get_property returns false). Also, no ManufacturerData property (or similar) shows up for the device in d-feet.

I have a small utility that just uses the hci API directly, and using that, I can get the complete contents of the advertisement, including the manufacturer-specific data. Full data is (in hex):

02 01 06 03 02 e0 c0 11 ff 00 02 01 03 00 00 00 00 00 00 00 00 5d 58 0e 94

Is there something wrong in the way I'm sending out the data, or do I need to register for data in some way to get it working for the D-Bus API also?

I'm using BlueZ 5.37 on KUbuntu 16.04 (running in VirtualBox), using an Aircable Host XR4 Bluetooth adapter connected over USB. BLE device is a custom solution, based on a TI CC2650 chip, using the TI BLE-Stack 2.2.0.

Any hints or comments are appreciated!

Thanks in advance,
Simon Falsig
