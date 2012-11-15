Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 05/16] manager: Move org.bluez.Manager to org/bluez
Date: Thu, 15 Nov 2012 16:09:08 +0100
Message-Id: <1352992159-11559-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Avoid using the root path to make the manager also a managed object,
handled by the ObjectManager. This is also more consistent with how
org.bluez.ProfileManager is being exposed.
---
 doc/manager-api.txt |  2 +-
 src/manager.c       | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index b0d534d..cf3284a 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -12,7 +12,7 @@ Manager hierarchy
 
 Service		org.bluez
 Interface	org.bluez.Manager
-Object path	/
+Object path	/org/bluez
 
 		object DefaultAdapter()
 
diff --git a/src/manager.c b/src/manager.c
index 79d049b..d6e7b80 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -186,7 +186,7 @@ static const GDBusPropertyTable manager_properties[] = {
 bool manager_init(const char *path)
 {
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					"/", MANAGER_INTERFACE,
+					base_path, MANAGER_INTERFACE,
 					manager_methods, manager_signals,
 					manager_properties, NULL, NULL))
 		return false;
@@ -209,7 +209,7 @@ static void manager_set_default_adapter(int id)
 
 	path = adapter_get_path(adapter);
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
+	g_dbus_emit_signal(btd_get_dbus_connection(), base_path,
 				MANAGER_INTERFACE, "DefaultAdapterChanged",
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
@@ -227,7 +227,7 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 
 	adapters = g_slist_remove(adapters, adapter);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), "/",
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), base_path,
 					MANAGER_INTERFACE, "Adapters");
 
 	if (default_adapter_id == dev_id || default_adapter_id < 0) {
@@ -236,7 +236,7 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 		manager_set_default_adapter(new_default);
 	}
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
+	g_dbus_emit_signal(btd_get_dbus_connection(), base_path,
 				MANAGER_INTERFACE, "AdapterRemoved",
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
@@ -263,7 +263,7 @@ void manager_cleanup(const char *path)
 	btd_start_exit_timer();
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
-						"/", MANAGER_INTERFACE);
+						base_path, MANAGER_INTERFACE);
 }
 
 static gint adapter_id_cmp(gconstpointer a, gconstpointer b)
@@ -340,12 +340,12 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 	}
 
 	path = adapter_get_path(adapter);
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
+	g_dbus_emit_signal(btd_get_dbus_connection(), base_path,
 				MANAGER_INTERFACE, "AdapterAdded",
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),  "/",
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),  base_path,
 					MANAGER_INTERFACE, "Adapters");
 
 	btd_stop_exit_timer();
-- 
1.7.11.7

