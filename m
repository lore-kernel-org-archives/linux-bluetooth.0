Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Leigh Fiddes <leigh.fiddes@atomos.com>
Subject: Race condition between DIS and HoG profiles
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <96447190-1a92-5864-f4f6-cfe9898da242@atomos.com>
Date: Fri, 19 Aug 2016 16:29:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In November 2012 an issue was identified in which the uhid device was
being created before the DIS information had been retrieved. This cause
the input device to not have the correct vendor and product identifiers.
See the message http://www.spinics.net/lists/linux-bluetooth/msg31931.html

The patch proposed was not included and I have not seen any discussion as to why.

I am seeing this exact problem with Bluez 5.41 on Linux 4.1 with a
Nordic nRF51 development board as the peripheral. Some snippets from the
/var/log/messages show the result.


Jan  1 00:02:54 bluetoothd[714]: src/device.c:device_probe_profiles() Probing profiles for device C0:58:9E:9D:A6:FF
Jan  1 00:02:54 bluetoothd[714]: profiles/input/hog.c:hog_probe() path /org/bluez/hci0/dev_C0_58_9E_9D_A6_FF
Jan  1 00:02:54 bluetoothd[714]: profiles/input/hog.c:hog_device_new() name=Nordic_Mouse vendor=0x0, product=0x0, version=0x0

Jan  1 00:02:55 bluetoothd[714]: profiles/deviceinfo/deviceinfo.c:read_pnpid_cb() Vendor 1915 Product EEEE Version 0001

Jan  1 00:02:57 kernel: [  179.706068] input: Nordic_Mouse as /devices/virtual/misc/uhid/0005:0000:0000.0001/input/input2
Jan  1 00:02:57 kernel: [  179.706681] hid-generic 0005:0000:0000.0001:input: BLUETOOTH HID v0.00 Mouse [Nordic_Mouse] on 00:1A:7D:DA:71:13
Jan  1 00:02:57 bluetoothd[714]: profiles/input/hog-lib.c:report_map_read_cb() HoG created uHID device

interestingly, if I stop and restart bluetoothd without changing
anything else the correct input is created, since the vendor, product
and version are now valid

Jan  1 00:04:14 kernel: [  256.476283] input: Nordic_Mouse as /devices/virtual/misc/uhid/0005:1915:EEEE.0002/input/input3
Jan  1 00:04:14 bluetoothd[773]: profiles/input/hog-lib.c:report_map_read_cb() HoG created uHID device
Jan  1 00:04:14 bluetoothd[773]: attrib/gattrib.c:g_attrib_unref() 0xad4e78: g_attrib_unref=2
Jan  1 00:04:14 kernel: [  256.477313] hid-generic 0005:1915:EEEE.0002:input: BLUETOOTH HID v0.01 Mouse [Nordic_Mouse] on 00:1A:7D:DA:71:13

Is this a problem for anyone else?

Leigh


