Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/3] device: Add paired parameter to device_set_paired
Date: Mon, 19 May 2014 12:16:04 +0200
Message-Id: <1400494566-8135-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to set device state to unpaired.
---
 src/adapter.c |  4 ++--
 src/device.c  | 35 +++++++++++++++++++++++++----------
 src/device.h  |  3 ++-
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4ac2f48..5bc6990 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2755,12 +2755,12 @@ static void load_devices(struct btd_adapter *adapter)
 
 device_exist:
 		if (key_info) {
-			device_set_paired(device, BDADDR_BREDR);
+			device_set_paired(device, BDADDR_BREDR, true);
 			device_set_bonded(device, BDADDR_BREDR);
 		}
 
 		if (ltk_info) {
-			device_set_paired(device, bdaddr_type);
+			device_set_paired(device, bdaddr_type, true);
 			device_set_bonded(device, bdaddr_type);
 		}
 
diff --git a/src/device.c b/src/device.c
index caa5c2a..34a10d9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4085,26 +4085,41 @@ static gboolean start_discovery(gpointer user_data)
 	return FALSE;
 }
 
-void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type)
+void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type, bool paired)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
 
-	if (state->paired)
+	if (state->paired == paired)
 		return;
 
-	state->paired = true;
+	state->paired = paired;
 
-	/* If the other bearer state was alraedy true we don't need to
-	 * send any property signals.
-	 */
-	if (dev->bredr_state.paired == dev->le_state.paired)
-		return;
+	if (state->paired) {
+		/*
+		 * If the other bearer state was already true we don't need to
+		 * send any property signals.
+		 */
+		if (dev->bredr_state.paired == dev->le_state.paired)
+			return;
+	} else {
+		/*
+		 * If the other bearer state is stil true we don't need to
+		 * send any property signals.
+		 */
+		if (dev->bredr_state.paired != dev->le_state.paired)
+			return;
+	}
 
-	if (!state->svc_resolved) {
+
+	if (state->paired && !state->svc_resolved) {
 		dev->pending_paired = true;
 		return;
 	}
 
+	/* If unpaired also remove bonded */
+	if (!state->paired && state->bonded)
+		state->bonded = false;
+
 	g_dbus_emit_property_changed(dbus_conn, dev->path,
 						DEVICE_INTERFACE, "Paired");
 }
@@ -4156,7 +4171,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	if (state->paired)
 		return;
 
-	device_set_paired(device, bdaddr_type);
+	device_set_paired(device, bdaddr_type, true);
 
 	/* If services are already resolved just reply to the pairing
 	 * request
diff --git a/src/device.h b/src/device.h
index 299dd3e..133c9d1 100644
--- a/src/device.h
+++ b/src/device.h
@@ -81,7 +81,8 @@ gboolean device_is_temporary(struct btd_device *device);
 bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
 gboolean device_is_trusted(struct btd_device *device);
-void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
+void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type,
+								bool paired);
 void btd_device_set_temporary(struct btd_device *device, gboolean temporary);
 void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
-- 
1.9.1

