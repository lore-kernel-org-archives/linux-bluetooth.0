Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/16] android/gatt: Check status on get characteristic callback
Date: Thu, 26 Feb 2015 10:39:33 +0100
Message-Id: <1424943583-30061-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 53b1983..0296788 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2725,12 +2725,20 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 	struct discover_char_data *data = user_data;
 	struct service *srvc = data->service;
 
+	if (status) {
+		error("gatt: Failed to get characteristics: %s",
+							att_ecode2str(status));
+		convert_send_client_char_notify(NULL, data->conn_id, srvc);
+		goto done;
+	}
+
 	if (queue_isempty(srvc->chars))
 		cache_all_srvc_chars(srvc, characteristics);
 
 	convert_send_client_char_notify(queue_peek_head(srvc->chars),
 							data->conn_id, srvc);
 
+done:
 	free(data);
 }
 
-- 
1.8.4

