Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 10/16] manager: Remove AdapterAdded/AdapterRemoved signals
Date: Thu, 15 Nov 2012 16:09:13 +0100
Message-Id: <1352992159-11559-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The Manager interface already reports changes in the adapter list in
form of property changes, so there is no need to keep these two signals
any more.
---
 doc/manager-api.txt |  8 --------
 src/manager.c       | 20 +-------------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index b89ab68..693a981 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -25,14 +25,6 @@ Object path	/org/bluez
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NoSuchAdapter
 
-Signals		AdapterAdded(object adapter)
-
-			Parameter is object path of added adapter.
-
-		AdapterRemoved(object adapter)
-
-			Parameter is object path of removed adapter.
-
 Properties	array{object} Adapters [readonly]
 
 			List of adapter object paths.
diff --git a/src/manager.c b/src/manager.c
index 08d6625..954ab8a 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -167,14 +167,6 @@ static const GDBusMethodTable manager_methods[] = {
 	{ }
 };
 
-static const GDBusSignalTable manager_signals[] = {
-	{ GDBUS_SIGNAL("AdapterAdded",
-			GDBUS_ARGS({ "adapter", "o" })) },
-	{ GDBUS_SIGNAL("AdapterRemoved",
-			GDBUS_ARGS({ "adapter", "o" })) },
-	{ }
-};
-
 static const GDBusPropertyTable manager_properties[] = {
 	{ "Adapters", "ao", manager_property_get_adapters },
 	{ "DefaultAdapter", "o", manager_property_get_default_adapter, NULL,
@@ -186,7 +178,7 @@ bool manager_init(const char *path)
 {
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					base_path, MANAGER_INTERFACE,
-					manager_methods, manager_signals,
+					manager_methods, NULL,
 					manager_properties, NULL, NULL))
 		return false;
 
@@ -214,7 +206,6 @@ struct btd_adapter *manager_get_default_adapter(void)
 static void manager_remove_adapter(struct btd_adapter *adapter)
 {
 	uint16_t dev_id = adapter_get_dev_id(adapter);
-	const gchar *path = adapter_get_path(adapter);
 
 	adapters = g_slist_remove(adapters, adapter);
 
@@ -227,11 +218,6 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 		manager_set_default_adapter(new_default);
 	}
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), base_path,
-				MANAGER_INTERFACE, "AdapterRemoved",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
 	adapter_remove(adapter);
 	btd_adapter_unref(adapter);
 
@@ -331,10 +317,6 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 	}
 
 	path = adapter_get_path(adapter);
-	g_dbus_emit_signal(btd_get_dbus_connection(), base_path,
-				MANAGER_INTERFACE, "AdapterAdded",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),  base_path,
 					MANAGER_INTERFACE, "Adapters");
-- 
1.7.11.7

