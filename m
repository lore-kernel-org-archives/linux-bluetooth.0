Return-Path: <cyrus@holtmann.org>
Message-ID: <5506F29B.20902@ubnt.com>
Date: Mon, 16 Mar 2015 17:11:23 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] Honor offset when reading external chrc.
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Honor offset when reading external characteristics via D-Bus and respond with properly chunked data.
---
 src/gatt-database.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index e07c70f..3ae2f62 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -119,6 +119,7 @@ struct pending_op {
 	struct gatt_db_attribute *attrib;
 	struct queue *owner_queue;
 	struct iovec data;
+	uint16_t offset;
 };
 
 struct device_state {
@@ -1446,6 +1447,19 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
 		goto done;
 	}
 
+	if (op->offset > len) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		value = NULL;
+		len = 0;
+		goto done;
+	} else if (op->offset == len) {
+		value = NULL;
+		len = 0;
+	} else {
+		len -= op->offset;
+		value = &value[op->offset];
+	}
+
 	/* Truncate the value if it's too large */
 	len = MIN(BT_ATT_MAX_VALUE_LEN, len);
 	value = len ? value : NULL;
@@ -1466,7 +1480,7 @@ static void pending_op_free(void *data)
 
 static struct pending_op *pending_read_new(struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
-					unsigned int id)
+					unsigned int id, uint16_t offset)
 {
 	struct pending_op *op;
 
@@ -1477,6 +1491,7 @@ static struct pending_op *pending_read_new(struct queue *owner_queue,
 	op->owner_queue = owner_queue;
 	op->attrib = attrib;
 	op->id = id;
+	op->offset = offset;
 	queue_push_tail(owner_queue, op);
 
 	return op;
@@ -1484,12 +1499,12 @@ static struct pending_op *pending_read_new(struct queue *owner_queue,
 
 static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
 						struct queue *owner_queue,
-						unsigned int id)
+						unsigned int id, uint16_t offset)
 {
 	struct pending_op *op;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
-	op = pending_read_new(owner_queue, attrib, id);
+	op = pending_read_new(owner_queue, attrib, id, offset);
 	if (!op) {
 		error("Failed to allocate memory for pending read call");
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
@@ -1785,7 +1800,7 @@ static void desc_read_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	send_read(attrib, desc->proxy, desc->pending_reads, id);
+	send_read(attrib, desc->proxy, desc->pending_reads, id, offset);
 }
 
 static void desc_write_cb(struct gatt_db_attribute *attrib,
@@ -1843,7 +1858,7 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	send_read(attrib, chrc->proxy, chrc->pending_reads, id);
+	send_read(attrib, chrc->proxy, chrc->pending_reads, id, offset);
 }
 
 static void chrc_write_cb(struct gatt_db_attribute *attrib,
-- 
1.9.1

