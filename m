Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 02/14] shared/gatt: Pass bt_att instead of bdaddr_t
Date: Wed, 11 Feb 2015 19:17:32 -0800
Message-Id: <1423711064-7390-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replaced the bdaddr_t parameter of gatt_db's read/write functions
and callbacks with a bt_att parameter. The BDADDR information can
be obtained from the bt_att's underlying file descriptor.
---
 android/gatt.c           | 98 ++++++++++++++++++++++++++++++++++++------------
 src/gatt-client.c        |  1 +
 src/shared/gatt-db.c     | 10 ++---
 src/shared/gatt-db.h     |  8 ++--
 src/shared/gatt-server.c | 32 +++++++++-------
 tools/btgatt-server.c    | 18 ++++-----
 unit/test-gatt.c         |  5 ++-
 7 files changed, 113 insertions(+), 59 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8e58e41..fd67b22 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -44,6 +44,7 @@
 #include "utils.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -4849,6 +4850,7 @@ static void read_requested_attributes(void *data, void *user_data)
 {
 	struct pending_request *resp_data = data;
 	struct request_processing_data *process_data = user_data;
+	struct bt_att *att = g_attrib_get_att(process_data->device->attrib);
 	struct gatt_db_attribute *attrib;
 	uint32_t permissions;
 	uint8_t error;
@@ -4879,8 +4881,7 @@ static void read_requested_attributes(void *data, void *user_data)
 	}
 
 	gatt_db_attribute_read(attrib, resp_data->offset, process_data->opcode,
-						&process_data->device->bdaddr,
-						attribute_read_cb, resp_data);
+					att, attribute_read_cb, resp_data);
 }
 
 static void process_dev_pending_requests(struct gatt_device *device,
@@ -4926,8 +4927,29 @@ static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
 	return transaction;
 }
 
+static bool get_dst_addr(struct bt_att *att, bdaddr_t *dst)
+{
+	GIOChannel *io = NULL;
+	GError *gerr = NULL;
+
+	io = g_io_channel_unix_new(bt_att_get_fd(att));
+	if (!io)
+		return false;
+
+	bt_io_get(io, &gerr, BT_IO_OPT_DEST_BDADDR, dst, BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("gatt: bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_unref(io);
+		return false;
+	}
+
+	g_io_channel_unref(io);
+	return true;
+}
+
 static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
-			uint16_t offset, uint8_t opcode, bdaddr_t *bdaddr,
+			uint16_t offset, uint8_t opcode, struct bt_att *att,
 			void *user_data)
 {
 	struct pending_trans_data *transaction;
@@ -4935,6 +4957,7 @@ static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 	struct gatt_app *app;
 	struct app_connection *conn;
 	int32_t app_id = PTR_TO_INT(user_data);
+	bdaddr_t bdaddr;
 
 	DBG("id %u", id);
 
@@ -4944,7 +4967,12 @@ static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 		goto failed;
 	}
 
-	conn = find_conn(bdaddr, app->id);
+	if (!get_dst_addr(att, &bdaddr)) {
+		error("gatt: read_cb, could not obtain dst BDADDR");
+		goto failed;
+	}
+
+	conn = find_conn(&bdaddr, app->id);
 	if (!conn) {
 		error("gatt: read_cb, cound not found connection");
 		goto failed;
@@ -4957,7 +4985,7 @@ static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 	if (!transaction)
 		goto failed;
 
-	bdaddr2android(bdaddr, ev.bdaddr);
+	bdaddr2android(&bdaddr, ev.bdaddr);
 	ev.conn_id = conn->id;
 	ev.attr_handle = gatt_db_attribute_get_handle(attrib);
 	ev.offset = offset;
@@ -4976,7 +5004,7 @@ failed:
 
 static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
 			uint16_t offset, const uint8_t *value, size_t len,
-			uint8_t opcode, bdaddr_t *bdaddr, void *user_data)
+			uint8_t opcode, struct bt_att *att, void *user_data)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_server_request_write *ev = (void *) buf;
@@ -4984,6 +5012,7 @@ static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
 	struct gatt_app *app;
 	int32_t app_id = PTR_TO_INT(user_data);
 	struct app_connection *conn;
