Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/4] Fix the behaviour of the Attribute API Discover method
Date: Fri, 11 Mar 2011 14:52:59 -0300
Message-Id: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method returns as soons as all the characteristics
are discovered or a error happens. The old behaviour was
to return as soon as the connection was made.

Now it is safe to call GetCharacteristics() as soon as this
method returns sucessfully.

After this method returns it will try to read all the characteristics
values.
---
 attrib/client.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 17157cd..47c5d4d 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -96,6 +96,7 @@ struct characteristic {
 struct query_data {
 	struct primary *prim;
 	struct characteristic *chr;
+	DBusMessage *msg;
 	uint16_t handle;
 };
 
@@ -863,6 +864,7 @@ static void update_all_chars(gpointer data, gpointer user_data)
 static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
+	DBusMessage *reply;
 	struct query_data *current = user_data;
 	struct primary *prim = current->prim;
 	struct att_primary *att = prim->att;
@@ -871,8 +873,10 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
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
 
@@ -909,9 +913,12 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	store_characteristics(gatt, prim);
 	register_characteristics(prim);
 
+	reply = dbus_message_new_method_return(current->msg);
+
 	g_slist_foreach(prim->chars, update_all_chars, prim);
 
 fail:
+	g_dbus_send_message(connection, reply);
 	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
@@ -933,11 +940,12 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 
 	qchr = g_new0(struct query_data, 1);
 	qchr->prim = prim;
+	qchr->msg = dbus_message_ref(msg);
 
 	gatt_discover_char(gatt->attrib, att->start, att->end,
 						char_discovered_cb, qchr);
 
-	return dbus_message_new_method_return(msg);
+	return NULL;
 }
 
 static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
@@ -983,7 +991,8 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable prim_methods[] = {
-	{ "Discover",		"",	"",		discover_char	},
+	{ "Discover",		"",	"",		discover_char,
+						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "RegisterCharacteristicsWatcher",	"o", "",
 						register_watcher	},
 	{ "UnregisterCharacteristicsWatcher",	"o", "",
-- 
1.7.4.1

