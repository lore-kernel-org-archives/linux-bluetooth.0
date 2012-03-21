Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/8] attrib: Centralize ATTIO connection management
Date: Wed, 21 Mar 2012 13:00:48 -0400
Message-Id: <1332349255-15764-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

On Generic Attribute, register only one ATTIO connection callback to
centralize the connection management.

Also make sure the connection reference is properly dropped only if
there is no pending operation.
---
 attrib/client.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 60cff01..412ff19 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -62,7 +62,6 @@ struct format {
 
 struct query {
 	DBusMessage *msg;
-	guint attioid;
 	GSList *list;
 };
 
@@ -141,6 +140,22 @@ static void gatt_service_free(struct gatt_service *gatt)
 	g_free(gatt);
 }
 
+static void remove_attio(struct gatt_service *gatt)
+{
+	if (gatt->offline_chars || gatt->watchers || gatt->query)
+		return;
+
+	if (gatt->attioid) {
+		btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
+		gatt->attioid = 0;
+	}
+
+	if (gatt->attrib) {
+		g_attrib_unref(gatt->attrib);
+		gatt->attrib = NULL;
+	}
+}
+
 static void gatt_get_address(struct gatt_service *gatt,
 				bdaddr_t *sba, bdaddr_t *dba)
 {
@@ -298,11 +313,7 @@ static void offline_char_written(gpointer user_data)
 
 	gatt->offline_chars = g_slist_remove(gatt->offline_chars, chr);
 
-	if (gatt->offline_chars || gatt->watchers)
-		return;
-
-	btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
-	gatt->attioid = 0;
+	remove_attio(gatt);
 }
 
 static void offline_char_write(gpointer data, gpointer user_data)
@@ -394,10 +405,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
 	watcher_free(watcher);
 
-	if (gatt->watchers == NULL && gatt->attioid) {
-		btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
-		gatt->attioid = 0;
-	}
+	remove_attio(gatt);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -632,10 +640,10 @@ static void query_list_remove(struct gatt_service *gatt, struct query_data *data
 	if (query->list != NULL)
 		return;
 
-	btd_device_remove_attio_callback(gatt->dev, query->attioid);
 	g_free(query);
-
 	gatt->query = NULL;
+
+	remove_attio(gatt);
 }
 
 static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
@@ -928,7 +936,8 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 	qchr->gatt = gatt;
 
 	query->msg = dbus_message_ref(msg);
-	query->attioid = btd_device_add_attio_callback(gatt->dev,
+
+	gatt->attioid = btd_device_add_attio_callback(gatt->dev,
 							send_discover,
 							cancel_discover,
 							qchr);
@@ -1046,9 +1055,6 @@ static void primary_unregister(struct gatt_service *gatt)
 {
 	GSList *l;
 
-	if (gatt->attioid)
-		btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
-
 	for (l = gatt->chars; l; l = l->next) {
 		struct characteristic *chr = l->data;
 		g_dbus_unregister_interface(gatt->conn, chr->path,
@@ -1056,6 +1062,8 @@ static void primary_unregister(struct gatt_service *gatt)
 	}
 
 	g_dbus_unregister_interface(gatt->conn, gatt->path, CHAR_INTERFACE);
+
+	remove_attio(gatt);
 }
 
 static int path_cmp(gconstpointer data, gconstpointer user_data)
-- 
1.7.5.4

