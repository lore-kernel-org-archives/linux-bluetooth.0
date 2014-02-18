Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] adapter: Handle MGMT_SETTING_LE change
Message-Id: <20140218185506.C44B81005C1@puck.mtv.corp.google.com>
Date: Tue, 18 Feb 2014 10:55:06 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On dual-mode Bluetooth adapters, BLE is not enabled by default. When bluetoothd
starts, BLE is enabled in read_info_complete(), but this management action does
not always complete before adapter_start() is called. Therefore, bluetoothd
needs to handle the MGMT_SETTING_LE change correctly in settings_changed().
Specifically, trigger_passive_scanning() needs to be called so that paired BLE
devices (e.g. HoG devices) are able to reconnect back to host.

The trace below shows this case:
bluetoothd[1087]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
 => adapter_start() is called, but BLE is not yet enabled
bluetoothd[1087]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
bluetoothd[1087]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[1087]: src/adapter.c:get_connections_complete() Connection count: 0
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000000c1
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000040
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002c1
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000200
 => BLE got enabled, so need to call trigger_passive_scanning()
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002d1
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000010
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000002

The issue is easily reproducible with this init sequence:
hciconfig hci0 up
bluetoothd -n -d
---
 src/adapter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 08296bd..596e1eb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -405,6 +405,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 static void trigger_pairable_timeout(struct btd_adapter *adapter);
 static void adapter_start(struct btd_adapter *adapter);
 static void adapter_stop(struct btd_adapter *adapter);
+static void trigger_passive_scanning(struct btd_adapter *adapter);
 
 static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 {
@@ -434,6 +435,12 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 		}
 	}
 
+	if (changed_mask & MGMT_SETTING_LE) {
+		if ((adapter->current_settings & MGMT_SETTING_POWERED) &&
+				(adapter->current_settings & MGMT_SETTING_LE))
+			trigger_passive_scanning(adapter);
+	}
+
 	if (changed_mask & MGMT_SETTING_CONNECTABLE)
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Connectable");
-- 
1.9.0.rc1.175.g0b1dcb5

