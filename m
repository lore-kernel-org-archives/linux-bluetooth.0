Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] core: Fix adapter_connect_list_add()
Message-Id: <20140625173829.4BAE0100934@puck.mtv.corp.google.com>
Date: Wed, 25 Jun 2014 10:38:29 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

adapter_connect_list_add() needs to ensure that trigger_passive_scanning() is
called even for existing devices on the connect list.

This issue can be seen with BLE HoG remotes trying to reconnect to BlueZ. If
the connection fails, att_error_cb() adds the failed device back to connect
list, but since the device is already on the list, no code ends up calling
trigger_passive_scanning(). After this point, passive scanning is disabled
and remains disabled for good, and BLE reconnects to BlueZ no longer work.

bluetoothd[931]: src/adapter.c:device_found_callback() hci0 addr ...
bluetoothd[931]: src/device.c:device_set_legacy() legacy 0
bluetoothd[931]: src/adapter.c:stop_passive_scanning()
bluetoothd[931]: src/adapter.c:stop_passive_scanning_complete() status 0x00 (Success)
bluetoothd[931]: src/device.c:device_connect_le() Connection attempt to: ...
bluetoothd[931]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
bluetoothd[931]: src/adapter.c:connect_failed_callback() hci0 ... status 2
bluetoothd[931]: plugins/policy.c:conn_fail_cb() status 2
bluetoothd[931]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr ... type 1 status 0x2
bluetoothd[931]: src/device.c:device_bonding_complete() bonding (nil) status 0x02
bluetoothd[931]: src/device.c:device_bonding_failed() status 2
bluetoothd[931]: src/adapter.c:resume_discovery()
bluetoothd[931]: src/device.c:att_connect_cb() connect error: Transport endpoint is not connected (134)
bluetoothd[931]: src/device.c:att_error_cb() Enabling automatic connections
bluetoothd[931]: src/adapter.c:adapter_connect_list_add() ignoring already added device ...
... passive scan is disabled and remains disabled for good ...
---
 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4a6953e..ca0f193 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3025,7 +3025,7 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
 	if (g_slist_find(adapter->connect_list, device)) {
 		DBG("ignoring already added device %s",
 						device_get_path(device));
-		return 0;
+		goto done;
 	}
 
 	if (!(adapter->supported_settings & MGMT_SETTING_LE)) {
@@ -3038,6 +3038,7 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
 	DBG("%s added to %s's connect_list", device_get_path(device),
 							adapter->system_name);
 
+done:
 	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
 		return 0;
 
-- 
2.0.0.526.g5318336

