Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 02/13] shared/gatt: Add bdaddr_type param to gatt_db APIs
Date: Tue, 10 Feb 2015 20:54:15 -0800
Message-Id: <1423630466-26327-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1423630466-26327-1-git-send-email-armansito@chromium.org>
References: <1423630466-26327-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added a bdaddr_type parameter to gatt_db's read/write functions and
callbacks, in addition to the bdaddr_t* parameter.
---
 android/gatt.c           | 32 +++++++++++++------------
 src/gatt-client.c        | 20 +++++++++-------
 src/shared/gatt-db.c     |  6 +++--
 src/shared/gatt-db.h     |  4 ++++
 src/shared/gatt-server.c | 62 +++++++++++++++++++++++++++++++++++++-----------
 tools/btgatt-server.c    | 22 ++++++++---------
 unit/test-gatt.c         |  7 +++---
 7 files changed, 99 insertions(+), 54 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a36922c..fd98f84 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4889,7 +4889,8 @@ static void read_requested_attributes(void *data, void *user_data)
 
 	gatt_db_attribute_read(attrib, resp_data->offset, process_data->opcode,
 						&process_data->device->bdaddr,
-						attribute_read_cb, resp_data);
+						0, attribute_read_cb,
+						resp_data);
 }
 
 static void process_dev_pending_requests(struct gatt_device *device,
@@ -4937,7 +4938,7 @@ static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
 
 static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 			uint16_t offset, uint8_t opcode, bdaddr_t *bdaddr,
-			void *user_data)
+			uint8_t bdaddr_type, void *user_data)
 {
 	struct pending_trans_data *transaction;
 	struct hal_ev_gatt_server_request_read ev;
@@ -4985,7 +4986,8 @@ failed:
 
 static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
 			uint16_t offset, const uint8_t *value, size_t len,
-			uint8_t opcode, bdaddr_t *bdaddr, void *user_data)
+			uint8_t opcode, bdaddr_t *bdaddr, uint8_t bdaddr_type,
+			void *user_data)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_server_request_write *ev = (void *) buf;
@@ -6401,7 +6403,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
 
-	gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr,
+	gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr, 0,
 							write_confirm, NULL);
 }
 
@@ -6474,7 +6476,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		/* Signature OK, proceed with write */
 		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
 		gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
-					&dev->bdaddr, write_confirm, NULL);
+					&dev->bdaddr, 0, write_confirm, NULL);
 	}
 }
 
@@ -6534,7 +6536,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
-					&dev->bdaddr, attribute_write_cb,
+					&dev->bdaddr, 0, attribute_write_cb,
 					data)) {
 		queue_remove(dev->pending_requests, data);
 		free(data);
@@ -6594,7 +6596,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	data->length = vlen;
 
 	if (!gatt_db_attribute_write(attrib, offset, value, vlen, cmd[0],
-					&dev->bdaddr, attribute_write_cb,
+					&dev->bdaddr, 0, attribute_write_cb,
 					data)) {
 		queue_remove(dev->pending_requests, data);
 		g_free(data->value);
@@ -6817,7 +6819,7 @@ static struct gap_srvc_handles gap_srvc_data;
 static void device_name_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	const char *name = bt_get_adapter_name();
 
@@ -6857,7 +6859,7 @@ static void register_gap_service(void)
 		value = cpu_to_le16(APPEARANCE_GENERIC_PHONE);
 		gatt_db_attribute_write(gap_srvc_data.appear, 0,
 						(void *) &value, sizeof(value),
-						ATT_OP_WRITE_REQ, NULL,
+						ATT_OP_WRITE_REQ, NULL, 0,
 						write_confirm, NULL);
 	}
 
@@ -6875,7 +6877,7 @@ static void register_gap_service(void)
 		value = PERIPHERAL_PRIVACY_DISABLE;
 		gatt_db_attribute_write(gap_srvc_data.priv, 0,
 						&value, sizeof(value),
-						ATT_OP_WRITE_REQ, NULL,
+						ATT_OP_WRITE_REQ, NULL, 0,
 						write_confirm, NULL);
 	}
 
@@ -6893,7 +6895,7 @@ static void register_gap_service(void)
 static void device_info_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	char *buf = user_data;
 
