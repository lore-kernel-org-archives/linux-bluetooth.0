Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/8] client: Rename MessageAccess method GetFolderListing to ListFolders
Date: Thu, 13 Sep 2012 16:06:54 +0300
Message-Id: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In addition to that add missing parsing of the filters.
---
 client/map.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 7 deletions(-)

diff --git a/client/map.c b/client/map.c
index 4f07fcb..a7bdf08 100644
--- a/client/map.c
+++ b/client/map.c
@@ -29,8 +29,11 @@
 #include <glib.h>
 #include <gdbus.h>
 
+#include <gobex-apparam.h>
+
 #include "dbus.h"
 #include "log.h"
+#include "map_ap.h"
 
 #include "map.h"
 #include "transfer.h"
@@ -46,6 +49,9 @@
 #define ERROR_INTERFACE "org.bluez.obex.Error"
 #define MAS_UUID "00001132-0000-1000-8000-00805f9b34fb"
 
+#define DEFAULT_COUNT 1024
+#define DEFAULT_OFFSET 0
+
 struct map_data {
 	struct obc_session *session;
 	DBusMessage *msg;
@@ -209,18 +215,25 @@ done:
 	dbus_message_unref(map->msg);
 }
 
-static DBusMessage *map_get_folder_listing(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
+static DBusMessage *get_folder_listing(struct map_data *map,
+							DBusMessage *message,
+							GObexApparam *apparam)
 {
-	struct map_data *map = user_data;
 	struct obc_transfer *transfer;
 	GError *err = NULL;
 	DBusMessage *reply;
+	guint8 buf[8];
+	gsize len;
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	g_obex_apparam_free(apparam);
 
 	transfer = obc_transfer_get("x-obex/folder-listing", NULL, NULL, &err);
 	if (transfer == NULL)
 		goto fail;
 
+	obc_transfer_set_params(transfer, buf, len);
+
 	if (obc_session_queue(map->session, transfer, folder_listing_cb, map,
 								&err)) {
 		map->msg = dbus_message_ref(message);
@@ -234,6 +247,88 @@ fail:
 	return reply;
 }
 
+static GObexApparam *parse_offset(GObexApparam *apparam, DBusMessageIter *iter)
+{
+	guint16 num;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &num);
+
+	return g_obex_apparam_set_uint16(apparam, MAP_AP_STARTOFFSET, num);
+}
+
+static GObexApparam *parse_max_count(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	guint16 num;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &num);
+
+	return g_obex_apparam_set_uint16(apparam, MAP_AP_MAXLISTCOUNT, num);
+}
+
+static GObexApparam *parse_folder_filters(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (strcasecmp(key, "Offset") == 0) {
+			if (parse_offset(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "MaxCount") == 0) {
+			if (parse_max_count(apparam, &value) == NULL)
+				return NULL;
+		}
+
+		dbus_message_iter_next(&array);
+	}
+
+	return apparam;
+}
+
+static DBusMessage *map_list_folders(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	GObexApparam *apparam;
+	DBusMessageIter args;
+
+	dbus_message_iter_init(message, &args);
+
+	apparam = g_obex_apparam_set_uint16(NULL, MAP_AP_MAXLISTCOUNT,
+							DEFAULT_COUNT);
+	apparam = g_obex_apparam_set_uint16(apparam, MAP_AP_STARTOFFSET,
+							DEFAULT_OFFSET);
+
+	if (parse_folder_filters(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
+	return get_folder_listing(map, message, apparam);
+}
+
 static void map_msg_free(void *data)
 {
 	struct map_msg *msg = data;
@@ -633,10 +728,10 @@ static const GDBusMethodTable map_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "s" }), NULL,
 				map_setpath) },
-	{ GDBUS_ASYNC_METHOD("GetFolderListing",
-					GDBUS_ARGS({ "filter", "a{ss}" }),
-					GDBUS_ARGS({ "content", "aa{sv}" }),
-					map_get_folder_listing) },
+	{ GDBUS_ASYNC_METHOD("ListFolders",
+			GDBUS_ARGS({ "filters", "a{sv}" }),
+			GDBUS_ARGS({ "content", "aa{sv}" }),
+			map_list_folders) },
 	{ GDBUS_ASYNC_METHOD("GetMessageListing",
 			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{ss}" }),
 			GDBUS_ARGS({ "messages", "a{oa{sv}}" }),
-- 
1.7.11.4

