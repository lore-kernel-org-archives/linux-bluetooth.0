Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 04/17] dbus-common: Remove conn parameter from emit_array_property_changed
Date: Wed, 19 Sep 2012 12:22:06 +0200
Message-ID: <1348050139-27883-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DBusConnection pointer is already stored in connection static variable
so it's redundant to pass it as function parameter.
---
 src/adapter.c     | 7 ++++---
 src/dbus-common.c | 5 ++---
 src/dbus-common.h | 3 +--
 src/device.c      | 6 +++---
 src/manager.c     | 3 +--
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2db3200..fb6a2e5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -811,7 +811,7 @@ static void adapter_update_devices(struct btd_adapter *adapter)
 		devices[i] = (char *) device_get_path(dev);
 	}
 
-	emit_array_property_changed(connection, adapter->path,
+	emit_array_property_changed(adapter->path,
 					ADAPTER_INTERFACE, "Devices",
 					DBUS_TYPE_OBJECT_PATH, &devices, i);
 	g_free(devices);
@@ -837,8 +837,9 @@ static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
 			uuids[i++] = uuid;
 	}
 
-	emit_array_property_changed(connection, adapter->path,
-			ADAPTER_INTERFACE, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
+	emit_array_property_changed(adapter->path,
+					ADAPTER_INTERFACE, "UUIDs",
+					DBUS_TYPE_STRING, &uuids, i);
 
 	g_strfreev(uuids);
 }
diff --git a/src/dbus-common.c b/src/dbus-common.c
index 21395d9..afd07de 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -143,8 +143,7 @@ dbus_bool_t emit_property_changed(const char *path,
 	return g_dbus_send_message(connection, signal);
 }
 
-dbus_bool_t emit_array_property_changed(DBusConnection *conn,
-					const char *path,
+dbus_bool_t emit_array_property_changed(const char *path,
 					const char *interface,
 					const char *name,
 					int type, void *value, int num)
@@ -166,7 +165,7 @@ dbus_bool_t emit_array_property_changed(DBusConnection *conn,
 
 	append_array_variant(&iter, type, value, num);
 
-	return g_dbus_send_message(conn, signal);
+	return g_dbus_send_message(connection, signal);
 }
 
 void set_dbus_connection(DBusConnection *conn)
diff --git a/src/dbus-common.h b/src/dbus-common.h
index ff130ff..823a292 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -34,8 +34,7 @@ dbus_bool_t emit_property_changed(const char *path,
 					const char *name,
 					int type, void *value);
 
-dbus_bool_t emit_array_property_changed(DBusConnection *conn,
-					const char *path,
+dbus_bool_t emit_array_property_changed(const char *path,
 					const char *interface,
 					const char *name,
 					int type, void *value, int num);
diff --git a/src/device.c b/src/device.c
index b732cc6..3e28608 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1377,7 +1377,6 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 
 static void uuids_changed(struct btd_device *device)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	char **uuids;
 	GSList *l;
 	int i;
@@ -1386,8 +1385,9 @@ static void uuids_changed(struct btd_device *device)
 	for (i = 0, l = device->uuids; l; l = l->next, i++)
 		uuids[i] = l->data;
 
-	emit_array_property_changed(conn, device->path, DEVICE_INTERFACE,
-					"UUIDs", DBUS_TYPE_STRING, &uuids, i);
+	emit_array_property_changed(device->path,
+					DEVICE_INTERFACE, "UUIDs",
+					DBUS_TYPE_STRING, &uuids, i);
 
 	g_free(uuids);
 }
diff --git a/src/manager.c b/src/manager.c
index 738bf0b..31feb84 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -217,8 +217,7 @@ static void manager_update_adapters(void)
 		i++;
 	}
 
-	emit_array_property_changed(connection, "/",
-					MANAGER_INTERFACE, "Adapters",
+	emit_array_property_changed("/", MANAGER_INTERFACE, "Adapters",
 					DBUS_TYPE_OBJECT_PATH, &array, i);
 
 	g_free(array);
-- 
1.7.11.3

