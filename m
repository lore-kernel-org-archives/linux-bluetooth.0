Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 1/2] GATT: Add support for find included services
Date: Tue, 27 Mar 2012 10:06:05 -0400
Message-Id: <1332857166-25002-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1332857166-25002-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1332857166-25002-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some services like HID over LE can reference another service using
included services.

See Vol 3, Part G, section 2.6.3 of Core specification for more
details.
---
This patch is a little confuse. Any sugestions are welcome.

 attrib/gatt.c |  173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h |    9 +++
 2 files changed, 182 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 1c3ff78..cdc7bce 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -47,6 +47,22 @@ struct discover_primary {
 	void *user_data;
 };
 
+struct find_included {
+	GAttrib *attrib;
+	uint16_t end;
+	GSList *includes;
+	gatt_cb_t cb;
+	uint16_t n_uuid_missing;
+	gboolean final;
+	unsigned int err;
+	void *user_data;
+};
+
+struct find_include_data {
+	struct find_included *find_incl;
+	struct gatt_included *gatt_incl;
+};
+
 struct discover_char {
 	GAttrib *attrib;
 	bt_uuid_t *uuid;
@@ -63,6 +79,13 @@ static void discover_primary_free(struct discover_primary *dp)
 	g_free(dp);
 }
 
+static void find_included_free(struct find_included *fi)
+{
+	g_slist_free_full(fi->includes, g_free);
+	g_attrib_unref(fi->attrib);
+	g_free(fi);
+}
+
 static void discover_char_free(struct discover_char *dc)
 {
 	g_slist_free_full(dc->characteristics, g_free);
@@ -107,6 +130,16 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 	return plen;
 }
 
+static size_t encode_find_included(uint16_t start, uint16_t end,
+					uint8_t *pdu, size_t len)
+{
+	bt_uuid_t uuid;
+	
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+
+	return enc_read_by_type_req(start, end, &uuid, pdu, len);
+}
+
 static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 					guint16 iplen, gpointer user_data)
 
@@ -219,6 +252,124 @@ done:
 	discover_primary_free(dp);
 }
 
+static void find_included_helper(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
+{
+	struct find_include_data *fid = user_data;
+	struct find_included *fi = fid->find_incl;
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(fi->attrib, &buflen);
+
+	fi->n_uuid_missing--;
+
+	if (status) {
+		fi->err = status;
+		goto done;
+	}
+
+	if (dec_read_resp(pdu, len, buf, &buflen) != len) {
+		fi->err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	if (buflen >= 16) {
+		bt_uuid_t uuid = att_get_uuid128(buf);
+		bt_uuid_to_string(&uuid, fid->gatt_incl->uuid,
+					sizeof(fid->gatt_incl->uuid));
+	}
+
+done:
+	if (fi->final && fi->n_uuid_missing == 0) {
+		fi->cb(fi->includes, fi->err, fi->user_data);
+		find_included_free(fi);
+	}
+
+	g_free(fid);
+}
+
+static void included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct find_included *fi = user_data;
+	struct att_data_list *list;
+	unsigned int i;
+	uint16_t last_handle = fi->end;
+
+	if (status) {
+		if (status != ATT_ECODE_ATTR_NOT_FOUND)
+			fi->err = status;
+		fi->final = TRUE;
+		goto done;
+	}
+
+	list = dec_read_by_type_resp(pdu, len);
+	if (list == NULL) {
+		fi->err = ATT_ECODE_IO;
+		fi->final = TRUE;
+		goto done;
+	}
+
+	for (i = 0; i < list->num; i++) {
+		const uint8_t *data = list->data[i];
+		struct gatt_included *include;
+		
+		/* Skipping invalid data */
+		if (list->len != 6 && list->len != 8)
+			continue;
+
+		include = g_new0(struct gatt_included, 1);
+		include->handle = att_get_u16(&data[0]);
+		include->range.start = att_get_u16(&data[2]);
+		include->range.end = att_get_u16(&data[4]);
+		fi->includes = g_slist_append(fi->includes, include);
+
+		if (list->len == 8) {
+			bt_uuid_t uuid128;
+			bt_uuid_t uuid16 = att_get_uuid16(&data[6]);
+			bt_uuid_to_uuid128(&uuid16, &uuid128);
+			bt_uuid_to_string(&uuid128, include->uuid,
+						sizeof(include->uuid));
+		} else {
+			uint8_t *buf;
+			int buflen;
+			uint16_t plen;
+			struct find_include_data *fid =
+					g_new0(struct find_include_data, 1);
+			fid->find_incl = fi;
+			fid->gatt_incl = include;
+
+			/* 128-bit UUID, we need to "resolve" it */
+			buf = g_attrib_get_buffer(fi->attrib, &buflen);
+			plen = enc_read_req(include->handle, buf, buflen);
+			fi->n_uuid_missing++;
+			g_attrib_send(fi->attrib, 0, buf[0], buf,
+						plen, find_included_helper,
+						fi, NULL);
+		}
+
+		last_handle = include->handle;
+	}
+
+	att_data_list_free(list);
+
+	if (last_handle != fi->end) {
+		int buflen = 0;
+		uint8_t *buf = g_attrib_get_buffer(fi->attrib, &buflen);
+		size_t oplen = encode_find_included(last_handle + 1,
+							fi->end, buf, buflen);
+
+		g_attrib_send(fi->attrib, 0, buf[0], buf, oplen,
+					included_cb, fi, NULL);
+	} else
+		fi->final = TRUE;
+
+done:
+	if (fi->final && fi->n_uuid_missing == 0) {
+		fi->cb(fi->includes, fi->err, fi->user_data);
+		find_included_free(fi);
+	}
+}
+
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data)
 {
@@ -249,6 +400,28 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	return g_attrib_send(attrib, 0, buf[0], buf, plen, cb, dp, NULL);
 }
 
+unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
+				gatt_cb_t func, gpointer user_data)
+{
+	struct find_included *fi;
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
+	size_t plen;
+
+	plen = encode_find_included(start, end, buf, buflen);
+	if (plen == 0)
+		return 0;
+
+	fi = g_new0(struct find_included, 1);
+	fi->attrib = g_attrib_ref(attrib);
+	fi->end = end;
+	fi->cb = func;
+	fi->user_data = user_data;
+
+	return g_attrib_send(attrib, 0, buf[0], buf, plen, included_cb,
+					fi, NULL);
+}
+
 static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 							gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 1732270..b420711 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -30,6 +30,12 @@ struct gatt_primary {
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
@@ -40,6 +46,9 @@ struct gatt_char {
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
+unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
+					gatt_cb_t func, gpointer user_data);
+
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					bt_uuid_t *uuid, gatt_cb_t func,
 					gpointer user_data);
-- 
1.7.9.4

