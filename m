Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 10/11] shared/gatt-client: Fix alignment warnings.
Date: Fri,  7 Nov 2014 12:41:58 -0800
Message-Id: <1415392919-17572-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1415392919-17572-1-git-send-email-armansito@chromium.org>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch addresses warnings that arise when compiled with
-W=cast-align.
---
 src/shared/gatt-client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b4f28b2..401f551 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1647,7 +1647,7 @@ bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
 		return false;
 
 	memset(iter, 0, sizeof(*iter));
-	iter->service = (struct service_list *) service;
+	iter->service = (void *) service;
 
 	return true;
 }
@@ -1677,7 +1677,7 @@ bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter *iter,
 		return false;
 
 	memset(iter, 0, sizeof(*iter));
-	iter->service = (struct service_list *) service;
+	iter->service = (void *) service;
 
 	return true;
 }
@@ -2402,7 +2402,7 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 	while (bt_gatt_service_iter_next(&iter, &service)) {
 		if (chrc_value_handle >= service->start_handle &&
 				chrc_value_handle <= service->end_handle) {
-			svc_data = (struct service_list *) service;
+			svc_data = (void *) service;
 			break;
 		}
 	}
-- 
2.1.0.rc2.206.gedb03e5

