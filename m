Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/8] android/handsfree: Add support for AT+CIND command
Date: Tue,  4 Mar 2014 16:32:04 +0100
Message-Id: <1393947130-11999-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index ce690d7..4db0560 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -51,6 +51,21 @@
 
 #define HFP_AG_FEATURES 0
 
+static const struct {
+	const char *name;
+	int min;
+	int max;
+	bool always_active;
+} indicators[] = {
+		{ "service",   0, 1, false },
+		{ "call",      0, 1, true },
+		{ "callsetup", 0, 3, true },
+		{ "callheld",  0, 2, true },
+		{ "signal",    0, 5, false },
+		{ "roam",      0, 1, false },
+		{ "battchg",   0, 5, false },
+};
+
 static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
@@ -120,6 +135,56 @@ static void disconnect_watch(void *user_data)
 	device_cleanup();
 }
 
+static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	char *buf, *ptr;
+	int len;
+	unsigned int i;
+
+	switch (type) {
+	case HFP_GW_CMD_TYPE_TEST:
+
+		len = strlen("+CIND:") + 1;
+
+		for (i = 0; i < G_N_ELEMENTS(indicators); i++) {
+			len += strlen("(\"\",(X,X)),");
+			len += strlen(indicators[i].name);
+		}
+
+		buf = g_malloc(len);
+
+		ptr = buf + sprintf(buf, "+CIND:");
+
+		for (i = 0; i < G_N_ELEMENTS(indicators); i++) {
+			ptr += sprintf(ptr, "(\"%s\",(%d%c%d)),",
+					indicators[i].name,
+					indicators[i].min,
+					indicators[i].max == 1 ? ',' : '-',
+					indicators[i].max);
+		}
+
+		ptr--;
+		*ptr = '\0';
+
+		hfp_gw_send_info(device.gw, "%s", buf);
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		g_free(buf);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+						HAL_EV_HANDSFREE_CIND, 0, NULL);
+		return;
+	case HFP_GW_CMD_TYPE_SET:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
 static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
@@ -166,6 +231,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 
 	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
 	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
 
 	return;
@@ -512,12 +578,41 @@ static void handle_cops(const void *buf, uint16_t len)
 			HAL_OP_HANDSFREE_COPS_RESPONSE, HAL_STATUS_FAILED);
 }
 
+static unsigned int get_callsetup(uint8_t state)
+{
+	switch (state) {
+	case HAL_HANDSFREE_CALL_STATE_INCOMING:
+		return 1;
+	case HAL_HANDSFREE_CALL_STATE_DIALING:
+		return 2;
+	case HAL_HANDSFREE_CALL_STATE_ALERTING:
+		return 3;
+	default:
+		return 0;
+	}
+}
+
 static void handle_cind(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_cind_response *cmd = buf;
+
 	DBG("");
 
+	/* HAL doesn't provide CIND values directly so need to convert here */
+
+	hfp_gw_send_info(device.gw, "+CIND: %u,%u,%u,%u,%u,%u,%u",
+				cmd->svc,
+				!!(cmd->num_active + cmd->num_held),
+				get_callsetup(cmd->state),
+				cmd->num_held ? (cmd->num_active ? 1 : 2) : 0,
+				cmd->signal,
+				cmd->roam,
+				cmd->batt_chg);
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_CIND_RESPONSE, HAL_STATUS_FAILED);
+			HAL_OP_HANDSFREE_CIND_RESPONSE, HAL_STATUS_SUCCESS);
 }
 
 static void handle_formatted_at_resp(const void *buf, uint16_t len)
-- 
1.8.3.2

