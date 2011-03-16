Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 3/5] Use GAttrib buffer for ATT protocol PDUs
Date: Wed, 16 Mar 2011 07:25:10 -0400
Message-Id: <1300274712-3931-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
References: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prior to this commit, there were local buffers inside GATT functions.
Now, a single buffer is used, to make sure the MTU limit is respected.
---
 attrib/gatt.c |  109 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 64 insertions(+), 45 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 32bd4a0..d3333fd 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -108,9 +108,9 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	struct discover_primary *dp = user_data;
 	GSList *ranges, *last;
 	struct att_range *range;
-	uint8_t opdu[ATT_DEFAULT_LE_MTU];
+	uint8_t *buf;
 	guint16 oplen;
-	int err = 0;
+	int err = 0, buflen;
 
 	if (status) {
 		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
@@ -129,13 +129,14 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	if (range->end == 0xffff)
 		goto done;
 
+	buf = g_attrib_get_buffer(dp->attrib, &buflen);
 	oplen = encode_discover_primary(range->end + 1, 0xffff, &dp->uuid,
-							opdu, sizeof(opdu));
+								buf, buflen);
 
 	if (oplen == 0)
 		goto done;
 
-	g_attrib_send(dp->attrib, 0, opdu[0], opdu, oplen, primary_by_uuid_cb,
+	g_attrib_send(dp->attrib, 0, buf[0], buf, oplen, primary_by_uuid_cb,
 								dp, NULL);
 	return;
 
@@ -196,12 +197,13 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	err = 0;
 
 	if (end != 0xffff) {
-		uint8_t opdu[ATT_DEFAULT_LE_MTU];
+		int buflen;
+		uint8_t *buf = g_attrib_get_buffer(dp->attrib, &buflen);
 		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
-							opdu, sizeof(opdu));
+								buf, buflen);
 
-		g_attrib_send(dp->attrib, 0, opdu[0], opdu, oplen,
-						primary_all_cb, dp, NULL);
+		g_attrib_send(dp->attrib, 0, buf[0], buf, oplen, primary_all_cb,
+								dp, NULL);
 
 		return;
 	}
@@ -215,11 +217,12 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data)
 {
 	struct discover_primary *dp;
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	GAttribResultFunc cb;
 	guint16 plen;
 
-	plen = encode_discover_primary(0x0001, 0xffff, uuid, pdu, sizeof(pdu));
+	plen = encode_discover_primary(0x0001, 0xffff, uuid, buf, buflen);
 	if (plen == 0)
 		return 0;
 
@@ -237,7 +240,7 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	} else
 		cb = primary_all_cb;
 
-	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, cb, dp, NULL);
+	return g_attrib_send(attrib, 0, buf[0], buf, plen, cb, dp, NULL);
 }
 
 static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
@@ -246,7 +249,8 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
 	unsigned int i, err;
-	uint8_t opdu[ATT_DEFAULT_LE_MTU];
+	int buflen;
+	uint8_t *buf;
 	guint16 oplen;
 	bt_uuid_t uuid;
 	uint16_t last = 0;
