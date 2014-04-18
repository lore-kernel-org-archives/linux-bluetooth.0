Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 5/6] android/gatt: Simplify descriptor discovery structs
Date: Fri, 18 Apr 2014 02:40:23 +0200
Message-Id: <1397781624-23817-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There's no need to pass/keep e.g. both gatt_device and conn_id since
we can retrieve one from another, so let's just use strutcures which
hold more data we can reuse later.
---
 android/gatt.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 15107b9..fbe16c2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1947,35 +1947,37 @@ static void cache_all_descr(const uint8_t *pdu, guint16 len,
 }
 
 struct discover_desc_data {
-	int32_t conn_id;
-	const struct element_id *srvc_id;
-	const struct characteristic *ch;
-	uint8_t primary;
+	struct gatt_device *dev;
+	struct service *srvc;
+	struct characteristic *ch;
 };
 
 static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct discover_desc_data *data = user_data;
+	struct gatt_device *dev = data->dev;
+	struct service *srvc = data->srvc;
+	struct characteristic *ch = data->ch;
 	struct descriptor *descr;
 
 	if (status)
 		error("gatt: Discover all char descriptors failed: %s",
 							att_ecode2str(status));
-	else if (queue_isempty(data->ch->descriptors))
-		cache_all_descr(pdu, len, data->ch->descriptors);
+	else if (queue_isempty(ch->descriptors))
+		cache_all_descr(pdu, len, ch->descriptors);
 
-	descr = queue_peek_head(data->ch->descriptors);
+	descr = queue_peek_head(ch->descriptors);
 
-	send_client_descr_notify(status, data->conn_id, data->primary,
-						data->srvc_id, &data->ch->id,
+	send_client_descr_notify(status, dev->conn_id, srvc->primary, &srvc->id,
+						&ch->id,
 						descr ? &descr->id : NULL);
 
 	free(data);
 }
 
-static bool build_descr_cache(int32_t conn_id, struct gatt_device *dev,
-					struct service *srvc, uint8_t primary,
+static bool build_descr_cache(struct gatt_device *dev,
+					struct service *srvc,
 					struct characteristic *ch)
 {
 	struct discover_desc_data *cb_data;
@@ -1993,10 +1995,9 @@ static bool build_descr_cache(int32_t conn_id, struct gatt_device *dev,
 	if (!cb_data)
 		return false;
 
-	cb_data->conn_id = conn_id;
-	cb_data->srvc_id = &srvc->id;
+	cb_data->dev = dev;
+	cb_data->srvc = srvc;
 	cb_data->ch = ch;
-	cb_data->primary = primary;
 
 	if (!gatt_discover_char_desc(dev->attrib, start, end,
 					gatt_discover_desc_cb, cb_data)) {
@@ -2053,7 +2054,7 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	}
 
 	if (queue_isempty(ch->descriptors)) {
-		if (build_descr_cache(conn_id, dev, srvc, primary, ch)) {
+		if (build_descr_cache(dev, srvc, ch)) {
 			ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_DESCRIPTOR,
 					HAL_STATUS_SUCCESS);
-- 
1.9.2

