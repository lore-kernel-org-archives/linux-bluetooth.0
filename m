Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 03/13] Rename device_set_temporary to btd_device_set_temporary
Date: Mon, 25 Nov 2013 22:15:42 +0000
Message-Id: <1385417752-25664-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 src/adapter.c | 12 ++++++------
 src/device.c  | 14 +++++++-------
 src/device.h  |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8a6dadf..ccd3c43 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1012,7 +1012,7 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 	if (!device)
 		return NULL;
 
-	device_set_temporary(device, TRUE);
+	btd_device_set_temporary(device, TRUE);
 
 	adapter->devices = g_slist_append(adapter->devices, device);
 
@@ -2156,7 +2156,7 @@ static DBusMessage *remove_device(DBusConnection *conn,
 
 	device = list->data;
 
-	device_set_temporary(device, TRUE);
+	btd_device_set_temporary(device, TRUE);
 
 	if (!device_is_connected(device)) {
 		adapter_remove_device(adapter, device);
@@ -2532,7 +2532,7 @@ static void load_devices(struct btd_adapter *adapter)
 		if (!device)
 			goto free;
 
-		device_set_temporary(device, FALSE);
+		btd_device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
 
 		/* TODO: register services from pre-loaded list of primaries */
@@ -5294,7 +5294,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, TRUE);
 
 		if (device_is_temporary(device))
-			device_set_temporary(device, FALSE);
+			btd_device_set_temporary(device, FALSE);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
@@ -5392,7 +5392,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, TRUE);
 
 		if (device_is_temporary(device))
-			device_set_temporary(device, FALSE);
+			btd_device_set_temporary(device, FALSE);
 	}
 
 	if (ev->key.master)
@@ -5860,7 +5860,7 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	device_set_temporary(device, TRUE);
+	btd_device_set_temporary(device, TRUE);
 
 	if (device_is_connected(device))
 		device_request_disconnect(device, NULL);
diff --git a/src/device.c b/src/device.c
index c0e317d..59e65b9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -997,7 +997,7 @@ int device_block(struct btd_device *device, gboolean update_only)
 
 	store_device_info(device);
 
-	device_set_temporary(device, FALSE);
+	btd_device_set_temporary(device, FALSE);
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Blocked");
@@ -1152,7 +1152,7 @@ static void device_profile_connected(struct btd_device *dev,
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
 
 	if (!err)
-		device_set_temporary(dev, FALSE);
+		btd_device_set_temporary(dev, FALSE);
 
 	if (dev->pending == NULL)
 		return;
@@ -1308,7 +1308,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 	if (!btd_adapter_get_powered(dev->adapter))
 		return btd_error_not_ready(msg);
 
-	device_set_temporary(dev, FALSE);
+	btd_device_set_temporary(dev, FALSE);
 
 	if (!dev->svc_resolved)
 		goto resolve_services;
@@ -1358,7 +1358,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 		if (device_is_connected(dev))
 			return dbus_message_new_method_return(msg);
 
-		device_set_temporary(dev, FALSE);
+		btd_device_set_temporary(dev, FALSE);
 
 		dev->disable_auto_connect = FALSE;
 
@@ -1609,7 +1609,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	uint8_t io_cap;
 	int err;
 
-	device_set_temporary(device, FALSE);
+	btd_device_set_temporary(device, FALSE);
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
@@ -3112,7 +3112,7 @@ static void register_all_services(struct browse_req *req, GSList *services)
 {
 	struct btd_device *device = req->device;
 
-	device_set_temporary(device, FALSE);
+	btd_device_set_temporary(device, FALSE);
 
 	update_gatt_services(req, device->primaries, services);
 	g_slist_free_full(device->primaries, g_free);
@@ -3549,7 +3549,7 @@ gboolean device_is_temporary(struct btd_device *device)
 	return device->temporary;
 }
 
-void device_set_temporary(struct btd_device *device, gboolean temporary)
+void btd_device_set_temporary(struct btd_device *device, gboolean temporary)
 {
 	if (!device)
 		return;
diff --git a/src/device.h b/src/device.h
index deec8d0..35d2a75 100644
--- a/src/device.h
+++ b/src/device.h
@@ -69,7 +69,7 @@ gboolean device_is_paired(struct btd_device *device);
 gboolean device_is_bonded(struct btd_device *device);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *device, gboolean paired);
-void device_set_temporary(struct btd_device *device, gboolean temporary);
+void btd_device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_legacy(struct btd_device *device, bool legacy);
-- 
1.8.4.4

