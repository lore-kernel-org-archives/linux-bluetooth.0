Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/8] android/handsfree: Add support for AT+CMER command
Date: Tue,  4 Mar 2014 16:32:05 +0100
Message-Id: <1393947130-11999-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When this command is received SLC is connected.
---
 android/handsfree.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 4db0560..a437fba 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -70,6 +70,7 @@ static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
 	uint32_t features;
+	bool indicators_enabled;
 	struct hfp_gw *gw;
 } device;
 
@@ -125,7 +126,8 @@ static void at_command_handler(const char *command, void *user_data)
 {
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 
-	hfp_gw_disconnect(device.gw);
+	if (device.state != HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED)
+		hfp_gw_disconnect(device.gw);
 }
 
 static void disconnect_watch(void *user_data)
@@ -135,6 +137,46 @@ static void disconnect_watch(void *user_data)
 	device_cleanup();
 }
 
+static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	unsigned int val;
+
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		/* mode must be =3 */
+		if (!hfp_gw_result_get_number(result, &val) || val != 3)
+			break;
+
+		/* keyp is don't care */
+		if (!hfp_gw_result_get_number(result, &val))
+			break;
+
+		/* disp is don't care */
+		if (!hfp_gw_result_get_number(result, &val))
+			break;
+
+		/* ind must be 0 or 1 */
+		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+			break;
+
+		device.indicators_enabled = val;
+
+		/* TODO Check for 3-way calling support */
+		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED);
+
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return;
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
 static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
@@ -232,6 +274,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
 	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", NULL, NULL);
 	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
 
 	return;
-- 
1.8.3.2

