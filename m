Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android/hid: Rename hdev vars to dev
Date: Fri,  1 Nov 2013 15:08:38 +0200
Message-Id: <1383311321-28429-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hid.c | 248 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 124 insertions(+), 124 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index f576548..bbdc66a 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -74,10 +74,10 @@ struct hid_device {
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
 {
-	const struct hid_device *hdev = s;
+	const struct hid_device *dev = s;
 	const bdaddr_t *dst = user_data;
 
-	return bacmp(&hdev->dst, dst);
+	return bacmp(&dev->dst, dst);
 }
 
 static void uhid_destroy(int fd)
@@ -95,38 +95,38 @@ static void uhid_destroy(int fd)
 	close(fd);
 }
 
-static void hid_device_free(struct hid_device *hdev)
+static void hid_device_free(struct hid_device *dev)
 {
-	if (hdev->ctrl_watch > 0)
-		g_source_remove(hdev->ctrl_watch);
+	if (dev->ctrl_watch > 0)
+		g_source_remove(dev->ctrl_watch);
 
-	if (hdev->intr_watch > 0)
-		g_source_remove(hdev->intr_watch);
+	if (dev->intr_watch > 0)
+		g_source_remove(dev->intr_watch);
 
-	if (hdev->intr_io)
-		g_io_channel_unref(hdev->intr_io);
+	if (dev->intr_io)
+		g_io_channel_unref(dev->intr_io);
 
-	if (hdev->ctrl_io)
-		g_io_channel_unref(hdev->ctrl_io);
+	if (dev->ctrl_io)
+		g_io_channel_unref(dev->ctrl_io);
 
-	if (hdev->uhid_watch_id) {
-		g_source_remove(hdev->uhid_watch_id);
-		hdev->uhid_watch_id = 0;
+	if (dev->uhid_watch_id) {
+		g_source_remove(dev->uhid_watch_id);
+		dev->uhid_watch_id = 0;
 	}
 
-	if (hdev->uhid_fd > 0)
-		uhid_destroy(hdev->uhid_fd);
+	if (dev->uhid_fd > 0)
+		uhid_destroy(dev->uhid_fd);
 
-	g_free(hdev->rd_data);
+	g_free(dev->rd_data);
 
-	devices = g_slist_remove(devices, hdev);
-	g_free(hdev);
+	devices = g_slist_remove(devices, dev);
+	g_free(dev);
 }
 
 static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	struct hid_device *hdev = user_data;
+	struct hid_device *dev = user_data;
 	struct uhid_event ev;
 	ssize_t bread;
 	int fd;
@@ -151,19 +151,19 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 
 failed:
-	hdev->uhid_watch_id = 0;
+	dev->uhid_watch_id = 0;
 	return FALSE;
 }
 
 static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 {
-	struct hid_device *hdev = data;
+	struct hid_device *dev = data;
 	uint8_t buf[UHID_DATA_MAX];
 	struct uhid_event ev;
 	int fd, bread;
 
 	/* Wait uHID if not ready */
-	if (hdev->uhid_fd < 0)
+	if (dev->uhid_fd < 0)
 		return TRUE;
 
 	fd = g_io_channel_unix_get_fd(chan);
@@ -183,26 +183,26 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 	ev.u.input.size = bread - 1;
 	memcpy(ev.u.input.data, &buf[1], ev.u.input.size);
 
-	if (write(hdev->uhid_fd, &ev, sizeof(ev)) < 0)
+	if (write(dev->uhid_fd, &ev, sizeof(ev)) < 0)
 		DBG("write: %s (%d)", strerror(errno), errno);
 
 	return TRUE;
 }
 
