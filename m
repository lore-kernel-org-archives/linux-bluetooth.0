Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 08/10] gatt: Better lifetime tracking for Find Included services
Date: Fri,  1 Mar 2013 20:22:31 -0300
Message-Id: <1362180153-11133-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the GDestroyNotify facility from g_attrib_send() to properly
end a procedure.
---
 attrib/gatt.c | 73 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index b451917..ef3ffff 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -328,30 +328,37 @@ static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
 	struct included_uuid_query *query = user_data;
 	struct included_discovery *isd = query->isd;
 	struct gatt_included *incl = query->included;
-	unsigned int err = status;
 	bt_uuid_t uuid;
 	size_t buflen;
 	uint8_t *buf;
 
-	if (err)
-		goto done;
+	if (status) {
+		set_error(&isd->err, status);
+		return;
+	}
 
 	buf = g_attrib_get_buffer(isd->attrib, &buflen);
 	if (dec_read_resp(pdu, len, buf, buflen) != 16) {
-		err = ATT_ECODE_IO;
-		goto done;
+		set_error(&isd->err, ATT_ECODE_IO);
+		return;
 	}
 
 	uuid = att_get_uuid128(buf);
 	bt_uuid_to_string(&uuid, incl->uuid, sizeof(incl->uuid));
 	isd->includes = g_slist_append(isd->includes, incl);
+}
 
-done:
-	if (err)
-		g_free(incl);
+static void included_query_free(gpointer user_data)
+{
+	struct included_uuid_query *query = user_data;
+	struct included_discovery *isd = query->isd;
 
-	if (isd->err == 0)
-		isd->err = err;
+	if (isd->err) {
+		/* This means that 'included' was not included in the
+		 * 'includes' list
+		 */
+		g_free(query->included);
+	}
 
 	isd_unref(isd);
 
@@ -365,13 +372,21 @@ static guint resolve_included_uuid(struct included_discovery *isd,
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(isd->attrib, &buflen);
 	guint16 oplen = enc_read_req(incl->range.start, buf, buflen);
+	int id;
 
 	query = g_new0(struct included_uuid_query, 1);
 	query->isd = isd_ref(isd);
 	query->included = incl;
 
-	return g_attrib_send(isd->attrib, 0, buf, oplen,
-				resolve_included_uuid_cb, query, NULL);
+	id = g_attrib_send(isd->attrib, 0, buf, oplen,
+				resolve_included_uuid_cb, query,
+				included_query_free);
+	if (id == 0) {
+		isd_unref(query->isd);
+		g_free(query);
+	}
+
+	return id;
 }
 
 static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
@@ -396,6 +411,13 @@ static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
 static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data);
 
+static void find_included_drop(gpointer user_data)
+{
+	struct included_discovery *isd = user_data;
+
+	isd_unref(isd);
+}
+
 static guint find_included(struct included_discovery *isd, uint16_t start)
 {
 	bt_uuid_t uuid;
@@ -408,7 +430,7 @@ static guint find_included(struct included_discovery *isd, uint16_t start)
 							buf, buflen);
 
 	return g_attrib_send(isd->attrib, 0, buf, oplen, find_included_cb,
-							isd_ref(isd), NULL);
+					isd_ref(isd), find_included_drop);
 }
 
 static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
@@ -416,26 +438,25 @@ static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 {
 	struct included_discovery *isd = user_data;
 	uint16_t last_handle = isd->end_handle;
-	unsigned int err = status;
 	struct att_data_list *list;
 	int i;
 
-	if (err == ATT_ECODE_ATTR_NOT_FOUND)
-		err = 0;
-
-	if (status)
-		goto done;
+	if (status) {
+		int err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		set_error(&isd->err, err);
+		return;
+	}
 
 	list = dec_read_by_type_resp(pdu, len);
 	if (list == NULL) {
-		err = ATT_ECODE_IO;
-		goto done;
+		set_error(&isd->err, ATT_ECODE_IO);
+		return;
 	}
 
 	if (list->len != 6 && list->len != 8) {
-		err = ATT_ECODE_IO;
+		set_error(&isd->err, ATT_ECODE_IO);
 		att_data_list_free(list);
-		goto done;
+		return;
 	}
 
 	for (i = 0; i < list->num; i++) {
@@ -457,12 +478,6 @@ static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 
 	if (last_handle < isd->end_handle)
 		find_included(isd, last_handle + 1);
-
-done:
-	if (isd->err == 0)
-		isd->err = err;
-
-	isd_unref(isd);
 }
 
 unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
-- 
1.8.1.3

