Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/4] android/pan: Listen for incoming connections and accept in NAP role
Date: Mon,  6 Jan 2014 23:26:30 +0200
Message-Id: <1389043592-5616-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389043592-5616-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389043592-5616-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Listen for incoming connections and accept it. Create bnep interface
add it to bridge and notify control and connection state information
through HAL. Remove the device on disconnect request. If android
settings UI does not have bluetooth tethering enabled it immediately
sends disconnect signal.
---
 android/pan.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 93f712f..87753a0 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -63,12 +63,17 @@ struct pan_device {
 	uint8_t		role;
 	GIOChannel	*io;
 	struct bnep	*session;
+	guint		watch;
 };
 
 static struct {
 	uint32_t	record_id;
+	guint		watch;
+	GIOChannel	*io;
 } nap_dev = {
 	.record_id = 0,
+	.watch = 0,
+	.io = NULL,
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -81,13 +86,21 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 
 static void pan_device_free(struct pan_device *dev)
 {
+	if (dev->watch > 0) {
+		bnep_server_delete(bridge, dev->iface, &dev->dst);
+		g_source_remove(dev->watch);
+		dev->watch = 0;
+	}
+
 	if (dev->io) {
 		g_io_channel_shutdown(dev->io, FALSE, NULL);
 		g_io_channel_unref(dev->io);
 		dev->io = NULL;
 	}
 
-	bnep_free(dev->session);
+	if (dev->session)
+		bnep_free(dev->session);
+
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 
@@ -298,7 +311,7 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 
 	dev = l->data;
 
-	if (dev->conn_state == HAL_PAN_STATE_CONNECTED)
+	if (dev->conn_state == HAL_PAN_STATE_CONNECTED && dev->session)
 		bnep_disconnect(dev->session);
 
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
@@ -308,6 +321,153 @@ failed:
 	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT, status);
 }
 
+static gboolean nap_watchdog_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct pan_device *dev = user_data;
+
+	DBG("disconnected");
+
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct pan_device *dev = user_data;
+	uint8_t packet[BNEP_MTU];
+	struct bnep_setup_conn_req *req = (void *) packet;
+	uint16_t src_role, dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
+	int sk, n;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		error("Hangup or error or inval on BNEP socket");
+		return FALSE;
+	}
+
+	sk = g_io_channel_unix_get_fd(chan);
+
+	/* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
+	n = read(sk, packet, sizeof(packet));
+	if (n  < 0) {
+		error("read(): %s(%d)", strerror(errno), errno);
+		goto failed;
+	}
+
+	/* Highest known control command id BNEP_FILTER_MULT_ADDR_RSP 0x06 */
+	if (req->type == BNEP_CONTROL &&
+			req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+		error("cmd not understood");
+		bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
+								req->ctrl);
+		goto failed;
+	}
+
+	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ) {
+		error("cmd is not BNEP_SETUP_CONN_REQ %02X %02X", req->type,
+								req->ctrl);
+		goto failed;
+	}
+
+	rsp = bnep_setup_decode(req, &dst_role, &src_role);
+	if (rsp) {
+		error("bnep_setup_decode failed");
+		goto failed;
+	}
+
+	rsp = bnep_setup_chk(dst_role, src_role);
+	if (rsp) {
+		error("benp_setup_chk failed");
+		goto failed;
+	}
+
+	if (bnep_server_add(sk, dst_role, bridge, dev->iface, &dev->dst) < 0) {
+		error("server_connadd failed");
+		rsp = BNEP_CONN_NOT_ALLOWED;
+		goto failed;
+	}
+
+	rsp = BNEP_SUCCESS;
+	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
+
+	dev->watch = g_io_add_watch(chan, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+							nap_watchdog_cb, dev);
+	g_io_channel_unref(dev->io);
+	dev->io = NULL;
+
+	bt_pan_notify_ctrl_state(dev, HAL_PAN_CTRL_ENABLED);
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTED);
+
+	return FALSE;
+
+failed:
+	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
+	pan_device_free(dev);
+
+	return FALSE;
+}
+
+static void nap_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct pan_device *dev = user_data;
+
+	DBG("");
+
+	if (err) {
+		error("%s", err->message);
+		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+		return;
+	}
+
+	g_io_channel_set_close_on_unref(chan, TRUE);
+	dev->watch = g_io_add_watch(chan,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				nap_setup_cb, dev);
+}
+
+static void nap_confirm_cb(GIOChannel *chan, gpointer data)
+{
+	struct pan_device *dev = NULL;
+	bdaddr_t dst;
+	char address[18];
+	GError *err = NULL;
+
+	DBG("");
+
+	bt_io_get(chan, &err, BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, address, BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	DBG("incoming connect request from %s", address);
+	dev = g_new0(struct pan_device, 1);
+	bacpy(&dev->dst, &dst);
+	local_role = HAL_PAN_ROLE_NAP;
+	dev->role = HAL_PAN_ROLE_PANU;
+
+	dev->io = g_io_channel_ref(chan);
+	g_io_channel_set_close_on_unref(dev->io, TRUE);
+
+	if (!bt_io_accept(dev->io, nap_connect_cb, dev, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	devices = g_slist_append(devices, dev);
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTING);
+
+	return;
+
+failed:
+	g_free(dev);
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+}
+
 static int set_forward_delay(void)
 {
 	FILE *f;
@@ -382,10 +542,22 @@ static void destroy_nap_device(void)
 	nap_remove_bridge();
 
 	nap_dev.record_id = 0;
+
+	if (nap_dev.watch > 0) {
+		g_source_remove(nap_dev.watch);
+		nap_dev.watch = 0;
+	}
+
+	if (nap_dev.io) {
+		g_io_channel_shutdown(nap_dev.io, FALSE, NULL);
+		g_io_channel_unref(nap_dev.io);
+		nap_dev.io = NULL;
+	}
 }
 
 static int register_nap_server(void)
 {
+	GError *gerr;
 	int err;
 
 	DBG("");
@@ -394,6 +566,21 @@ static int register_nap_server(void)
 	if (err < 0)
 		return err;
 
+	nap_dev.io = bt_io_listen(NULL, nap_confirm_cb, NULL, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+					BT_IO_OPT_PSM, BNEP_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_OMTU, BNEP_MTU,
+					BT_IO_OPT_IMTU, BNEP_MTU,
+					BT_IO_OPT_INVALID);
+
+	if (!nap_dev.io) {
+		destroy_nap_device();
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.2

