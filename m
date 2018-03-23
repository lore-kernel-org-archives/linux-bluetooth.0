Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] gatt: Send device and link options with AcquireNotify
Date: Fri, 23 Mar 2018 15:37:02 +0200
Message-Id: <20180323133703.12499-2-luiz.dentz@gmail.com>
In-Reply-To: <20180323133703.12499-1-luiz.dentz@gmail.com>
References: <20180323133703.12499-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the device and lin to AcquireNotify as mentioned in the
documentation.
---
 src/gatt-database.c | 175 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 111 insertions(+), 64 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index a22fc3b85..4ab4ec3c7 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -174,8 +174,7 @@ struct device_state {
 	struct notify *pending;
 };
 
-typedef uint8_t (*btd_gatt_database_ccc_write_t) (struct bt_att *att,
-							uint16_t value,
+typedef uint8_t (*btd_gatt_database_ccc_write_t) (struct pending_op *op,
 							void *user_data);
 typedef void (*btd_gatt_database_destroy_t) (void *data);
 
@@ -308,7 +307,7 @@ static void clear_ccc_state(void *data, void *user_data)
 		return;
 
 	if (ccc_cb->callback)
-		ccc_cb->callback(NULL, 0, ccc_cb->user_data);
+		ccc_cb->callback(NULL, ccc_cb->user_data);
 }
 
 static void att_disconnected(int err, void *user_data)
@@ -861,6 +860,71 @@ done:
 	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
 }
 
+static struct pending_op *pending_ccc_new(struct btd_device *device,
+					struct gatt_db_attribute *attrib,
+					unsigned int id,
+					uint16_t value,
+					uint8_t link_type)
+{
+	struct pending_op *op;
+
+	op = new0(struct pending_op, 1);
+
+	op->data.iov_base = UINT_TO_PTR(value);
+	op->data.iov_len = sizeof(value);
+
+	op->device = device;
+	op->attrib = attrib;
+	op->id = id;
+	op->link_type = link_type;
+
+	return op;
+}
+
+static struct btd_device *att_get_device(struct bt_att *att)
+{
+	GIOChannel *io = NULL;
+	GError *gerr = NULL;
+	bdaddr_t src, dst;
+	uint8_t dst_type;
+	struct btd_adapter *adapter;
+
+	io = g_io_channel_unix_new(bt_att_get_fd(att));
+	if (!io)
+		return NULL;
+
+	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_DEST_BDADDR, &dst,
+					BT_IO_OPT_DEST_TYPE, &dst_type,
+					BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	g_io_channel_unref(io);
+
+	adapter = adapter_find(&src);
+	if (!adapter) {
+		error("Unable to find adapter object");
+		return NULL;
+	}
+
+	return btd_adapter_find_device(adapter, &dst, dst_type);
+}
+
+static void pending_op_free(void *data)
+{
+	struct pending_op *op = data;
+
+	if (op->owner_queue)
+		queue_remove(op->owner_queue, op);
+
+	free(op);
+}
+
 static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
@@ -904,9 +968,23 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 	if (ccc->value[0] == value[0] && ccc->value[1] == value[1])
 		goto done;
 
-	if (ccc_cb->callback)
-		ecode = ccc_cb->callback(att, get_le16(value),
-						ccc_cb->user_data);
+	if (ccc_cb->callback) {
+		struct pending_op *op;
+		struct btd_device *device;
+
+		device = att_get_device(att);
+		if (!device) {
+			error("Unable to find device object");
+			ecode = BT_ATT_ERROR_UNLIKELY;
+			goto done;
+		}
+
+		op = pending_ccc_new(device, attrib, id, get_le16(value),
+					bt_att_get_link_type(att));
+		ecode = ccc_cb->callback(op, ccc_cb->user_data);
+		if (ecode)
+			pending_op_free(op);
+	}
 
 	if (!ecode) {
 		ccc->value[0] = value[0];
@@ -1799,16 +1877,6 @@ done:
 	gatt_db_attribute_read_result(op->attrib, op->id, ecode, value, len);
 }
 
