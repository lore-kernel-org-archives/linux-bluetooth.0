Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 6/6] android/gatt: Fix descriptors discovery
Date: Fri, 18 Apr 2014 02:40:24 +0200
Message-Id: <1397781624-23817-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

gatt_discover_char_desc() may not return all of characteristic's
descriptors in single call since they may not fit into single
response (i.e. there are simply too many of them or there are both 16-
and 128-bit UUID descriptors which cannot be sent in single response).
We need to check if all descriptors were already returned by using
characteristic handles range and/or status error and request remaining
if possible.

Retrieved descriptors are stored on temporary queue which is later just
swapped with characteristic descriptors queue once finished. This it to
make update process atomic-like.
---
 android/gatt.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index fbe16c2..183fb02 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1896,22 +1896,22 @@ static void send_client_descr_notify(int32_t status, int32_t conn_id,
 			HAL_EV_GATT_CLIENT_GET_DESCRIPTOR, sizeof(ev), &ev);
 }
 
-static void cache_all_descr(const uint8_t *pdu, guint16 len,
+static uint16_t parse_descrs(const uint8_t *pdu, guint16 len,
 							struct queue *cache)
 {
 	struct att_data_list *list;
 	guint8 format;
+	uint16_t handle = 0xffff;
 	int i;
 
 	list = dec_find_info_resp(pdu, len, &format);
 	if (!list)
-		return;
+		return handle;
 
 	for (i = 0; i < list->num; i++) {
 		char uuidstr[MAX_LEN_UUID_STR];
 		struct descriptor *descr;
 		bt_uuid_t uuid128;
-		uint16_t handle;
 		uint8_t *value;
 		bt_uuid_t uuid;
 
@@ -1944,12 +1944,16 @@ static void cache_all_descr(const uint8_t *pdu, guint16 len,
 	}
 
 	att_data_list_free(list);
+
+	return handle;
 }
 
 struct discover_desc_data {
 	struct gatt_device *dev;
 	struct service *srvc;
 	struct characteristic *ch;
+
+	struct queue *result;
 };
 
 static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
@@ -1961,11 +1965,27 @@ static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	struct characteristic *ch = data->ch;
 	struct descriptor *descr;
 
-	if (status)
+	if (!status) {
+		uint16_t last_handle = parse_descrs(pdu, len, data->result);
+
+		if (last_handle >= ch->end_handle)
+			goto reply;
+
+		if (!gatt_discover_char_desc(dev->attrib, last_handle + 1,
+						ch->end_handle,
+						gatt_discover_desc_cb, data))
+			goto reply;
+
+		/* Do not reply yet, wait for next piece */
+		return;
+	} else if (status != ATT_ECODE_ATTR_NOT_FOUND) {
 		error("gatt: Discover all char descriptors failed: %s",
 							att_ecode2str(status));
-	else if (queue_isempty(ch->descriptors))
-		cache_all_descr(pdu, len, ch->descriptors);
+	}
+
+reply:
+	queue_destroy(ch->descriptors, free);
+	ch->descriptors = data->result;
 
 	descr = queue_peek_head(ch->descriptors);
 
@@ -1998,9 +2018,16 @@ static bool build_descr_cache(struct gatt_device *dev,
 	cb_data->dev = dev;
 	cb_data->srvc = srvc;
 	cb_data->ch = ch;
+	cb_data->result = queue_new();
+
+	if (!cb_data->result) {
+		free(cb_data);
+		return false;
+	}
 
 	if (!gatt_discover_char_desc(dev->attrib, start, end,
 					gatt_discover_desc_cb, cb_data)) {
+		queue_destroy(cb_data->result, NULL);
 		free(cb_data);
 		return false;
 	}
-- 
1.9.2

