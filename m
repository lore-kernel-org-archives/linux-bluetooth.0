Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/13] android/handsfree: Add support for AT+CIND command
Date: Sun,  2 Feb 2014 22:09:23 +0100
Message-Id: <1391375364-27106-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android supports only fixed number of indicators so this is all static
for now.
---
 android/handsfree.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 990ba2f..02135cb 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -51,6 +51,10 @@
 
 #define AG_FEATURES 0
 
+#define CIND_SUPPORT_STR "+CIND: (\"service\",(0,1)),(\"call\",(0,1)),\
+			(\"callsetup\",(0-3)),(\"callheld\",(0-2)),\
+			(\"signal\",(0-5)),(\"roam\",(0,1)),(\"battchg\",(0,1))"
+
 static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
@@ -146,12 +150,35 @@ static bool at_brsf(const char *at)
 	return true;
 }
 
+static bool at_cind(const char *at)
+{
+	if (strcmp(at, "?")) {
+		ipc_send_notif(HAL_SERVICE_ID_HANDSFREE, HAL_EV_HANDSFREE_CIND,
+								0, NULL);
+
+		return true;
+	}
+
+	if (strcmp(at, "=?")) {
+		hfp_gw_send_info(device.gw, "%s", CIND_SUPPORT_STR);
+
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return true;
+	}
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+
+	return false;
+}
+
 static const struct {
 	const char *prefix;
 	int prefix_len;
 	bool (*func)(const char *at_cmds);
 } at_cmds[] = {
 	{ "+BRSF", sizeof("+BRSF") - 1, at_brsf },
+	{ "+CIND", sizeof("+CIND") - 1, at_cind },
 };
 
 static void at_command_handler(const char *command, void *user_data)
@@ -466,12 +493,41 @@ static void handle_cops(const void *buf, uint16_t len)
 							HAL_STATUS_FAILED);
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
 	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CIND_RESPONSE,
-							HAL_STATUS_FAILED);
+							HAL_STATUS_SUCCESS);
 }
 
 static void handle_formatted_at_resp(const void *buf, uint16_t len)
-- 
1.8.5.3

