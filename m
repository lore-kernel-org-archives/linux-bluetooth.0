Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 11/15] adapter: Remove redundant Devices property
Date: Thu, 29 Nov 2012 13:47:32 +0100
Message-Id: <1354193256-30610-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The ObjectManager interface already reports the list of devices, so the
the property can be entirely removed.
---
 doc/adapter-api.txt |  4 ----
 src/adapter.c       | 30 ------------------------------
 2 files changed, 34 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 132e60f..3582793 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -180,10 +180,6 @@ Properties	string Address [readonly]
 
 			Indicates that a device discovery procedure is active.
 
-		array{object} Devices [readonly]
-
-			List of device object paths.
-
 		array{string} UUIDs [readonly]
 
 			List of 128-bit UUIDs that represents the available
diff --git a/src/adapter.c b/src/adapter.c
index 683833d..1516a1d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1019,9 +1019,6 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 
 	adapter->devices = g_slist_append(adapter->devices, device);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-				adapter->path, ADAPTER_INTERFACE, "Devices");
-
 	return device;
 }
 
@@ -1074,9 +1071,6 @@ void adapter_remove_device(struct btd_adapter *adapter,
 		service_auth_cancel(auth);
 	}
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-				adapter->path, ADAPTER_INTERFACE, "Devices");
-
 	device_remove(dev, remove_storage);
 }
 
@@ -1382,29 +1376,6 @@ static gboolean adapter_property_get_discovering(
 	return TRUE;
 }
 
-static gboolean adapter_property_get_devices(
-					const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct btd_adapter *adapter = data;
-	DBusMessageIter entry;
-	GSList *l;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &entry);
-
-	for (l = adapter->devices; l != NULL; l = l->next) {
-		const char *path = device_get_path(l->data);
-
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
-								&path);
-	}
-
-	dbus_message_iter_close_container(iter, &entry);
-
-	return TRUE;
-}
-
 static gboolean adapter_property_get_uuids(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1689,7 +1660,6 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "PairableTimeout", "u", adapter_property_get_pairable_timeout,
 				adapter_property_set_pairable_timeout },
 	{ "Discovering", "b", adapter_property_get_discovering },
-	{ "Devices", "ao", adapter_property_get_devices },
 	{ "UUIDs", "as", adapter_property_get_uuids },
 	{ }
 };
-- 
1.7.11.7

