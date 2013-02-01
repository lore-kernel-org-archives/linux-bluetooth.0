Return-Path: <cyrus@holtmann.org>
From: Damjan Cvetko <Damjan.Cvetko@monotek.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Add heartrate monitoring LE device to auto connect list.
Date: Fri, 1 Feb 2013 13:39:08 +0000
Message-ID: <CEE0DF8E7B2727428D202DA3F3FBC4DD8C756889@PULWAR.mtk.lan>
References: <1359408442-8002-1-git-send-email-damjan.cvetko@monotek.net>
 <20130129233606.GA16365@x220>
In-Reply-To: <20130129233606.GA16365@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> This patch isn't needed anymore since btd_device_add_attio_callback was fixed to enable the auto connecting. Please verify that latest git works for you.

Hi Johan.

Sorry, could not get back earlier.

Generally the latest code works, but not always. Every so often the reconnect would not happen. Here a snip from output when the reconnection does not happen (or fails somehow):


bluetoothd[4628]: src/attrib-server.c:channel_handler() op 0x1b
bluetoothd[4628]: src/adapter.c:dev_disconnected() Device 00:22:D0:00:00:64 disconnected, reason 0
bluetoothd[4628]: src/adapter.c:adapter_remove_connection()
bluetoothd[4628]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[4628]: src/device.c:device_bonding_failed() status 14
bluetoothd[4628]: src/adapter.c:resume_discovery()
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=4
bluetoothd[4628]: profiles/heartrate/heartrate.c:attio_disconnected_cb()
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=3
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=2
bluetoothd[4628]: g_attrib_unregister: invalid id
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=1
bluetoothd[4628]: src/adapter.c:adapter_connect_list_add() /org/bluez/hci0/dev_00_22_D0_00_00_64 added to BlueZ 5.1's connect_list
bluetoothd[4628]: src/adapter.c:trigger_passive_scanning()
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=0
bluetoothd[4628]: src/adapter.c:passive_scanning_complete() status 0x00
bluetoothd[4628]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
bluetoothd[4628]: src/adapter.c:device_found_callback() hci0 addr 00:22:D0:00:00:64, rssi -91 flags 0x0000 eir_len 17
bluetoothd[4628]: src/device.c:device_set_legacy() legacy 0
bluetoothd[4628]: src/adapter.c:stop_passive_scanning()
bluetoothd[4628]: src/device.c:device_connect_le() Connection attempt to: 00:22:D0:00:00:64
bluetoothd[4628]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
bluetoothd[4628]: src/adapter.c:connected_callback() hci0 device 00:22:D0:00:00:64 connected eir_len 0
bluetoothd[4628]: src/adapter.c:dev_disconnected() Device 00:22:D0:00:00:64 disconnected, reason 0
bluetoothd[4628]: src/adapter.c:adapter_remove_connection()
bluetoothd[4628]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[4628]: src/device.c:device_bonding_failed() status 14
bluetoothd[4628]: src/adapter.c:resume_discovery()
bluetoothd[4628]: src/device.c:att_connect_cb() connect error: Function not implemented (38)
bluetoothd[4628]: src/device.c:att_error_cb() Enabling automatic connections
bluetoothd[4628]: src/adapter.c:adapter_connect_list_add() ignoring already added device /org/bluez/hci0/dev_00_22_D0_00_00_64
(end)

And for reference a situation where reconnection works:

bluetoothd[4628]: src/attrib-server.c:channel_handler() op 0x1b
bluetoothd[4628]: src/adapter.c:dev_disconnected() Device 00:22:D0:00:00:64 disconnected, reason 0
bluetoothd[4628]: src/adapter.c:adapter_remove_connection()
bluetoothd[4628]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[4628]: src/device.c:device_bonding_failed() status 14
bluetoothd[4628]: src/adapter.c:resume_discovery()
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1fa33e8: ref=4
bluetoothd[4628]: profiles/heartrate/heartrate.c:attio_disconnected_cb()
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1fa33e8: ref=3
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1fa33e8: ref=2
bluetoothd[4628]: g_attrib_unregister: invalid id
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1fa33e8: ref=1
bluetoothd[4628]: src/adapter.c:adapter_connect_list_add() /org/bluez/hci0/dev_00_22_D0_00_00_64 added to BlueZ 5.1's connect_list
bluetoothd[4628]: src/adapter.c:trigger_passive_scanning()
bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1fa33e8: ref=0
bluetoothd[4628]: src/adapter.c:passive_scanning_complete() status 0x00
bluetoothd[4628]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
bluetoothd[4628]: src/adapter.c:device_found_callback() hci0 addr 00:22:D0:00:00:64, rssi -87 flags 0x0000 eir_len 17
bluetoothd[4628]: src/device.c:device_set_legacy() legacy 0
bluetoothd[4628]: src/device.c:device_set_rssi() rssi -87 delta 10
bluetoothd[4628]: src/adapter.c:stop_passive_scanning()
bluetoothd[4628]: src/adapter.c:device_found_callback() hci0 addr 00:22:D0:00:00:64, rssi -87 flags 0x0000 eir_len 17
bluetoothd[4628]: src/device.c:device_set_legacy() legacy 0
bluetoothd[4628]: src/adapter.c:stop_passive_scanning()
bluetoothd[4628]: src/device.c:device_connect_le() Connection attempt to: 00:22:D0:00:00:64
bluetoothd[4628]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
bluetoothd[4628]: Stopping passive scanning failed: Rejected
bluetoothd[4628]: src/adapter.c:connected_callback() hci0 device 00:22:D0:00:00:64 connected eir_len 0
bluetoothd[4628]: attrib/gattrib.c:g_attrib_ref() 0x1f9eda8: ref=1
bluetoothd[4628]: attrib/gattrib.c:g_attrib_ref() 0x1f9eda8: ref=2
bluetoothd[4628]: src/adapter.c:adapter_connect_list_remove() /org/bluez/hci0/dev_00_22_D0_00_00_64 removed from BlueZ 5.1's connect_list
bluetoothd[4628]: src/adapter.c:stop_passive_scanning()
bluetoothd[4628]: profiles/heartrate/heartrate.c:attio_connected_cb()
bluetoothd[4628]: attrib/gattrib.c:g_attrib_ref() 0x1f9eda8: ref=3
bluetoothd[4628]: attrib/gattrib.c:g_attrib_ref() 0x1f9eda8: ref=4
bluetoothd[4628]: attrib/gattrib.c:g_attrib_ref() 0x1f9eda8: ref=5
(goes on)

I did not have time yet to look into this, will try to do it next week. With the old solution this did not happen in the window of one week when constantly testing this.

Best regards,
Damjan