-static void bt_hid_set_state(struct hid_device *hdev, uint8_t state)
+static void bt_hid_set_state(struct hid_device *dev, uint8_t state)
 {
 	struct hal_ev_hid_conn_state ev;
 	char address[18];
 
-	if (hdev->state == state)
+	if (dev->state == state)
 		return;
 
-	hdev->state = state;
+	dev->state = state;
 
-	ba2str(&hdev->dst, address);
+	ba2str(&dev->dst, address);
 	DBG("device %s state %u", address, state);
 
-	bdaddr2android(&hdev->dst, ev.bdaddr);
+	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.state = state;
 
 	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST,
@@ -212,7 +212,7 @@ static void bt_hid_set_state(struct hid_device *hdev, uint8_t state)
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
-	struct hid_device *hdev = data;
+	struct hid_device *dev = data;
 
 	if (cond & G_IO_IN)
 		return intr_io_watch_cb(chan, data);
@@ -220,19 +220,19 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
 	/* Checking for ctrl_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that ctrl_watch_cb has been queued for dispatching in
 	 * this mainloop iteration */
-	if ((cond & (G_IO_HUP | G_IO_ERR)) && hdev->ctrl_watch)
+	if ((cond & (G_IO_HUP | G_IO_ERR)) && dev->ctrl_watch)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 
-	hdev->intr_watch = 0;
+	dev->intr_watch = 0;
 
-	if (hdev->intr_io) {
-		g_io_channel_unref(hdev->intr_io);
-		hdev->intr_io = NULL;
+	if (dev->intr_io) {
+		g_io_channel_unref(dev->intr_io);
+		dev->intr_io = NULL;
 	}
 
 	/* Close control channel */
-	if (hdev->ctrl_io && !(cond & G_IO_NVAL))
-		g_io_channel_shutdown(hdev->ctrl_io, TRUE, NULL);
+	if (dev->ctrl_io && !(cond & G_IO_NVAL))
+		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
 
 	return FALSE;
 }
@@ -240,34 +240,34 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
 static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
-	struct hid_device *hdev = data;
+	struct hid_device *dev = data;
 	char address[18];
 
-	ba2str(&hdev->dst, address);
-	bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTED);
+	ba2str(&dev->dst, address);
+	bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTED);
 
 	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that intr_watch_cb has been queued for dispatching in
 	 * this mainloop iteration */
-	if ((cond & (G_IO_HUP | G_IO_ERR)) && hdev->intr_watch)
+	if ((cond & (G_IO_HUP | G_IO_ERR)) && dev->intr_watch)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 
-	if (hdev->intr_io && !(cond & G_IO_NVAL))
-		g_io_channel_shutdown(hdev->intr_io, TRUE, NULL);
+	if (dev->intr_io && !(cond & G_IO_NVAL))
+		g_io_channel_shutdown(dev->intr_io, TRUE, NULL);
 
-	hid_device_free(hdev);
+	hid_device_free(dev);
 
 	return FALSE;
 }
 
-static int uhid_create(struct hid_device *hdev)
+static int uhid_create(struct hid_device *dev)
 {
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
 	GIOChannel *io;
 	struct uhid_event ev;
 
-	hdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
-	if (hdev->uhid_fd < 0) {
+	dev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
+	if (dev->uhid_fd < 0) {
 		error("Failed to open uHID device: %s", strerror(errno));
 		return -errno;
 	}
@@ -276,23 +276,23 @@ static int uhid_create(struct hid_device *hdev)
 	ev.type = UHID_CREATE;
 	strcpy((char *) ev.u.create.name, "bluez-input-device");
 	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.vendor = hdev->vendor;
-	ev.u.create.product = hdev->product;
-	ev.u.create.version = hdev->vendor;
-	ev.u.create.country = hdev->country;
-	ev.u.create.rd_size = hdev->rd_size;
-	ev.u.create.rd_data = hdev->rd_data;
-
-	if (write(hdev->uhid_fd, &ev, sizeof(ev)) < 0) {
+	ev.u.create.vendor = dev->vendor;
+	ev.u.create.product = dev->product;
+	ev.u.create.version = dev->vendor;
+	ev.u.create.country = dev->country;
+	ev.u.create.rd_size = dev->rd_size;
+	ev.u.create.rd_data = dev->rd_data;
+
+	if (write(dev->uhid_fd, &ev, sizeof(ev)) < 0) {
 		error("Failed to create uHID device: %s", strerror(errno));
-		close(hdev->uhid_fd);
-		hdev->uhid_fd = -1;
+		close(dev->uhid_fd);
+		dev->uhid_fd = -1;
 		return -errno;
 	}
 
-	io = g_io_channel_unix_new(hdev->uhid_fd);
+	io = g_io_channel_unix_new(dev->uhid_fd);
 	g_io_channel_set_encoding(io, NULL, NULL);
-	hdev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb, hdev);
+	dev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb, dev);
 	g_io_channel_unref(io);
 
 	return 0;
@@ -301,21 +301,21 @@ static int uhid_create(struct hid_device *hdev)
 static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
-	struct hid_device *hdev = user_data;
+	struct hid_device *dev = user_data;
 
 	DBG("");
 
 	if (conn_err)
 		goto failed;
 
-	if (uhid_create(hdev) < 0)
+	if (uhid_create(dev) < 0)
 		goto failed;
 
-	hdev->intr_watch = g_io_add_watch(hdev->intr_io,
+	dev->intr_watch = g_io_add_watch(dev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				intr_watch_cb, hdev);
+				intr_watch_cb, dev);
 
-	bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTED);
+	bt_hid_set_state(dev, HAL_HID_STATE_CONNECTED);
 
 	return;
 
