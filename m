Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 2/7] manager: Remove redundant D-Bus signals
Date: Thu,  8 Nov 2012 15:30:10 +0100
Message-Id: <1352385015-2127-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
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
index 1cebb27..b6e4a0f 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -99,14 +99,6 @@ Object path	/
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
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
index 598c081..f07cefe 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -171,14 +171,6 @@ static const GDBusMethodTable manager_methods[] = {
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
@@ -192,7 +184,7 @@ dbus_bool_t manager_init(const char *path)
 
 	return g_dbus_register_interface(btd_get_dbus_connection(),
 					"/", MANAGER_INTERFACE,
-					manager_methods, manager_signals,
+					manager_methods, NULL,
 					manager_properties, NULL, NULL);
 }
 
@@ -215,7 +207,6 @@ struct btd_adapter *manager_get_default_adapter(void)
 static void manager_remove_adapter(struct btd_adapter *adapter)
 {
 	uint16_t dev_id = adapter_get_dev_id(adapter);
-	const gchar *path = adapter_get_path(adapter);
 
 	adapters = g_slist_remove(adapters, adapter);
 
@@ -228,11 +219,6 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 		manager_set_default_adapter(new_default);
 	}
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
-				MANAGER_INTERFACE, "AdapterRemoved",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
 	adapter_remove(adapter);
 	btd_adapter_unref(adapter);
 
@@ -332,10 +318,6 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 	}
 
 	path = adapter_get_path(adapter);
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
-				MANAGER_INTERFACE, "AdapterAdded",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),  "/",
 					MANAGER_INTERFACE, "Adapters");
-- 
1.7.11.7

