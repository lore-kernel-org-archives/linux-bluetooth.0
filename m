Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] core: Fix stop_passive_scanning_complete()
Message-Id: <20140625173804.13C85100934@puck.mtv.corp.google.com>
Date: Wed, 25 Jun 2014 10:38:03 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Consider MGMT_STATUS_REJECTED as success for stop_passive_scanning().
MGMT_STATUS_REJECTED may be returned from kernel because the passive
scan timer had expired in kernel and passive scan was disabled just
around the time we called stop_passive_scanning().

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
 src/adapter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index f5f8c8c..4a66da1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1228,7 +1228,12 @@ static void stop_passive_scanning_complete(uint8_t status, uint16_t length,
 	dev = adapter->connect_le;
 	adapter->connect_le = NULL;
 
-	if (status != MGMT_STATUS_SUCCESS) {
+	/*
+	 * MGMT_STATUS_REJECTED may be returned from kernel because the passive
+	 * scan timer had expired in kernel and passive scan was disabled just
+	 * around the time we called stop_passive_scanning().
+	 */
+	if (status != MGMT_STATUS_SUCCESS && status != MGMT_STATUS_REJECTED) {
 		error("Stopping passive scanning failed: %s",
 							mgmt_errstr(status));
 		return;
-- 
2.0.0.526.g5318336

