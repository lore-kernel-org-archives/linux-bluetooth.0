Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 01/16] client: Add D-Bus helper library
Date: Fri, 25 May 2012 12:11:18 +0200
Message-Id: <1337940693-3417-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

No functionality changes. This is just about avoiding duplicated code.
---
 Makefile.am       |    1 +
 client/dbus.c     |  256 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/dbus.h     |   66 ++++++++++++++
 client/ftp.c      |   42 ++--------
 client/session.c  |   42 +--------
 client/transfer.c |   42 +--------
 6 files changed, 339 insertions(+), 110 deletions(-)
 create mode 100644 client/dbus.c
 create mode 100644 client/dbus.h

diff --git a/Makefile.am b/Makefile.am
index 3cde6c0..86f9ad1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -126,6 +126,7 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
 				client/transport.h client/transport.c \
+				client/dbus.h client/dbus.c \
 				client/driver.h client/driver.c \
 				src/map_ap.h src/map_ap.c
 
diff --git a/client/dbus.c b/client/dbus.c
new file mode 100644
index 0000000..c8f86f8
--- /dev/null
+++ b/client/dbus.c
@@ -0,0 +1,256 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "log.h"
+#include "dbus.h"
+
+static void append_variant(DBusMessageIter *iter,
+				int type, void *value)
+{
+	char sig[2];
+	DBusMessageIter valueiter;
+
+	sig[0] = type;
+	sig[1] = 0;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						sig, &valueiter);
+
+	dbus_message_iter_append_basic(&valueiter, type, value);
+
+	dbus_message_iter_close_container(iter, &valueiter);
+}
+
+void obex_dbus_dict_append(DBusMessageIter *dict,
+			const char *key, int type, void *value)
+{
+	DBusMessageIter keyiter;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) value);
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &keyiter);
+
+	dbus_message_iter_append_basic(&keyiter, DBUS_TYPE_STRING, &key);
+
+	append_variant(&keyiter, type, value);
+
+	dbus_message_iter_close_container(dict, &keyiter);
+}
+
+static void append_array_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter variant, array;
+	char typesig[2];
+	char arraysig[3];
+	const char **str_array = *(const char ***) val;
+	int i;
+
+	arraysig[0] = DBUS_TYPE_ARRAY;
+	arraysig[1] = typesig[0] = type;
+	arraysig[2] = typesig[1] = '\0';
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						arraysig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+
+	for (i = 0; str_array[i]; i++)
+		dbus_message_iter_append_basic(&array, type,
+						&(str_array[i]));
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+void obex_dbus_dict_append_array(DBusMessageIter *dict, const char *key,
+				int type, void *val)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_array_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void append_dict_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter variant, array, entry;
+	char typesig[5];
+	char arraysig[6];
+	const void **val_array = *(const void ***) val;
+	int i;
+
+	arraysig[0] = DBUS_TYPE_ARRAY;
+	arraysig[1] = typesig[0] = DBUS_DICT_ENTRY_BEGIN_CHAR;
+	arraysig[2] = typesig[1] = DBUS_TYPE_STRING;
+	arraysig[3] = typesig[2] = type;
+	arraysig[4] = typesig[3] = DBUS_DICT_ENTRY_END_CHAR;
+	arraysig[5] = typesig[4] = '\0';
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						arraysig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+
+	for (i = 0; val_array[i]; i += 2) {
+		dbus_message_iter_open_container(&array, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+						&(val_array[i + 0]));
+
+		/*
+		 * D-Bus expects a char** or uint8* depending on the type
+		 * given. Since we are dealing with an array through a void**
+		 * (and thus val_array[i] is a pointer) we need to
+		 * differentiate DBUS_TYPE_STRING from the others. The other
+		 * option would be the user to pass the exact type to this
+		 * function, instead of a pointer to it. However in this case
+		 * a cast from type to void* would be needed, which is not
+		 * good.
+		 */
+		if (type == DBUS_TYPE_STRING) {
+			dbus_message_iter_append_basic(&entry, type,
+							&(val_array[i + 1]));
+		} else {
+			dbus_message_iter_append_basic(&entry, type,
+							val_array[i + 1]);
+		}
+
+		dbus_message_iter_close_container(&array, &entry);
+	}
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+void obex_dbus_dict_append_dict(DBusMessageIter *dict, const char *key,
+				int type, void *val)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_dict_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+int obex_dbus_signal_property_changed(DBusConnection *conn,
+					const char *path,
+					const char *interface,
+					const char *name,
+					int type, void *value)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	signal = dbus_message_new_signal(path, interface, "PropertyChanged");
+	if (signal == NULL) {
+		error("Unable to allocate new %s.PropertyChanged signal",
+				interface);
+		return -1;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	append_variant(&iter, type, value);
+
+	return g_dbus_send_message(conn, signal);
+}
+
+int obex_dbus_signal_array_property_changed(DBusConnection *conn,
+						const char *path,
+						const char *interface,
+						const char *name,
+						int type, void *value)
+
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	signal = dbus_message_new_signal(path, interface, "PropertyChanged");
+	if (signal == NULL) {
+		error("Unable to allocate new %s.PropertyChanged signal",
+				interface);
+		return -1;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	append_array_variant(&iter, type, value);
+
+	return g_dbus_send_message(conn, signal);
+}
+
+int obex_dbus_signal_dict_property_changed(DBusConnection *conn,
+						const char *path,
+						const char *interface,
+						const char *name,
+						int type, void *value)
+
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	signal = dbus_message_new_signal(path, interface, "PropertyChanged");
+	if (signal == NULL) {
+		error("Unable to allocate new %s.PropertyChanged signal",
+				interface);
+		return -1;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	append_dict_variant(&iter, type, value);
+
+	return g_dbus_send_message(conn, signal);
+}
diff --git a/client/dbus.h b/client/dbus.h
new file mode 100644
index 0000000..d861c1a
--- /dev/null
+++ b/client/dbus.h
@@ -0,0 +1,66 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __OBEX_DBUS_H
+#define __OBEX_DBUS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <dbus/dbus.h>
+
+/* Essentially a{sv} */
+#define OBC_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING \
+					DBUS_TYPE_STRING_AS_STRING \
+					DBUS_TYPE_VARIANT_AS_STRING \
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+
+void obex_dbus_dict_append(DBusMessageIter *dict, const char *key, int type,
+				void *value);
+
+void obex_dbus_dict_append_array(DBusMessageIter *dict, const char *key,
+					int type, void *val);
+
+void obex_dbus_dict_append_dict(DBusMessageIter *dict, const char *key,
+					int type, void *val);
+
+int obex_dbus_signal_property_changed(DBusConnection *conn, const char *path,
+					const char *interface, const char *name,
+					int type, void *value);
+
+int obex_dbus_signal_array_property_changed(DBusConnection *conn,
+						const char *path,
+						const char *interface,
+						const char *name, int type,
+						void *value);
+
+int obex_dbus_signal_dict_property_changed(DBusConnection *conn,
+						const char *path,
+						const char *interface,
+						const char *name, int type,
+						void *value);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OBEX_DBUS_H */
diff --git a/client/ftp.c b/client/ftp.c
index 8585566..9b2c51d 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -30,6 +30,7 @@
 
 #include <gdbus.h>
 
