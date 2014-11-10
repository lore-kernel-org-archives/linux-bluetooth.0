Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix incorrect attribute check
Date: Mon, 10 Nov 2014 11:10:00 +0200
Message-Id: <1415610600-2984-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2fad5ee..086bb94 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4311,7 +4311,7 @@ static void handle_server_add_included_service(const void *buf, uint16_t len)
 	}
 
 	include = gatt_db_get_attribute(gatt_db, cmd->included_handle);
-	if (!service) {
+	if (!include) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
-- 
1.9.1

