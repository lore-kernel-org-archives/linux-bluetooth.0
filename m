Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/12] android/gatt: Require encryption for Serial and System ID in DIS
Date: Tue, 30 Sep 2014 13:06:19 +0200
Message-Id: <1412075187-5518-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those chararcteristics are unique for device and could allow tracking
with privacy enabled. Require devices to be paired before reading
those.
---
 android/gatt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index c482364..c00265a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6451,6 +6451,7 @@ static void register_device_info_service(void)
 	bt_uuid_t uuid;
 	uint16_t srvc_handle, end_handle;
 	const char *data;
+	uint32_t enc_perm = GATT_PERM_READ | GATT_PERM_READ_ENCRYPTED;
 
 	DBG("");
 
@@ -6473,8 +6474,7 @@ static void register_device_info_service(void)
 	if (data) {
 		bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
 		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
-						GATT_PERM_READ,
-						GATT_CHR_PROP_READ,
+						enc_perm, GATT_CHR_PROP_READ,
 						device_info_read_cb, NULL,
 						(void *) data);
 	}
@@ -6482,8 +6482,7 @@ static void register_device_info_service(void)
 	if (bt_config_get_system_id()) {
 		bt_uuid16_create(&uuid, GATT_CHARAC_SYSTEM_ID);
 		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
-						GATT_PERM_READ,
-						GATT_CHR_PROP_READ,
+						enc_perm, GATT_CHR_PROP_READ,
 						device_info_read_system_id_cb,
 						NULL, NULL);
 	}
-- 
1.9.1

