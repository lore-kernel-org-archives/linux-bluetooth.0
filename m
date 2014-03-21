Return-Path: <cyrus@holtmann.org>
Message-ID: <532CAAB8.5020403@gmail.com>
Date: Fri, 21 Mar 2014 21:10:16 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Help on connecting a PS3 headset
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been trying to manually connect a PS3 headset using bluez 5.16 without success.
It does work using KDE Bluetooth tools (still based on bluez 4), but as I would like to use it on a
headless box, I need to do it via CLI.

Using bluez 5.16 (both in Fedora 19 and on Arch on a Pi) I can pair the device but when I try to
connect I get

[NEW] Controller 00:15:83:0C:BF:EB localhost.localdomain [default]
[NEW] Device 00:22:A6:16:E3:F0 Wireless Headset
[bluetooth]# list
Controller 00:15:83:0C:BF:EB localhost.localdomain [default]
[bluetooth]# connect 00:22:A6:16:E3:F0
Attempting to connect to 00:22:A6:16:E3:F0
[CHG] Device 00:22:A6:16:E3:F0 Connected: yes
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
Failed to connect: org.bluez.Error.NotAvailable
[CHG] Device 00:22:A6:16:E3:F0 Connected: no

on the daemon I can see

bluetoothd[16241]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_22_A6_16_E3_F0 (all),
client :1.234
bluetoothd[16241]: src/device.c:connect_profiles() Resolving services for
/org/bluez/hci0/dev_00_22_A6_16_E3_F0
bluetoothd[16241]: src/adapter.c:connected_callback() hci0 device 00:22:A6:16:E3:F0 connected eir_len 18
bluetoothd[16241]: src/device.c:search_cb() 00:22:A6:16:E3:F0: No service update
bluetoothd[16241]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00_22_A6_16_E3_F0 err 0
bluetoothd[16241]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_22_A6_16_E3_F0 (all),
client :1.234
bluetoothd[16241]: src/adapter.c:dev_disconnected() Device 00:22:A6:16:E3:F0 disconnected, reason 2
bluetoothd[16241]: src/adapter.c:adapter_remove_connection()
bluetoothd[16241]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:22:A6:16:E3:F0 type 0
status 0xe
bluetoothd[16241]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[16241]: src/device.c:device_bonding_failed() status 14
bluetoothd[16241]: src/adapter.c:resume_discovery()


anything else I should be doing to get a connection?
