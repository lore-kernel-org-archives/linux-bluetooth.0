Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/gatt: Add cache check in Clients caching callbacks
Date: Thu, 10 Apr 2014 16:34:54 +0200
Message-Id: <1397140494-4023-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397140494-4023-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397140494-4023-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we were only checking in API call functions if cache exist and not
in asynchronous callbacks, it was possible to schedule multiple
discovery sessions before cache was filled with data. This resulted in
adding duplicate entries, when all scheduled discovery sessions started
to cache data.
---
 android/gatt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5c33253..aa2a5fd 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -623,6 +623,12 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		goto done;
 	}
 
+	if (!queue_isempty(dev->services)) {
+		info("gatt: Services already cached");
+		gatt_status = GATT_SUCCESS;
+		goto done;
+	}
+
 	/* There might be multiply services with same uuid. Therefore make sure
 	 * each primary service one has unique instance_id
 	 */
@@ -1564,7 +1570,8 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 {
 	struct discover_char_data *data = user_data;
 
-	cache_all_srvc_chars(characteristics, data->service->chars);
+	if (queue_isempty(data->service->chars))
+		cache_all_srvc_chars(characteristics, data->service->chars);
 
 	send_client_char_notify(queue_peek_head(data->service->chars),
 						data->conn_id, data->service);
@@ -1731,7 +1738,7 @@ static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	if (status)
 		error("gatt: Discover all char descriptors failed: %s",
 							att_ecode2str(status));
-	else
+	else if (queue_isempty(data->ch->descriptors))
 		cache_all_descr(pdu, len, data->ch->descriptors);
 
 	descr = queue_peek_head(data->ch->descriptors);
-- 
1.9.1

