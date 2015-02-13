Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ v2 5/6] core: device: add device_set_rssi_no_delta
Date: Thu, 12 Feb 2015 19:48:36 -0800
Message-Id: <1423799317-28457-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1423799317-28457-1-git-send-email-jpawlowski@google.com>
References: <1423799317-28457-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds new method that allow to update RSSI value without
taking delta into account. It will be used by StartFilteredDiscovery
method, in order to achieve more accurate proximity detection.
---
 src/device.c | 10 ++++++++--
 src/device.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index a28d6fb..6c06c70 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4417,7 +4417,8 @@ void device_set_legacy(struct btd_device *device, bool legacy)
 					DEVICE_INTERFACE, "LegacyPairing");
 }
 
-void device_set_rssi(struct btd_device *device, int8_t rssi)
+void device_set_rssi_no_delta(struct btd_device *device, int8_t rssi,
+			      bool use_delta)
 {
 	if (!device)
 		return;
@@ -4438,7 +4439,7 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 			delta = rssi - device->rssi;
 
 		/* only report changes of 8 dBm or more */
-		if (delta < 8)
+		if (use_delta && delta < 8)
 			return;
 
 		DBG("rssi %d delta %d", rssi, delta);
@@ -4450,6 +4451,11 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 						DEVICE_INTERFACE, "RSSI");
 }
 
+void device_set_rssi(struct btd_device *device, int8_t rssi)
+{
+	device_set_rssi_no_delta(device, rssi, true);
+}
+
 static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index a7fefee..97e6f9e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -89,6 +89,8 @@ void btd_device_set_temporary(struct btd_device *device, gboolean temporary);
 void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
+void device_set_rssi_no_delta(struct btd_device *device, int8_t rssi,
+			      bool use_delta);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
 bool btd_device_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
-- 
2.2.0.rc0.207.ga3a616c

