Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/6] android/gatt: Simplify discover_char_cb
Date: Fri, 18 Apr 2014 02:40:21 +0200
Message-Id: <1397781624-23817-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 67bb9b5..18f1a37 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1792,12 +1792,13 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 								void *user_data)
 {
 	struct discover_char_data *data = user_data;
+	struct service *srvc = data->service;
 
-	if (queue_isempty(data->service->chars))
-		cache_all_srvc_chars(data->service, characteristics);
+	if (queue_isempty(srvc->chars))
+		cache_all_srvc_chars(srvc, characteristics);
 
-	send_client_char_notify(queue_peek_head(data->service->chars),
-						data->conn_id, data->service);
+	send_client_char_notify(queue_peek_head(srvc->chars), data->conn_id,
+									srvc);
 
 	free(data);
 }
-- 
1.9.2