@@ -293,15 +297,17 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	err = 0;
 
 	if (last != 0) {
+		buf = g_attrib_get_buffer(dc->attrib, &buflen);
+
 		bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 
-		oplen = enc_read_by_type_req(last + 1, dc->end, &uuid, opdu,
-								sizeof(opdu));
+		oplen = enc_read_by_type_req(last + 1, dc->end, &uuid, buf,
+									buflen);
 
 		if (oplen == 0)
 			return;
 
-		g_attrib_send(dc->attrib, 0, opdu[0], opdu, oplen,
+		g_attrib_send(dc->attrib, 0, buf[0], buf, oplen,
 						char_discovered_cb, dc, NULL);
 
 		return;
@@ -315,14 +321,15 @@ done:
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					gatt_cb_t func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	struct discover_char *dc;
 	guint16 plen;
 	bt_uuid_t uuid;
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 
-	plen = enc_read_by_type_req(start, end, &uuid, pdu, sizeof(pdu));
+	plen = enc_read_by_type_req(start, end, &uuid, buf, buflen);
 	if (plen == 0)
 		return 0;
 
@@ -335,7 +342,7 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	dc->user_data = user_data;
 	dc->end = end;
 
-	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, char_discovered_cb,
+	return g_attrib_send(attrib, 0, buf[0], buf, plen, char_discovered_cb,
 								dc, NULL);
 }
 
@@ -343,15 +350,16 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 					bt_uuid_t *uuid, GAttribResultFunc func,
 					gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	guint16 plen;
 
-	plen = enc_read_by_type_req(start, end, uuid, pdu, sizeof(pdu));
+	plen = enc_read_by_type_req(start, end, uuid, buf, buflen);
 	if (plen == 0)
 		return 0;
 
 	return g_attrib_send(attrib, 0, ATT_OP_READ_BY_TYPE_REQ,
-					pdu, plen, func, user_data, NULL);
+					buf, plen, func, user_data, NULL);
 }
 
 struct read_long_data {
@@ -382,7 +390,8 @@ static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
 							gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	uint8_t *buf;
+	int buflen;
 	guint8 *tmp;
 	guint16 plen;
 	guint id;
@@ -403,13 +412,14 @@ static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
 	long_read->buffer = tmp;
 	long_read->size += rlen - 1;
 
-	if (rlen < ATT_DEFAULT_LE_MTU)
+	buf = g_attrib_get_buffer(long_read->attrib, &buflen);
+	if (rlen < buflen)
 		goto done;
 
 	plen = enc_read_blob_req(long_read->handle, long_read->size - 1,
-							pdu, sizeof(pdu));
+								buf, buflen);
 	id = g_attrib_send(long_read->attrib, long_read->id,
-				ATT_OP_READ_BLOB_REQ, pdu, plen,
+				ATT_OP_READ_BLOB_REQ, buf, plen,
 				read_blob_helper, long_read, read_long_destroy);
 
 	if (id != 0) {
@@ -428,11 +438,12 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 					guint16 rlen, gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	int buflen;
+	uint8_t *buf = g_attrib_get_buffer(long_read->attrib, &buflen);
 	guint16 plen;
 	guint id;
 
-	if (status != 0 || rlen < ATT_DEFAULT_LE_MTU)
+	if (status != 0 || rlen < buflen)
 		goto done;
 
 	long_read->buffer = g_malloc(rlen);
@@ -443,9 +454,9 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 	memcpy(long_read->buffer, rpdu, rlen);
 	long_read->size = rlen;
 
-	plen = enc_read_blob_req(long_read->handle, rlen - 1, pdu, sizeof(pdu));
+	plen = enc_read_blob_req(long_read->handle, rlen - 1, buf, buflen);
 	id = g_attrib_send(long_read->attrib, long_read->id,
-			ATT_OP_READ_BLOB_REQ, pdu, plen, read_blob_helper,
+			ATT_OP_READ_BLOB_REQ, buf, plen, read_blob_helper,
 			long_read, read_long_destroy);
 
 	if (id != 0) {
@@ -462,7 +473,8 @@ done:
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
 				GAttribResultFunc func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	uint8_t *buf;
+	int buflen;
 	guint16 plen;
 	guint id;
 	struct read_long_data *long_read;
@@ -477,14 +489,15 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
 	long_read->user_data = user_data;
 	long_read->handle = handle;
 
+	buf = g_attrib_get_buffer(attrib, &buflen);
 	if (offset > 0) {
-		plen = enc_read_blob_req(long_read->handle, offset, pdu,
-								sizeof(pdu));
-		id = g_attrib_send(attrib, 0, ATT_OP_READ_BLOB_REQ, pdu, plen,
+		plen = enc_read_blob_req(long_read->handle, offset, buf,
+									buflen);
+		id = g_attrib_send(attrib, 0, ATT_OP_READ_BLOB_REQ, buf, plen,
 				read_blob_helper, long_read, read_long_destroy);
 	} else {
-		plen = enc_read_req(handle, pdu, sizeof(pdu));
-		id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, pdu, plen,
+		plen = enc_read_req(handle, buf, buflen);
+		id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, buf, plen,
 				read_char_helper, long_read, read_long_destroy);
 	}
 
@@ -501,39 +514,45 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 			int vlen, GAttribResultFunc func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	uint8_t *buf;
+	int buflen;
 	guint16 plen;
 
+	buf = g_attrib_get_buffer(attrib, &buflen);
 	if (func)
-		plen = enc_write_req(handle, value, vlen, pdu, sizeof(pdu));
+		plen = enc_write_req(handle, value, vlen, buf, buflen);
 	else
-		plen = enc_write_cmd(handle, value, vlen, pdu, sizeof(pdu));
+		plen = enc_write_cmd(handle, value, vlen, buf, buflen);
 
-	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, func,
+	return g_attrib_send(attrib, 0, buf[0], buf, plen, func,
 							user_data, NULL);
 }
 
 guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	uint8_t *buf;
+	int buflen;
 	guint16 plen;
 
-	plen = enc_find_info_req(start, end, pdu, sizeof(pdu));
+	buf = g_attrib_get_buffer(attrib, &buflen);
+	plen = enc_find_info_req(start, end, buf, buflen);
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, ATT_OP_FIND_INFO_REQ, pdu, plen, func,
+	return g_attrib_send(attrib, 0, ATT_OP_FIND_INFO_REQ, buf, plen, func,
 							user_data, NULL);
 }
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 				GDestroyNotify notify, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	uint8_t *buf;
+	int buflen;
 	guint16 plen;
 
-	plen = enc_write_cmd(handle, value, vlen, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, 0, ATT_OP_WRITE_CMD, pdu, plen, NULL,
+	buf = g_attrib_get_buffer(attrib, &buflen);
+	plen = enc_write_cmd(handle, value, vlen, buf, buflen);
+	return g_attrib_send(attrib, 0, ATT_OP_WRITE_CMD, buf, plen, NULL,
 							user_data, notify);
 }
-- 
1.7.0.4