+	bdaddr_t bdaddr;
 
 	DBG("id %u", id);
 
@@ -4993,7 +5022,12 @@ static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
 		goto failed;
 	}
 
-	conn = find_conn(bdaddr, app->id);
+	if (!get_dst_addr(att, &bdaddr)) {
+		error("gatt: write_cb, could not obtain dst BDADDR");
+		goto failed;
+	}
+
+	conn = find_conn(&bdaddr, app->id);
 	if (!conn) {
 		error("gatt: write_cb could not found connection");
 		goto failed;
@@ -5013,7 +5047,7 @@ static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
 
 	memset(ev, 0, sizeof(*ev));
 
-	bdaddr2android(bdaddr, &ev->bdaddr);
+	bdaddr2android(&bdaddr, &ev->bdaddr);
 	ev->attr_handle = gatt_db_attribute_get_handle(attrib);
 	ev->offset = offset;
 
@@ -6405,8 +6439,9 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
 
-	gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr,
-							write_confirm, NULL);
+	gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
+						g_attrib_get_att(dev->attrib),
+						write_confirm, NULL);
 }
 
 static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
@@ -6478,7 +6513,8 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		/* Signature OK, proceed with write */
 		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
 		gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
-					&dev->bdaddr, write_confirm, NULL);
+						g_attrib_get_att(dev->attrib),
+						write_confirm, NULL);
 	}
 }
 
@@ -6537,8 +6573,8 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
-					&dev->bdaddr, attribute_write_cb,
-					data)) {
+						g_attrib_get_att(dev->attrib),
+						attribute_write_cb, data)) {
 		queue_remove(dev->pending_requests, data);
 		free(data);
 		return ATT_ECODE_UNLIKELY;
@@ -6596,8 +6632,8 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	data->length = vlen;
 
 	if (!gatt_db_attribute_write(attrib, offset, value, vlen, cmd[0],
-					&dev->bdaddr, attribute_write_cb,
-					data)) {
+						g_attrib_get_att(dev->attrib),
+						attribute_write_cb, data)) {
 		queue_remove(dev->pending_requests, data);
 		g_free(data->value);
 		free(data);
@@ -6817,7 +6853,7 @@ static struct gap_srvc_handles gap_srvc_data;
 
 static void device_name_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	const char *name = bt_get_adapter_name();
@@ -6893,7 +6929,7 @@ static void register_gap_service(void)
 
 static void device_info_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	char *buf = user_data;
@@ -6903,7 +6939,7 @@ static void device_info_read_cb(struct gatt_db_attribute *attrib,
 
 static void device_info_read_system_id_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	uint8_t pdu[8];
@@ -6915,7 +6951,7 @@ static void device_info_read_system_id_cb(struct gatt_db_attribute *attrib,
 
 static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	uint8_t pdu[7];
@@ -7029,18 +7065,24 @@ static void register_device_info_service(void)
 static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct gatt_device *dev;
+	bdaddr_t bdaddr;
 
-	dev = find_device_by_addr(bdaddr);
+	if (!get_dst_addr(att, &bdaddr)) {
+		error("gatt: srvc_change_write_cb, could not obtain BDADDR");
+		return;
+	}
+
+	dev = find_device_by_addr(&bdaddr);
 	if (!dev) {
 		error("gatt: Could not find device ?!");
 		return;
 	}
 
-	if (!bt_device_is_bonded(bdaddr)) {
+	if (!bt_device_is_bonded(&bdaddr)) {
 		gatt_db_attribute_write_result(attrib, id,
 						ATT_ECODE_AUTHORIZATION);
 		return;
@@ -7054,20 +7096,26 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	/* Set services changed indication value */
-	bt_store_gatt_ccc(bdaddr, get_le16(value));
+	bt_store_gatt_ccc(&bdaddr, get_le16(value));
 
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
 
 static void gatt_srvc_change_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct gatt_device *dev;
 	uint8_t pdu[2];
+	bdaddr_t bdaddr;
 
-	dev = find_device_by_addr(bdaddr);
+	if (!get_dst_addr(att, &bdaddr)) {
+		error("gatt: srvc_change_read_cb, could not obtain BDADDR");
+		return;
+	}
+
+	dev = find_device_by_addr(&bdaddr);
 	if (!dev) {
 		error("gatt: Could not find device ?!");
 		return;
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 9811bd8..06988c6 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -34,6 +34,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "lib/uuid.h"
+#include "lib/bluetooth.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f72d58e..42ce5c2 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -28,8 +28,8 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/timeout.h"
+#include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
-#include "src/shared/att-types.h"
 
 #ifndef MAX
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -1427,7 +1427,7 @@ static bool read_timeout(void *user_data)
 }
 
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
-				uint8_t opcode, bdaddr_t *bdaddr,
+				uint8_t opcode, struct bt_att *att,
 				gatt_db_attribute_read_t func, void *user_data)
 {
 	uint8_t *value;
@@ -1451,7 +1451,7 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 
 		queue_push_tail(attrib->pending_reads, p);
 
-		attrib->read_func(attrib, p->id, offset, opcode, bdaddr,
+		attrib->read_func(attrib, p->id, offset, opcode, att,
 							attrib->user_data);
 		return true;
 	}
@@ -1522,7 +1522,7 @@ static bool write_timeout(void *user_data)
 
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					gatt_db_attribute_write_t func,
 					void *user_data)
 {
@@ -1546,7 +1546,7 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 		queue_push_tail(attrib->pending_writes, p);
 
 		attrib->write_func(attrib, p->id, offset, value, len, opcode,
-						bdaddr, attrib->user_data);
+							att, attrib->user_data);
 		return true;
 	}
 
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 37df4d5..75f0668 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -50,13 +50,13 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 
 typedef void (*gatt_db_read_t) (struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data);
 
 typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data);
 
 struct gatt_db_attribute *
@@ -196,7 +196,7 @@ typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
 						size_t length, void *user_data);
 
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
-				uint8_t opcode, bdaddr_t *bdaddr,
+				uint8_t opcode, struct bt_att *att,
 				gatt_db_attribute_read_t func, void *user_data);
 
 bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
