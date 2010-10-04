Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 2/4] Remove typecast from att_get_u16() calls
Date: Mon,  4 Oct 2010 15:13:02 -0400
Message-Id: <1286219584-8199-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1286219584-8199-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1286219584-8199-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

att_get_u16() already does a cast of the void* parameter to uint16_t*.
---
 attrib/att.c      |   26 +++++++++++++-------------
 attrib/client.c   |   19 +++++++++----------
 attrib/gatttool.c |   21 +++++++++------------
 3 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 6c697f8..21659f0 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -132,10 +132,10 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
 	if (len < 7)
 		return 0;
 
-	*start = att_get_u16((uint16_t *) &pdu[1]);
-	*end = att_get_u16((uint16_t *) &pdu[3]);
+	*start = att_get_u16(&pdu[1]);
+	*end = att_get_u16(&pdu[3]);
 	if (len == 7)
-		sdp_uuid16_create(uuid, att_get_u16((uint16_t *) &pdu[5]));
+		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
 	else
 		sdp_uuid128_create(uuid, &pdu[5]);
 
@@ -245,11 +245,11 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
 		return 0;
 
-	*start = att_get_u16((uint16_t *) &pdu[1]);
-	*end = att_get_u16((uint16_t *) &pdu[3]);
+	*start = att_get_u16(&pdu[1]);
+	*end = att_get_u16(&pdu[3]);
 
 	if (len == 7)
-		sdp_uuid16_create(uuid, att_get_u16((uint16_t *) &pdu[5]));
+		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
 	else
 		sdp_uuid128_create(uuid, &pdu[5]);
 
@@ -346,7 +346,7 @@ uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
 	if (pdu[0] != ATT_OP_WRITE_CMD)
 		return 0;
 
-	*handle = att_get_u16((uint16_t *) &pdu[1]);
+	*handle = att_get_u16(&pdu[1]);
 	memcpy(value, pdu + 3, len - 3);
 	*vlen = len - 3;
 
@@ -378,7 +378,7 @@ uint16_t dec_read_req(const uint8_t *pdu, uint16_t *handle)
 	if (pdu[0] != ATT_OP_READ_REQ)
 		return 0;
 
-	*handle = att_get_u16((uint16_t *) &pdu[1]);
+	*handle = att_get_u16(&pdu[1]);
 
 	return 3;
 }
@@ -466,8 +466,8 @@ uint16_t dec_find_info_req(const uint8_t *pdu, int len, uint16_t *start,
 	if (pdu[0] != ATT_OP_FIND_INFO_REQ)
 		return 0;
 
-	*start = att_get_u16((uint16_t *) &pdu[1]);
-	*end = att_get_u16((uint16_t *) &pdu[3]);
+	*start = att_get_u16(&pdu[1]);
+	*end = att_get_u16(&pdu[3]);
 
 	return 5;
 }
@@ -585,7 +585,7 @@ struct attribute *dec_indication(const uint8_t *pdu, int len)
 
 	a->len = len - 3;
 
-	a->handle = att_get_u16((uint16_t *) &pdu[1]);
+	a->handle = att_get_u16(&pdu[1]);
 	memcpy(a->data, &pdu[3], a->len);
 
 	return a;
@@ -632,7 +632,7 @@ uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu)
 	if (pdu[0] != ATT_OP_MTU_REQ)
 		return 0;
 
-	*mtu = att_get_u16((uint16_t *) &pdu[1]);
+	*mtu = att_get_u16(&pdu[1]);
 
 	return 3;
 }
@@ -665,7 +665,7 @@ uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu)
 	if (pdu[0] != ATT_OP_MTU_RESP)
 		return 0;
 
-	*mtu = att_get_u16((uint16_t *) &pdu[1]);
+	*mtu = att_get_u16(&pdu[1]);
 
 	return 3;
 }
diff --git a/attrib/client.c b/attrib/client.c
index db84b78..cd720e6 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -286,7 +286,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	struct primary *prim;
 	GSList *lprim, *lchr;
 	uint8_t opdu[ATT_MAX_MTU];
