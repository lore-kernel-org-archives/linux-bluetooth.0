Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 07/15] dbus: Remove org.bluez.Manager
Date: Thu, 29 Nov 2012 13:47:28 +0100
Message-Id: <1354193256-30610-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

After the decision to drop the "default-adapter" feature in the D-Bus
API, the org.bluez.Manager interface can be entirely dropped since it
has been replaced by the ObjectManager.
---
 Makefile.am         |   3 +-
 doc/bluez-docs.xml  |   7 ---
 doc/manager-api.txt |  51 ----------------
 src/adapter.c       |   4 +-
 src/manager.c       | 163 ----------------------------------------------------
 src/manager.h       |   3 -
 6 files changed, 3 insertions(+), 228 deletions(-)
 delete mode 100644 doc/manager-api.txt

diff --git a/Makefile.am b/Makefile.am
index 18522f0..fb1d888 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -334,8 +334,7 @@ CLEANFILES += $(rules_DATA)
 
 EXTRA_DIST += scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules
 
-EXTRA_DIST += doc/manager-api.txt \
-		doc/adapter-api.txt doc/device-api.txt doc/profile-api.txt \
+EXTRA_DIST += doc/adapter-api.txt doc/device-api.txt doc/profile-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/network-api.txt doc/control-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
diff --git a/doc/bluez-docs.xml b/doc/bluez-docs.xml
index a90dde7..814ce00 100644
--- a/doc/bluez-docs.xml
+++ b/doc/bluez-docs.xml
@@ -47,13 +47,6 @@
     </legalnotice>
   </bookinfo>
 
-  <reference id="manager">
-    <title>Manager interface</title>
-    <para>
-<programlisting><xi:include href="manager-api.txt" parse="text" /></programlisting>
-    </para>
-  </reference>
-
   <reference id="adapter">
     <title>Adapter interface</title>
     <para>
diff --git a/doc/manager-api.txt b/doc/manager-api.txt
deleted file mode 100644
index 3add587..0000000
--- a/doc/manager-api.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-BlueZ D-Bus Manager API description
-***********************************
-
-Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
-Copyright (C) 2005-2006  Johan Hedberg <johan.hedberg@nokia.com>
-Copyright (C) 2005-2006  Claudio Takahasi <claudio.takahasi@indt.org.br>
-Copyright (C) 2006-2007  Luiz von Dentz <luiz.dentz@indt.org.br>
-
-
-Manager hierarchy
-=================
-
-Service		org.bluez
-Interface	org.bluez.Manager
-Object path	/
-
-		object DefaultAdapter()
-
-			Returns object path for the default adapter.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NoSuchAdapter
-
-		object FindAdapter(string pattern)
-
-			Returns object path for the specified adapter. Valid
-			patterns are "hci0" or "00:11:22:33:44:55".
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NoSuchAdapter
-
-Signals		AdapterAdded(object adapter)
-
-			Parameter is object path of added adapter.
-
-		AdapterRemoved(object adapter)
-
-			Parameter is object path of removed adapter.
-
-		DefaultAdapterChanged(object adapter)
-
-			Parameter is object path of the new default adapter.
-
-			In case all adapters are removed this signal will not
-			be emitted. The AdapterRemoved signal has to be used
-			to detect that no default adapter is selected or
-			available anymore.
-
-Properties	array{object} Adapters [readonly]
-
-			List of adapter object paths.
diff --git a/src/adapter.c b/src/adapter.c
index f134dfe..89ba34d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -84,6 +84,7 @@
 #define REMOVE_TEMP_TIMEOUT (3 * 60)
 #define PENDING_FOUND_MAX 5
 
