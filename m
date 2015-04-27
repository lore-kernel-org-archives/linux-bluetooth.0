Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] shared/gatt-server: Check attribute permissions
Date: Mon, 27 Apr 2015 16:14:31 +0300
Message-Id: <1430140475-20349-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/att-types.h   | 16 ++++-----
 src/shared/gatt-server.c | 93 ++++++++++++++++++++++++++----------------------
 2 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index ea4c009..ee20992 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -115,12 +115,12 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_PERM_WRITE		0x02
 #define BT_ATT_PERM_READ_ENCRYPT	0x04
 #define BT_ATT_PERM_WRITE_ENCRYPT	0x08
-#define BT_ATT_PERM_ENCRYPT		BT_ATT_PERM_READ_ENCRYPT | \
-					BT_ATT_PERM_WRITE_ENCRYPT
+#define BT_ATT_PERM_ENCRYPT		(BT_ATT_PERM_READ_ENCRYPT | \
+					BT_ATT_PERM_WRITE_ENCRYPT)
 #define BT_ATT_PERM_READ_AUTHEN		0x10
 #define BT_ATT_PERM_WRITE_AUTHEN	0x20
-#define BT_ATT_PERM_AUTHEN		BT_ATT_PERM_READ_AUTHEN | \
-					BT_ATT_PERM_WRITE_AUTHEN
+#define BT_ATT_PERM_AUTHEN		(BT_ATT_PERM_READ_AUTHEN | \
+					BT_ATT_PERM_WRITE_AUTHEN)
 #define BT_ATT_PERM_AUTHOR		0x40
 #define BT_ATT_PERM_NONE		0x80
 
@@ -139,9 +139,9 @@ struct bt_att_pdu_error_rsp {
 #define BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX		0x02
 #define BT_GATT_CHRC_EXT_PROP_ENC_READ			0x04
 #define BT_GATT_CHRC_EXT_PROP_ENC_WRITE			0x08
-#define BT_GATT_CHRC_EXT_PROP_ENC	BT_GATT_CHRC_EXT_PROP_ENC_READ | \
-					BT_GATT_CHRC_EXT_PROP_ENC_WRITE
+#define BT_GATT_CHRC_EXT_PROP_ENC	(BT_GATT_CHRC_EXT_PROP_ENC_READ | \
+					BT_GATT_CHRC_EXT_PROP_ENC_WRITE)
 #define BT_GATT_CHRC_EXT_PROP_AUTH_READ			0x10
 #define BT_GATT_CHRC_EXT_PROP_AUTH_WRITE		0x20
-#define BT_GATT_CHRC_EXT_PROP_AUTH	BT_GATT_CHRC_EXT_PROP_AUTH_READ | \
-					BT_GATT_CHRC_EXT_PROP_AUTH_WRITE
+#define BT_GATT_CHRC_EXT_PROP_AUTH	(BT_GATT_CHRC_EXT_PROP_AUTH_READ | \
+					BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index b5f55ad..ae77dcc 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -377,12 +377,39 @@ done:
 	process_read_by_type(op);
 }
 
+static uint8_t check_permissions(struct bt_gatt_server *server,
+				struct gatt_db_attribute *attr, uint32_t mask)
+{
+	uint32_t perm;
+	int security;
+
+	perm = gatt_db_attribute_get_permissions(attr);
+
+	if (perm && mask & BT_ATT_PERM_READ && !(perm & BT_ATT_PERM_READ))
+		return BT_ATT_ERROR_READ_NOT_PERMITTED;
+
+	if (perm && mask & BT_ATT_PERM_WRITE && !(perm & BT_ATT_PERM_WRITE))
+		return BT_ATT_ERROR_WRITE_NOT_PERMITTED;
+
+	perm &= mask;
+	if (!perm)
+		return 0;
+
+	security = bt_att_get_sec_level(server->att);
+	if (perm & BT_ATT_PERM_AUTHEN && security < BT_ATT_SECURITY_HIGH)
+		return BT_ATT_ERROR_AUTHENTICATION;
+
+	if (perm & BT_ATT_PERM_ENCRYPT && security < BT_ATT_SECURITY_MEDIUM)
+		return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION;
+
+	return 0;
+}
+
 static void process_read_by_type(struct async_read_op *op)
 {
 	struct bt_gatt_server *server = op->server;
 	uint8_t ecode;
 	struct gatt_db_attribute *attr;
-	uint32_t perm;
 
 	attr = queue_pop_head(op->db_data);
 
@@ -395,18 +422,11 @@ static void process_read_by_type(struct async_read_op *op)
 		return;
 	}
 
