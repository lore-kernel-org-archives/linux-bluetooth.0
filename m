Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 10/11] On demand connection for characteristics discovery
Date: Tue, 12 Jul 2011 17:28:40 -0300
Message-Id: <1310502521-462-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the Generic Attribute API, when DiscoverCharacteristics is called
ATT connection should be requested if the link is not up. A query
list is required to control when the link can be disconnected since
the discover finishes after receiving all caracteristic declarations.
---
 attrib/client.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 962cdb7..03d161e 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -62,6 +62,12 @@ struct format {
 	guint16 desc;
 } __attribute__ ((packed));
 
+struct query {
+	DBusMessage *msg;
+	guint attioid;
+	GSList *list;
+};
+
 struct gatt_service {
 	struct btd_device *dev;
 	struct att_primary *prim;
@@ -72,6 +78,7 @@ struct gatt_service {
 	char *path;
 	GSList *chars;
 	GSList *watchers;
+	struct query *query;
 };
 
 struct characteristic {
@@ -91,7 +98,6 @@ struct characteristic {
 struct query_data {
 	struct gatt_service *gatt;
 	struct characteristic *chr;
-	DBusMessage *msg;
 	uint16_t handle;
 };
 
@@ -576,6 +582,27 @@ static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 	g_free(str);
 }
 
+static void query_list_append(struct gatt_service *gatt, struct query_data *data)
+{
+	struct query *query = gatt->query;
+
+	query->list = g_slist_append(query->list, data);
+}
+
+static void query_list_remove(struct gatt_service *gatt, struct query_data *data)
+{
+	struct query *query = gatt->query;
+
+	query->list = g_slist_remove(query->list, data);
+	if (query->list != NULL)
+		return;
+
+	btd_device_remove_attio_callback(gatt->dev, query->attioid);
+	g_free(query);
+
+	gatt->query = NULL;
+}
+
 static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -606,6 +633,7 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 		}
 	}
 
+	query_list_remove(gatt, current);
 	g_free(current);
 }
 
@@ -631,6 +659,7 @@ static void update_char_format(guint8 status, const guint8 *pdu, guint16 len,
 				(void *) chr->format, sizeof(*chr->format));
 
 done:
+	query_list_remove(gatt, current);
 	g_free(current);
 }
 
@@ -655,6 +684,7 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 		}
 	}
 
+	query_list_remove(gatt, current);
 	g_free(current);
 }
 
@@ -708,9 +738,11 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		qfmt->handle = handle;
 
 		if (uuid_desc16_cmp(&uuid, GATT_CHARAC_USER_DESC_UUID) == 0) {
+			query_list_append(gatt, qfmt);
 			gatt_read_char(gatt->attrib, handle, 0, update_char_desc,
 									qfmt);
 		} else if (uuid_desc16_cmp(&uuid, GATT_CHARAC_FMT_UUID) == 0) {
+			query_list_append(gatt, qfmt);
 			gatt_read_char(gatt->attrib, handle, 0,
 						update_char_format, qfmt);
 		} else
@@ -719,6 +751,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	att_data_list_free(list);
 done:
+	query_list_remove(gatt, current);
 	g_free(current);
 }
 
@@ -732,6 +765,8 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	qdesc->gatt = gatt;
 	qdesc->chr = chr;
 
+	query_list_append(gatt, qdesc);
+
 	gatt_find_info(gatt->attrib, chr->handle + 1, chr->end, descriptor_cb,
 									qdesc);
 
@@ -739,6 +774,8 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	qvalue->gatt = gatt;
 	qvalue->chr = chr;
 
+	query_list_append(gatt, qvalue);
+
 	gatt_read_char(gatt->attrib, chr->handle, 0, update_char_value, qvalue);
 }
 
@@ -758,7 +795,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 		const char *str = att_ecode2str(status);
 
 		DBG("Discover all characteristics failed: %s", str);
-		reply = btd_error_failed(current->msg, str);
+		reply = btd_error_failed(gatt->query->msg, str);
 		goto fail;
 	}
 
@@ -795,7 +832,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
 
-	reply = dbus_message_new_method_return(current->msg);
+	reply = dbus_message_new_method_return(gatt->query->msg);
 
 	dbus_message_iter_init_append(reply, &iter);
 
@@ -815,25 +852,54 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 fail:
 	g_dbus_send_message(gatt->conn, reply);
+	query_list_remove(gatt, current);
 	g_free(current);
 }
 
+static void send_discover(GAttrib *attrib, gpointer user_data)
+{
+	struct query_data *qchr = user_data;
+	struct gatt_service *gatt = qchr->gatt;
+	struct att_primary *prim = gatt->prim;
+
+	gatt->attrib = attrib;
+
+	gatt_discover_char(gatt->attrib, prim->start, prim->end, NULL,
+						char_discovered_cb, qchr);
+}
+
+static void cancel_discover(gpointer user_data)
+{
+	struct query_data *qchr = user_data;
+	struct gatt_service *gatt = qchr->gatt;
+
+	gatt->attrib = NULL;
+}
+
 static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct gatt_service *gatt = data;
-	struct att_primary *prim = gatt->prim;
+	struct query *query;
 	struct query_data *qchr;
 
-	if (gatt->attrib == NULL)
-		return btd_error_not_connected(msg);
+	if (gatt->query)
+		return btd_error_busy(msg);
+
+	query = g_new0(struct query, 1);
 
 	qchr = g_new0(struct query_data, 1);
 	qchr->gatt = gatt;
-	qchr->msg = dbus_message_ref(msg);
 
-	gatt_discover_char(gatt->attrib, prim->start, prim->end, NULL,
-						char_discovered_cb, qchr);
+	query->msg = dbus_message_ref(msg);
+	query->attioid = btd_device_add_attio_callback(gatt->dev,
+							send_discover,
+							cancel_discover,
+							qchr);
+
+	gatt->query = query;
+
+	query_list_append(gatt, qchr);
 
 	return NULL;
 }
-- 
1.7.6

