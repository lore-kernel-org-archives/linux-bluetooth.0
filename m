Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/8] android/handsfree: Add support for AT+BIA command
Date: Tue,  4 Mar 2014 16:32:09 +0100
Message-Id: <1393947130-11999-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 50b32da..99e786f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -71,6 +71,7 @@ static struct {
 	uint8_t state;
 	uint32_t features;
 	bool indicators_enabled;
+	bool active_ind[G_N_ELEMENTS(indicators)];
 	bool hsp;
 	struct hfp_gw *gw;
 } device;
@@ -106,8 +107,13 @@ static void device_set_state(uint8_t state)
 
 static void device_init(const bdaddr_t *bdaddr)
 {
+	unsigned int i;
+
 	bacpy(&device.bdaddr, bdaddr);
 
+	for (i = 0; i < G_N_ELEMENTS(device.active_ind); i++)
+		device.active_ind[i] = indicators[i].always_active;
+
 	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTING);
 }
 
@@ -138,6 +144,54 @@ static void disconnect_watch(void *user_data)
 	device_cleanup();
 }
 
+static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	unsigned int val, i = 0;
+
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		do {
+			if (!hfp_gw_result_get_number_default(result, &val, 0))
+				goto failed;
+
+			if (val > 1)
+				goto failed;
+		} while(hfp_gw_result_has_next(result));
+
+
+		do {
+			if (!hfp_gw_result_get_number(result, &val))
+				device.active_ind[i] = val ||
+						indicators[i].always_active;
+
+			if (++i == G_N_ELEMENTS(indicators))
+				break;
+		} while (hfp_gw_result_has_next(result));
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
+failed:
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void register_post_slc_at(void)
+{
+	if (device.hsp) {
+		/* TODO CKPD, VGS, VGM */
+		return;
+	}
+
+	hfp_gw_register(device.gw, at_cmd_bia, "+BIA", NULL, NULL);
+}
+
 static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
@@ -164,6 +218,7 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		device.indicators_enabled = val;
 
 		/* TODO Check for 3-way calling support */
+		register_post_slc_at();
 		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED);
 
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
@@ -253,6 +308,13 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
+static void register_slc_at(void)
+{
+	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", NULL, NULL);
+}
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	DBG("");
@@ -274,16 +336,15 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 
 	if (device.hsp) {
-		/* TODO CKPD, VGS, VGM */
+		register_post_slc_at();
 		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
 		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED);
-	} else {
-		hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
-		hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
-		hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", NULL, NULL);
-		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
+		return;
 	}
 
+	register_slc_at();
+	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
+
 	return;
 
 failed:
-- 
1.8.3.2

