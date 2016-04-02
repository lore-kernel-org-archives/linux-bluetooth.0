Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v5 1/3] shared/gatt-server: Add support for long write
Date: Sat,  2 Apr 2016 22:26:47 +0200
Message-Id: <1459628809-32348-2-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1459628809-32348-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1459628809-32348-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch long write and nested long write reliable is supported.
GATT server is responsible now to do aggregation of prep write data
for long write session.
Note: We consider long write as the consequtive prepare writes with
continues offsets.

E.g. 1

prep_write: handle 1, offset 0, value_len 10
prep_write: handle 1, offset 10, value_len 10
prep_write: handle 2, offset 0, value_len 10
prep_write: handle 2, offset 10, value_len 10

Will result with following calles to app:

exec_write: handle 1: offset 0, value_len 20
exec_write: handle 2: offset 0, value_len 20

E.g. 2

prep_write: handle 1, offset 0, value_len 10
prep_write: handle 1, offset 2, value_len 5
prep_write: handle 2, offset 0, value_len 10
prep_write: handle 2, offset 4, value_len 5

Will result with following calles to app:

exec_write: handle 1: offset 0, value_len 10
exec_write: handle 1: offset 2, value_len 5
exec_write: handle 2: offset 0, value_len 10
exec_write: handle 2: offset 4, value_len 5

E.g. 3
prep_write: handle 1, offset 0, value_len 10
prep_write: handle 1, offset 5, value_len 5
prep_write: handle 1, offset 10, value_len 6

will result with following calles to app:

exec_write: handle 1, offset 0, value 10
exec_write: handle 1, offset 5, value 11
---
 src/shared/gatt-server.c | 91 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 20 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index c41273a..a88b62f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1088,11 +1088,77 @@ error:
 	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
 }
 
+static bool create_and_store_prep_data(struct bt_gatt_server *server,
+						uint16_t handle, uint16_t offset,
+						uint16_t length, uint8_t *value)
+{
+	struct prep_write_data *prep_data;
+
+	prep_data = new0(struct prep_write_data, 1);
+	prep_data->length = length;
+	if (prep_data->length) {
+		prep_data->value = malloc(prep_data->length);
+		if (!prep_data->value) {
+			prep_write_data_destroy(prep_data);
+			return false;
+		}
+
+		memcpy(prep_data->value, value, prep_data->length);
+	}
+
+	prep_data->server = server;
+	prep_data->handle = handle;
+	prep_data->offset = offset;
+
+	queue_push_tail(server->prep_queue, prep_data);
+
+	return true;
+}
+
+static bool make_aggregation_of_long_write_data(struct bt_gatt_server *server,
+					struct prep_write_data *prep_data,
+					uint16_t handle, uint16_t length,
+					uint8_t *value)
+{
+	uint16_t new_len;
+
+	new_len = prep_data->length + length;
+
+	prep_data->value = realloc(prep_data->value, new_len);
+	if (!prep_data->value)
+		return false;
+
+	memcpy(prep_data->value + prep_data->length, value, length);
+	prep_data->length = new_len;
+
+	return true;
+}
+
+static bool store_prep_data(struct bt_gatt_server *server,
+						uint16_t handle, uint16_t offset,
+						uint16_t length, uint8_t *value)
+{
+	struct prep_write_data *prep_data = NULL;
+
+	/*
+	 * Now lets check if prep write is a continuation of long write
+	 * If so do aggregation of data
+	 */
+	prep_data = queue_peek_tail(server->prep_queue);
+	if (prep_data && (prep_data->handle == handle) &&
+			(offset == (prep_data->length + prep_data->offset)))
+		return make_aggregation_of_long_write_data(server, prep_data,
+								handle,
+								length, value);
+
+	return create_and_store_prep_data(server, handle, offset,
+								length, value);
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
@@ -1126,33 +1192,18 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	if (ecode)
 		goto error;
 
-	prep_data = new0(struct prep_write_data, 1);
-	prep_data->length = length - 4;
-	if (prep_data->length) {
-		prep_data->value = malloc(prep_data->length);
-		if (!prep_data->value) {
-			ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-			goto error;
-		}
+	if (!store_prep_data(server, handle, offset, length - 4,
+						&((uint8_t *) pdu)[4])) {
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
 	}
 
-	prep_data->server = server;
-	prep_data->handle = handle;
-	prep_data->offset = offset;
-	memcpy(prep_data->value, pdu + 4, prep_data->length);
-
-	queue_push_tail(server->prep_queue, prep_data);
-
 	bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length, NULL,
 								NULL, NULL);
 	return;
 
 error:
-	if (prep_data)
-		prep_write_data_destroy(prep_data);
-
 	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
-
 }
 
 static void exec_next_prep_write(struct bt_gatt_server *server,
-- 
2.5.0

