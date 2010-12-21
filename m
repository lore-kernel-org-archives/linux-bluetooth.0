Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 15/18] Remove GetCharacteristics DBus method
Date: Tue, 21 Dec 2010 19:26:37 -0200
Message-Id: <1292966800-6264-16-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method was not documented in the API, and it has the same
functionality as getting the Characteristics property.
---
 attrib/client.c |   46 ----------------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 8dc5c79..8b5aea8 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -349,51 +349,6 @@ fail:
 	g_attrib_unref(gatt->attrib);
 }
 
-static DBusMessage *get_characteristics(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	struct primary *prim = data;
-	DBusMessage *reply;
-	DBusMessageIter iter, array;
-	GSList *l;
-
-	reply = dbus_message_new_method_return(msg);
-	if (reply == NULL)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_OBJECT_PATH_AS_STRING
-			DBUS_TYPE_ARRAY_AS_STRING
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
-
-	for (l = prim->chars; l; l = l->next) {
-		struct characteristic *chr = l->data;
-		DBusMessageIter sub;
-
-		DBG("path %s", chr->path);
-
-		dbus_message_iter_open_container(&array, DBUS_TYPE_DICT_ENTRY,
-								NULL, &sub);
-
-		dbus_message_iter_append_basic(&sub, DBUS_TYPE_OBJECT_PATH,
-								&chr->path);
-
-		append_char_dict(&sub, chr);
-
-		dbus_message_iter_close_container(&array, &sub);
-	}
-
-	dbus_message_iter_close_container(&iter, &array);
-
-	return reply;
-}
-
 static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
 								gboolean listen)
 {
@@ -987,7 +942,6 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable prim_methods[] = {
-	{ "GetCharacteristics",	"",	"a{oa{sv}}", get_characteristics},
 	{ "Discover",		"",	"",		discover_char	},
 	{ "RegisterCharacteristicsWatcher",	"o", "",
 						register_watcher	},
-- 
1.7.3.4

