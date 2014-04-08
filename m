Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 05/15] android/gatt: Add create_device helper function
Date: Tue, 8 Apr 2014 11:22:22 +0200
Message-ID: <1396948952-2035-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index eb99d54..7e083e1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -938,6 +938,33 @@ static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
 	return queue_find(conn_list, match_dev_by_conn_id, INT_TO_PTR(conn_id));
 }
 
+static struct gatt_device *create_device(bdaddr_t *addr)
+{
+	struct gatt_device *dev;
+
+	dev = new0(struct gatt_device, 1);
+	if (!dev)
+		return NULL;
+
+	memcpy(&dev->bdaddr, addr, sizeof(bdaddr_t));
+
+	/* Create queue to keep list of clients for given device*/
+	dev->clients = queue_new();
+	if (!dev->clients) {
+		error("gatt: Cannot create client queue");
+		return NULL;
+	}
+
+	dev->services = queue_new();
+	if (!dev->services) {
+		error("gatt: Cannot create services queue");
+		queue_destroy(dev->clients, NULL);
+		return NULL;
+	}
+
+	return dev;
+}
+
 static void handle_client_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_connect *cmd = buf;
@@ -992,30 +1019,12 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	/* Lets create new gatt device and put it on conn_wait_queue.
 	  * Once it is connected we move it to conn_list
 	  */
-	dev = new0(struct gatt_device, 1);
+	dev = create_device(&addr);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
 
-	memcpy(&dev->bdaddr, &addr, sizeof(bdaddr_t));
-
-	/* Create queue to keep list of clients for given device*/
-	dev->clients = queue_new();
-	if (!dev->clients) {
-		error("gatt: Cannot create client queue");
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
-
-	dev->services = queue_new();
-	if (!dev->services) {
-		error("gatt: Cannot create services queue");
-		queue_destroy(dev->clients, NULL);
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
-
 	/* Update client list of device */
 	if (!queue_push_tail(dev->clients, INT_TO_PTR(cmd->client_if))) {
 		error("gatt: Cannot push client on the client queue!?");
-- 
1.8.4

