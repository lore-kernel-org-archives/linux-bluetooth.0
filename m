Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/9] android/gatt: Add queue for characteristic descriptors caching
Date: Fri, 28 Mar 2014 19:54:40 +0100
Message-Id: <1396032885-32077-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4dd16e7..be38f66 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -62,9 +62,16 @@ struct element_id {
 	uint8_t instance;
 };
 
+struct descriptor {
+	struct element_id id;
+	uint16_t handle;
+};
+
 struct characteristic {
 	struct element_id id;
 	struct gatt_char ch;
+
+	struct queue *descriptors;
 };
 
 struct service {
@@ -135,6 +142,17 @@ static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
 		uuid[15 - i] = src->value.u128.data[i];
 }
 
+static void destroy_characteristic(void *data)
+{
+	struct characteristic *chars = data;
+
+	if (!chars)
+		return;
+
+	queue_destroy(chars->descriptors, free);
+	free(chars);
+}
+
 static void destroy_service(void *data)
 {
 	struct service *srvc = data;
@@ -142,7 +160,7 @@ static void destroy_service(void *data)
 	if (!srvc)
 		return;
 
-	queue_destroy(srvc->chars, free);
+	queue_destroy(srvc->chars, destroy_characteristic);
 	free(srvc);
 }
 
@@ -1237,6 +1255,12 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
 			continue;
 		}
 
+		ch->descriptors = queue_new();
+		if (!ch->descriptors) {
+			free(ch);
+			continue;
+		}
+
 		memcpy(&ch->ch, characteristics->data, sizeof(ch->ch));
 
 		bt_string_to_uuid(&uuid, ch->ch.uuid);
-- 
1.9.0

