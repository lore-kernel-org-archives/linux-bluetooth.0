Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/6] android/gatt: Cache end handle for characteristics
Date: Fri, 18 Apr 2014 02:40:20 +0200
Message-Id: <1397781624-23817-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 59bcd23..67bb9b5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -78,6 +78,7 @@ struct descriptor {
 struct characteristic {
 	struct element_id id;
 	struct gatt_char ch;
+	uint16_t end_handle;
 
 	struct queue *descriptors;
 };
@@ -1734,7 +1735,8 @@ static void send_client_char_notify(const struct characteristic *ch,
 					sizeof(ev), &ev);
 }
 
-static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
+static void cache_all_srvc_chars(struct service *srvc,
+							GSList *characteristics)
 {
 	uint16_t inst_id = 0;
 	bt_uuid_t uuid;
@@ -1765,7 +1767,16 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
 		 */
 		ch->id.instance = ++inst_id;
 
-		if (!queue_push_tail(q, ch)) {
+		/* Store end handle to use later for descriptors discovery */
+		if (characteristics->next) {
+			struct gatt_char *next = characteristics->next->data;
+			ch->end_handle = next->handle - 1;
+		} else {
+			ch->end_handle = srvc->primary ? srvc->prim.range.end :
+							srvc->incl.range.end;
+		}
+
+		if (!queue_push_tail(srvc->chars, ch)) {
 			error("gatt: Error while caching characteristic");
 			destroy_characteristic(ch);
 		}
@@ -1783,7 +1794,7 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 	struct discover_char_data *data = user_data;
 
 	if (queue_isempty(data->service->chars))
-		cache_all_srvc_chars(characteristics, data->service->chars);
+		cache_all_srvc_chars(data->service, characteristics);
 
 	send_client_char_notify(queue_peek_head(data->service->chars),
 						data->conn_id, data->service);
-- 
1.9.2

