Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 3/7] manager: Remove redundant Adapters property
Date: Thu,  8 Nov 2012 15:30:11 +0100
Message-Id: <1352385015-2127-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The ObjectManager interface already reports the available adapters, so
the property can be entirely removed.
---
 doc/manager-api.txt |  6 +-----
 src/manager.c       | 30 ------------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index b6e4a0f..d225239 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -99,10 +99,6 @@ Object path	/
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
-Properties	array{object} Adapters [readonly]
-
-			List of adapter object paths.
-
-		object DefaultAdapter [readonly, optional]
+Properties	object DefaultAdapter [readonly, optional]
 
 			Object path for the default adapter, if any.
diff --git a/src/manager.c b/src/manager.c
index f07cefe..d3e37b1 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -109,29 +109,6 @@ done:
 	return reply;
 }
 
-static gboolean manager_property_get_adapters(
-					const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	DBusMessageIter entry;
-	GSList *l;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &entry);
-
-	for (l = adapters; l != NULL; l = l->next) {
-		struct btd_adapter *adapter = l->data;
-		const char *path = adapter_get_path(adapter);
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
 static gboolean manager_property_get_default_adapter(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -172,7 +149,6 @@ static const GDBusMethodTable manager_methods[] = {
 };
 
 static const GDBusPropertyTable manager_properties[] = {
-	{ "Adapters", "ao", manager_property_get_adapters },
 	{ "DefaultAdapter", "o", manager_property_get_default_adapter, NULL,
 				manager_property_exists_default_adapter },
 	{ }
@@ -210,9 +186,6 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 
 	adapters = g_slist_remove(adapters, adapter);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), "/",
-					MANAGER_INTERFACE, "Adapters");
-
 	if (default_adapter_id == dev_id || default_adapter_id < 0) {
 		int new_default = hci_get_route(NULL);
 
@@ -319,9 +292,6 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 
 	path = adapter_get_path(adapter);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),  "/",
-					MANAGER_INTERFACE, "Adapters");
-
 	btd_stop_exit_timer();
 
 	if (default_adapter_id < 0)
-- 
1.7.11.7

