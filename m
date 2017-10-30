Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Add implementation of link option
Date: Mon, 30 Oct 2017 14:59:25 +0200
Message-Id: <20171030125925.17784-2-luiz.dentz@gmail.com>
In-Reply-To: <20171030125925.17784-1-luiz.dentz@gmail.com>
References: <20171030125925.17784-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This includes the link type into the options passed to ReadValue and
WriteValue, with this the implementation can pass tests such as
TP/GAR/CL/BI-34-I which requires specific errors to be reported
depending on the bearer.
---
 src/gatt-database.c | 53 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index a1e8ff346..1d262ccd4 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -144,6 +144,7 @@ struct pending_op {
 	struct btd_device *device;
 	unsigned int id;
 	uint16_t offset;
+	uint8_t link_type;
 	struct gatt_db_attribute *attrib;
 	struct queue *owner_queue;
 	struct iovec data;
@@ -1676,7 +1677,8 @@ static void pending_op_free(void *data)
 static struct pending_op *pending_read_new(struct btd_device *device,
 					struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
-					unsigned int id, uint16_t offset)
+					unsigned int id, uint16_t offset,
+					uint8_t link_type)
 {
 	struct pending_op *op;
 
@@ -1687,6 +1689,7 @@ static struct pending_op *pending_read_new(struct btd_device *device,
 	op->attrib = attrib;
 	op->id = id;
 	op->offset = offset;
+	op->link_type = link_type;
 	queue_push_tail(owner_queue, op);
 
 	return op;
@@ -1696,11 +1699,26 @@ static void append_options(DBusMessageIter *iter, void *user_data)
 {
 	struct pending_op *op = user_data;
 	const char *path = device_get_path(op->device);
+	const char *link;
+
+	switch (op->link_type) {
+	case BT_ATT_LINK_BREDR:
+		link = "BR/EDR";
+		break;
+	case BT_ATT_LINK_LE:
+		link = "LE";
+		break;
+	default:
+		link = NULL;
+		break;
+	}
 
 	dict_append_entry(iter, "device", DBUS_TYPE_OBJECT_PATH, &path);
 	if (op->offset)
 		dict_append_entry(iter, "offset", DBUS_TYPE_UINT16,
 							&op->offset);
+	if (link)
+		dict_append_entry(iter, "link", DBUS_TYPE_STRING, &link);
 }
 
 static void read_setup_cb(DBusMessageIter *iter, void *user_data)
@@ -1725,11 +1743,13 @@ static struct pending_op *send_read(struct btd_device *device,
 					GDBusProxy *proxy,
 					struct queue *owner_queue,
 					unsigned int id,
-					uint16_t offset)
+					uint16_t offset,
+					uint8_t link_type)
 {
 	struct pending_op *op;
 
-	op = pending_read_new(device, owner_queue, attrib, id, offset);
+	op = pending_read_new(device, owner_queue, attrib, id, offset,
+							link_type);
 
 	if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup_cb,
 				read_reply_cb, op, pending_op_free) == TRUE)
@@ -1809,7 +1829,7 @@ static struct pending_op *pending_write_new(struct btd_device *device,
 					unsigned int id,
 					const uint8_t *value,
 					size_t len,
-					uint16_t offset)
+					uint16_t offset, uint8_t link_type)
 {
 	struct pending_op *op;
 
@@ -1823,6 +1843,7 @@ static struct pending_op *pending_write_new(struct btd_device *device,
 	op->attrib = attrib;
 	op->id = id;
 	op->offset = offset;
+	op->link_type = link_type;
 	queue_push_tail(owner_queue, op);
 
 	return op;
@@ -1834,12 +1855,12 @@ static struct pending_op *send_write(struct btd_device *device,
 					struct queue *owner_queue,
 					unsigned int id,
 					const uint8_t *value, size_t len,
-					uint16_t offset)
+					uint16_t offset, uint8_t link_type)
 {
 	struct pending_op *op;
 
 	op = pending_write_new(device, owner_queue, attrib, id, value, len,
-								offset);
+							offset, link_type);
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
 					owner_queue ? write_reply_cb : NULL,
@@ -1951,7 +1972,8 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
 retry:
 	send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
-				op->data.iov_base, op->data.iov_len, 0);
+				op->data.iov_base, op->data.iov_len, 0,
+				op->link_type);
 }
 
 static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
@@ -1983,11 +2005,13 @@ static struct pending_op *acquire_write(struct external_chrc *chrc,
 					struct btd_device *device,
 					struct gatt_db_attribute *attrib,
 					unsigned int id,
-					const uint8_t *value, size_t len)
+					const uint8_t *value, size_t len,
+					uint8_t link_type)
 {
 	struct pending_op *op;
 
-	op = pending_write_new(device, NULL, attrib, id, value, len, 0);
+	op = pending_write_new(device, NULL, attrib, id, value, len, 0,
+							link_type);
 
 	if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
 					acquire_write_setup,
@@ -2280,7 +2304,7 @@ static void desc_read_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (send_read(device, attrib, desc->proxy, desc->pending_reads, id,
-								offset))
+					offset, bt_att_get_link_type(att)))
 		return;
 
 fail:
@@ -2309,7 +2333,7 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (send_write(device, attrib, desc->proxy, desc->pending_writes, id,
-							value, len, offset))
+				value, len, offset, bt_att_get_link_type(att)))
 		return;
 
 fail:
@@ -2360,7 +2384,7 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (send_read(device, attrib, chrc->proxy, chrc->pending_reads, id,
-								offset))
+					offset, bt_att_get_link_type(att)))
 		return;
 
 fail:
@@ -2401,7 +2425,8 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (g_dbus_proxy_get_property(chrc->proxy, "WriteAcquired", &iter)) {
-		if (acquire_write(chrc, device, attrib, id, value, len))
+		if (acquire_write(chrc, device, attrib, id, value, len,
+						bt_att_get_link_type(att)))
 			return;
 	}
 
@@ -2411,7 +2436,7 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		queue = NULL;
 
 	if (send_write(device, attrib, chrc->proxy, queue, id, value, len,
-								offset))
+					offset, bt_att_get_link_type(att)))
 		return;
 
 fail:
-- 
2.13.6

