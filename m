Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] adapter: Handle MGMT_SETTING_LE change
Message-Id: <20140213014521.59803100423@puck.mtv.corp.google.com>
Date: Wed, 12 Feb 2014 17:45:21 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On some BLE-capable adapters, BLE is not enabled by default. When BLE is
enabled after the adapter is already powered up, we need to call
trigger_passive_scanning() so that paired BLE devices (e.g. HoG devices)
are able to reconnect back to host.

bluetoothd[1087]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
bluetoothd[1087]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
bluetoothd[1087]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[1087]: src/adapter.c:get_connections_complete() Connection count: 0
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000000c1
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000040
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002c1
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000200
 => BLE got enabled, adapter already up, need to call trigger_passive_scanning()
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002d1
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000010
bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000002
---
 src/adapter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 18601ea..01006f2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -405,6 +405,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 static void trigger_pairable_timeout(struct btd_adapter *adapter);
 static void adapter_start(struct btd_adapter *adapter);
 static void adapter_stop(struct btd_adapter *adapter);
+static void trigger_passive_scanning(struct btd_adapter *adapter);
 
 static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 {
@@ -434,6 +435,13 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 		}
 	}
 
+	if (changed_mask & MGMT_SETTING_LE) {
+		if ((adapter->current_settings & MGMT_SETTING_POWERED) &&
+		    (adapter->current_settings & MGMT_SETTING_LE)) {
+			trigger_passive_scanning(adapter);
+		}
+	}
+
 	if (changed_mask & MGMT_SETTING_CONNECTABLE)
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Connectable");
-- 
1.9.0.rc1.175.g0b1dcb5

