Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] android/gatt: Add GATT_PERM_NONE define
Date: Thu, 17 Jul 2014 10:42:48 +0200
Message-Id: <1405586570-16851-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use this permission if no read and write is allowed. It is now set
in service change characteristic.
---
 android/gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4d16d1e..6253d28 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -68,6 +68,7 @@
 #define GATT_PERM_WRITE_AUTHORIZATION	0x00000800
 #define GATT_PERM_WRITE_SIGNED		0x00010000
 #define GATT_PERM_WRITE_SIGNED_MITM	0x00020000
+#define GATT_PERM_NONE			0x10000000
 
 #define GATT_CONN_TIMEOUT 2
 
@@ -6393,7 +6394,7 @@ static void register_gatt_service(void)
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	service_changed_handle =  gatt_db_add_characteristic(gatt_db,
-					srvc_handle, &uuid, 0,
+					srvc_handle, &uuid, GATT_PERM_NONE,
 					GATT_CHR_PROP_INDICATE, NULL, NULL,
 					NULL);
 
-- 
1.9.0

