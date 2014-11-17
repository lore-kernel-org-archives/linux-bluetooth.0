Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Set Descriptor handle and Include Service handle
Date: Mon, 17 Nov 2014 11:30:54 +0100
Message-Id: <1416220254-9349-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set newly created attribute's handle in notification data.
---
 android/gatt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 086bb94..199243d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4322,6 +4322,7 @@ static void handle_server_add_included_service(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	ev.incl_srvc_handle = gatt_db_attribute_get_handle(service);
 	status = HAL_STATUS_SUCCESS;
 failed:
 	ev.srvc_handle = cmd->service_handle;
@@ -5056,10 +5057,13 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 	attrib = gatt_db_service_add_descriptor(attrib, &uuid, permissions,
 							read_cb, write_cb,
 							INT_TO_PTR(app_id));
-	if (!attrib)
+	if (!attrib) {
 		status = HAL_STATUS_FAILED;
-	else
-		status = HAL_STATUS_SUCCESS;
+		goto failed;
+	}
+
+	ev.descr_handle = gatt_db_attribute_get_handle(attrib);
+	status = HAL_STATUS_SUCCESS;
 
 failed:
 	ev.server_if = app_id;
-- 
1.9.3

