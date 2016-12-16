Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/gatt-database: Send offset if set to WriteValue
Date: Fri, 16 Dec 2016 15:18:53 +0200
Message-Id: <20161216131853.2815-2-luiz.dentz@gmail.com>
In-Reply-To: <20161216131853.2815-1-luiz.dentz@gmail.com>
References: <20161216131853.2815-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there remote is using Prepare + Execute Write commands as part of
a Write Long procedure the offset needs to be set in order for the
application to detect from where it shall write the data.
---
 src/gatt-database.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 88627ac..5979e37 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1738,7 +1738,8 @@ static struct pending_op *pending_write_new(struct btd_device *device,
 					struct gatt_db_attribute *attrib,
 					unsigned int id,
 					const uint8_t *value,
-					size_t len)
+					size_t len,
+					uint16_t offset)
 {
 	struct pending_op *op;
 
@@ -1751,6 +1752,7 @@ static struct pending_op *pending_write_new(struct btd_device *device,
 	op->owner_queue = owner_queue;
 	op->attrib = attrib;
 	op->id = id;
+	op->offset = offset;
 	queue_push_tail(owner_queue, op);
 
 	return op;
@@ -1761,11 +1763,13 @@ static struct pending_op *send_write(struct btd_device *device,
 					GDBusProxy *proxy,
 					struct queue *owner_queue,
 					unsigned int id,
-					const uint8_t *value, size_t len)
+					const uint8_t *value, size_t len,
+					uint16_t offset)
 {
 	struct pending_op *op;
 
-	op = pending_write_new(device, owner_queue, attrib, id, value, len);
+	op = pending_write_new(device, owner_queue, attrib, id, value, len,
+								offset);
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
 					owner_queue ? write_reply_cb : NULL,
@@ -2010,7 +2014,7 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (send_write(device, attrib, desc->proxy, desc->pending_writes, id,
-							value, len))
+							value, len, offset))
 		return;
 
 fail:
@@ -2096,7 +2100,8 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	else
 		queue = NULL;
 
-	if (send_write(device, attrib, chrc->proxy, queue, id, value, len))
+	if (send_write(device, attrib, chrc->proxy, queue, id, value, len,
+								offset))
 		return;
 
 fail:
-- 
2.9.3

