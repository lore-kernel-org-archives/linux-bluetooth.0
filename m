Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 04/13] core/dbus-common: Add dict helpers for basic keys
Date: Thu, 16 Apr 2015 17:41:06 +0300
Message-Id: <1429195275-19635-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
References: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The specification allows any basic type to be key:

  'A DICT_ENTRY works exactly like a struct, but rather than parentheses
   it uses curly braces, and it has more restrictions. The restrictions
   are: it occurs only as an array element type; it has exactly two
   single complete types inside the curly braces; the first single
   complete type (the "key") must be a basic type rather than a
   container type...'
---
 src/dbus-common.c | 27 +++++++++++++++++++++------
 src/dbus-common.h |  5 +++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 936616b..adb0a7a 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -83,8 +83,8 @@ static void append_array_variant(DBusMessageIter *iter, int type, void *val,
 	dbus_message_iter_close_container(iter, &variant);
 }
 
-void dict_append_entry(DBusMessageIter *dict,
-			const char *key, int type, void *val)
+void dict_append_basic(DBusMessageIter *dict, int key_type, const void *key,
+						int type, void *val)
 {
 	DBusMessageIter entry;
 
@@ -97,28 +97,43 @@ void dict_append_entry(DBusMessageIter *dict,
 	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
 							NULL, &entry);
 
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_append_basic(&entry, key_type, key);
 
 	append_variant(&entry, type, val);
 
 	dbus_message_iter_close_container(dict, &entry);
+
 }
 
-void dict_append_array(DBusMessageIter *dict, const char *key, int type,
-			void *val, int n_elements)
+void dict_append_entry(DBusMessageIter *dict,
+			const char *key, int type, void *val)
+{
+	dict_append_basic(dict, DBUS_TYPE_STRING, &key, type, val);
+}
+
+void dict_append_basic_array(DBusMessageIter *dict, int key_type,
+					const void *key, int type, void *val,
+					int n_elements)
 {
 	DBusMessageIter entry;
 
 	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
 						NULL, &entry);
 
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_append_basic(&entry, key_type, key);
 
 	append_array_variant(&entry, type, val, n_elements);
 
 	dbus_message_iter_close_container(dict, &entry);
 }
 
+void dict_append_array(DBusMessageIter *dict, const char *key, int type,
+			void *val, int n_elements)
+{
+	dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
+								n_elements);
+}
+
 void set_dbus_connection(DBusConnection *conn)
 {
 	connection = conn;
diff --git a/src/dbus-common.h b/src/dbus-common.h
index f331b2f..2e7d51e 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -21,9 +21,14 @@
  *
  */
 
+void dict_append_basic(DBusMessageIter *dict, int key_type, const void *key,
+						int type, void *val);
 void dict_append_entry(DBusMessageIter *dict,
 			const char *key, int type, void *val);
 
+void dict_append_basic_array(DBusMessageIter *dict, int key_type,
+					const void *key, int type, void *val,
+					int n_elements);
 void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 			void *val, int n_elements);
 
-- 
2.1.0

