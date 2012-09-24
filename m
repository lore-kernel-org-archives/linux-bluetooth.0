Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v3] gatt: Delay D-Bus reply on char discovery
Date: Mon, 24 Sep 2012 11:08:00 +0200
Message-ID: <1348477680-3752-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Delay sending the D-Bus reply for the discover_characteristics
command. The D-Bus reply for characteristics is sent before all
the relevant characteristic information is gathered. This can
cause problems, when trying to get characteristic information too
soon. This patch moves the D-Bus reply to the end of the char
discovery process. Only after all descriptors are discovered and
read, the D-Bus reply is sent.
---
 attrib/client.c |   92 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 2423fad..6015a7d 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -330,6 +330,43 @@ static void update_watchers(gpointer data, gpointer user_data)
 	g_dbus_send_message(btd_get_dbus_connection(), msg);
 }
 
+static DBusMessage *create_discover_char_reply(DBusMessage *msg, GSList *chars)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, array_iter;
+	GSList *l;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
+
+	for (l = chars; l; l = l->next) {
+		struct characteristic *chr = l->data;
+
+		dbus_message_iter_append_basic(&array_iter,
+					DBUS_TYPE_OBJECT_PATH, &chr->path);
+	}
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return reply;
+}
+
+static void send_chr_discovery_complete(struct gatt_service *gatt)
+{
+	DBusMessage *reply;
+
+	reply = create_discover_char_reply(gatt->query->msg, gatt->chars);
+
+	dbus_message_unref(gatt->query->msg);
+	gatt->query->msg = NULL;
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+}
+
 static void events_handler(const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
@@ -746,6 +783,7 @@ static void query_list_remove(struct gatt_service *gatt, struct query_data *data
 	if (query->list != NULL)
 		return;
 
+	send_chr_discovery_complete(gatt);
 	g_free(query);
 	gatt->query = NULL;
 
@@ -916,15 +954,6 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	struct characteristic *chr = data;
 	struct gatt_service *gatt = user_data;
 
-	qdesc = g_new0(struct query_data, 1);
-	qdesc->gatt = gatt;
-	qdesc->chr = chr;
-
-	query_list_append(gatt, qdesc);
-
-	gatt_find_info(gatt->attrib, chr->handle + 1, chr->end, descriptor_cb,
-									qdesc);
-
 	qvalue = g_new0(struct query_data, 1);
 	qvalue->gatt = gatt;
 	qvalue->chr = chr;
@@ -932,37 +961,20 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	query_list_append(gatt, qvalue);
 
 	gatt_read_char(gatt->attrib, chr->handle, 0, update_char_value, qvalue);
-}
-
-static DBusMessage *create_discover_char_reply(DBusMessage *msg, GSList *chars)
-{
-	DBusMessage *reply;
-	DBusMessageIter iter, array_iter;
-	GSList *l;
-
-	reply = dbus_message_new_method_return(msg);
 
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
-
-	for (l = chars; l; l = l->next) {
-		struct characteristic *chr = l->data;
-
-		dbus_message_iter_append_basic(&array_iter,
-					DBUS_TYPE_OBJECT_PATH, &chr->path);
-	}
+	qdesc = g_new0(struct query_data, 1);
+	qdesc->gatt = gatt;
+	qdesc->chr = chr;
 
-	dbus_message_iter_close_container(&iter, &array_iter);
+	query_list_append(gatt, qdesc);
 
-	return reply;
+	gatt_find_info(gatt->attrib, chr->handle + 1, chr->end, descriptor_cb,
+									qdesc);
 }
 
 static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
-	DBusMessage *reply;
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
 	struct gatt_primary *prim = gatt->prim;
@@ -973,10 +985,13 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
+		DBusMessage *reply = btd_error_failed(gatt->query->msg, str);
 
 		DBG("Discover all characteristics failed: %s", str);
-		reply = btd_error_failed(gatt->query->msg, str);
-		goto fail;
+		dbus_message_unref(gatt->query->msg);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+		goto done;
 	}
 
 	for (l = characteristics; l; l = l->next) {
@@ -1011,16 +1026,9 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	gatt_get_address(gatt, &sba, &dba, &bdaddr_type);
 	store_characteristics(&sba, &dba, bdaddr_type, prim->range.start,
 								gatt->chars);
-
 	g_slist_foreach(gatt->chars, update_all_chars, gatt);
 
-	reply = create_discover_char_reply(gatt->query->msg, gatt->chars);
-
-fail:
-	dbus_message_unref(gatt->query->msg);
-	gatt->query->msg = NULL;
-
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
+done:
 	query_list_remove(gatt, current);
 	g_free(current);
 }
-- 
1.7.9.5

