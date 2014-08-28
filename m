Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 07/13] shared/gatt-helpers: Fixed typo in callback args.
Date: Thu, 28 Aug 2014 14:25:19 -0700
Message-Id: <1409261125-6673-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1409261125-6673-1-git-send-email-armansito@chromium.org>
References: <1409261125-6673-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed a small typo in one of the callback arguments.
---
 src/shared/gatt-helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index d63fac1..443e6c5 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -54,7 +54,7 @@ typedef void (*bt_gatt_destroy_func_t)(void *user_data);
 
 typedef void (*bt_gatt_result_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
-typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_code,
+typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
 typedef void (*bt_gatt_read_callback_t)(bool success, uint8_t att_ecode,
-- 
2.1.0.rc2.206.gedb03e5

