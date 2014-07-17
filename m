Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] android/gatt: Fix read responses with o length value
Date: Thu, 17 Jul 2014 10:42:47 +0200
Message-Id: <1405586570-16851-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attribute's value length can be 0, so fill read response and send.
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 002592c..4d16d1e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4488,7 +4488,7 @@ static void read_requested_attributes(void *data, void *user_data)
 	struct pending_request *resp_data = data;
 	struct request_processing_data *process_data = user_data;
 	uint32_t permissions;
-	uint8_t *value, error;
+	uint8_t *value = NULL, error;
 	int value_len = 0;
 
 	if (!gatt_db_get_attribute_permissions(gatt_db, resp_data->handle,
@@ -4524,7 +4524,7 @@ static void read_requested_attributes(void *data, void *user_data)
 		error = ATT_ECODE_UNLIKELY;
 
 	/* We have value here already if no callback will be called */
-	if (value_len > 0)
+	if (value_len >= 0)
 		fill_gatt_response(resp_data, resp_data->handle,
 					resp_data->offset, error, value_len,
 					value);
-- 
1.9.0