@@ -6903,7 +6905,7 @@ static void device_info_read_cb(struct gatt_db_attribute *attrib,
 static void device_info_read_system_id_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	uint8_t pdu[8];
 
@@ -6915,7 +6917,7 @@ static void device_info_read_system_id_cb(struct gatt_db_attribute *attrib,
 static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	uint8_t pdu[7];
 
@@ -7029,7 +7031,7 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct gatt_device *dev;
 
@@ -7061,7 +7063,7 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 static void gatt_srvc_change_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct gatt_device *dev;
 	uint8_t pdu[2];
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 9811bd8..ed6bd86 100644
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
@@ -160,7 +161,7 @@ static gboolean descriptor_get_value(const GDBusPropertyTable *property,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
 
-	gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_cb, &array);
+	gatt_db_attribute_read(desc->attr, 0, 0, NULL, 0, read_cb, &array);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -187,7 +188,7 @@ static gboolean descriptor_value_exists(const GDBusPropertyTable *property,
 	struct descriptor *desc = data;
 	gboolean ret;
 
-	gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_check_cb, &ret);
+	gatt_db_attribute_read(desc->attr, 0, 0, NULL, 0, read_check_cb, &ret);
 
 	return ret;
 }
@@ -355,7 +356,7 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 		gatt_db_attribute_reset(desc->attr);
 
 	gatt_db_attribute_write(desc->attr, op->offset, value, length, 0, NULL,
-						write_descriptor_cb, desc);
+						0, write_descriptor_cb, desc);
 
 	/*
 	 * If the value length is exactly MTU-1, then we may not have read the
@@ -378,7 +379,7 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 	desc->read_id = 0;
 
 	/* Read the stored data from db */
-	gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op);
+	gatt_db_attribute_read(desc->attr, 0, 0, NULL, 0, read_op_cb, op);
 }
 
 static DBusMessage *descriptor_read_value(DBusConnection *conn,
@@ -680,7 +681,7 @@ static gboolean characteristic_get_value(const GDBusPropertyTable *property,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
 
-	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_cb, &array);
+	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, 0, read_cb, &array);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -693,7 +694,7 @@ static gboolean characteristic_value_exists(const GDBusPropertyTable *property,
 	struct characteristic *chrc = data;
 	gboolean ret;
 
-	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_check_cb, &ret);
+	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, 0, read_check_cb, &ret);
 
 	return TRUE;
 }
@@ -789,7 +790,8 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 		gatt_db_attribute_reset(chrc->attr);
 
 	gatt_db_attribute_write(chrc->attr, op->offset, value, length, 0, NULL,
-						write_characteristic_cb, chrc);
+						0, write_characteristic_cb,
+						chrc);
 
 	/*
 	 * If the value length is exactly MTU-1, then we may not have read the
@@ -812,7 +814,7 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	chrc->read_id = 0;
 
 	/* Read the stored data from db */
-	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op);
+	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, 0, read_op_cb, op);
 }
 
 static DBusMessage *characteristic_read_value(DBusConnection *conn,
@@ -1065,7 +1067,7 @@ static void notify_cb(uint16_t value_handle, const uint8_t *value,
 	 * applications.
 	 */
 	gatt_db_attribute_reset(chrc->attr);
-	gatt_db_attribute_write(chrc->attr, 0, value, length, 0, NULL,
+	gatt_db_attribute_write(chrc->attr, 0, value, length, 0, NULL, 0,
 						write_characteristic_cb, chrc);
 }
 
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f72d58e..cd28689 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1428,6 +1428,7 @@ static bool read_timeout(void *user_data)
 
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, bdaddr_t *bdaddr,
+				uint8_t bdaddr_type,
 				gatt_db_attribute_read_t func, void *user_data)
 {
 	uint8_t *value;
@@ -1452,7 +1453,7 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 		queue_push_tail(attrib->pending_reads, p);
 
 		attrib->read_func(attrib, p->id, offset, opcode, bdaddr,
-							attrib->user_data);
+						bdaddr_type, attrib->user_data);
 		return true;
 	}
 
@@ -1523,6 +1524,7 @@ static bool write_timeout(void *user_data)
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
+                                        uint8_t bdaddr_type,
 					gatt_db_attribute_write_t func,
 					void *user_data)
 {
@@ -1546,7 +1548,7 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 		queue_push_tail(attrib->pending_writes, p);
 
 		attrib->write_func(attrib, p->id, offset, value, len, opcode,
-						bdaddr, attrib->user_data);
+					bdaddr, bdaddr_type, attrib->user_data);
 		return true;
 	}
 
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 37df4d5..b5f190c 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -51,12 +51,14 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 typedef void (*gatt_db_read_t) (struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
 					void *user_data);
 
 typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
 					void *user_data);
 
 struct gatt_db_attribute *
@@ -197,6 +199,7 @@ typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
 
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, bdaddr_t *bdaddr,
+				uint8_t bdaddr_type,
 				gatt_db_attribute_read_t func, void *user_data);
 
 bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