@@ -324,58 +324,58 @@ failed:
 	 * control channel (if we only do unref GLib will close it only
 	 * after returning control to the mainloop */
 	if (!conn_err)
-		g_io_channel_shutdown(hdev->intr_io, FALSE, NULL);
+		g_io_channel_shutdown(dev->intr_io, FALSE, NULL);
 
-	g_io_channel_unref(hdev->intr_io);
-	hdev->intr_io = NULL;
+	g_io_channel_unref(dev->intr_io);
+	dev->intr_io = NULL;
 
-	if (hdev->ctrl_io) {
-		g_io_channel_unref(hdev->ctrl_io);
-		hdev->ctrl_io = NULL;
+	if (dev->ctrl_io) {
+		g_io_channel_unref(dev->ctrl_io);
+		dev->ctrl_io = NULL;
 	}
 }
 
 static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
-	struct hid_device *hdev = user_data;
+	struct hid_device *dev = user_data;
 	GError *err = NULL;
 	const bdaddr_t *src = bt_adapter_get_address();
 
 	DBG("");
 
 	if (conn_err) {
-		bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTED);
+		bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTED);
 		error("%s", conn_err->message);
 		goto failed;
 	}
 
 	/* Connect to the HID interrupt channel */
-	hdev->intr_io = bt_io_connect(interrupt_connect_cb, hdev, NULL, &err,
+	dev->intr_io = bt_io_connect(interrupt_connect_cb, dev, NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR, src,
-					BT_IO_OPT_DEST_BDADDR, &hdev->dst,
+					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
-	if (!hdev->intr_io) {
+	if (!dev->intr_io) {
 		error("%s", err->message);
 		g_error_free(err);
 		goto failed;
 	}
 
-	hdev->ctrl_watch = g_io_add_watch(hdev->ctrl_io,
+	dev->ctrl_watch = g_io_add_watch(dev->ctrl_io,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					ctrl_watch_cb, hdev);
+					ctrl_watch_cb, dev);
 
 	return;
 
 failed:
-	hid_device_free(hdev);
+	hid_device_free(dev);
 }
 
 static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
-	struct hid_device *hdev = data;
+	struct hid_device *dev = data;
 	sdp_list_t *list;
 	GError *gerr = NULL;
 	const bdaddr_t *src = bt_adapter_get_address();
@@ -398,19 +398,19 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
 		data = sdp_data_get(rec, SDP_ATTR_VENDOR_ID);
 		if (data)
-			hdev->vendor = data->val.uint16;
+			dev->vendor = data->val.uint16;
 
 		data = sdp_data_get(rec, SDP_ATTR_PRODUCT_ID);
 		if (data)
-			hdev->product = data->val.uint16;
+			dev->product = data->val.uint16;
 
 		data = sdp_data_get(rec, SDP_ATTR_VERSION);
 		if (data)
-			hdev->version = data->val.uint16;
+			dev->version = data->val.uint16;
 
 		data = sdp_data_get(rec, SDP_ATTR_HID_COUNTRY_CODE);
 		if (data)
-			hdev->country = data->val.uint8;
+			dev->country = data->val.uint8;
 
 		data = sdp_data_get(rec, SDP_ATTR_HID_DESCRIPTOR_LIST);
 		if (data) {
@@ -432,20 +432,20 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 			if (!data || !SDP_IS_TEXT_STR(data->dtd))
 				goto fail;
 
-			hdev->rd_size = data->unitSize;
-			hdev->rd_data = g_memdup(data->val.str, data->unitSize);
+			dev->rd_size = data->unitSize;
+			dev->rd_data = g_memdup(data->val.str, data->unitSize);
 		}
 	}
 
-	if (hdev->ctrl_io) {
-		if (uhid_create(hdev) < 0)
+	if (dev->ctrl_io) {
+		if (uhid_create(dev) < 0)
 			goto fail;
 		return;
 	}
 
-	hdev->ctrl_io = bt_io_connect(control_connect_cb, hdev, NULL, &gerr,
+	dev->ctrl_io = bt_io_connect(control_connect_cb, dev, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, src,
-					BT_IO_OPT_DEST_BDADDR, &hdev->dst,
+					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
@@ -458,13 +458,13 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	return;
 
 fail:
-	bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTED);
-	hid_device_free(hdev);
+	bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTED);
+	hid_device_free(dev);
 }
 
 static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 {
-	struct hid_device *hdev;
+	struct hid_device *dev;
 	char addr[18];
 	bdaddr_t dst;
 	GSList *l;
@@ -482,23 +482,23 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 	if (l)
 		return HAL_STATUS_FAILED;
 
-	hdev = g_new0(struct hid_device, 1);
-	bacpy(&hdev->dst, &dst);
-	hdev->uhid_fd = -1;
+	dev = g_new0(struct hid_device, 1);
+	bacpy(&dev->dst, &dst);
+	dev->uhid_fd = -1;
 
-	ba2str(&hdev->dst, addr);
+	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
 
 	bt_string2uuid(&uuid, HID_UUID);
-	if (bt_search_service(src, &hdev->dst, &uuid, hid_sdp_search_cb, hdev,
+	if (bt_search_service(src, &dev->dst, &uuid, hid_sdp_search_cb, dev,
 								NULL) < 0) {
 		error("Failed to search sdp details");
-		hid_device_free(hdev);
+		hid_device_free(dev);
 		return HAL_STATUS_FAILED;
 	}
 
-	devices = g_slist_append(devices, hdev);
-	bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTING);
+	devices = g_slist_append(devices, dev);
+	bt_hid_set_state(dev, HAL_HID_STATE_CONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -506,7 +506,7 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 								uint16_t len)
 {
-	struct hid_device *hdev;
+	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
 
@@ -521,16 +521,16 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 	if (!l)
 		return HAL_STATUS_FAILED;
 
-	hdev = l->data;
+	dev = l->data;
 
 	/* Wait either channels to HUP */
-	if (hdev->intr_io)
-		g_io_channel_shutdown(hdev->intr_io, TRUE, NULL);
+	if (dev->intr_io)
+		g_io_channel_shutdown(dev->intr_io, TRUE, NULL);
 
-	if (hdev->ctrl_io)
-		g_io_channel_shutdown(hdev->ctrl_io, TRUE, NULL);
+	if (dev->ctrl_io)
+		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
 
-	bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTING);
+	bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -556,7 +556,7 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
-	struct hid_device *hdev;
+	struct hid_device *dev;
 	bdaddr_t dst;
 	char address[18];
 	uint16_t psm;
@@ -589,25 +589,25 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		if (l)
 			return;
 
-		hdev = g_new0(struct hid_device, 1);
-		bacpy(&hdev->dst, &dst);
-		hdev->ctrl_io = g_io_channel_ref(chan);
-		hdev->uhid_fd = -1;
+		dev = g_new0(struct hid_device, 1);
+		bacpy(&dev->dst, &dst);
+		dev->ctrl_io = g_io_channel_ref(chan);
+		dev->uhid_fd = -1;
 
 		bt_string2uuid(&uuid, HID_UUID);
-		if (bt_search_service(src, &hdev->dst, &uuid,
-					hid_sdp_search_cb, hdev, NULL) < 0) {
+		if (bt_search_service(src, &dev->dst, &uuid,
+					hid_sdp_search_cb, dev, NULL) < 0) {
 			error("failed to search sdp details");
-			hid_device_free(hdev);
+			hid_device_free(dev);
 			return;
 		}
 
-		devices = g_slist_append(devices, hdev);
+		devices = g_slist_append(devices, dev);
 
-		hdev->ctrl_watch = g_io_add_watch(hdev->ctrl_io,
+		dev->ctrl_watch = g_io_add_watch(dev->ctrl_io,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					ctrl_watch_cb, hdev);
-		bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTING);
+					ctrl_watch_cb, dev);
+		bt_hid_set_state(dev, HAL_HID_STATE_CONNECTING);
 		break;
 
 	case L2CAP_PSM_HIDP_INTR:
@@ -615,12 +615,12 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		if (!l)
 			return;
 
-		hdev = l->data;
-		hdev->intr_io = g_io_channel_ref(chan);
-		hdev->intr_watch = g_io_add_watch(hdev->intr_io,
+		dev = l->data;
+		dev->intr_io = g_io_channel_ref(chan);
+		dev->intr_watch = g_io_add_watch(dev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				intr_watch_cb, hdev);
-		bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTED);
+				intr_watch_cb, dev);
+		bt_hid_set_state(dev, HAL_HID_STATE_CONNECTED);
 		break;
 	}
 }
-- 
1.8.3.1

