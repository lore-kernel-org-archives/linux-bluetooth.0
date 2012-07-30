Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH v3 BlueZ 1/2] GATT: Add support for find included services
Date: Mon, 30 Jul 2012 11:24:34 -0400
Message-Id: <1343661875-27700-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1343661875-27700-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
 <1343661875-27700-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some services like HID over LE can reference another service using
included services.

See Vol 3, Part G, section 2.6.3 of Core specification for more
details.
---
 attrib/gatt.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h |   9 +++
 2 files changed, 204 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 6f9a11d..c182088 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -45,6 +45,15 @@ struct discover_primary {
 	void *user_data;
 };
 
+struct find_included_data {
+	GAttrib		*attrib;
+	uint16_t	end_handle;
+	GSList		*includes;
+	GSList		*current_include;
+	gatt_cb_t	cb;
+	void		*user_data;
+};
+
 struct discover_char {
 	GAttrib *attrib;
 	bt_uuid_t *uuid;
@@ -61,6 +70,13 @@ static void discover_primary_free(struct discover_primary *dp)
 	g_free(dp);
 }
 
+static void find_included_data_free(struct find_included_data *data)
+{
+	g_slist_free_full(data->includes, g_free);
+	g_attrib_unref(data->attrib);
+	g_free(data);
+}
+
 static void discover_char_free(struct discover_char *dc)
 {
 	g_slist_free_full(dc->characteristics, g_free);
@@ -247,6 +263,185 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	return g_attrib_send(attrib, 0, buf[0], buf, plen, cb, dp, NULL);
 }
 
+static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
+							gpointer user_data);
+
+static guint call_find_included(struct find_included_data *data,
+							uint16_t start_handle)
+{
+	bt_uuid_t uuid;
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(data->attrib, &buflen);
+	guint16 oplen;
+
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+	oplen = enc_read_by_type_req(start_handle, data->end_handle, &uuid, buf,
+									buflen);
+
+	return g_attrib_send(data->attrib, 0, buf[0], buf, oplen,
+						find_included_cb, data, NULL);
+}
+
+static void find_included_uuid_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data);
+
+static guint call_find_included_uuid(struct find_included_data *data,
+								uint16_t handle)
+{
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(data->attrib, &buflen);
+	guint16 oplen = enc_read_req(handle, buf, buflen);
+
+	return g_attrib_send(data->attrib, 0, buf[0], buf, oplen,
+					find_included_uuid_cb, data, NULL);
+}
+
+static void find_included_uuid_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
+{
+	struct find_included_data *data = user_data;
+	struct gatt_included *incl;
+	bt_uuid_t uuid;
+	unsigned int err = status;
+	int buflen;
+	uint8_t *buf;
+
+	if (err)
+		goto done;
+
+	buf = g_attrib_get_buffer(data->attrib, &buflen);
+	if (dec_read_resp(pdu, len, buf, buflen) != 16) {
+		err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	incl = g_slist_nth_data(data->current_include, 0);
+	uuid = att_get_uuid128(buf);
+	bt_uuid_to_string(&uuid, incl->uuid, sizeof(incl->uuid));
+
+	data->current_include = g_slist_next(data->current_include);
+	if (data->current_include) {
+		/* resolve next 128-Bit UUID */
+		incl = g_slist_nth_data(data->current_include, 0);
+		call_find_included_uuid(data, incl->range.start);
+		return;
+	}
+
+	if (incl->handle != data->end_handle) {
+		call_find_included(data, incl->handle + 1);
+		return;
+	}
+
+done:
+	data->cb(data->includes, err, data->user_data);
+	find_included_data_free(data);
+}
+
+static struct gatt_included* fill_new_included(struct att_data_list *list,
+							unsigned int pos)
+{
+	struct gatt_included *incl = g_new0(struct gatt_included, 1);
+	uint8_t *d = list->data[pos];
+
+	incl->handle = att_get_u16(&d[0]);
+	incl->range.start = att_get_u16(&d[2]);
+	incl->range.end = att_get_u16(&d[4]);
+
+	if (list->len == 8) {
+		bt_uuid_t uuid128;
+		bt_uuid_t uuid16 = att_get_uuid16(&d[6]);
+
+		bt_uuid_to_uuid128(&uuid16, &uuid128);
+		bt_uuid_to_string(&uuid128, incl->uuid, sizeof(incl->uuid));
+	}
+
+	return incl;
+}
+
+static void parse_included_uuid(struct att_data_list *list,
+						struct find_included_data *data)
+{
+	struct gatt_included *incl = NULL;
+	GSList *includes = NULL;
+	unsigned int i;
+
+	for (i = list->num; i > 0; i--) {
+		incl = fill_new_included(list, i - 1);
+		includes = g_slist_prepend(includes, incl);
+	}
+
+	data->includes = g_slist_concat(data->includes, includes);
+
+	/* for 128-bit UUID, we need to resolve it */
+	if (list->len == 6) {
+		data->current_include = includes;
+		call_find_included_uuid(data, incl->range.start);
+	}
+}
+
+static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct find_included_data *data = user_data;
+	uint16_t last_handle = data->end_handle;
+	unsigned int err = status;
+	struct att_data_list *list;
+
+	if (err == ATT_ECODE_ATTR_NOT_FOUND)
+		err = 0;
+
+	if (status)
+		goto done;
+
+	list = dec_read_by_type_resp(pdu, len);
+	if (list == NULL) {
+		err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	if (list->num == 0) {
+		att_data_list_free(list);
+		goto done;
+	}
+
+	/* parse valid data only */
+	if (list->len == 6) {
+		parse_included_uuid(list, data);
+		att_data_list_free(list);
+		return;
+	} else if (list->len == 8) {
+		struct gatt_included *incl;
+		parse_included_uuid(list, data);
+		incl = g_slist_nth_data(g_slist_last(data->includes), 0);
+		last_handle = incl->handle;
+	}
+
+	att_data_list_free(list);
+
+	if (last_handle != data->end_handle) {
+		call_find_included(data, last_handle + 1);
+		return;
+	}
+
+done:
+	data->cb(data->includes, err, data->user_data);
+	find_included_data_free(data);
+}
+
+unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
+					gatt_cb_t func, gpointer user_data)
+{
+	struct find_included_data *data;
+
+	data = g_new0(struct find_included_data, 1);
+	data->attrib = g_attrib_ref(attrib);
+	data->end_handle = end;
+	data->cb = func;
+	data->user_data = user_data;
+
+	return call_find_included(data, start);
+}
+
 static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 							gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index c7e79ab..3bda1b2 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -59,6 +59,12 @@ struct gatt_primary {
 	struct att_range range;
 };
 
+struct gatt_included {
+	char uuid[MAX_LEN_UUID_STR + 1];
+	uint16_t handle;
+	struct att_range range;
+};
+
 struct gatt_char {
 	char uuid[MAX_LEN_UUID_STR + 1];
 	uint16_t handle;
@@ -69,6 +75,9 @@ struct gatt_char {
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
+unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
+					gatt_cb_t func, gpointer user_data);
+
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					bt_uuid_t *uuid, gatt_cb_t func,
 					gpointer user_data);
-- 
1.7.11.3

