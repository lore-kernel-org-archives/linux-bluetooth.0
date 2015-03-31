Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v7 1/8] core: device: add device_set_rssi_with_delta
Date: Tue, 31 Mar 2015 00:33:23 -0700
Message-Id: <1427787210-4436-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1427787210-4436-1-git-send-email-jpawlowski@google.com>
References: <1427787210-4436-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds new method that allow to update RSSI value with
given delta threshold. It will be used in upcoming patches with
SetDiscoveryFilter, in order to disable delta threshold.
---
 src/device.c | 14 +++++++++++---
 src/device.h |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8ad62d3..91dea27 100644
--- a/src/device.c
+++ b/src/device.c
@@ -83,6 +83,8 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+#define RSSI_THRESHOLD		8
+
 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
 
@@ -4547,7 +4549,8 @@ void device_set_legacy(struct btd_device *device, bool legacy)
 					DEVICE_INTERFACE, "LegacyPairing");
 }
 
-void device_set_rssi(struct btd_device *device, int8_t rssi)
+void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
+							int8_t delta_threshold)
 {
 	if (!device)
 		return;
@@ -4567,8 +4570,8 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 		else
 			delta = rssi - device->rssi;
 
-		/* only report changes of 8 dBm or more */
-		if (delta < 8)
+		/* only report changes of delta_threshold dBm or more */
+		if (delta < delta_threshold)
 			return;
 
 		DBG("rssi %d delta %d", rssi, delta);
@@ -4580,6 +4583,11 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 						DEVICE_INTERFACE, "RSSI");
 }
 
+void device_set_rssi(struct btd_device *device, int8_t rssi)
+{
+	device_set_rssi_with_delta(device, rssi, RSSI_THRESHOLD);
+}
+
 static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index b17f53a..9e86469 100644
--- a/src/device.h
+++ b/src/device.h
@@ -90,6 +90,8 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary);
 void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
+void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
+							int8_t delta_threshold);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
 bool btd_device_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
-- 
2.2.0.rc0.207.ga3a616c

