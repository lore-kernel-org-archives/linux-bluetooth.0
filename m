Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/15] android/gatt: Add list of disconnected device
Date: Tue, 8 Apr 2014 11:22:23 +0200
Message-ID: <1396948952-2035-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add disconnected device list. It is in order to not lose
the cache if we disconnect from LE device.

Once device is disconnected we move it to disc_dev_list. When Client
wants to connect we first check if we know device, if so we use it.
---
 android/gatt.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7e083e1..6259176 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -124,6 +124,7 @@ static struct queue *gatt_clients = NULL;
 static struct queue *gatt_servers = NULL;
 static struct queue *conn_list	= NULL;		/* Connected devices */
 static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
+static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
 
 static void bt_le_discovery_stop_cb(void);
 
@@ -679,6 +680,13 @@ connect:
 	bt_le_discovery_stop(bt_le_discovery_stop_cb);
 }
 
+static void put_device_on_disc_list(struct gatt_device *dev)
+{
+	dev->conn_id = 0;
+	queue_remove_all(dev->clients, NULL, NULL, NULL);
+	queue_push_tail(disc_dev_list, dev);
+}
+
 static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -713,7 +721,9 @@ done:
 	connection_cleanup(dev);
 
 	queue_foreach(dev->clients, client_disconnect_notify, dev);
-	destroy_device(dev);
+
+	/* Reset conn_id and put on disconnected list.*/
+	put_device_on_disc_list(dev);
 
 	return FALSE;
 }
@@ -1016,13 +1026,15 @@ static void handle_client_connect(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	/* Lets create new gatt device and put it on conn_wait_queue.
-	  * Once it is connected we move it to conn_list
-	  */
-	dev = create_device(&addr);
+	/* Let's check if we know device already */
+	dev = queue_remove_if(disc_dev_list, match_dev_by_bdaddr, &addr);
 	if (!dev) {
-		status = HAL_STATUS_FAILED;
-		goto reply;
+		/* New device, create it. */
+		dev = create_device(&addr);
+		if (!dev) {
+			status = HAL_STATUS_FAILED;
+			goto reply;
+		}
 	}
 
 	/* Update client list of device */
@@ -1121,7 +1133,7 @@ reply:
 	/* If this is last client do more cleaning */
 	connection_cleanup(dev);
 	dev = queue_remove_if(conn_list, match_dev_by_bdaddr, &dev->bdaddr);
-	destroy_device(dev);
+	put_device_on_disc_list(dev);
 }
 
 static void handle_client_listen(const void *buf, uint16_t len)
@@ -2730,8 +2742,10 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	conn_wait_queue = queue_new();
 	gatt_clients = queue_new();
 	gatt_servers = queue_new();
+	disc_dev_list = queue_new();
 
-	if (!conn_list || !conn_wait_queue || !gatt_clients || !gatt_servers) {
+	if (!conn_list || !conn_wait_queue || !gatt_clients || !gatt_servers ||
+							!disc_dev_list) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_servers, NULL);
@@ -2746,6 +2760,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(conn_wait_queue, NULL);
 		conn_wait_queue = NULL;
 
+		queue_destroy(disc_dev_list, NULL);
+		disc_dev_list = NULL;
+
 		return false;
 	}
 
@@ -2777,4 +2794,7 @@ void bt_gatt_unregister(void)
 
 	queue_destroy(conn_wait_queue, destroy_device);
 	conn_wait_queue = NULL;
+
+	queue_destroy(disc_dev_list, destroy_device);
+	disc_dev_list = NULL;
 }
-- 
1.8.4

