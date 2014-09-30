Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/12] android/gatt: Use release version for software revision in DIS
Date: Tue, 30 Sep 2014 13:06:23 +0200
Message-Id: <1412075187-5518-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7346d98..425f6a5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6546,16 +6546,10 @@ static void register_device_info_service(void)
 						(void *) data);
 	}
 
-	/* TODO */
-	data = NULL;
-	if (data) {
-		bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
-		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
-						GATT_PERM_READ,
-						GATT_CHR_PROP_READ,
-						device_info_read_cb, NULL,
-						(void *) data);
-	}
+	bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
+					GATT_CHR_PROP_READ, device_info_read_cb,
+					NULL, VERSION);
 
 	data = bt_config_get_vendor();
 	if (data) {
-- 
1.9.1

