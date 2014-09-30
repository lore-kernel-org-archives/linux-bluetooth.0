Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/12] android/gatt: Fix serial number in DIS
Date: Tue, 30 Sep 2014 13:06:18 +0200
Message-Id: <1412075187-5518-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix use of name as serial number value. Since now proper config option
exists use real serial if provided.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 37bdeb6..c482364 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6469,7 +6469,7 @@ static void register_device_info_service(void)
 						(void *) data);
 	}
 
-	/* TODO */
+	data = bt_config_get_serial();
 	if (data) {
 		bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
 		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
-- 
1.9.1

