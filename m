Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/5] android/gatt: Add queue for characteristic descriptors caching
Date: Tue,  1 Apr 2014 17:19:23 +0200
Message-Id: <1396365567-17339-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is where descriptors will be cached.
---
 android/gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8bd7028..0e63df5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -67,9 +67,16 @@ struct element_id {
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
@@ -171,6 +178,17 @@ static void element_id_to_hal_gatt_id(const struct element_id *from,
 	uuid2android(&from->uuid, to->uuid);
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
@@ -178,7 +196,7 @@ static void destroy_service(void *data)
 	if (!srvc)
 		return;
 
-	queue_destroy(srvc->chars, free);
+	queue_destroy(srvc->chars, destroy_characteristic);
 	free(srvc);
 }
 
@@ -1268,6 +1286,12 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
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

