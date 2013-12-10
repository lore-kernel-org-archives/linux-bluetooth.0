Return-Path: <cyrus@holtmann.org>
Message-ID: <1386663785.1982.4.camel@nuvo>
Subject: Missing AuthorizeService callback?
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 10 Dec 2013 09:23:05 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

This mouse is particularly troublesome, and refuses to forget about a
previous setup with my computer. It tries to connect when started, which
shouldn't be as much of a problem if I did get an AuthorizeService
callback to allow the device to connect:

Dec 10 09:15:03 nuvo bluetoothd[20264]: src/adapter.c:connected_callback() hci0 device 00:0A:94:C0:AB:9B connected eir_len 5
Dec 10 09:15:03 nuvo bluetoothd[20264]: src/device.c:device_create() dst 00:0A:94:C0:AB:9B
Dec 10 09:15:03 nuvo bluetoothd[20264]: src/device.c:device_new() address 00:0A:94:C0:AB:9B
Dec 10 09:15:03 nuvo bluetoothd[20264]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_0A_94_C0_AB_9B
Dec 10 09:15:03 nuvo bluetoothd[20264]: src/device.c:device_set_temporary() temporary 1
Dec 10 09:15:03 nuvo bluetoothd[20264]: src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_00_0A_94_C0_AB_9B is not on the list, ignoring
Dec 10 09:15:03 nuvo bluetoothd[20264]: src/device.c:device_set_class() /org/bluez/hci0/dev_00_0A_94_C0_AB_9B 0x002580
Dec 10 09:15:03 nuvo bluetoothd[20264]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:0A:94:C0:AB:9B on PSM 17
Dec 10 09:15:03 nuvo bluetoothd[20264]: profiles/input/device.c:input_device_set_channel() idev (nil) psm 17
Dec 10 09:15:03 nuvo bluetoothd[20264]: Refusing input device connect: No such file or directory (2)
Dec 10 09:15:03 nuvo bluetoothd[20264]: profiles/input/server.c:confirm_event_cb()
Dec 10 09:15:03 nuvo bluetoothd[20264]: Refusing connection from 00:0A:94:C0:AB:9B: unknown device

Seems that we have the same problem I mentioned earlier with the device
getting created, and deleted straight away.

