Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] android/gatt: Fix scan handling
Date: Sun, 23 Mar 2014 21:20:08 +0100
Message-ID: <1395606010-19807-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android has its own ScanQueue which is used for tracking scanning
clients which means we do not have to have this logic internally.

Android will call Scan Off only when his scanQueue is empty.
---
 android/gatt.c | 62 ++++++++++++++++++----------------------------------------
 1 file changed, 19 insertions(+), 43 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0dfb90e..775adec 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -71,9 +71,9 @@ struct gatt_device {
 
 static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
+static bool scanning = false;
 
 static struct queue *gatt_clients = NULL;
-static struct queue *scan_clients = NULL;
 static struct queue *conn_list	= NULL;		/* Connected devices */
 static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 
@@ -192,13 +192,6 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	queue_remove_if(scan_clients, match_by_value,
-						INT_TO_PTR(cmd->client_if));
-
-	/* If there is no client interesting in scan, just stop it */
-	if (queue_isempty(scan_clients))
-		bt_le_discovery_stop(NULL);
-
 	free(cl);
 	status = HAL_STATUS_SUCCESS;
 
@@ -350,7 +343,7 @@ static void le_device_found_handler(bdaddr_t *addr, uint8_t addr_type,
 	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
 	char bda[18];
 
-	if (queue_isempty(scan_clients))
+	if (!scanning)
 		goto connect;
 
 	ba2str(addr, bda);
@@ -541,51 +534,43 @@ static void handle_client_scan(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_scan *cmd = buf;
 	uint8_t status;
 	void *registered;
-	void *l;
 
 	DBG("new state %d", cmd->start);
 
 	registered = queue_find(gatt_clients, match_client_by_id,
 						INT_TO_PTR(cmd->client_if));
+	if (!registered) {
+		error("gatt: Client not registered");
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
 	/* Turn off scan */
 	if (!cmd->start) {
-		if (registered)
-			queue_remove_if(scan_clients, match_by_value,
-						INT_TO_PTR(cmd->client_if));
+		DBG("Stopping LE SCAN");
 
-		if (queue_isempty(scan_clients)) {
-			DBG("Stopping LE SCAN");
+		if (scanning) {
 			bt_le_discovery_stop(NULL);
+			scanning = false;
 		}
 
 		status = HAL_STATUS_SUCCESS;
 		goto reply;
 	}
 
-	/* If device already do scan, reply with success and avoid to add it
-	 * again to the list
-	 */
-	l = queue_find(scan_clients, match_by_value,
-						INT_TO_PTR(cmd->client_if));
-	if (l) {
+	/* Reply success if we already do scan */
+	if (scanning) {
 		status = HAL_STATUS_SUCCESS;
 		goto reply;
 	}
 
+	/* Turn on scan */
 	if (!bt_le_discovery_start(le_device_found_handler)) {
 		error("gatt: LE scan switch failed");
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
-
-	/* Add scan client to the list if its registered */
-	if (registered && !queue_push_tail(scan_clients,
-						INT_TO_PTR(cmd->client_if))) {
-		error("gatt: Cannot push scan client");
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
-
+	scanning = true;
 	status = HAL_STATUS_SUCCESS;
 
 reply:
@@ -724,12 +709,10 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	}
 
 	/* Start le scan if not started */
-	if (queue_isempty(scan_clients)) {
-		if (!bt_le_discovery_start(le_device_found_handler)) {
-			error("gatt: Could not start scan");
-			status = HAL_STATUS_FAILED;
-			goto reply;
-		}
+	if (!scanning && !bt_le_discovery_start(le_device_found_handler)) {
+		error("gatt: Could not start scan");
+		status = HAL_STATUS_FAILED;
+		goto reply;
 	}
 
 	if (!queue_push_tail(conn_wait_queue, dev)) {
@@ -1226,13 +1209,6 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		return false;
 	}
 
-	scan_clients = queue_new();
-	if (!scan_clients) {
-		error("gatt: Cannot allocate scan_clients");
-		queue_destroy(gatt_clients, NULL);
-		return false;
-	}
-
 	return true;
 }
 
-- 
1.8.4

