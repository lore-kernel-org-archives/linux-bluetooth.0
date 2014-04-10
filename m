Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/gatt: Trivial whitespace fixes
Date: Thu, 10 Apr 2014 16:34:51 +0200
Message-Id: <1397140494-4023-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a7a7204..ff19767 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -745,8 +745,8 @@ connect:
 		return;
 
 	/* We are ok to perform connect now. Stop discovery
-	* and once it is stopped continue with creating ACL
-	*/
+	 * and once it is stopped continue with creating ACL
+	 */
 	bt_le_discovery_stop(bt_le_discovery_stop_cb);
 }
 
@@ -792,7 +792,7 @@ done:
 
 	queue_foreach(dev->clients, client_disconnect_notify, dev);
 
-	/* Reset conn_id and put on disconnected list.*/
+	/* Reset conn_id and put on disconnected list. */
 	put_device_on_disc_list(dev);
 
 	return FALSE;
@@ -875,7 +875,7 @@ reply:
 	if (scanning)
 		bt_le_discovery_start(le_device_found_handler);
 
-	/*FIXME: What to do if discovery won't start here. */
+	/* FIXME: What to do if discovery won't start here. */
 }
 
 static int connect_le(struct gatt_device *dev)
@@ -895,11 +895,10 @@ static int connect_le(struct gatt_device *dev)
 
 	DBG("Connection attempt to: %s", addr);
 
-	/*TODO: If we are bonded then we should use higier sec level */
+	/* TODO: If we are bonded then we should use higier sec level */
 	sec_level = BT_IO_SEC_LOW;
 
-	/*
-	 * This connection will help us catch any PDUs that comes before
+	/* This connection will help us catch any PDUs that comes before
 	 * pairing finishes
 	 */
 	io = bt_io_connect(connect_cb, dev, NULL, &gerr,
@@ -996,7 +995,7 @@ static void bt_le_discovery_stop_cb(void)
 {
 	DBG("");
 
-	/* Check now if there is any device ready to connect*/
+	/* Check now if there is any device ready to connect */
 	if (connect_next_dev() < 0)
 		bt_le_discovery_start(le_device_found_handler);
 }
@@ -1061,9 +1060,9 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	android2bdaddr(&cmd->bdaddr, &addr);
 
 	/* We do support many clients for one device connection so lets check
-	  * If device is connected or in connecting state just update list of
-	  * clients
-	  */
+	 * If device is connected or in connecting state just update list of
+	 * clients
+	 */
 	dev = find_device(&addr);
 	if (dev) {
 		/* Remeber to send dummy notification event  if we area
@@ -1127,13 +1126,13 @@ reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
 								status);
 
-	/* If there is an error here we should make sure dev is out.*/
+	/* If there is an error here we should make sure dev is out. */
 	if ((status != HAL_STATUS_SUCCESS) && dev) {
 		destroy_device(dev);
 		return;
 	}
 
-	/* Send dummy notification since ACL is already up*/
+	/* Send dummy notification since ACL is already up */
 	if (send_notify) {
 		struct hal_ev_gatt_client_connect ev;
 
-- 
1.9.1

