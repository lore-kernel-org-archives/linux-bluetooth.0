Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] code: Improve handling of unpaired event
Date: Mon, 19 May 2014 19:33:50 +0200
Message-Id: <1400520830-12651-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unpaired event is per bearer and and bluetoothd should unpair device
only on that bearer.
---
 src/adapter.c | 44 ++++++++++++++++++++++++++++++++++++++------
 src/device.c  | 32 ++++++++++++++++++++++++++++++++
 src/device.h  |  1 +
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4ac2f48..f5f8c8c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6336,6 +6336,42 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 		btd_adapter_remove_device(adapter, device);
 }
 
+static void remove_keys(struct btd_adapter *adapter,
+					struct btd_device *device, uint8_t type)
+{
+	char adapter_addr[18];
+	char device_addr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	gsize length = 0;
+	char *str;
+
+	ba2str(btd_adapter_get_address(adapter), adapter_addr);
+	ba2str(device_get_address(device), device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+								device_addr);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	if (type == BDADDR_BREDR) {
+		g_key_file_remove_group(key_file, "LinkKey", NULL);
+	} else {
+		g_key_file_remove_group(key_file, "LongTermKey", NULL);
+		g_key_file_remove_group(key_file, "LocalSignatureKey", NULL);
+		g_key_file_remove_group(key_file, "RemoteSignatureKey", NULL);
+		g_key_file_remove_group(key_file, "IdentityResolvingKey", NULL);
+	}
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 static void unpaired_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -6360,12 +6396,8 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	btd_device_set_temporary(device, TRUE);
-
-	if (btd_device_is_connected(device))
-		device_request_disconnect(device, NULL);
-	else
-		btd_adapter_remove_device(adapter, device);
+	remove_keys(adapter, device, ev->addr.type);
+	device_set_unpaired(device, ev->addr.type);
 }
 
 static void read_info_complete(uint8_t status, uint16_t length,
diff --git a/src/device.c b/src/device.c
index caa5c2a..8222610 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4109,6 +4109,38 @@ void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type)
 						DEVICE_INTERFACE, "Paired");
 }
 
+void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type)
+{
+	struct bearer_state *state = get_state(dev, bdaddr_type);
+
+	if (!state->paired)
+		return;
+
+	state->paired = false;
+
+	/*
+	 * If the other bearer state is still true we don't need to
+	 * send any property signals or remove device.
+	 */
+	if (dev->bredr_state.paired != dev->le_state.paired) {
+		/* TODO disconnect only unpaired bearer */
+		if (state->connected)
+			device_request_disconnect(dev, NULL);
+
+		return;
+	}
+
+	g_dbus_emit_property_changed(dbus_conn, dev->path,
+						DEVICE_INTERFACE, "Paired");
+
+	btd_device_set_temporary(dev, TRUE);
+
+	if (btd_device_is_connected(dev))
+		device_request_disconnect(dev, NULL);
+	else
+		btd_adapter_remove_device(dev->adapter, dev);
+}
+
 static void device_auth_req_free(struct btd_device *device)
 {
 	struct authentication_req *authr = device->authr;
diff --git a/src/device.h b/src/device.h
index 299dd3e..2e0473e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -82,6 +82,7 @@ bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
+void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
 void btd_device_set_temporary(struct btd_device *device, gboolean temporary);
 void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
-- 
1.9.0

