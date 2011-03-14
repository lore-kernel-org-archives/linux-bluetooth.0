Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 2/5] Fix the behaviour of the DiscoverCharacteristics method
Date: Mon, 14 Mar 2011 18:19:41 -0300
Message-Id: <1300137584-24437-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1300137584-24437-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1300137584-24437-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The previous behaviour could lead to some problems, as it returned
as soon as possible. To avoid problems we return just after as the
characteristics are discovered, and to save a few round trips we
return the path of all characteristics that belong to this service.

After this method return it will try to read the characteristics
values.
---
 attrib/client.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index f0b0b14..14fd911 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -96,6 +96,7 @@ struct characteristic {
 struct query_data {
 	struct primary *prim;
 	struct characteristic *chr;
+	DBusMessage *msg;
 	uint16_t handle;
 };
 
@@ -863,6 +864,8 @@ static void update_all_chars(gpointer data, gpointer user_data)
 static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
+	DBusMessage *reply;
+	DBusMessageIter iter, array_iter;
 	struct query_data *current = user_data;
 	struct primary *prim = current->prim;
 	struct att_primary *att = prim->att;
@@ -871,8 +874,10 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	GSList *l;
 
 	if (status != 0) {
-		DBG("Discover all characteristics failed: %s",
-						att_ecode2str(status));
+		const char *str = att_ecode2str(status);
+
+		DBG("Discover all characteristics failed: %s", str);
+		reply = btd_error_failed(current->msg, str);
 		goto fail;
 	}
 
@@ -909,9 +914,26 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	store_characteristics(gatt, prim);
 	register_characteristics(prim);
 
+	reply = dbus_message_new_method_return(current->msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
+
+	for (l = prim->chars; l; l = l->next) {
+		struct characteristic *chr = l->data;
+
+		dbus_message_iter_append_basic(&array_iter,
+					DBUS_TYPE_OBJECT_PATH, &chr->path);
+	}
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
 	g_slist_foreach(prim->chars, update_all_chars, prim);
 
 fail:
+	g_dbus_send_message(connection, reply);
 	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
@@ -933,11 +955,12 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 
 	qchr = g_new0(struct query_data, 1);
 	qchr->prim = prim;
+	qchr->msg = dbus_message_ref(msg);
 
 	gatt_discover_char(gatt->attrib, att->start, att->end,
 						char_discovered_cb, qchr);
 
-	return dbus_message_new_method_return(msg);
+	return NULL;
 }
 
 static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
@@ -983,7 +1006,8 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable prim_methods[] = {
-	{ "DiscoverCharacteristics",	"",	"",	discover_char	},
+	{ "DiscoverCharacteristics",	"",	"ao",	discover_char,
+					G_DBUS_METHOD_FLAG_ASYNC	},
 	{ "RegisterCharacteristicsWatcher",	"o", "",
 						register_watcher	},
 	{ "UnregisterCharacteristicsWatcher",	"o", "",
-- 
1.7.4.1

