Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 2/2] core: Remove unused emit_array_property_changed function
Date: Fri, 14 Dec 2012 12:13:30 -0200
Message-Id: <1355494410-24627-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1355494410-24627-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1355494410-24627-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/dbus-common.c | 25 -------------------------
 src/dbus-common.h |  5 -----
 2 files changed, 30 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 42afa55..d466a8f 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -118,31 +118,6 @@ void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 	dbus_message_iter_close_container(dict, &entry);
 }
 
-dbus_bool_t emit_array_property_changed(const char *path,
-					const char *interface,
-					const char *name,
-					int type, void *value, int num)
-{
-	DBusMessage *signal;
-	DBusMessageIter iter;
-
-	signal = dbus_message_new_signal(path, interface, "PropertyChanged");
-
-	if (!signal) {
-		error("Unable to allocate new %s.PropertyChanged signal",
-				interface);
-		return FALSE;
-	}
-
-	dbus_message_iter_init_append(signal, &iter);
-
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
-
-	append_array_variant(&iter, type, value, num);
-
-	return g_dbus_send_message(connection, signal);
-}
-
 void set_dbus_connection(DBusConnection *conn)
 {
 	connection = conn;
diff --git a/src/dbus-common.h b/src/dbus-common.h
index 825560d..e2ea365 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -29,11 +29,6 @@ void dict_append_entry(DBusMessageIter *dict,
 void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 			void *val, int n_elements);
 
-dbus_bool_t emit_array_property_changed(const char *path,
-					const char *interface,
-					const char *name,
-					int type, void *value, int num);
-
 void set_dbus_connection(DBusConnection *conn);
 DBusConnection *btd_get_dbus_connection(void);
 
-- 
1.8.0.2

