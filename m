Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/7] android/gatt: Add helper for service search
Date: Wed, 26 Mar 2014 18:00:56 +0100
Message-Id: <1395853259-15618-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This kind of search will be performed in most of the functions
implementing gatt's HAL API.
---
 android/gatt.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 06ae5cd..e97677d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1024,6 +1024,33 @@ static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
 	bt_uuid128_create(&to->uuid, uuid128);
 }
 
+static bool find_service(int32_t conn_id, struct element_id *service_id,
+				struct gatt_device **dev, struct service **srvc)
+{
+	struct gatt_device *device;
+	struct service *service;
+
+	device = queue_find(conn_list, match_dev_by_conn_id,
+							INT_TO_PTR(conn_id));
+	if (!device) {
+		error("gatt: conn_id=%d not found", conn_id);
+		return false;
+	}
+
+	service = queue_find(device->services, match_srvc_by_element_id,
+								service_id);
+	if (!service) {
+		error("gatt: Service with inst_id: %d not found",
+							service_id->instance);
+		return false;
+	}
+
+	*dev = device;
+	*srvc = service;
+
+	return true;
+}
+
 static void handle_client_get_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_characteristic *cmd = buf;
@@ -1043,19 +1070,8 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		return;
 	}
 
-	dev = queue_find(conn_list, match_dev_by_conn_id,
-						INT_TO_PTR(cmd->conn_id));
-	if (!dev) {
-		error("gatt: conn_id=%d not found", cmd->conn_id);
-		status = HAL_STATUS_FAILED;
-		goto done;
-	}
-
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
-	srvc = queue_find(dev->services, match_srvc_by_element_id, &match_id);
-	if (!srvc) {
-		error("gatt: Service with inst_id: %d not found",
-							match_id.instance);
+	if (!find_service(cmd->conn_id, &match_id, &dev, &srvc)) {
 		status = HAL_STATUS_FAILED;
 		goto done;
 	}
-- 
1.9.0

