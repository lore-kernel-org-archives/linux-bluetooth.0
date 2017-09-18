Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/10] gatt: Implement AcquireWrite for server
Date: Mon, 18 Sep 2017 15:39:57 +0300
Message-Id: <20170918124001.2617-7-luiz.dentz@gmail.com>
In-Reply-To: <20170918124001.2617-1-luiz.dentz@gmail.com>
References: <20170918124001.2617-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables IO via file descriptors using AcquireWrite if server
implements it.
---
 src/gatt-database.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 61eed71d6..6a883c96d 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -33,6 +33,7 @@
 #include "gdbus/gdbus.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/io.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
@@ -117,6 +118,7 @@ struct external_chrc {
 	uint8_t props;
 	uint8_t ext_props;
 	uint32_t perm;
+	struct io *write_io;
 	struct gatt_db_attribute *attrib;
 	struct gatt_db_attribute *ccc;
 	struct queue *pending_reads;
@@ -325,6 +327,8 @@ static void chrc_free(void *data)
 {
 	struct external_chrc *chrc = data;
 
+	io_destroy(chrc->write_io);
+
 	queue_destroy(chrc->pending_reads, cancel_pending_read);
 	queue_destroy(chrc->pending_writes, cancel_pending_write);
 
@@ -1789,6 +1793,128 @@ static struct pending_op *send_write(struct btd_device *device,
 	return NULL;
 }
 
+static bool pipe_hup(struct io *io, void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+
+	DBG("%p closed\n", io);
+
+	if (io == chrc->write_io)
+		chrc->write_io = NULL;
+
+	io_destroy(io);
+
+	return false;
+}
+
+static struct io *pipe_io_new(int fd, void *user_data)
+{
+	struct io *io;
+
+	io = io_new(fd);
+
+	io_set_close_on_destroy(io, true);
+
+	io_set_disconnect_handler(io, pipe_hup, user_data, NULL);
+
+	return io;
+}
+
+static int pipe_io_send(struct io *io, const void *data, size_t len)
+{
+	struct iovec iov;
+
+	iov.iov_base = (void *) data;
+	iov.iov_len = len;
+
+	return io_send(io, &iov, 1);
+}
+
+static void acquire_write_reply(DBusMessage *message, void *user_data)
+{
+	struct pending_op *op = user_data;
+	struct external_chrc *chrc;
+	DBusError err;
+	int fd;
+	uint16_t mtu;
+
+	chrc = gatt_db_attribute_get_user_data(op->attrib);
+	dbus_error_init(&err);
+
+	if (dbus_set_error_from_message(&err, message) == TRUE) {
+		error("Failed to acquire write: %s\n", err.name);
+		dbus_error_free(&err);
+		goto retry;
+	}
+
+	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_UINT16, &mtu,
+					DBUS_TYPE_INVALID) == false)) {
+		error("Invalid AcquireWrite response\n");
+		goto retry;
+	}
+
+	DBG("AcquireWrite success: fd %d MTU %u\n", fd, mtu);
+
+	chrc->write_io = pipe_io_new(fd, chrc);
+
+	if (pipe_io_send(chrc->write_io, op->data.iov_base,
+				op->data.iov_len) < 0)
+		goto retry;
+
+	return;
+
+retry:
+	send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
+				op->data.iov_base, op->data.iov_len, 0);
+}
+
+static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct pending_op *op = user_data;
+	DBusMessageIter dict;
+	struct bt_gatt_server *server;
+	uint16_t mtu;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	append_options(&dict, op);
+
+	server = btd_device_get_gatt_server(op->device);
+
+	mtu = bt_gatt_server_get_mtu(server);
+
+	dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &mtu);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static struct pending_op *acquire_write(struct external_chrc *chrc,
+					struct btd_device *device,
+					struct gatt_db_attribute *attrib,
+					unsigned int id,
+					const uint8_t *value, size_t len)
+{
+	struct pending_op *op;
+
+	op = pending_write_new(device, NULL, attrib, id, value, len, 0);
+
+	if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
+					acquire_write_setup,
+					acquire_write_reply,
+					op, pending_op_free))
+		return op;
+
+	pending_op_free(op);
+
+	return NULL;
+}
+
 static uint8_t ccc_write_cb(uint16_t value, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
@@ -2090,6 +2216,7 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	struct external_chrc *chrc = user_data;
 	struct btd_device *device;
 	struct queue *queue;
+	DBusMessageIter iter;
 
 	if (chrc->attrib != attrib) {
 		error("Write callback called with incorrect attribute");
@@ -2102,9 +2229,24 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		goto fail;
 	}
 
+	if (chrc->write_io) {
+		if (pipe_io_send(chrc->write_io, value, len) < 0) {
+			error("Unable to write: %s", strerror(errno));
+			goto fail;
+		}
+
+		gatt_db_attribute_write_result(attrib, id, 0);
+		return;
+	}
+
 	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
 		queue = chrc->pending_writes;
-	else
+	else if (g_dbus_proxy_get_property(chrc->proxy, "WriteAcquired",
+								&iter)) {
+		if (acquire_write(chrc, device, attrib, id, value, len))
+			return;
+		queue = NULL;
+	} else
 		queue = NULL;
 
 	if (send_write(device, attrib, chrc->proxy, queue, id, value, len,
-- 
2.13.5

