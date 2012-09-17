Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 1/4] gatt: Add support for find included services
Date: Mon, 17 Sep 2012 17:46:41 -0300
Message-Id: <1347914804-29624-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1347914804-29624-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1347914804-29624-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some services like HID over LE can reference another service using
included services.

See Vol 3, Part G, section 2.6.3 of Core specification for more
details.
---
 attrib/gatt.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h |   9 +++
 2 files changed, 203 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 6880e2d..902ac23 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -45,6 +45,21 @@ struct discover_primary {
 	void *user_data;
 };
 
+struct find_included {
+	GAttrib		*attrib;
+	int		refs;
+	int		err;
+	uint16_t	end_handle;
+	GSList		*includes;
+	gatt_cb_t	cb;
+	void		*user_data;
+};
+
+struct included_uuid_resolve {
+	struct find_included *fi;
+	struct gatt_included *included;
+};
+
 struct discover_char {
 	GAttrib *attrib;
 	bt_uuid_t *uuid;
@@ -61,6 +76,26 @@ static void discover_primary_free(struct discover_primary *dp)
 	g_free(dp);
 }
 
+static struct find_included *find_included_ref(struct find_included *fi)
+{
+	g_atomic_int_inc(&fi->refs);
+
+	return fi;
+}
+
+static void find_included_unref(struct find_included *fi)
+{
+	if (g_atomic_int_dec_and_test(&fi->refs) == FALSE)
+		return;
+
+	fi->cb(fi->includes, fi->err, fi->user_data);
+
+	g_slist_free_full(fi->includes, g_free);
+	g_attrib_unref(fi->attrib);
+	g_free(fi);
+}
+
+
 static void discover_char_free(struct discover_char *dc)
 {
 	g_slist_free_full(dc->characteristics, g_free);
@@ -248,6 +283,165 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	return g_attrib_send(attrib, 0, buf[0], buf, plen, cb, dp, NULL);
 }
 
+static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
+{
+	struct included_uuid_resolve *resolve = user_data;
+	struct find_included *fi = resolve->fi;
+	struct gatt_included *incl = resolve->included;
+	bt_uuid_t uuid;
+	unsigned int err = status;
+	size_t buflen;
+	uint8_t *buf;
+
+	if (err)
+		goto done;
+
+	buf = g_attrib_get_buffer(fi->attrib, &buflen);
+	if (dec_read_resp(pdu, len, buf, buflen) != 16) {
+		err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	uuid = att_get_uuid128(buf);
+	bt_uuid_to_string(&uuid, incl->uuid, sizeof(incl->uuid));
+	fi->includes = g_slist_append(fi->includes, incl);
+
+done:
+	if (err)
+		g_free(incl);
+
+	if (fi->err == 0)
+		fi->err = err;
+
+	find_included_unref(fi);
+
+	g_free(resolve);
+}
+
+static guint resolve_included_uuid(struct find_included *fi,
+					struct gatt_included *incl)
+{
+	size_t buflen;
+	uint8_t *buf = g_attrib_get_buffer(fi->attrib, &buflen);
+	guint16 oplen = enc_read_req(incl->range.start, buf, buflen);
+	struct included_uuid_resolve *resolve;
+
+	resolve = g_new0(struct included_uuid_resolve, 1);
+	resolve->fi = find_included_ref(fi);
+	resolve->included = incl;
+
+	return g_attrib_send(fi->attrib, 0, buf[0], buf, oplen,
+					resolve_included_uuid_cb, resolve, NULL);
+}
+
+static struct gatt_included *included_from_buf(const uint8_t *buf, gsize buflen)
+{
+	struct gatt_included *incl = g_new0(struct gatt_included, 1);
+
+	incl->handle = att_get_u16(&buf[0]);
+	incl->range.start = att_get_u16(&buf[2]);
+	incl->range.end = att_get_u16(&buf[4]);
+
+	if (buflen == 8) {
+		bt_uuid_t uuid128;
+		bt_uuid_t uuid16 = att_get_uuid16(&buf[6]);
+
+		bt_uuid_to_uuid128(&uuid16, &uuid128);
+		bt_uuid_to_string(&uuid128, incl->uuid, sizeof(incl->uuid));
+	}
+
+	return incl;
+}
+
+static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
+							gpointer user_data);
+
+static guint find_included(struct find_included *fi, uint16_t start)
+{
+	bt_uuid_t uuid;
+	size_t buflen;
+	uint8_t *buf = g_attrib_get_buffer(fi->attrib, &buflen);
+	guint16 oplen;
+
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+	oplen = enc_read_by_type_req(start, fi->end_handle, &uuid,
+							buf, buflen);
+
+	find_included_ref(fi);
+
+	return g_attrib_send(fi->attrib, 0, buf[0], buf, oplen,
+						find_included_cb, fi, NULL);
+}
+
+static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct find_included *fi = user_data;
+	uint16_t last_handle = fi->end_handle;
+	unsigned int err = status;
+	struct att_data_list *list;
+	int i;
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
+	if (list->len != 6 && list->len != 8) {
+		err = ATT_ECODE_IO;
+		att_data_list_free(list);
+		goto done;
+	}
+
+	for (i = 0; i < list->num; i++) {
+		struct gatt_included *incl;
+
+		incl = included_from_buf(list->data[i], list->len);
+		last_handle = incl->handle;
+
+		/* 128 bit UUID, needs resolving */
+		if (list->len == 6) {
+			resolve_included_uuid(fi, incl);
+			continue;
+		}
+
+		fi->includes = g_slist_append(fi->includes, incl);
+	}
+
+	att_data_list_free(list);
+
+	if (last_handle < fi->end_handle)
+		find_included(fi, last_handle + 1);
+
+done:
+	if (fi->err == 0)
+		fi->err = err;
+
+	find_included_unref(fi);
+}
+
+unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
+					gatt_cb_t func, gpointer user_data)
+{
+	struct find_included *fi;
+
+	fi = g_new0(struct find_included, 1);
+	fi->attrib = g_attrib_ref(attrib);
+	fi->end_handle = end;
+	fi->cb = func;
+	fi->user_data = user_data;
+
+	return find_included(fi, start);
+}
+
 static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 							gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 6bb6f0f..2897482 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -61,6 +61,12 @@ struct gatt_primary {
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
@@ -71,6 +77,9 @@ struct gatt_char {
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
+unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
+					gatt_cb_t func, gpointer user_data);
+
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					bt_uuid_t *uuid, gatt_cb_t func,
 					gpointer user_data);
-- 
1.7.12

