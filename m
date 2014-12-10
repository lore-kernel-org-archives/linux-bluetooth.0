Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/gatt: Fix missing error response to find by type value request
Date: Wed, 10 Dec 2014 14:31:19 +0100
Message-Id: <1418218279-17642-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes Find By Type Value Request issue.
When the attribute queue is empty, error response should be sent.
---
 android/gatt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index b2ce9c1..484775a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4546,7 +4546,6 @@ static void send_dev_complete_response(struct gatt_device *device,
 			if ((val->length != val->filter_vlen) ||
 				memcmp(val->value, val->filter_value,
 								val->length)) {
-
 				destroy_pending_request(val);
 				val = queue_pop_head(device->pending_requests);
 				continue;
@@ -6172,6 +6171,9 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	struct queue *q;
 	bt_uuid_t uuid;
 	uint16_t len;
+	size_t mtu;
+	uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
+
 
 	DBG("");
 
@@ -6189,6 +6191,14 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	gatt_db_find_by_type(gatt_db, start, end, &uuid, q);
 
+	if (queue_isempty(q)) {
+		len = enc_error_resp(ATT_OP_FIND_BY_TYPE_REQ, start,
+					ATT_ECODE_ATTR_NOT_FOUND, rsp, mtu);
+		g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
+		queue_destroy(q, NULL);
+		return 0;
+	}
+
 	while (queue_peek_head(q)) {
 		struct gatt_db_attribute *attrib = queue_pop_head(q);
 		struct pending_request *data;
-- 
1.9.1

