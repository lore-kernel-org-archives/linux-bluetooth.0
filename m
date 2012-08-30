Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH] gatt: Delay D-Bus reply on char discovery
Date: Thu, 30 Aug 2012 12:28:59 +0300
Message-ID: <1346318939-9556-1-git-send-email-chen.ganir@ti.com>
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
 attrib/client.c |  163 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 116 insertions(+), 47 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index bb6adf8..9b2103b 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -78,6 +78,11 @@ struct gatt_service {
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
@@ -90,6 +95,9 @@ struct characteristic {
 	struct format *format;
 	uint8_t *value;
 	size_t vlen;
+
+	GSList *descriptors;
+	uint16_t descriptor_count;
 };
 
 struct query_data {
@@ -116,6 +124,7 @@ static void characteristic_free(void *user_data)
 	g_free(chr->format);
 	g_free(chr->value);
 	g_free(chr->name);
+	g_slist_free_full(chr->descriptors, g_free);
 	g_free(chr);
 }
 
@@ -263,6 +272,71 @@ static void update_watchers(gpointer data, gpointer user_data)
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
+static void check_chr_discovery_complete(struct gatt_service *gatt)
+{
+	DBusMessage *reply;
+	GSList *l;
+
+	for (l = gatt->chars; l; l = l->next) {
+		struct characteristic *chr = l->data;
+
+		if (chr->descriptor_count == 0xFFFF)
+			return;
+
+		if (chr->descriptor_count > g_slist_length(chr->descriptors))
+			return;
+	}
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
+
+	check_chr_discovery_complete(gatt);
+}
+
 static void events_handler(const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
@@ -690,6 +764,7 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
 	struct characteristic *chr = current->chr;
+	bt_uuid_t uuid;
 
 	if (status == 0) {
 
@@ -720,6 +795,9 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 		}
 	}
 
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	add_descriptor(current->gatt, chr, current->handle, uuid);
+
 	query_list_remove(gatt, current);
 	g_free(current);
 }
@@ -730,6 +808,7 @@ static void update_char_format(guint8 status, const guint8 *pdu, guint16 len,
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
 	struct characteristic *chr = current->chr;
+	bt_uuid_t uuid;
 
 	if (status != 0)
 		goto done;
@@ -746,6 +825,9 @@ static void update_char_format(guint8 status, const guint8 *pdu, guint16 len,
 				(void *) chr->format, sizeof(*chr->format));
 
 done:
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	add_descriptor(current->gatt, chr, current->handle, uuid);
+
 	query_list_remove(gatt, current);
 	g_free(current);
 }
@@ -789,24 +871,33 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 {
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
+	struct characteristic *chr = current->chr;
 	struct att_data_list *list;
 	guint8 format;
 	int i;
 
-	if (status != 0)
+	chr->descriptor_count = 0;
+
+	if (status != 0) {
+		check_chr_discovery_complete(gatt);
 		goto done;
+	}
 
 	DBG("Find Information Response received");
 
 	list = dec_find_info_resp(pdu, plen, &format);
-	if (list == NULL)
+	if (list == NULL) {
+		check_chr_discovery_complete(gatt);
 		goto done;
+	}
 
+	chr->descriptor_count = list->num;
 	for (i = 0; i < list->num; i++) {
 		guint16 handle;
 		bt_uuid_t uuid;
 		uint8_t *info = list->data[i];
 		struct query_data *qfmt;
+		guint ret = 0;
 
 		handle = att_get_u16(info);
 
@@ -817,6 +908,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			 * format" descriptors are used, and both have 16-bit
 			 * UUIDs. Therefore there is no need to support format
 			 * 0x02 yet. */
+			add_descriptor(gatt, chr, current->handle, uuid);
 			continue;
 		}
 		qfmt = g_new0(struct query_data, 1);
@@ -826,14 +918,17 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
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
@@ -848,53 +943,31 @@ static void update_all_chars(gpointer data, gpointer user_data)
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
+	chr->descriptor_count = 0xFFFF;
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
@@ -905,10 +978,13 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
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
@@ -943,16 +1019,9 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
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

