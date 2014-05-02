Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 01/11] attrib: Add simpler call for descriptors discovery
Date: Fri,  2 May 2014 12:57:32 +0200
Message-Id: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds gatt_discover_desc() function which performs descriptor
discovery in a manner similar to gatt_discover_char(), i.e. it does
complete discovery procedure and returns list of descriptors found when
finished. For 16-bit UUIDs in addition to string UUID, short UUID is
provided.

It's also possible to specify single descriptor UUID to look for and
discovery procedure is interrupted as soon as UUID is found. This way
no more than one descriptor is returned which is useful when searching
for common descriptors like CCC.
---
 attrib/gatt.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h |  10 ++++
 2 files changed, 156 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index f5917db..f766617 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -73,6 +73,16 @@ struct discover_char {
 	void *user_data;
 };
 
+struct discover_desc {
+	int ref;
+	GAttrib *attrib;
+	bt_uuid_t *uuid;
+	uint16_t end;
+	GSList *descriptors;
+	gatt_cb_t cb;
+	void *user_data;
+};
+
 static void discover_primary_unref(void *data)
 {
 	struct discover_primary *dp = data;
@@ -139,6 +149,28 @@ static struct discover_char *discover_char_ref(struct discover_char *dc)
 	return dc;
 }
 
+static void discover_desc_unref(void *data)
+{
+	struct discover_desc *dd = data;
+
+	dd->ref--;
+
+	if (dd->ref > 0)
+		return;
+
+	g_slist_free_full(dd->descriptors, g_free);
+	g_attrib_unref(dd->attrib);
+	g_free(dd->uuid);
+	g_free(dd);
+}
+
+static struct discover_desc *discover_desc_ref(struct discover_desc *dd)
+{
+	dd->ref++;
+
+	return dd;
+}
+
 static void put_uuid_le(const bt_uuid_t *uuid, void *dst)
 {
 	if (uuid->type == BT_UUID16)
@@ -907,6 +939,120 @@ guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
+
+static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
+					guint16 iplen, gpointer user_data)
+{
+	struct discover_desc *dd = user_data;
+	struct att_data_list *list;
+	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
+	guint8 format;
+	uint16_t last = 0xffff;
+	uint8_t type;
+	gboolean uuid_found = FALSE;
+
+	if (status) {
+		err = status;
+		goto done;
+	}
+
+	list = dec_find_info_resp(ipdu, iplen, &format);
+	if (!list) {
+		err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	if (format == ATT_FIND_INFO_RESP_FMT_16BIT)
+		type = BT_UUID16;
+	else
+		type = BT_UUID128;
+
+	for (i = 0; i < list->num; i++) {
+		uint8_t *value = list->data[i];
+		struct gatt_desc *desc;
+		bt_uuid_t uuid128;
+
+		last = get_le16(value);
+
+		get_uuid128(type, &value[2], &uuid128);
+
+		if (dd->uuid) {
+			if (bt_uuid_cmp(dd->uuid, &uuid128))
+				continue;
+			else
+				uuid_found = TRUE;
+		}
+
+		desc = g_try_new0(struct gatt_desc, 1);
+		if (!desc) {
+			att_data_list_free(list);
+			err = ATT_ECODE_INSUFF_RESOURCES;
+			goto done;
+		}
+
+		bt_uuid_to_string(&uuid128, desc->uuid, sizeof(desc->uuid));
+		desc->handle = last;
+
+		if (type == BT_UUID16)
+			desc->uuid16 = get_le16(&value[2]);
+
+		dd->descriptors = g_slist_append(dd->descriptors, desc);
+
+		if (uuid_found)
+			break;
+	}
+
+	att_data_list_free(list);
+
+	if (last + 1 < dd->end && !uuid_found) {
+		guint16 oplen;
+		size_t buflen;
+		uint8_t *buf;
+
+		buf = g_attrib_get_buffer(dd->attrib, &buflen);
+
+		oplen = enc_find_info_req(last + 1, dd->end, buf, buflen);
+		if (oplen == 0)
+			return;
+
+		g_attrib_send(dd->attrib, 0, buf, oplen, desc_discovered_cb,
+				discover_desc_ref(dd), discover_desc_unref);
+
+		return;
+	}
+
+done:
+	err = (dd->descriptors ? 0 : err);
+	dd->cb(err, dd->descriptors, dd->user_data);
+}
+
+guint gatt_discover_desc(GAttrib *attrib, uint16_t start, uint16_t end,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
+{
+	size_t buflen;
+	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
+	struct discover_desc *dd;
+	guint16 plen;
+
+	plen = enc_find_info_req(start, end, buf, buflen);
+	if (plen == 0)
+		return 0;
+
+	dd = g_try_new0(struct discover_desc, 1);
+	if (dd == NULL)
+		return 0;
+
+	dd->attrib = g_attrib_ref(attrib);
+	dd->cb = func;
+	dd->user_data = user_data;
+	dd->end = end;
+	dd->uuid = g_memdup(uuid, sizeof(bt_uuid_t));
+
+	return g_attrib_send(attrib, 0, buf, plen, desc_discovered_cb,
+				discover_desc_ref(dd), discover_desc_unref);
+}
+
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 3fe6041..533bfd7 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -67,6 +67,12 @@ struct gatt_char {
 	uint16_t value_handle;
 };
 
+struct gatt_desc {
+	char uuid[MAX_LEN_UUID_STR + 1];
+	uint16_t handle;
+	uint16_t uuid16;
+};
+
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
@@ -84,6 +90,10 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
 					gpointer user_data);
 
+guint gatt_discover_desc(GAttrib *attrib, uint16_t start, uint16_t end,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data);
+
 guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
 					const uint8_t *value, size_t vlen,
 					GAttribResultFunc func,
-- 
1.9.2