@@ -209,6 +212,7 @@ typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
 					gatt_db_attribute_write_t func,
 					void *user_data);
 
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 8f7b5cd..34f82d6 100644
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
@@ -168,8 +169,10 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
 }
 
 static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
-						uint16_t mtu,
-						uint8_t *pdu, uint16_t *len)
+						bdaddr_t *bdaddr,
+						uint8_t bdaddr_type,
+						uint16_t mtu, uint8_t *pdu,
+						uint16_t *len)
 {
 	int iter = 0;
 	uint16_t start_handle, end_handle;
@@ -190,7 +193,8 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 		 */
 		if (!gatt_db_attribute_read(attrib, 0,
 						BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-						NULL, attribute_read_cb,
+						bdaddr, bdaddr_type,
+						attribute_read_cb,
 						&value) || !value.iov_len)
 			return false;
 
@@ -239,6 +243,8 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	uint8_t ecode = 0;
 	uint16_t ehandle = 0;
 	struct queue *q = NULL;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	if (length != 6 && length != 20) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -291,8 +297,10 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	if (!encode_read_by_grp_type_rsp(server->db, q, mtu, rsp_pdu,
-								&rsp_len)) {
+	bt_att_get_bdaddr(server->att, &bdaddr, &bdaddr_type);
+
+	if (!encode_read_by_grp_type_rsp(server->db, q, &bdaddr, bdaddr_type,
+						mtu, rsp_pdu, &rsp_len)) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
 		goto error;
 	}
@@ -381,6 +389,8 @@ static void process_read_by_type(struct async_read_op *op)
 	uint8_t ecode;
 	struct gatt_db_attribute *attr;
 	uint32_t perm;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	attr = queue_pop_head(op->db_data);
 
@@ -406,8 +416,10 @@ static void process_read_by_type(struct async_read_op *op)
 		goto error;
 	}
 
-	if (gatt_db_attribute_read(attr, 0, op->opcode, NULL,
-				read_by_type_read_complete_cb, op))
+	bt_att_get_bdaddr(server->att, &bdaddr, &bdaddr_type);
+
+	if (gatt_db_attribute_read(attr, 0, op->opcode, &bdaddr, bdaddr_type,
+					read_by_type_read_complete_cb, op))
 		return;
 
 	ecode = BT_ATT_ERROR_UNLIKELY;
@@ -772,6 +784,8 @@ static void write_cb(uint8_t opcode, const void *pdu,
 	struct async_write_op *op = NULL;
 	uint8_t ecode;
 	uint32_t perm;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	if (length < 2) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -812,8 +826,11 @@ static void write_cb(uint8_t opcode, const void *pdu,
 	op->opcode = opcode;
 	server->pending_write_op = op;
 
+	bt_att_get_bdaddr(server->att, &bdaddr, &bdaddr_type);
+
 	if (gatt_db_attribute_write(attr, 0, pdu + 2, length - 2, opcode,
-						NULL, write_complete_cb, op))
+							&bdaddr, bdaddr_type,
+							write_complete_cb, op))
 		return;
 
 	if (op)
