Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/gatt: Remove redundant queue check
Date: Wed, 26 Mar 2014 19:23:36 +0100
Message-Id: <1395858216-26503-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395858216-26503-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395858216-26503-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is safe to just call queue_peak_head on empty queue. Now its also
safe to pass NULL to send_client_char_notify as status will be set
inside it.
---
 android/gatt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index cad7e1a..dcc533c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1023,11 +1023,8 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 
 	cache_all_srvc_chars(characteristics, data->service->chars);
 
-	if (!queue_isempty(data->service->chars))
-		send_client_char_notify(queue_peek_head(data->service->chars),
-						data->conn_id, data->service);
-	else
-		send_client_char_notify(NULL, data->conn_id, data->service);
+	send_client_char_notify(queue_peek_head(data->service->chars),
+	 					data->conn_id, data->service);
 
 	free(data);
 }
-- 
1.9.0

