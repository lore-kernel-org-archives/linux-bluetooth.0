Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 19/20] android/handsfree: Add support for AT+CLIP command
Date: Sat,  8 Mar 2014 01:20:03 +0100
Message-Id: <1394238004-15691-20-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index e07278c..2a081ef 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -109,6 +109,7 @@ static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
 	uint32_t features;
+	bool clip_enabled;
 	bool cmee_enabled;
 	bool indicators_enabled;
 	struct indicator inds[IND_COUNT];
@@ -468,9 +469,28 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	unsigned int val;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+			break;
+
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		device.clip_enabled = val;
+
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
@@ -1552,8 +1572,13 @@ done:
 
 static gboolean ring_cb(gpointer user_data)
 {
+	char *clip = user_data;
+
 	hfp_gw_send_info(device.gw, "+RING");
 
+	if (device.clip_enabled && clip)
+		hfp_gw_send_info(device.gw, "%s", clip);
+
 	return TRUE;
 }
 
@@ -1580,11 +1605,29 @@ static void phone_state_alerting(int num_active, int num_held)
 static void phone_state_incoming(int num_active, int num_held, uint8_t type,
 					const uint8_t *number, uint16_t len)
 {
+	char *clip = NULL;
+
 	update_indicator(IND_CALLSETUP, 1);
 
+	if (len) {
+		if (type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL &&
+							number[0] != '+')
+			clip = g_strdup_printf("+CLIP: \"+%.*s\",%u",
+							len, number, type );
+		else
+			clip = g_strdup_printf("+CLIP: \"%.*s\",%u",
+							len, number, type );
+	}
+
+	/* send first +RING */
+	ring_cb(clip);
+
 	device.ring = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
 							RING_TIMEOUT, ring_cb,
-							NULL, NULL);
+							clip, g_free);
+
+	if (!device.ring)
+		g_free(clip);
 }
 
 static void phone_state_waiting(int num_active, int num_held, uint8_t type,
-- 
1.8.5.3

