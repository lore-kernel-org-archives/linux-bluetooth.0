Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/3] android/gatt: Fix offset in prepare write notifications
Date: Wed, 10 Dec 2014 10:57:08 +0100
Message-Id: <1418205428-6122-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418205428-6122-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418205428-6122-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes TC_GAW_SR_BI_07_C and probably few other cases.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index f39a66b..e24feb7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6448,7 +6448,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	data->value = g_memdup(value, vlen);
 	data->length = vlen;
 
-	if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
+	if (!gatt_db_attribute_write(attrib, offset, value, vlen, cmd[0],
 					&dev->bdaddr, attribute_write_cb,
 					data)) {
 		queue_remove(dev->pending_requests, data);
-- 
1.9.1

