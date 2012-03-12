Return-Path: <cyrus@holtmann.org>
Message-ID: <1331552237.5372.10.camel@localhost>
Subject: bluetoothd OOM
From: Alberto =?ISO-8859-1?Q?Jos=E9_Rodr=EDguez_?=
	 =?ISO-8859-1?Q?Rodr=EDguez?= <ajrodriguez@blulabs.es>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Mar 2012 12:37:17 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have one machine that send files to the devices that it detects
(pairing when requested by the target device). But recently it goes out
of memory, and if a launch bluetoothd by hand I see thousands of lines
like this:

..................
bluetoothd[3341]: src/device.c:device_create() Creating
device /org/bluez/3341/hci1/dev_E4_EC_10_CD_56_C2
bluetoothd[3341]: src/device.c:btd_device_ref() 0x234e5988: ref=1
bluetoothd[3341]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3341]: src/device.c:device_probe_drivers() Probing drivers
for E4:EC:10:CD:56:C2
bluetoothd[3341]: src/device.c:device_create() Creating
device /org/bluez/3341/hci1/dev_FC_A1_3E_11_6D_81
bluetoothd[3341]: src/device.c:btd_device_ref() 0x234eb4c8: ref=1
bluetoothd[3341]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3341]: src/device.c:device_probe_drivers() Probing drivers
for FC:A1:3E:11:6D:81
bluetoothd[3341]: src/device.c:device_create() Creating
device /org/bluez/3341/hci1/dev_E0_A6_70_49_6E_6A
bluetoothd[3341]: src/device.c:btd_device_ref() 0x234ee6d8: ref=1
bluetoothd[3341]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3341]: src/device.c:device_probe_drivers() Probing drivers
for E0:A6:70:49:6E:6A
bluetoothd[3341]: src/device.c:device_create() Creating
device /org/bluez/3341/hci1/dev_00_26_CC_6B_F8_0A
....................

It seems to remember all the devices that are paired once. How I can
make him clean them?

Thanks in advance

