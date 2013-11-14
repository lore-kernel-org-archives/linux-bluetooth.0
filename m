Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] android/a2dp: Add initial implementation of HAL_OP_A2DP_CONNECT
Date: Thu, 14 Nov 2013 12:18:20 +0200
Message-Id: <1384424301-31265-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
References: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 18 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 5ffb8ae..adbad05 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -45,6 +45,7 @@
 static int notification_sk = -1;
 static GIOChannel *io = NULL;
 static GSList *devices = NULL;
+static const bdaddr_t *adapter_addr = NULL;
 
 struct a2dp_device {
 	bdaddr_t	dst;
@@ -104,11 +105,74 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 			HAL_EV_A2DP_CONN_STATE, sizeof(ev), &ev, -1);
 }
 
+static gboolean watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+	struct a2dp_device *dev = data;
+
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+
+	a2dp_device_free(dev);
+
+	return FALSE;
+}
+
+static void signaling_connect_cb(GIOChannel *chan, GError *err,
+							gpointer user_data)
+{
+	struct a2dp_device *dev = user_data;
+
+	if (err) {
+		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+		error("%s", err->message);
+		a2dp_device_free(dev);
+		return;
+	}
+
+	dev->watch = g_io_add_watch(dev->io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+								watch_cb, dev);
+
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
+}
+
 static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 {
-	DBG("Not Implemented");
+	struct a2dp_device *dev;
+	char addr[18];
+	bdaddr_t dst;
+	GSList *l;
+	GError *err = NULL;
 
-	return HAL_STATUS_FAILED;
+	DBG("");
+
+	if (len < sizeof(*cmd))
+		return HAL_STATUS_INVALID;
+
+	android2bdaddr(&cmd->bdaddr, &dst);
+
+	l = g_slist_find_custom(devices, &dst, device_cmp);
+	if (l)
+		return HAL_STATUS_FAILED;
+
+	dev = a2dp_device_new(&dst);
+	dev->io = bt_io_connect(signaling_connect_cb, dev, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, adapter_addr,
+					BT_IO_OPT_DEST_BDADDR, &dev->dst,
+					BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		a2dp_device_free(dev);
+		return HAL_STATUS_FAILED;
+	}
+
+	ba2str(&dev->dst, addr);
+	DBG("connecting to %s", addr);
+
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTING);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_a2dp_disconnect(struct hal_cmd_a2dp_connect *cmd,
@@ -138,17 +202,6 @@ void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, status);
 }
 
-static gboolean watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
-{
-	struct a2dp_device *dev = data;
-
-	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
-
-	a2dp_device_free(dev);
-
-	return FALSE;
-}
-
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct a2dp_device *dev;
@@ -181,10 +234,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	DBG("Incoming connection from %s", address);
 
 	dev = a2dp_device_new(&dst);
-	dev->watch = g_io_add_watch(dev->io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-								watch_cb, dev);
-
-	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
+	signaling_connect_cb(chan, err, dev);
 }
 
 bool bt_a2dp_register(int sk, const bdaddr_t *addr)
@@ -193,8 +243,10 @@ bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 
 	DBG("");
 
+	adapter_addr = addr;
+
 	io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, addr,
+				BT_IO_OPT_SOURCE_BDADDR, adapter_addr,
 				BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
@@ -213,6 +265,7 @@ void bt_a2dp_unregister(void)
 {
 	DBG("");
 
+	adapter_addr = NULL;
 	notification_sk = -1;
 
 	if (io) {
-- 
1.8.3.1