@@ -208,7 +208,7 @@ typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
 
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					gatt_db_attribute_write_t func,
 					void *user_data);
 
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 8f7b5cd..1415b27 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -24,8 +24,9 @@
 #include <sys/uio.h>
 #include <errno.h>
 
-#include "src/shared/att.h"
 #include "lib/uuid.h"
+#include "lib/bluetooth.h"
+#include "src/shared/att.h"
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
@@ -168,8 +169,9 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
 }
 
 static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
-						uint16_t mtu,
-						uint8_t *pdu, uint16_t *len)
+						struct bt_att *att,
+						uint16_t mtu, uint8_t *pdu,
+						uint16_t *len)
 {
 	int iter = 0;
 	uint16_t start_handle, end_handle;
@@ -190,7 +192,7 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 		 */
 		if (!gatt_db_attribute_read(attrib, 0,
 						BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-						NULL, attribute_read_cb,
+						att, attribute_read_cb,
 						&value) || !value.iov_len)
 			return false;
 
@@ -291,8 +293,8 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	if (!encode_read_by_grp_type_rsp(server->db, q, mtu, rsp_pdu,
-								&rsp_len)) {
+	if (!encode_read_by_grp_type_rsp(server->db, q, server->att, mtu,
+							rsp_pdu, &rsp_len)) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
 		goto error;
 	}
@@ -406,8 +408,8 @@ static void process_read_by_type(struct async_read_op *op)
 		goto error;
 	}
 
-	if (gatt_db_attribute_read(attr, 0, op->opcode, NULL,
-				read_by_type_read_complete_cb, op))
+	if (gatt_db_attribute_read(attr, 0, op->opcode, server->att,
+					read_by_type_read_complete_cb, op))
 		return;
 
 	ecode = BT_ATT_ERROR_UNLIKELY;
