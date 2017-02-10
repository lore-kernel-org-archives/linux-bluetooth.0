Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Reading manufacturer-specific advertisement data from BLE device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d01aae99bbca4803aa34ab90ba3f080b@veritystudios.com>
Date: Fri, 10 Feb 2017 12:39:40 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <82640EE1-8244-4609-B51E-F2ECFAE35992@holtmann.org>
References: <d01aae99bbca4803aa34ab90ba3f080b@veritystudios.com>
To: Simon Falsig <sfalsig@veritystudios.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

> I'm currently trying to read manufacturer-specific data from an advertisement from a custom BLE device, using the BlueZ D-Bus API, but can't seem to get it working.
> 
> I can see my device when doing a scan in bluetoothctl, but haven't figured out how to get to the actual advertisement data. I've tried modifying bluetoothctl to get the "ManufacturerData" property, but this is not found (g_dbus_proxy_get_property returns false). Also, no ManufacturerData property (or similar) shows up for the device in d-feet.
> 
> I have a small utility that just uses the hci API directly, and using that, I can get the complete contents of the advertisement, including the manufacturer-specific data. Full data is (in hex):
> 
> 02 01 06 03 02 e0 c0 11 ff 00 02 01 03 00 00 00 00 00 00 00 00 5d 58 0e 94
> 
> Is there something wrong in the way I'm sending out the data, or do I need to register for data in some way to get it working for the D-Bus API also?
> 
> I'm using BlueZ 5.37 on KUbuntu 16.04 (running in VirtualBox), using an Aircable Host XR4 Bluetooth adapter connected over USB. BLE device is a custom solution, based on a TI CC2650 chip, using the TI BLE-Stack 2.2.0.
> 
> Any hints or comments are appreciated!

not sure when the support for ManufacturerData went into BlueZ. However try the latest version and run btmon to verify it is actually transmitted in the advertising report itself.

Regards

Marcel

