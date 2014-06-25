Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] core: Fix discovering_callback()
Message-Id: <20140625173817.5C9A3100934@puck.mtv.corp.google.com>
Date: Wed, 25 Jun 2014 10:38:17 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

discovering_callback() should not call trigger_passive_scanning() when
outgoing BLE connection is pending.

This issue can be seen with BLE HoG devices trying to reconnect to BlueZ:
bluetoothd[931]: src/adapter.c:device_found_callback() hci0 addr ...
bluetoothd[931]: src/device.c:device_set_legacy() legacy 0
bluetoothd[931]: src/device.c:device_set_rssi() rssi -75
bluetoothd[931]: src/adapter.c:stop_passive_scanning()
bluetoothd[931]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
bluetoothd[931]: src/adapter.c:trigger_passive_scanning()
bluetoothd[931]: src/adapter.c:stop_passive_scanning_complete() status 0x0b (Rejected)
bluetoothd[931]: Stopping passive scanning failed: Rejected
---
 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4a66da1..4a6953e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1505,7 +1505,8 @@ static void discovering_callback(uint16_t index, uint16_t length,
 	 * passive scanning attempt.
 	 */
 	if (!adapter->discovery_list) {
-		trigger_passive_scanning(adapter);
+		if (!adapter->connect_le)
+			trigger_passive_scanning(adapter);
 		return;
 	}
 
-- 
2.0.0.526.g5318336

