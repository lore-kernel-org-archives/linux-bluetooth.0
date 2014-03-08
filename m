Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 18/20] android/handsfree: Add support for phone state change command
Date: Sat,  8 Mar 2014 01:20:02 +0100
Message-Id: <1394238004-15691-19-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unfortunately HAL is not getting call, callsetup and callheld
indicators values directly from Android Framework and those need to be
chosen based on number of active/hold calls and call state that
triggered phone state change.

This patch adds only basic call state handling (no three way call).
---
 android/handsfree.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index c1ae359..e07278c 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -84,6 +84,8 @@
 #define IND_BATTCHG	6
 #define IND_COUNT	(IND_BATTCHG + 1)
 
+#define RING_TIMEOUT 2
+
 struct indicator {
 	const char *name;
 	int min;
@@ -110,6 +112,7 @@ static struct {
 	bool cmee_enabled;
 	bool indicators_enabled;
 	struct indicator inds[IND_COUNT];
+	guint ring;
 	bool hsp;
 	struct hfp_gw *gw;
 } device;
@@ -1547,13 +1550,110 @@ done:
 				HAL_OP_HANDSFREE_CLCC_RESPONSE, status);
 }
 
+static gboolean ring_cb(gpointer user_data)
+{
+	hfp_gw_send_info(device.gw, "+RING");
+
+	return TRUE;
+}
+
+static void phone_state_active(int num_active, int num_held)
+{
+
+}
+
+static void phone_state_held(int num_active, int num_held)
+{
+
+}
+
+static void phone_state_dialing(int num_active, int num_held)
+{
+	update_indicator(IND_CALLSETUP, 2);
+}
+
+static void phone_state_alerting(int num_active, int num_held)
+{
+	update_indicator(IND_CALLSETUP, 3);
+}
+
+static void phone_state_incoming(int num_active, int num_held, uint8_t type,
+					const uint8_t *number, uint16_t len)
+{
+	update_indicator(IND_CALLSETUP, 1);
+
+	device.ring = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
+							RING_TIMEOUT, ring_cb,
+							NULL, NULL);
+}
+
+static void phone_state_waiting(int num_active, int num_held, uint8_t type,
+					const uint8_t *number, uint16_t len)
+{
+
+}
+
+static void phone_state_idle(int num_active, int num_held)
+{
+
+	update_indicator(IND_CALL, !!num_active);
+
+	if (device.ring) {
+		g_source_remove(device.ring);
+		device.ring = 0;
+	}
+
+	update_indicator(IND_CALLSETUP, 0);
+}
+
 static void handle_phone_state_change(const void *buf, uint16_t len)
 {
-	DBG("");
+	const struct hal_cmd_handsfree_phone_state_change *cmd = buf;
+	uint8_t status;
+
+	if (len != sizeof(*cmd) + cmd->number_len) {
+		error("Invalid phone state change command, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
+	DBG("active=%u hold=%u state=%u", cmd->num_active, cmd->num_held,
+								cmd->state);
+
+	switch (cmd->state) {
+	case HAL_HANDSFREE_CALL_STATE_ACTIVE:
+		phone_state_active(cmd->num_active, cmd->num_held);
+		break;
+	case HAL_HANDSFREE_CALL_STATE_HELD:
+		phone_state_held(cmd->num_active, cmd->num_held);
+		break;
+	case HAL_HANDSFREE_CALL_STATE_DIALING:
+		phone_state_dialing(cmd->num_active, cmd->num_held);
+		break;
+	case HAL_HANDSFREE_CALL_STATE_ALERTING:
+		phone_state_alerting(cmd->num_active, cmd->num_held);
+		break;
+	case HAL_HANDSFREE_CALL_STATE_INCOMING:
+		phone_state_incoming(cmd->num_active, cmd->num_held, cmd->type,
+						cmd->number, cmd->number_len);
+		break;
+	case HAL_HANDSFREE_CALL_STATE_WAITING:
+		phone_state_waiting(cmd->num_active, cmd->num_held, cmd->type,
+						cmd->number, cmd->number_len);
+		break;
+	case HAL_HANDSFREE_CALL_STATE_IDLE:
+		phone_state_idle(cmd->num_active, cmd->num_held);
+		break;
+	default:
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
 
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-					HAL_OP_HANDSFREE_PHONE_STATE_CHANGE,
-					HAL_STATUS_FAILED);
+				HAL_OP_HANDSFREE_PHONE_STATE_CHANGE, status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.8.5.3