-	perm = gatt_db_attribute_get_permissions(attr);
-
-	/*
-	 * Check for the READ access permission. Encryption,
-	 * authentication, and authorization permissions need to be
-	 * checked by the read handler, since bt_att is agnostic to
-	 * connection type and doesn't have security information on it.
-	 */
-	if (perm && !(perm & BT_ATT_PERM_READ)) {
-		ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
+	ecode = check_permissions(server, attr, BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_AUTHEN |
+						BT_ATT_PERM_READ_ENCRYPT);
+	if (ecode)
 		goto error;
-	}
 
 	if (gatt_db_attribute_read(attr, 0, op->opcode, server->att,
 					read_by_type_read_complete_cb, op))
@@ -752,7 +772,6 @@ static void write_cb(uint8_t opcode, const void *pdu,
 	uint16_t handle = 0;
 	struct async_write_op *op = NULL;
 	uint8_t ecode;
-	uint32_t perm;
 
 	if (length < 2) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -771,12 +790,11 @@ static void write_cb(uint8_t opcode, const void *pdu,
 				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
 				handle);
 
-	perm = gatt_db_attribute_get_permissions(attr);
-
-	if (!(perm & BT_ATT_PERM_WRITE)) {
-		ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
+	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE |
+						BT_ATT_PERM_WRITE_AUTHEN |
+						BT_ATT_PERM_WRITE_ENCRYPT);
+	if (ecode)
 		goto error;
-	}
 
 	if (server->pending_write_op) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
@@ -871,7 +889,6 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 {
 	struct gatt_db_attribute *attr;
 	uint8_t ecode;
-	uint32_t perm;
 	struct async_read_op *op = NULL;
 
 	attr = gatt_db_get_attribute(server->db, handle);
@@ -885,12 +902,11 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 			opcode == BT_ATT_OP_READ_BLOB_REQ ? "Blob " : "",
 			handle);
 
-	perm = gatt_db_attribute_get_permissions(attr);
-
-	if (perm && !(perm & BT_ATT_PERM_READ)) {
-		ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
+	ecode = check_permissions(server, attr, BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_AUTHEN |
+						BT_ATT_PERM_READ_ENCRYPT);
+	if (ecode)
 		goto error;
-	}
 
 	if (server->pending_read_op) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
@@ -980,8 +996,8 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 {
 	struct read_multiple_resp_data *data = user_data;
 	struct gatt_db_attribute *next_attr;
-	uint32_t perm;
 	uint16_t handle = gatt_db_attribute_get_handle(attr);
+	uint8_t ecode;
 
 	if (err != 0) {
 		bt_att_send_error_rsp(data->server->att,
@@ -990,12 +1006,12 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 		return;
 	}
 
-	perm = gatt_db_attribute_get_permissions(attr);
-
-	if (perm && !(perm & BT_ATT_PERM_READ)) {
+	ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_AUTHEN |
+						BT_ATT_PERM_READ_ENCRYPT);
+	if (ecode) {
 		bt_att_send_error_rsp(data->server->att,
-					BT_ATT_OP_READ_MULT_REQ, handle,
-					BT_ATT_ERROR_READ_NOT_PERMITTED);
+					BT_ATT_OP_READ_MULT_REQ, handle, ecode);
 		read_multiple_resp_data_free(data);
 		return;
 	}
@@ -1107,7 +1123,6 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	uint16_t offset;
 	struct gatt_db_attribute *attr;
 	uint8_t ecode;
-	uint32_t perm;
 
 	if (length < 4) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -1131,19 +1146,11 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	util_debug(server->debug_callback, server->debug_data,
 				"Prep Write Req - handle: 0x%04x", handle);
 
-	perm = gatt_db_attribute_get_permissions(attr);
-
-	/*
-	 * TODO: The "Prepare Write" request requires security permission checks
-	 * to be performed before the write is executed. I.e., we can't leave
-	 * the permission check to the upper layer since we can't call
-	 * gatt_db_write until the entire queue is atomically processed during
-	 * an "Execute Write" request. Figure out how to make this check here.
-	 */
-	if (!(perm & BT_ATT_PERM_WRITE)) {
-		ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
+	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE |
+						BT_ATT_PERM_WRITE_AUTHEN |
+						BT_ATT_PERM_WRITE_ENCRYPT);
+	if (ecode)
 		goto error;
-	}
 
 	prep_data = new0(struct prep_write_data, 1);
 	if (!prep_data) {
-- 
2.1.0

