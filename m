Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/A2DP: Connect transport channel when initiator
Date: Tue, 14 Jan 2014 13:48:10 +0200
Message-Id: <1389700090-3642-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389700090-3642-1-git-send-email-luiz.dentz@gmail.com>
References: <1389700090-3642-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This connects transport channel when initiator of open request.
---
 android/a2dp.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index aab0940..7b76cf3 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -141,6 +141,25 @@ static struct a2dp_device *a2dp_device_new(const bdaddr_t *dst)
 	return dev;
 }
 
+static bool a2dp_device_connect(struct a2dp_device *dev, BtIOConnect cb)
+{
+	GError *err = NULL;
+
+	dev->io = bt_io_connect(cb, dev, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+					BT_IO_OPT_DEST_BDADDR, &dev->dst,
+					BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
+	return true;
+}
+
 static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 {
 	struct hal_ev_a2dp_conn_state ev;
@@ -398,7 +417,6 @@ static void bt_a2dp_connect(const void *buf, uint16_t len)
 	char addr[18];
 	bdaddr_t dst;
 	GSList *l;
-	GError *err = NULL;
 
 	DBG("");
 
@@ -411,15 +429,7 @@ static void bt_a2dp_connect(const void *buf, uint16_t len)
 	}
 
 	dev = a2dp_device_new(&dst);
-	dev->io = bt_io_connect(signaling_connect_cb, dev, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-					BT_IO_OPT_DEST_BDADDR, &dev->dst,
-					BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-					BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
+	if (!a2dp_device_connect(dev, signaling_connect_cb)) {
 		a2dp_device_free(dev);
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -529,6 +539,11 @@ static void transport_connect_cb(GIOChannel *chan, GError *err,
 	}
 
 	g_io_channel_set_close_on_unref(chan, FALSE);
+
+	if (dev->io) {
+		g_io_channel_unref(dev->io);
+		dev->io = NULL;
+	}
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -928,12 +943,24 @@ static void sep_open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_device *dev;
 
 	DBG("");
 
-	if (!err)
-		return;
+	if (err)
+		goto failed;
 
+	dev = find_device_by_session(session);
+	if (!dev) {
+		error("Unable to find device for session");
+		goto failed;
+	}
+
+	a2dp_device_connect(dev, transport_connect_cb);
+
+	return;
+
+failed:
 	setup_remove_by_id(endpoint->id);
 }
 
-- 
1.8.4.2

