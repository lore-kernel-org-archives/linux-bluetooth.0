Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Getting the address type of a  BLE device
Date: Fri, 7 Oct 2016 14:49:07 +0000
Message-ID: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D43A@DEDC01MBX02.corp.lairdtech.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

One thing I've noticed that is lacking in BlueZ seems to be the inability to get the address type of the devices found in a scan for Bluetooth Low Energy scans (not Bluetooth Classic). This is a headache in frameworks like Qt. According to a BlueZ 4 -> 5 porting guide when a device is detected the Bluetooth daemon holds the address type for 3 minutes and you should be able to connect or pair with it without needing to set the address type (random or private) but this does not work at all from Qt. Also (assuming it worked) there is the problem of what if a user performs a scan and decides to connect in 5 minutes' time? The type of address will have been deleted.
I propose adding an additional field to the list of devices in a scan that will return nothing for BTC devices (or something to indicate it is not a BLE device, there is also the option to return something else if the device is both a BLE and BTC device combined) or the first byte of the BLE address if it is a BLE device. Right now in Qt it is purely guess work what type of address is received and it'd be nice to improve that to make the system workable. This means you can detect what type of device it is (great for logging), check if it also has  BTC service (and decide to connect with that) or check if it's using a random address that your device has a resolving key for - none of which is possible at the moment. It also helps out with a potential MITM issue whereby a device exists with a random address and someone clones the address but sets it as a static address: how do you know what device you are really pairing with? The correct device or the impersonation which could be decryp
 ting all data passing through it and passing it to the real device.

I'm interested to hear everyone's thoughts and suggestions regarding this addition.

Thanks,
Jamie
