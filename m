Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v4 BlueZ 1/4] gatt: Add support for find included services
Date: Mon,  8 Oct 2012 21:17:35 -0300
Message-Id: <1349741858-18325-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some services like HID over LE can reference another service using
included services.

See Vol 3, Part G, section 2.6.3 of Core specification for more
details.
---
 attrib/gatt.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h |   9 +++
 2 files changed, 201 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 882f3c1..d55e7fe 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -45,6 +45,22 @@ struct discover_primary {
 	void *user_data;
 };
 
+/* Used for the Included Services Discovery (ISD) procedure */
+struct included_discovery {
+	GAttrib		*attrib;
+	int		refs;
+	int		err;
+	uint16_t	end_handle;
+	GSList		*includes;
+	gatt_cb_t	cb;
+	void		*user_data;
+};
+
+struct included_uuid_query {
+	struct included_discovery	*isd;
+	struct gatt_included		*included;
+};
+
 struct discover_char {
 	GAttrib *attrib;
 	bt_uuid_t *uuid;
@@ -61,6 +77,25 @@ static void discover_primary_free(struct discover_primary *dp)
 	g_free(dp);
 }
 
+static struct included_discovery *isd_ref(struct included_discovery *isd)
+{
+	g_atomic_int_inc(&isd->refs);
+
+	return isd;
+}
+
+static void isd_unref(struct included_discovery *isd)
+{
+	if (g_atomic_int_dec_and_test(&isd->refs) == FALSE)
+		return;
+
+	isd->cb(isd->includes, isd->err, isd->user_data);
+
+	g_slist_free_full(isd->includes, g_free);
+	g_attrib_unref(isd->attrib);
+	g_free(isd);
+}
+
 static void discover_char_free(struct discover_char *dc)
 {
 	g_slist_free_full(dc->characteristics, g_free);
@@ -248,6 +283,163 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	return g_attrib_send(attrib, 0, buf[0], buf, plen, cb, dp, NULL);
 }
 
+static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
+{
+	struct included_uuid_query *query = user_data;
+	struct included_discovery *isd = query->isd;
+	struct gatt_included *incl = query->included;
+	unsigned int err = status;
+	bt_uuid_t uuid;
+	size_t buflen;
+	uint8_t *buf;
+
+	if (err)
+		goto done;
+
+	buf = g_attrib_get_buffer(isd->attrib, &buflen);
+	if (dec_read_resp(pdu, len, buf, buflen) != 16) {
+		err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	uuid = att_get_uuid128(buf);
+	bt_uuid_to_string(&uuid, incl->uuid, sizeof(incl->uuid));
+	isd->includes = g_slist_append(isd->includes, incl);
+
+done:
+	if (err)
+		g_free(incl);
+
+	if (isd->err == 0)
+		isd->err = err;
+
+	isd_unref(isd);
+
+	g_free(query);
+}
+
+static guint resolve_included_uuid(struct included_discovery *isd,
+					struct gatt_included *incl)
+{
+	struct included_uuid_query *query;
+	size_t buflen;
+	uint8_t *buf = g_attrib_get_buffer(isd->attrib, &buflen);
+	guint16 oplen = enc_read_req(incl->range.start, buf, buflen);
+
+	query = g_new0(struct included_uuid_query, 1);
+	query->isd = isd_ref(isd);
+	query->included = incl;
+
+	return g_attrib_send(isd->attrib, 0, buf[0], buf, oplen,
+				resolve_included_uuid_cb, query, NULL);
+}
+
+static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
+{
+	struct gatt_included *incl = g_new0(struct gatt_included, 1);
+
+	incl->handle = att_get_u16(&buf[0]);
+	incl->range.start = att_get_u16(&buf[2]);
+	incl->range.end = att_get_u16(&buf[4]);
+
+	if (len == 8) {
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
+static guint find_included(struct included_discovery *isd, uint16_t start)
+{
+	bt_uuid_t uuid;
+	size_t buflen;
+	uint8_t *buf = g_attrib_get_buffer(isd->attrib, &buflen);
+	guint16 oplen;
+
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+	oplen = enc_read_by_type_req(start, isd->end_handle, &uuid,
+							buf, buflen);
+
+	return g_attrib_send(isd->attrib, 0, buf[0], buf, oplen,
+					find_included_cb, isd_ref(isd), NULL);
+}
+
+static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct included_discovery *isd = user_data;
+	uint16_t last_handle = isd->end_handle;
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
+			resolve_included_uuid(isd, incl);
+			continue;
+		}
+
+		isd->includes = g_slist_append(isd->includes, incl);
+	}
+
+	att_data_list_free(list);
+
+	if (last_handle < isd->end_handle)
+		find_included(isd, last_handle + 1);
+
+done:
+	if (isd->err == 0)
+		isd->err = err;
+
+	isd_unref(isd);
+}
+
+unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
+					gatt_cb_t func, gpointer user_data)
+{
+	struct included_discovery *isd;
+
+	isd = g_new0(struct included_discovery, 1);
+	isd->attrib = g_attrib_ref(attrib);
+	isd->end_handle = end;
+	isd->cb = func;
+	isd->user_data = user_data;
+
+	return find_included(isd, start);
+}
+
 static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 							gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 3862011..305b4c6 100644
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
1.7.12.2

