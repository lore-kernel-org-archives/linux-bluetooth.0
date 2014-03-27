Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 01/11] android/gatt: Add helper for getting device by conn_id
Date: Thu, 27 Mar 2014 22:12:59 +0100
Message-Id: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for cgatt_device by conn_id.
---
 android/gatt.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 81bfdc0..7a3db27 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -713,6 +713,17 @@ static struct gatt_device *find_device(bdaddr_t *addr)
 	return NULL;
 }
 
+static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
+{
+	struct gatt_device *dev;
+
+	dev = queue_find(conn_list, match_dev_by_conn_id, INT_TO_PTR(conn_id));
+	if (dev)
+		return dev;
+
+	return NULL;
+}
+
 static void handle_client_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_connect *cmd = buf;
@@ -850,8 +861,7 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 
 	ba2str((bdaddr_t *)&cmd->bdaddr, addr);
 
-	dev = queue_find(conn_list, match_dev_by_conn_id,
-						INT_TO_PTR(cmd->conn_id));
+	dev = find_device_by_conn_id(cmd->conn_id);
 	if (!dev) {
 		error("gatt: dev %s with conn_id=%d not found",
 							addr, cmd->conn_id);
@@ -916,8 +926,7 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 
 	DBG("");
 
-	dev = queue_find(conn_list, match_dev_by_conn_id,
-						INT_TO_PTR(cmd->conn_id));
+	dev = find_device_by_conn_id(cmd->conn_id);
 	if (!dev) {
 		error("gatt: dev with conn_id=%d not found", cmd->conn_id);
 		status = HAL_STATUS_FAILED;
@@ -1040,8 +1049,7 @@ static bool find_service(int32_t conn_id, struct element_id *service_id,
 	struct gatt_device *device;
 	struct service *service;
 
-	device = queue_find(conn_list, match_dev_by_conn_id,
-							INT_TO_PTR(conn_id));
+	device = find_device_by_conn_id(conn_id);
 	if (!device) {
 		error("gatt: conn_id=%d not found", conn_id);
 		return false;
-- 
1.8.3.1

