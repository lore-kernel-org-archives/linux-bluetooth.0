Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/8] android/handsfree: Add support for AT+BRSF command
Date: Tue,  4 Mar 2014 16:32:03 +0100
Message-Id: <1393947130-11999-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index 4f69e68..ce690d7 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -54,6 +54,7 @@
 static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
+	uint32_t features;
 	struct hfp_gw *gw;
 } device;
 
@@ -119,6 +120,31 @@ static void disconnect_watch(void *user_data)
 	device_cleanup();
 }
 
+static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	unsigned int feat;
+
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_number(result, &feat))
+			break;
+
+		/* TODO verify features */
+		device.features = feat;
+
+		hfp_gw_send_info(device.gw, "+BRSF=%u", HFP_AG_FEATURES);
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	DBG("");
@@ -138,6 +164,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	hfp_gw_set_command_handler(device.gw, at_command_handler, NULL, NULL);
 	hfp_gw_set_disconnect_handler(device.gw, disconnect_watch, NULL, NULL);
 
+
+	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
 	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
 
 	return;
-- 
1.8.3.2

