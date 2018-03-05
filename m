Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] device: Fix bearer selection with single mode controller
Date: Mon,  5 Mar 2018 17:16:35 +0100
Message-Id: <20180305161635.25898-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote device is dual mode and advertises without "BR/EDR flag
not supported" set than device is marked as supporting BR/EDR
even if controller is doing LE only. This results in bluetoothd
trying to connect over BR/EDR since this is prefered transport
if none is connected.

Fix this by checking if adapter supports specified technology
before doing heuristic transport selection.
---
 src/adapter.c | 8 ++++++++
 src/adapter.h | 1 +
 src/device.c  | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0fc9f840e..67dd20b79 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4326,6 +4326,14 @@ bool btd_adapter_get_discoverable(struct btd_adapter *adapter)
 	return false;
 }
 
+bool btd_adapter_get_bredr(struct btd_adapter *adapter)
+{
+	if (adapter->current_settings & MGMT_SETTING_BREDR)
+		return true;
+
+	return false;
+}
+
 struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter)
 {
 	if (!adapter)
diff --git a/src/adapter.h b/src/adapter.h
index e619a5be9..016d3d75b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -75,6 +75,7 @@ bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 bool btd_adapter_get_powered(struct btd_adapter *adapter);
 bool btd_adapter_get_connectable(struct btd_adapter *adapter);
 bool btd_adapter_get_discoverable(struct btd_adapter *adapter);
+bool btd_adapter_get_bredr(struct btd_adapter *adapter);
 
 struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter);
 
diff --git a/src/device.c b/src/device.c
index 8eb99e4bd..b86a35c81 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1863,7 +1863,7 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	 * Prefer BR/EDR if time is the same since it might be from an
 	 * advertisement with BR/EDR flag set.
 	 */
-	if (bredr_last <= le_last)
+	if (bredr_last <= le_last && btd_adapter_get_bredr(dev->adapter))
 		return BDADDR_BREDR;
 
 	return dev->bdaddr_type;
-- 
2.14.3