@@ -813,7 +815,8 @@ static void write_cb(uint8_t opcode, const void *pdu,
 	server->pending_write_op = op;
 
 	if (gatt_db_attribute_write(attr, 0, pdu + 2, length - 2, opcode,
-						NULL, write_complete_cb, op))
+							server->att,
+							write_complete_cb, op))
 		return;
 
 	if (op)
@@ -925,7 +928,7 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 	op->server = server;
 	server->pending_read_op = op;
 
-	if (gatt_db_attribute_read(attr, offset, opcode, NULL,
+	if (gatt_db_attribute_read(attr, offset, opcode, server->att,
 							read_complete_cb, op))
 		return;
 
@@ -999,7 +1002,6 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct read_multiple_resp_data *data = user_data;
 	struct gatt_db_attribute *next_attr;
 	uint32_t perm;
-
 	uint16_t handle = gatt_db_attribute_get_handle(attr);
 
 	if (err != 0) {
@@ -1051,7 +1053,8 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 		return;
 	}
 
-	if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ, NULL,
+	if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ,
+					data->server->att,
 					read_multiple_complete_cb, data)) {
 		bt_att_send_error_rsp(data->server->att,
 						BT_ATT_OP_READ_MULT_REQ,
@@ -1107,7 +1110,7 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	if (gatt_db_attribute_read(attr, 0, opcode, NULL,
+	if (gatt_db_attribute_read(attr, 0, opcode, server->att,
 					read_multiple_complete_cb, &data))
 		return;
 
@@ -1234,7 +1237,8 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 
 	status = gatt_db_attribute_write(attr, next->offset,
 						next->value, next->length,
-						BT_ATT_OP_EXEC_WRITE_REQ, NULL,
+						BT_ATT_OP_EXEC_WRITE_REQ,
+						server->att,
 						exec_write_complete_cb, server);
 
 	prep_write_data_destroy(next);
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index d27cf10..868fe32 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -125,7 +125,7 @@ static void gatt_debug_cb(const char *str, void *user_data)
 
 static void gap_device_name_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct server *server = user_data;
@@ -152,7 +152,7 @@ done:
 static void gap_device_name_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct server *server = user_data;
@@ -196,7 +196,7 @@ done:
 
 static void gap_device_name_ext_prop_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	uint8_t value[2];
@@ -211,7 +211,7 @@ static void gap_device_name_ext_prop_read_cb(struct gatt_db_attribute *attrib,
 
 static void gatt_service_changed_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	PRLOG("Service Changed Read called\n");
@@ -221,7 +221,7 @@ static void gatt_service_changed_cb(struct gatt_db_attribute *attrib,
 
 static void gatt_svc_chngd_ccc_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct server *server = user_data;
@@ -238,7 +238,7 @@ static void gatt_svc_chngd_ccc_read_cb(struct gatt_db_attribute *attrib,
 static void gatt_svc_chngd_ccc_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct server *server = user_data;
@@ -272,7 +272,7 @@ done:
 
 static void hr_msrmt_ccc_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct server *server = user_data;
@@ -326,7 +326,7 @@ static void update_hr_msrmt_simulation(struct server *server)
 static void hr_msrmt_ccc_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct server *server = user_data;
@@ -366,7 +366,7 @@ done:
 static void hr_control_point_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct server *server = user_data;
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6c98cfa..fb0ddbc 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -36,6 +36,7 @@
 #include <glib.h>
 
 #include "lib/uuid.h"
+#include "lib/bluetooth.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-helpers.h"
@@ -762,8 +763,8 @@ static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
 
 	g_assert(attrib != NULL);
 
-	gatt_db_attribute_write(attrib, 0, value, len, 0x00, NULL, att_write_cb,
-									NULL);
+	gatt_db_attribute_write(attrib, 0, value, len, 0x00, NULL,
+							att_write_cb, NULL);
 
 	return attrib;
 }
-- 
2.2.0.rc0.207.ga3a616c

