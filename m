Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/3] android/gatt Refactor le device connecting
Date: Mon, 28 Apr 2014 15:17:49 +0200
Message-Id: <1398691070-25530-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691070-25530-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691070-25530-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes device connect triggering on le scan stop.

We should be setting proper state for devices for which connection
failed and then check if we should retry the scan and connect. If we do
that there is no need for error codes. Previously we were using both,
error codes and device search results to decide if we should rescan.
---
 android/gatt.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b533661..7c59e12 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1001,7 +1001,7 @@ reply:
 	/* FIXME: What to do if discovery won't start here. */
 }
 
-static int connect_le(struct gatt_device *dev)
+static void connect_le(struct gatt_device *dev)
 {
 	BtIOSecLevel sec_level;
 	GIOChannel *io;
@@ -1013,7 +1013,8 @@ static int connect_le(struct gatt_device *dev)
 	/* There is one connection attempt going on */
 	if (dev->att_io) {
 		info("gatt: connection to dev %s is ongoing", addr);
-		return -EALREADY;
+		device_set_state(dev, DEVICE_CONNECTING);
+		return;
 	}
 
 	DBG("Connection attempt to: %s", addr);
@@ -1037,14 +1038,13 @@ static int connect_le(struct gatt_device *dev)
 		error("gatt: Failed bt_io_connect(%s): %s", addr,
 							gerr->message);
 		g_error_free(gerr);
-		return -EIO;
+		device_set_state(dev, DEVICE_CONNECT_INIT);
+		return;
 	}
 
 	/* Keep this, so we can cancel the connection */
 	dev->att_io = io;
 	device_set_state(dev, DEVICE_CONNECTING);
-
-	return 0;
 }
 
 static void handle_client_scan(const void *buf, uint16_t len)
@@ -1095,25 +1095,19 @@ reply:
 									status);
 }
 
-static int connect_next_dev(void)
+static void bt_le_discovery_stop_cb(void)
 {
 	struct gatt_device *dev;
 
 	DBG("");
 
+	/* connect ready devices */
 	dev = find_device_by_state(DEVICE_CONNECT_READY);
-	if (!dev)
-		return -ENODEV;
-
-	return connect_le(dev);
-}
-
-static void bt_le_discovery_stop_cb(void)
-{
-	DBG("");
+	if (dev)
+		connect_le(dev);
 
-	/* Check now if there is any device ready to connect */
-	if (connect_next_dev() < 0)
+	/* In case of some pending connections */
+	if (find_device_by_state(DEVICE_CONNECT_INIT))
 		bt_le_discovery_start(le_device_found_handler);
 }
 
-- 
1.9.1