-	guint handle = att_get_u16((uint16_t *) &pdu[1]);
+	guint handle = att_get_u16(&pdu[1]);
 	uint16_t olen;
 
 	for (lprim = gatt->primary, prim = NULL, chr = NULL; lprim;
@@ -872,11 +872,10 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		uint8_t *info = list->data[i];
 		struct query_data *qfmt;
 
-		handle = att_get_u16((uint16_t *) info);
+		handle = att_get_u16(info);
 
 		if (format == 0x01) {
-			sdp_uuid16_create(&uuid, att_get_u16((uint16_t *)
-								&info[2]));
+			sdp_uuid16_create(&uuid, att_get_u16(&info[2]));
 		} else {
 			/* Currently, only "user description" and "presentation
 			 * format" descriptors are used, and both have 16-bit
@@ -963,17 +962,17 @@ static void char_discovered_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		chr = g_new0(struct characteristic, 1);
 		chr->prim = prim;
 		chr->perm = decl[2];
-		chr->handle = att_get_u16((uint16_t *) &decl[3]);
+		chr->handle = att_get_u16(&decl[3]);
 		chr->path = g_strdup_printf("%s/characteristic%04x",
 						prim->path, chr->handle);
 		if (list->len == 7) {
 			sdp_uuid16_create(&chr->type,
-					att_get_u16((uint16_t *) &decl[5]));
+					att_get_u16(&decl[5]));
 		} else
 			sdp_uuid128_create(&chr->type, &decl[5]);
 
 		if (previous_end) {
-			*previous_end = att_get_u16((uint16_t *) decl);
+			*previous_end = att_get_u16(decl);
 		}
 
 		last = chr->handle;
@@ -1270,8 +1269,8 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		/* Each element contains: attribute handle, end group handle
 		 * and attribute value */
-		start = att_get_u16((uint16_t *) info);
-		end = att_get_u16((uint16_t *) &info[2]);
+		start = att_get_u16(info);
+		end = att_get_u16(&info[2]);
 
 		prim = g_new0(struct primary, 1);
 		prim->gatt = gatt;
@@ -1280,7 +1279,7 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		if (list->len == 6) {
 			sdp_uuid16_create(&prim->uuid,
-					att_get_u16((uint16_t *) &info[4]));
+					att_get_u16(&info[4]));
 
 		} else if (list->len == 20) {
 			/* FIXME: endianness */
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 18f32a2..4a66340 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -167,14 +167,13 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		/* Each element contains: attribute handle, end group handle
 		 * and attribute value */
 		length = list->len - 2 * sizeof(uint16_t);
-		start = att_get_u16((uint16_t *) value);
-		end = att_get_u16((uint16_t *) &value[2]);
+		start = att_get_u16(value);
+		end = att_get_u16(&value[2]);
 
 		g_print("attr handle = 0x%04x, end grp handle = 0x%04x, ",
 								start, end);
 		if (length == 2)
-			sdp_uuid16_create(&uuid, att_get_u16((uint16_t *)
-								&value[4]));
+			sdp_uuid16_create(&uuid, att_get_u16(&value[4]));
 		else
 			sdp_uuid128_create(&uuid, value + 4);
 
@@ -204,7 +203,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	uint8_t opdu[ATT_MAX_MTU];
 	uint16_t handle, i, olen = 0;
 
-	handle = att_get_u16((uint16_t *) &pdu[1]);
+	handle = att_get_u16(&pdu[1]);
 
 	switch (pdu[0]) {
 	case ATT_OP_HANDLE_NOTIFY:
@@ -279,15 +278,14 @@ static void char_discovered_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		char uuidstr[MAX_LEN_UUID_STR];
 		uuid_t uuid;
 
-		last = att_get_u16((uint16_t *) value);
+		last = att_get_u16(value);
 
 		g_print("handle = 0x%04x, char properties = 0x%02x, "
 			"char value handle = 0x%04x, ", last, value[2],
-			att_get_u16((uint16_t *) &value[3]));
+			att_get_u16(&value[3]));
 
 		if (list->len == 7)
-			sdp_uuid16_create(&uuid, att_get_u16((uint16_t *)
-								&value[5]));
+			sdp_uuid16_create(&uuid, att_get_u16(&value[5]));
 		else
 			sdp_uuid128_create(&uuid, value + 5);
 
@@ -447,11 +445,10 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		uuid_t uuid;
 
 		value = list->data[i];
-		handle = att_get_u16((uint16_t *) value);
+		handle = att_get_u16(value);
 
 		if (format == 0x01)
-			sdp_uuid16_create(&uuid, att_get_u16((uint16_t *)
-								&value[2]));
+			sdp_uuid16_create(&uuid, att_get_u16(&value[2]));
 		else
 			sdp_uuid128_create(&uuid, &value[2]);
 
-- 
1.7.0.4