+#include "dbus.h"
 #include "log.h"
 
 #include "transfer.h"
@@ -95,39 +96,6 @@ static DBusMessage *change_folder(DBusConnection *connection,
 	return NULL;
 }
 
-static void append_variant(DBusMessageIter *iter, int type, void *val)
-{
-	DBusMessageIter value;
-	char sig[2] = { type, '\0' };
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
-
-	dbus_message_iter_append_basic(&value, type, val);
-
-	dbus_message_iter_close_container(iter, &value);
-}
-
-static void dict_append_entry(DBusMessageIter *dict,
-			const char *key, int type, void *val)
-{
-	DBusMessageIter entry;
-
-	if (type == DBUS_TYPE_STRING) {
-		const char *str = *((const char **) val);
-		if (str == NULL)
-			return;
-	}
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-
-	append_variant(&entry, type, val);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
 static void xml_element(GMarkupParseContext *ctxt,
 			const gchar *element,
 			const gchar **names,
@@ -147,7 +115,7 @@ static void xml_element(GMarkupParseContext *ctxt,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &element);
+	obex_dbus_dict_append(&dict, "Type", DBUS_TYPE_STRING, &element);
 
 	/* FIXME: User, Group, Other permission must be reviewed */
 
@@ -157,9 +125,11 @@ static void xml_element(GMarkupParseContext *ctxt,
 		if (g_str_equal("Size", key) == TRUE) {
 			guint64 size;
 			size = g_ascii_strtoll(values[i], NULL, 10);
-			dict_append_entry(&dict, key, DBUS_TYPE_UINT64, &size);
+			obex_dbus_dict_append(&dict, key, DBUS_TYPE_UINT64,
+								&size);
 		} else
-			dict_append_entry(&dict, key, DBUS_TYPE_STRING, &values[i]);
+			obex_dbus_dict_append(&dict, key, DBUS_TYPE_STRING,
+								&values[i]);
 	}
 
 	dbus_message_iter_close_container(iter, &dict);
diff --git a/client/session.c b/client/session.c
index 1c5e452..94256b4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -37,6 +37,7 @@
 #include <gdbus.h>
 #include <gobex.h>
 
+#include "dbus.h"
 #include "log.h"
 #include "transfer.h"
 #include "session.h"
@@ -582,40 +583,6 @@ static DBusMessage *release_agent(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void append_entry(DBusMessageIter *dict,
-				const char *key, int type, void *val)
-{
-	DBusMessageIter entry, value;
-	const char *signature;
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-								NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-
-	switch (type) {
-	case DBUS_TYPE_STRING:
-		signature = DBUS_TYPE_STRING_AS_STRING;
-		break;
-	case DBUS_TYPE_BYTE:
-		signature = DBUS_TYPE_BYTE_AS_STRING;
-		break;
-	case DBUS_TYPE_UINT64:
-		signature = DBUS_TYPE_UINT64_AS_STRING;
-		break;
-	default:
-		signature = DBUS_TYPE_VARIANT_AS_STRING;
-		break;
-	}
-
-	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
-							signature, &value);
-	dbus_message_iter_append_basic(&value, type, val);
-	dbus_message_iter_close_container(&entry, &value);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
 static DBusMessage *session_get_properties(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
@@ -635,13 +602,14 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	if (session->source != NULL)
-		append_entry(&dict, "Source", DBUS_TYPE_STRING,
+		obex_dbus_dict_append(&dict, "Source", DBUS_TYPE_STRING,
 							&session->source);
 
-	append_entry(&dict, "Destination", DBUS_TYPE_STRING,
+	obex_dbus_dict_append(&dict, "Destination", DBUS_TYPE_STRING,
 							&session->destination);
 
-	append_entry(&dict, "Channel", DBUS_TYPE_BYTE, &session->channel);
+	obex_dbus_dict_append(&dict, "Channel", DBUS_TYPE_BYTE,
+							&session->channel);
 
 	dbus_message_iter_close_container(&iter, &dict);
 
diff --git a/client/transfer.c b/client/transfer.c
index 3065c9c..8292265 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -38,6 +38,7 @@
 #include <gdbus.h>
 #include <gobex.h>
 
+#include "dbus.h"
 #include "log.h"
 #include "transfer.h"
 
@@ -81,40 +82,6 @@ static GQuark obc_transfer_error_quark(void)
 	return g_quark_from_static_string("obc-transfer-error-quark");
 }
 
-static void append_entry(DBusMessageIter *dict,
-				const char *key, int type, void *val)
-{
-	DBusMessageIter entry, value;
-	const char *signature;
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-								NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-
-	switch (type) {
-	case DBUS_TYPE_STRING:
-		signature = DBUS_TYPE_STRING_AS_STRING;
-		break;
-	case DBUS_TYPE_BYTE:
-		signature = DBUS_TYPE_BYTE_AS_STRING;
-		break;
-	case DBUS_TYPE_UINT64:
-		signature = DBUS_TYPE_UINT64_AS_STRING;
-		break;
-	default:
-		signature = DBUS_TYPE_VARIANT_AS_STRING;
-		break;
-	}
-
-	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
-							signature, &value);
-	dbus_message_iter_append_basic(&value, type, val);
-	dbus_message_iter_close_container(&entry, &value);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
 static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -133,9 +100,10 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	append_entry(&dict, "Name", DBUS_TYPE_STRING, &transfer->name);
-	append_entry(&dict, "Size", DBUS_TYPE_UINT64, &transfer->size);
-	append_entry(&dict, "Filename", DBUS_TYPE_STRING, &transfer->filename);
+	obex_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING, &transfer->name);
+	obex_dbus_dict_append(&dict, "Size", DBUS_TYPE_UINT64, &transfer->size);
+	obex_dbus_dict_append(&dict, "Filename", DBUS_TYPE_STRING,
+							&transfer->filename);
 
 	dbus_message_iter_close_container(&iter, &dict);
 
-- 
1.7.7.6

