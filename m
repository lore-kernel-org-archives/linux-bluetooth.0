Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 06/28] manager: remove deprecated ListAdapters() method
Date: Wed,  4 Jul 2012 10:17:25 +0200
Message-Id: <1341389867-30749-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 src/manager.c |   33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 7061f64..d588995 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -130,36 +130,6 @@ done:
 	return reply;
 }
 
-static DBusMessage *list_adapters(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter;
-	DBusMessageIter array_iter;
-	DBusMessage *reply;
-	GSList *l;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
-
-	for (l = adapters; l; l = l->next) {
-		struct btd_adapter *adapter = l->data;
-		const gchar *path = adapter_get_path(adapter);
-
-		dbus_message_iter_append_basic(&array_iter,
-					DBUS_TYPE_OBJECT_PATH, &path);
-	}
-
-	dbus_message_iter_close_container(&iter, &array_iter);
-
-	return reply;
-}
-
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -207,9 +177,6 @@ static const GDBusMethodTable manager_methods[] = {
 			GDBUS_ARGS({ "pattern", "s" }),
 			GDBUS_ARGS({ "adapter", "o" }),
 			find_adapter) },
-	{ GDBUS_DEPRECATED_METHOD("ListAdapters",
-			NULL, GDBUS_ARGS({ "adapters", "ao" }),
-			list_adapters) },
 	{ }
 };
 
-- 
1.7.10.2

