Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v3 7/9] shared/gatt-server: Support for reliable session nested with long
Date: Fri, 18 Mar 2016 14:08:16 +0100
Message-Id: <1458306498-28151-8-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1458306498-28151-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1458306498-28151-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to do reliable session to one
characteristic nested with long write.

We assume that long write as consequtive prep writes with continous
offsets. Otherwise we treat it as single reliable write.

Note: Long write can be started from non 0 offset as well

With this patch we support following scenarios:

e.g. 1:
(a) prep_write: handle 1, offset 0, value_len 10
(b) prep_write: handle 1, offset 5, value_len 5
(c) prep_write: handle 1, offset 10, value_len 6

Will result with:

(a) exec_write: handle 1, offset 0, value_len 10
(b + c) exec_write: handle 1, offset 10, value_len 11

e.g. 2:
(a) prep_write: handle 1, offset 0, value_len 10
(b) prep_write: handle 1, offset 5, value_len 3
(c) prep_write: handle 1, offset 10, value_len 6

Will result with:

(a) exec_write: handle 1, offset 0, value_len 10
(b) exec_write: handle 1, offset 5, value_len 3
(c) exec_write: handle 1, offset 10, value_len 6
---
 src/shared/gatt-server.c | 49 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0904336..7a0c92f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1088,13 +1088,6 @@ error:
 	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
 }
 
-static bool match_attribute_handle(const void *data, const void *match_data)
-{
-	const struct prep_write_data *prep_data = data;
-
-	return prep_data->handle == PTR_TO_UINT(match_data);
-}
-
 static bool create_and_store_prep_data(struct bt_gatt_server *server,
 						uint16_t handle, uint16_t offset,
 						uint16_t length, uint8_t *value)
@@ -1145,16 +1138,40 @@ static bool make_aggregation_of_long_write_data(struct bt_gatt_server *server,
 	return true;
 }
 
+struct prep_match_data {
+	uint16_t handle;
+	uint16_t offset;
+	struct prep_write_data *p;
+};
+
+static void match_prep_data(void *data, void *user_data)
+{
+	struct prep_write_data *prep_data = data;
+	struct prep_match_data *s = user_data;
+
+	if (prep_data->handle != s->handle)
+		return;
+
+	/*
+	 * We are looking for last prepare write for given handle
+	 * with offset we could assume that it is long write
+	 */
+	if (prep_data->offset + prep_data->length == s->offset)
+		s->p = prep_data;
+	else
+		s->p = NULL;
+}
+
 static void prep_write_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
-	struct prep_write_data *prep_data = NULL;
 	uint16_t handle = 0;
 	uint16_t offset;
 	struct gatt_db_attribute *attr;
 	uint8_t ecode;
 	bool success;
+	struct prep_match_data match_data;
 
 	if (length < 4) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -1184,12 +1201,15 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	if (ecode)
 		goto error;
 
-	prep_data = queue_find(server->prep_queue, match_attribute_handle,
-							UINT_TO_PTR(handle));
+	match_data.handle = handle;
+	match_data.offset = offset;
+	match_data.p = NULL;
 
-	if (prep_data && offset == prep_data->length + prep_data->offset)
-		success = make_aggregation_of_long_write_data(server, prep_data,
-							handle, length - 4,
+	queue_foreach(server->prep_queue, match_prep_data, &match_data);
+	if (match_data.p)
+		success = make_aggregation_of_long_write_data(server,
+							match_data.p,
+							handle,length - 4,
 							&((uint8_t *) pdu)[4]);
 	else
 		success = create_and_store_prep_data(server, handle, offset,
@@ -1205,9 +1225,6 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	return;
 
 error:
-	if (prep_data)
-		prep_write_data_destroy(prep_data);
-
 	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
 
 }
-- 
2.5.0

