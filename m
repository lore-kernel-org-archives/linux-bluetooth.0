Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/14] obexd: Remove unused static functions
Date: Fri, 4 Oct 2013 11:05:30 +0200
Message-ID: <1380877538-22614-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

obexd/src/manager.c: At top level:
obexd/src/manager.c:190:13: error:
     ‘dbus_message_iter_append_dict_entry’ defined but not used
     [-Werror=unused-function]
---
 obexd/src/manager.c | 75 -----------------------------------------------------
 1 file changed, 75 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index f64b7b9..a67838c 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -127,81 +127,6 @@ static inline DBusMessage *not_authorized(DBusMessage *msg)
 			"Not authorized");
 }
 
-static void dbus_message_iter_append_variant(DBusMessageIter *iter,
-						int type, void *val)
-{
-	DBusMessageIter value;
-	DBusMessageIter array;
-	const char *sig;
-
-	switch (type) {
-	case DBUS_TYPE_STRING:
-		sig = DBUS_TYPE_STRING_AS_STRING;
-		break;
-	case DBUS_TYPE_BYTE:
-		sig = DBUS_TYPE_BYTE_AS_STRING;
-		break;
-	case DBUS_TYPE_INT16:
-		sig = DBUS_TYPE_INT16_AS_STRING;
-		break;
-	case DBUS_TYPE_UINT16:
-		sig = DBUS_TYPE_UINT16_AS_STRING;
-		break;
-	case DBUS_TYPE_INT32:
-		sig = DBUS_TYPE_INT32_AS_STRING;
-		break;
-	case DBUS_TYPE_UINT32:
-		sig = DBUS_TYPE_UINT32_AS_STRING;
-		break;
-	case DBUS_TYPE_BOOLEAN:
-		sig = DBUS_TYPE_BOOLEAN_AS_STRING;
-		break;
-	case DBUS_TYPE_ARRAY:
-		sig = DBUS_TYPE_ARRAY_AS_STRING DBUS_TYPE_STRING_AS_STRING;
-		break;
-	case DBUS_TYPE_OBJECT_PATH:
-		sig = DBUS_TYPE_OBJECT_PATH_AS_STRING;
-		break;
-	default:
-		error("Could not append variant with type %d", type);
-		return;
-	}
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
-
-	if (type == DBUS_TYPE_ARRAY) {
-		int i;
-		const char ***str_array = val;
-
-		dbus_message_iter_open_container(&value, DBUS_TYPE_ARRAY,
-			DBUS_TYPE_STRING_AS_STRING, &array);
-
-		for (i = 0; (*str_array)[i]; i++)
-			dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
-							&((*str_array)[i]));
-
-		dbus_message_iter_close_container(&value, &array);
-	} else
-		dbus_message_iter_append_basic(&value, type, val);
-
-	dbus_message_iter_close_container(iter, &value);
-}
-
-static void dbus_message_iter_append_dict_entry(DBusMessageIter *dict,
-					const char *key, int type, void *val)
-{
-	DBusMessageIter entry;
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-					NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-
-	dbus_message_iter_append_variant(&entry, type, val);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
 static void agent_disconnected(DBusConnection *conn, void *user_data)
 {
 	DBG("Agent exited");
-- 
1.8.4