-static void pending_op_free(void *data)
-{
-	struct pending_op *op = data;
-
-	if (op->owner_queue)
-		queue_remove(op->owner_queue, op);
-
-	free(op);
-}
-
 static struct pending_op *pending_read_new(struct btd_device *device,
 					struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
@@ -2161,7 +2229,8 @@ static struct pending_op *acquire_write(struct external_chrc *chrc,
 
 static void acquire_notify_reply(DBusMessage *message, void *user_data)
 {
-	struct external_chrc *chrc = user_data;
+	struct pending_op *op = user_data;
+	struct external_chrc *chrc = (void *) op->data.iov_base;
 	DBusError err;
 	int fd;
 	uint16_t mtu;
@@ -2199,7 +2268,9 @@ retry:
 static void acquire_notify_setup(DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
-	struct external_chrc *chrc = user_data;
+	struct pending_op *op = user_data;
+	struct bt_gatt_server *server;
+	uint16_t mtu;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -2208,30 +2279,39 @@ static void acquire_notify_setup(DBusMessageIter *iter, void *user_data)
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
 
-	dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &chrc->mtu);
+	append_options(&dict, op);
+
+	server = btd_device_get_gatt_server(op->device);
+
+	mtu = bt_gatt_server_get_mtu(server);
+
+	dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &mtu);
 
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static uint8_t ccc_write_cb(struct bt_att *att, uint16_t value, void *user_data)
+static uint8_t ccc_write_cb(struct pending_op *op, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
 	DBusMessageIter iter;
+	uint16_t value;
+
+	value = PTR_TO_UINT(op->data.iov_base);
 
 	DBG("External CCC write received with value: 0x%04x", value);
 
 	/* Notifications/indications disabled */
 	if (!value) {
 		if (!chrc->ntfy_cnt)
-			return 0;
+			goto done;
 
 		if (__sync_sub_and_fetch(&chrc->ntfy_cnt, 1))
-			return 0;
+			goto done;
 
 		if (chrc->notify_io) {
 			io_destroy(chrc->notify_io);
 			chrc->notify_io = NULL;
-			return 0;
+			goto done;
 		}
 
 		/*
@@ -2240,13 +2320,12 @@ static uint8_t ccc_write_cb(struct bt_att *att, uint16_t value, void *user_data)
 		 */
 		g_dbus_proxy_method_call(chrc->proxy, "StopNotify", NULL,
 							NULL, NULL, NULL);
-		return 0;
+		goto done;
 	}
 
-	if (chrc->ntfy_cnt == UINT_MAX) {
+	if (chrc->ntfy_cnt == UINT_MAX)
 		/* Maximum number of per-device CCC descriptors configured */
 		return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-	}
 
 	/* Don't support undefined CCC values yet */
 	if (value > 2 ||
@@ -2256,17 +2335,17 @@ static uint8_t ccc_write_cb(struct bt_att *att, uint16_t value, void *user_data)
 
 	if (chrc->notify_io) {
 		__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
-		return 0;
+		goto done;
 	}
 
-	chrc->mtu = bt_att_get_mtu(att);
-
 	/* Make use of AcquireNotify if supported */
 	if (g_dbus_proxy_get_property(chrc->proxy, "NotifyAcquired", &iter)) {
+		op->data.iov_base = (void *) chrc;
+		op->data.iov_len = sizeof(chrc);
 		if (g_dbus_proxy_method_call(chrc->proxy, "AcquireNotify",
 						acquire_notify_setup,
 						acquire_notify_reply,
-						chrc, NULL))
+						op, pending_op_free))
 			return 0;
 	}
 
@@ -2280,6 +2359,8 @@ static uint8_t ccc_write_cb(struct bt_att *att, uint16_t value, void *user_data)
 
 	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
 
+done:
+	pending_op_free(op);
 	return 0;
 }
 
@@ -2386,40 +2467,6 @@ static bool database_add_cep(struct external_service *service,
 	return true;
 }
 
-static struct btd_device *att_get_device(struct bt_att *att)
-{
-	GIOChannel *io = NULL;
-	GError *gerr = NULL;
-	bdaddr_t src, dst;
-	uint8_t dst_type;
-	struct btd_adapter *adapter;
-
-	io = g_io_channel_unix_new(bt_att_get_fd(att));
-	if (!io)
-		return NULL;
-
-	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
-					BT_IO_OPT_DEST_BDADDR, &dst,
-					BT_IO_OPT_DEST_TYPE, &dst_type,
-					BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("bt_io_get: %s", gerr->message);
-		g_error_free(gerr);
-		g_io_channel_unref(io);
-		return NULL;
-	}
-
-	g_io_channel_unref(io);
-
-	adapter = adapter_find(&src);
-	if (!adapter) {
-		error("Unable to find adapter object");
-		return NULL;
-	}
-
-	return btd_adapter_find_device(adapter, &dst, dst_type);
-}
-
 static void desc_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, struct bt_att *att,
-- 
2.14.3

