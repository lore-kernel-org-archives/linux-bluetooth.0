Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix wrong initial value
Date: Thu, 12 Jun 2014 13:43:45 +0300
Message-Id: <1402569825-27168-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Initialize value_len to -1 since otherwise check value_len >= 0 does not
make sense.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8da77d0..8260a8d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4147,7 +4147,7 @@ static void read_requested_attributes(void *data, void *user_data)
 	struct request_processing_data *process_data = user_data;
 	uint32_t permissions;
 	uint8_t *value, error;
-	int value_len = 0;
+	int value_len = -1;
 
 	if (!gatt_db_get_attribute_permissions(gatt_db, resp_data->handle,
 								&permissions)) {
-- 
1.8.3.2

