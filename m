Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v2] gatt: Delay D-Bus reply on char discovery
Date: Tue, 11 Sep 2012 11:47:20 +0300
Message-ID: <1347353240-1942-1-git-send-email-chen.ganir@ti.com>
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
 attrib/client.c |  138 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 93 insertions(+), 45 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index d5d40a1..7ee99e5 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -79,6 +79,11 @@ struct gatt_service {
 	struct query *query;
 };
 
+struct characteristic_descriptor {
+	uint16_t handle;
+	bt_uuid_t uuid;
+};
+
 struct characteristic {
 	struct gatt_service *gatt;
 	char *path;
@@ -91,6 +96,8 @@ struct characteristic {
 	struct format *format;
 	uint8_t *value;
 	size_t vlen;
+
+	GSList *descriptors;
 };
 
 struct query_data {
@@ -185,6 +192,7 @@ static void characteristic_free(void *user_data)
 	g_free(chr->format);
 	g_free(chr->value);
 	g_free(chr->name);
+	g_slist_free_full(chr->descriptors, g_free);
 	g_free(chr);
 }
 
@@ -333,6 +341,58 @@ static void update_watchers(gpointer data, gpointer user_data)
 	g_dbus_send_message(conn, msg);
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
+	g_dbus_send_message(gatt->conn, reply);
+}
+
+static void add_descriptor(struct gatt_service *gatt,
+			      struct characteristic *chr, uint16_t handle,
+			      bt_uuid_t uuid)
+{
+	struct characteristic_descriptor *desc;
+
+	desc = g_new0(struct characteristic_descriptor, 1);
+
+	desc->handle = handle;
+	desc->uuid = uuid;
+
+	chr->descriptors = g_slist_append(chr->descriptors, desc);
+}
+
 static void events_handler(const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
@@ -748,6 +808,7 @@ static void query_list_remove(struct gatt_service *gatt, struct query_data *data
 	if (query->list != NULL)
 		return;
 
+	send_chr_discovery_complete(gatt);
 	g_free(query);
 	gatt->query = NULL;
 
@@ -760,6 +821,7 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
 	struct characteristic *chr = current->chr;
+	bt_uuid_t uuid;
 
 	if (status == 0) {
 
@@ -790,6 +852,9 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 		}
 	}
 
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	add_descriptor(current->gatt, chr, current->handle, uuid);
+
 	query_list_remove(gatt, current);
 	g_free(current);
 }
@@ -800,6 +865,7 @@ static void update_char_format(guint8 status, const guint8 *pdu, guint16 len,
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
 	struct characteristic *chr = current->chr;
+	bt_uuid_t uuid;
 
 	if (status != 0)
 		goto done;
@@ -816,6 +882,9 @@ static void update_char_format(guint8 status, const guint8 *pdu, guint16 len,
 				(void *) chr->format, sizeof(*chr->format));
 
 done:
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	add_descriptor(current->gatt, chr, current->handle, uuid);
+
 	query_list_remove(gatt, current);
 	g_free(current);
 }
@@ -859,6 +928,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 {
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
+	struct characteristic *chr = current->chr;
 	struct att_data_list *list;
 	guint8 format;
 	int i;
@@ -877,6 +947,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		bt_uuid_t uuid;
 		uint8_t *info = list->data[i];
 		struct query_data *qfmt;
+		guint ret = 0;
 
 		handle = att_get_u16(info);
 
@@ -887,6 +958,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			 * format" descriptors are used, and both have 16-bit
 			 * UUIDs. Therefore there is no need to support format
 			 * 0x02 yet. */
+			add_descriptor(gatt, chr, current->handle, uuid);
 			continue;
 		}
 		qfmt = g_new0(struct query_data, 1);
@@ -896,14 +968,17 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		if (uuid_desc16_cmp(&uuid, GATT_CHARAC_USER_DESC_UUID) == 0) {
 			query_list_append(gatt, qfmt);
-			gatt_read_char(gatt->attrib, handle, 0, update_char_desc,
-									qfmt);
+			ret = gatt_read_char(gatt->attrib, handle, 0,
+							update_char_desc, qfmt);
 		} else if (uuid_desc16_cmp(&uuid, GATT_CHARAC_FMT_UUID) == 0) {
 			query_list_append(gatt, qfmt);
-			gatt_read_char(gatt->attrib, handle, 0,
+			ret = gatt_read_char(gatt->attrib, handle, 0,
 						update_char_format, qfmt);
 		} else
 			g_free(qfmt);
+
+		if (ret == 0)
+			add_descriptor(gatt, chr, current->handle, uuid);
 	}
 
 	att_data_list_free(list);
@@ -918,53 +993,30 @@ static void update_all_chars(gpointer data, gpointer user_data)
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
 
+	g_slist_free_full(chr->descriptors, g_free);
+	chr->descriptors = NULL;
+
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
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
-
-	for (l = chars; l; l = l->next) {
-		struct characteristic *chr = l->data;
 
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
@@ -975,10 +1027,13 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
+		DBusMessage *reply = btd_error_failed(gatt->query->msg, str);
 
 		DBG("Discover all characteristics failed: %s", str);
-		reply = btd_error_failed(gatt->query->msg, str);
-		goto fail;
+		dbus_message_unref(gatt->query->msg);
+		g_dbus_send_message(gatt->conn, reply);
+
+		goto done;
 	}
 
 	for (l = characteristics; l; l = l->next) {
@@ -1013,16 +1068,9 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
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
-	g_dbus_send_message(gatt->conn, reply);
+done:
 	query_list_remove(gatt, current);
 	g_free(current);
 }
-- 
1.7.9.5