+static const char *base_path = "/org/bluez";
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
@@ -2859,7 +2860,6 @@ struct btd_adapter *adapter_create(int id)
 {
 	char path[MAX_PATH_LENGTH];
 	struct btd_adapter *adapter;
-	const char *base_path = manager_get_base_path();
 
 	adapter = g_try_new0(struct btd_adapter, 1);
 	if (!adapter) {
@@ -3489,7 +3489,7 @@ const char *btd_adapter_any_request_path(void)
 	if (adapter_any_refcount++ > 0)
 		return adapter_any_path;
 
-	adapter_any_path = g_strdup_printf("%s/any", manager_get_base_path());
+	adapter_any_path = g_strdup_printf("%s/any", base_path);
 
 	return adapter_any_path;
 }
diff --git a/src/manager.c b/src/manager.c
index 3088dd9..3c415db 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -54,141 +54,11 @@
 #include "error.h"
 #include "manager.h"
 
-static const char *base_path = "/org/bluez";
-
 static int default_adapter_id = -1;
 static GSList *adapters = NULL;
 
-const char *manager_get_base_path(void)
-{
-	return base_path;
-}
-
-static DBusMessage *default_adapter(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	DBusMessage *reply;
-	struct btd_adapter *adapter;
-	const gchar *path;
-
-	adapter = manager_find_adapter_by_id(default_adapter_id);
-	if (!adapter)
-		return btd_error_no_such_adapter(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	path = adapter_get_path(adapter);
-
-	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
-static DBusMessage *find_adapter(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	DBusMessage *reply;
-	struct btd_adapter *adapter;
-	const char *pattern;
-	int dev_id;
-	const gchar *path;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
-							DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	/* hci_devid() would make sense to use here, except it is
-	 * restricted to devices which are up */
-	if (!strcmp(pattern, "any") || !strcmp(pattern, "00:00:00:00:00:00")) {
-		path = adapter_any_get_path();
-		if (path != NULL)
-			goto done;
-		return btd_error_no_such_adapter(msg);
-	} else if (!strncmp(pattern, "hci", 3) && strlen(pattern) >= 4) {
-		dev_id = atoi(pattern + 3);
-		adapter = manager_find_adapter_by_id(dev_id);
-	} else {
-		bdaddr_t bdaddr;
-		str2ba(pattern, &bdaddr);
-		adapter = manager_find_adapter(&bdaddr);
-	}
-
-	if (!adapter)
-		return btd_error_no_such_adapter(msg);
-
-	path = adapter_get_path(adapter);
-
-done:
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
-							DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
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
-static const GDBusMethodTable manager_methods[] = {
-	{ GDBUS_METHOD("DefaultAdapter",
-			NULL, GDBUS_ARGS({ "adapter", "o" }),
-			default_adapter) },
-	{ GDBUS_METHOD("FindAdapter",
-			GDBUS_ARGS({ "pattern", "s" }),
-			GDBUS_ARGS({ "adapter", "o" }),
-			find_adapter) },
-	{ }
-};
-
-static const GDBusSignalTable manager_signals[] = {
-	{ GDBUS_SIGNAL("AdapterAdded",
-			GDBUS_ARGS({ "adapter", "o" })) },
-	{ GDBUS_SIGNAL("AdapterRemoved",
-			GDBUS_ARGS({ "adapter", "o" })) },
-	{ GDBUS_SIGNAL("DefaultAdapterChanged",
-			GDBUS_ARGS({ "adapter", "o" })) },
-	{ }
-};
-
-static const GDBusPropertyTable manager_properties[] = {
-	{ "Adapters", "ao", manager_property_get_adapters },
-	{ }
-};
-
 bool manager_init(const char *path)
 {
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					"/", MANAGER_INTERFACE,
-					manager_methods, manager_signals,
-					manager_properties, NULL, NULL))
-		return false;
-
 	btd_profile_init();
 
 	return true;
@@ -196,21 +66,7 @@ bool manager_init(const char *path)
 
 static void manager_set_default_adapter(int id)
 {
-	struct btd_adapter *adapter;
-	const gchar *path;
-
 	default_adapter_id = id;
-
-	adapter = manager_find_adapter_by_id(id);
-	if (!adapter)
-		return;
-
-	path = adapter_get_path(adapter);
-
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
-				MANAGER_INTERFACE, "DefaultAdapterChanged",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
 }
 
 struct btd_adapter *manager_get_default_adapter(void)
@@ -221,24 +77,15 @@ struct btd_adapter *manager_get_default_adapter(void)
 static void manager_remove_adapter(struct btd_adapter *adapter)
 {
 	uint16_t dev_id = adapter_get_dev_id(adapter);
-	const gchar *path = adapter_get_path(adapter);
 
 	adapters = g_slist_remove(adapters, adapter);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), "/",
-					MANAGER_INTERFACE, "Adapters");
-
 	if (default_adapter_id == dev_id || default_adapter_id < 0) {
 		int new_default = hci_get_route(NULL);
 
 		manager_set_default_adapter(new_default);
 	}
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
-				MANAGER_INTERFACE, "AdapterRemoved",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
 	adapter_remove(adapter);
 	btd_adapter_unref(adapter);
 
@@ -259,9 +106,6 @@ void manager_cleanup(const char *path)
 	}
 
 	btd_start_exit_timer();
-
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-						"/", MANAGER_INTERFACE);
 }
 
 static gint adapter_id_cmp(gconstpointer a, gconstpointer b)
@@ -338,13 +182,6 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 	}
 
 	path = adapter_get_path(adapter);
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
-				MANAGER_INTERFACE, "AdapterAdded",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),  "/",
-					MANAGER_INTERFACE, "Adapters");
 
 	btd_stop_exit_timer();
 
diff --git a/src/manager.h b/src/manager.h
index 4d094b6..fdaabfd 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -25,14 +25,11 @@
 #include <bluetooth/bluetooth.h>
 #include <dbus/dbus.h>
 
-#define MANAGER_INTERFACE "org.bluez.Manager"
-
 typedef void (*adapter_cb) (struct btd_adapter *adapter, gpointer user_data);
 
 bool manager_init(const char *path);
 void manager_cleanup(const char *path);
 
-const char *manager_get_base_path(void);
 struct btd_adapter *manager_find_adapter(const bdaddr_t *sba);
 struct btd_adapter *manager_find_adapter_by_id(int id);
 struct btd_adapter *manager_get_default_adapter(void);
-- 
1.7.11.7

