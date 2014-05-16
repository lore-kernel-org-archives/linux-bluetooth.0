Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/gatt: Fix reading attribute value
Date: Fri, 16 May 2014 10:37:37 +0200
Message-Id: <1400229459-21617-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If value and length was set by callback while gatt_db_read(), don't set
length to READ_PENDING. We have to set it only for async callbacks, then
length is still READ_INIT.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index b367eef..2a2e649 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3670,7 +3670,7 @@ static void read_requested_attributes(void *data, void *user_data)
 
 		memcpy(resp_data->value, value, value_len);
 		resp_data->length = value_len;
-	} else {
+	} else if (resp_data->length == READ_INIT) {
 		resp_data->length = READ_PENDING;
 	}
 }
-- 
1.9.0