@@ -891,6 +908,8 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 	uint8_t ecode;
 	uint32_t perm;
 	struct async_read_op *op = NULL;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	attr = gatt_db_get_attribute(server->db, handle);
 	if (!attr) {
@@ -925,7 +944,9 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 	op->server = server;
 	server->pending_read_op = op;
 
-	if (gatt_db_attribute_read(attr, offset, opcode, NULL,
+	bt_att_get_bdaddr(server->att, &bdaddr, &bdaddr_type);
+
+	if (gatt_db_attribute_read(attr, offset, opcode, &bdaddr, bdaddr_type,
 							read_complete_cb, op))
 		return;
 
@@ -999,8 +1020,9 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct read_multiple_resp_data *data = user_data;
 	struct gatt_db_attribute *next_attr;
 	uint32_t perm;
-
 	uint16_t handle = gatt_db_attribute_get_handle(attr);
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	if (err != 0) {
 		bt_att_send_error_rsp(data->server->att,
@@ -1051,7 +1073,10 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 		return;
 	}
 
-	if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ, NULL,
+	bt_att_get_bdaddr(data->server->att, &bdaddr, &bdaddr_type);
+
+	if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ,
+					&bdaddr, bdaddr_type,
 					read_multiple_complete_cb, data)) {
 		bt_att_send_error_rsp(data->server->att,
 						BT_ATT_OP_READ_MULT_REQ,
@@ -1069,6 +1094,8 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu,
 	struct read_multiple_resp_data data;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 	size_t i = 0;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	data.handles = NULL;
 	data.rsp_data = NULL;
@@ -1107,7 +1134,9 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	if (gatt_db_attribute_read(attr, 0, opcode, NULL,
+	bt_att_get_bdaddr(server->att, &bdaddr, &bdaddr_type);
+
+	if (gatt_db_attribute_read(attr, 0, opcode, &bdaddr, bdaddr_type,
 					read_multiple_complete_cb, &data))
 		return;
 
@@ -1215,6 +1244,8 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 	struct prep_write_data *next = NULL;
 	struct gatt_db_attribute *attr;
 	bool status;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	if (err)
 		goto error;
@@ -1232,9 +1263,12 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 		goto error;
 	}
 
+	bt_att_get_bdaddr(server->att, &bdaddr, &bdaddr_type);
+
 	status = gatt_db_attribute_write(attr, next->offset,
 						next->value, next->length,
-						BT_ATT_OP_EXEC_WRITE_REQ, NULL,
+						BT_ATT_OP_EXEC_WRITE_REQ,
+						&bdaddr, bdaddr_type,
 						exec_write_complete_cb, server);
 
 	prep_write_data_destroy(next);
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index d27cf10..4a78b44 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -126,7 +126,7 @@ static void gatt_debug_cb(const char *str, void *user_data)
 static void gap_device_name_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct server *server = user_data;
 	uint8_t error = 0;
@@ -153,7 +153,7 @@ static void gap_device_name_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct server *server = user_data;
 	uint8_t error = 0;
@@ -197,7 +197,7 @@ done:
 static void gap_device_name_ext_prop_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	uint8_t value[2];
 
@@ -212,7 +212,7 @@ static void gap_device_name_ext_prop_read_cb(struct gatt_db_attribute *attrib,
 static void gatt_service_changed_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	PRLOG("Service Changed Read called\n");
 
@@ -222,7 +222,7 @@ static void gatt_service_changed_cb(struct gatt_db_attribute *attrib,
 static void gatt_svc_chngd_ccc_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct server *server = user_data;
 	uint8_t value[2];
@@ -239,7 +239,7 @@ static void gatt_svc_chngd_ccc_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct server *server = user_data;
 	uint8_t ecode = 0;
@@ -273,7 +273,7 @@ done:
 static void hr_msrmt_ccc_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct server *server = user_data;
 	uint8_t value[2];
@@ -327,7 +327,7 @@ static void hr_msrmt_ccc_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct server *server = user_data;
 	uint8_t ecode = 0;
@@ -367,7 +367,7 @@ static void hr_control_point_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
-					void *user_data)
+					uint8_t bdaddr_type, void *user_data)
 {
 	struct server *server = user_data;
 	uint8_t ecode = 0;
@@ -446,7 +446,7 @@ static void populate_gap_service(struct server *server)
 	gatt_db_attribute_write(tmp, 0, (void *) &appearance,
 							sizeof(appearance),
 							BT_ATT_OP_WRITE_REQ,
-							NULL, confirm_write,
+							NULL, 0, confirm_write,
 							NULL);
 
 	gatt_db_service_set_active(service, true);
@@ -514,7 +514,7 @@ static void populate_hr_service(struct server *server)
 						NULL, NULL, server);
 	gatt_db_attribute_write(body, 0, (void *) &body_loc, sizeof(body_loc),
 							BT_ATT_OP_WRITE_REQ,
-							NULL, confirm_write,
+							NULL, 0, confirm_write,
 							NULL);
 
 	/* HR Control Point Characteristic */
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index cd90d83..4755bcd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -36,6 +36,7 @@
 #include <glib.h>
 
 #include "lib/uuid.h"
+#include "lib/bluetooth.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-helpers.h"
@@ -691,8 +692,8 @@ static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
 
 	g_assert(attrib != NULL);
 
-	gatt_db_attribute_write(attrib, 0, value, len, 0x00, NULL, att_write_cb,
-									NULL);
+	gatt_db_attribute_write(attrib, 0, value, len, 0x00, NULL, 0,
+							att_write_cb, NULL);
 
 	return attrib;
 }
@@ -707,7 +708,7 @@ add_desc_with_value(struct gatt_db_attribute *att, bt_uuid_t *uuid,
 	desc_att = gatt_db_service_add_descriptor(att, uuid, att_perms, NULL,
 								NULL, NULL);
 
-	gatt_db_attribute_write(desc_att, 0, value, len, 0x00, NULL,
+	gatt_db_attribute_write(desc_att, 0, value, len, 0x00, NULL, 0,
 							att_write_cb, NULL);
 
 	return desc_att;
-- 
2.2.0.rc0.207.ga3a616c

