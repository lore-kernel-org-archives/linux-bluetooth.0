Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/13] android/handsfree: Pass device to connection handling functions
Date: Wed,  8 Oct 2014 09:12:14 +0200
Message-Id: <1412752343-7001-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
References: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 56 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index d49d13b..e66fa84 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1352,6 +1352,8 @@ static void register_slc_at(void)
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	if (err) {
@@ -1359,30 +1361,30 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
-	device.gw = hfp_gw_new(g_io_channel_unix_get_fd(chan));
-	if (!device.gw)
+	dev->gw = hfp_gw_new(g_io_channel_unix_get_fd(chan));
+	if (!dev->gw)
 		goto failed;
 
 	g_io_channel_set_close_on_unref(chan, FALSE);
 
-	hfp_gw_set_close_on_unref(device.gw, true);
-	hfp_gw_set_command_handler(device.gw, at_cmd_unknown, NULL, NULL);
-	hfp_gw_set_disconnect_handler(device.gw, disconnect_watch, NULL, NULL);
+	hfp_gw_set_close_on_unref(dev->gw, true);
+	hfp_gw_set_command_handler(dev->gw, at_cmd_unknown, NULL, NULL);
+	hfp_gw_set_disconnect_handler(dev->gw, disconnect_watch, NULL, NULL);
 
-	if (device.hsp) {
+	if (dev->hsp) {
 		register_post_slc_at();
-		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
-		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
+		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
+		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	}
 
 	register_slc_at();
-	set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
+	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
 	return;
 
 failed:
 	g_io_channel_shutdown(chan, TRUE, NULL);
-	device_cleanup(&device);
+	device_cleanup(dev);
 }
 
 static void confirm_cb(GIOChannel *chan, gpointer data)
@@ -1410,7 +1412,7 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 
 	device_init(&device, &bdaddr);
 
-	if (!bt_io_accept(chan, connect_cb, NULL, NULL, NULL)) {
+	if (!bt_io_accept(chan, connect_cb, &device, NULL, NULL)) {
 		error("handsfree: failed to accept connection");
 		device_cleanup(&device);
 		goto drop;
@@ -1425,6 +1427,7 @@ drop:
 
 static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
+	struct hf_device *dev = data;
 	sdp_list_t *protos, *classes;
 	GError *gerr = NULL;
 	GIOChannel *io;
@@ -1476,9 +1479,9 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
-	io = bt_io_connect(connect_cb, NULL, NULL, &gerr,
+	io = bt_io_connect(connect_cb, dev, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
+				BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_CHANNEL, channel,
 				BT_IO_OPT_INVALID);
@@ -1488,27 +1491,28 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
-	device.hsp = true;
+	dev->hsp = true;
 
 	g_io_channel_unref(io);
 	return;
 
 fail:
-	device_cleanup(&device);
+	device_cleanup(dev);
 }
 
-static int sdp_search_hsp(void)
+static int sdp_search_hsp(struct hf_device *dev)
 {
 	uuid_t uuid;
 
 	sdp_uuid16_create(&uuid, HEADSET_SVCLASS_ID);
 
-	return bt_search_service(&adapter_addr, &device.bdaddr, &uuid,
-					sdp_hsp_search_cb, NULL, NULL, 0);
+	return bt_search_service(&adapter_addr, &dev->bdaddr, &uuid,
+					sdp_hsp_search_cb, dev, NULL, 0);
 }
 
 static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
+	struct hf_device *dev = data;
 	sdp_list_t *protos, *classes;
 	GError *gerr = NULL;
 	GIOChannel *io;
@@ -1526,7 +1530,7 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	if (!recs || !recs->data) {
 		info("handsfree: no HFP SDP records found, trying HSP");
 
-		if (sdp_search_hsp() < 0) {
+		if (sdp_search_hsp(dev) < 0) {
 			error("handsfree: HSP SDP search failed");
 			goto fail;
 		}
@@ -1565,9 +1569,9 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
-	io = bt_io_connect(connect_cb, NULL, NULL, &gerr,
+	io = bt_io_connect(connect_cb, dev, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
+				BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_CHANNEL, channel,
 				BT_IO_OPT_INVALID);
@@ -1581,17 +1585,17 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	return;
 
 fail:
-	device_cleanup(&device);
+	device_cleanup(dev);
 }
 
-static int sdp_search_hfp(void)
+static int sdp_search_hfp(struct hf_device *dev)
 {
 	uuid_t uuid;
 
 	sdp_uuid16_create(&uuid, HANDSFREE_SVCLASS_ID);
 
-	return bt_search_service(&adapter_addr, &device.bdaddr, &uuid,
-					sdp_hfp_search_cb, NULL, NULL, 0);
+	return bt_search_service(&adapter_addr, &dev->bdaddr, &uuid,
+					sdp_hfp_search_cb, dev, NULL, 0);
 }
 
 static void handle_connect(const void *buf, uint16_t len)
@@ -1617,7 +1621,7 @@ static void handle_connect(const void *buf, uint16_t len)
 	device_init(&device, &bdaddr);
 
 	/* prefer HFP over HSP */
-	ret = hfp_server ? sdp_search_hfp() : sdp_search_hsp();
+	ret = hfp_server ? sdp_search_hfp(&device) : sdp_search_hsp(&device);
 	if (ret < 0) {
 		error("handsfree: SDP search failed");
 		device_cleanup(&device);
-- 
1.9.1

