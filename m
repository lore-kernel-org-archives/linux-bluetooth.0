Return-Path: <cyrus@holtmann.org>
Subject: Inquiry Failed with status 0x0c
From: Alberto =?ISO-8859-1?Q?Jos=E9_Rodr=EDguez_?=
	 =?ISO-8859-1?Q?Rodr=EDguez?= <ajrodriguez@blulabs.es>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Sep 2011 14:15:53 +0200
Message-ID: <1316780153.3433.6.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some times when I'm doing an inquiry, the inquiry fails with status
0x0c. What is it means? Thanks in advance

..........................
bluetoothd[2432]: src/device.c:device_remove() Removing
device /org/bluez/2432/hci0/dev_00_1D_6E_91_22_8F
bluetoothd[2432]: src/device.c:btd_device_unref() 0x4d88330: ref=0
bluetoothd[2432]: src/device.c:device_free() 0x4d88330
bluetoothd[2432]: plugins/hciops.c:__get_remote_version() hci0 handle 43
bluetoothd[2432]: plugins/hciops.c:__get_remote_version() hci0 handle 42
bluetoothd[2432]: plugins/hciops.c:disconn_complete() handle 43 status
0x00
bluetoothd[2432]: src/event.c:btd_event_disconn_complete() 
bluetoothd[2432]: src/adapter.c:adapter_remove_connection() 
bluetoothd[2432]: src/device.c:search_cb() 0C:DD:EF:0B:C8:35: No service
update
bluetoothd[2432]: src/device.c:btd_device_unref() 0x5206c88: ref=1
bluetoothd[2432]: src/device.c:btd_device_ref() 0x5206c88: ref=2
bluetoothd[2432]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[2432]: src/adapter.c:adapter_get_device() 0C:DD:EF:0B:C8:35
bluetoothd[2432]: plugins/hciops.c:remote_features_information() hci0
status 0
bluetoothd[2432]: plugins/hciops.c:remote_version_information() hci0
status 0
bluetoothd[2432]: plugins/hciops.c:__get_remote_version() hci0 handle 42
bluetoothd[2432]: plugins/hciops.c:hciops_start_inquiry() hci0 length 8
bluetoothd[2432]: Discovery session 0x6372f88 with :1.252 activated
bluetoothd[2432]: src/adapter.c:session_ref() 0x6372f88: ref=1
bluetoothd[2432]: plugins/hciops.c:disconn_complete() handle 42 status
0x00
bluetoothd[2432]: src/event.c:btd_event_disconn_complete() 
bluetoothd[2432]: src/adapter.c:adapter_remove_connection() 
bluetoothd[2432]: Inquiry Failed with status 0x0c
bluetoothd[2432]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[2432]: src/adapter.c:adapter_get_device() 0C:DD:EF:0B:C8:35
bluetoothd[2432]: plugins/hciops.c:remote_features_information() hci0
status 0
bluetoothd[2432]: src/device.c:device_probe_drivers() Probing drivers
for 0C:DD:EF:0B:C8:35
bluetoothd[2432]: src/device.c:btd_device_unref() 0x5206c88: ref=1
bluetoothd[2432]: plugins/hciops.c:disconn_complete() handle 43 status
0x00
bluetoothd[2432]: src/event.c:btd_event_disconn_complete() 
bluetoothd[2432]: src/adapter.c:adapter_remove_connection()

