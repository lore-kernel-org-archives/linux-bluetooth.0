Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 8/8] android/handsfree: Make connection state constants name shorter
Date: Tue,  4 Mar 2014 16:32:10 +0100
Message-Id: <1393947130-11999-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h   | 10 +++++-----
 android/handsfree.c | 26 +++++++++++++-------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index dd25f6e..886b5d3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -979,11 +979,11 @@ struct hal_ev_a2dp_audio_state {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED	0x00
-#define HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTING	0x01
-#define HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED	0x02
-#define HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED	0x03
-#define HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING	0x04
+#define HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED	0x00
+#define HAL_EV_HANDSFREE_CONN_STATE_CONNECTING		0x01
+#define HAL_EV_HANDSFREE_CONN_STATE_CONNECTED		0x02
+#define HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED	0x03
+#define HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING	0x04
 
 #define HAL_EV_HANDSFREE_CONN_STATE		0x81
 struct hal_ev_handsfree_conn_state {
diff --git a/android/handsfree.c b/android/handsfree.c
index 99e786f..6f91e74 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -114,7 +114,7 @@ static void device_init(const bdaddr_t *bdaddr)
 	for (i = 0; i < G_N_ELEMENTS(device.active_ind); i++)
 		device.active_ind[i] = indicators[i].always_active;
 
-	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTING);
+	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
 }
 
 static void device_cleanup(void)
@@ -124,7 +124,7 @@ static void device_cleanup(void)
 		device.gw = NULL;
 	}
 
-	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED);
+	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED);
 
 	memset(&device, 0, sizeof(device));
 }
@@ -133,7 +133,7 @@ static void at_command_handler(const char *command, void *user_data)
 {
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 
-	if (device.state != HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED)
+	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
 		hfp_gw_disconnect(device.gw);
 }
 
@@ -219,7 +219,7 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 		/* TODO Check for 3-way calling support */
 		register_post_slc_at();
-		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED);
+		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
 
@@ -337,13 +337,13 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	if (device.hsp) {
 		register_post_slc_at();
-		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
-		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED);
+		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
+		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	}
 
 	register_slc_at();
-	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
+	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
 
 	return;
 
@@ -370,7 +370,7 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 
 	DBG("incoming connect from %s", address);
 
-	if (device.state != HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED) {
+	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
 		info("handsfree: refusing connection from %s", address);
 		goto drop;
 	}
@@ -572,7 +572,7 @@ static void handle_connect(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (device.state != HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED) {
+	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -610,22 +610,22 @@ static void handle_disconnect(const void *buf, uint16_t len)
 
 	android2bdaddr(cmd->bdaddr, &bdaddr);
 
-	if (device.state == HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED ||
+	if (device.state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED ||
 			bacmp(&device.bdaddr, &bdaddr)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 
 	}
 
-	if (device.state == HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING) {
+	if (device.state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING) {
 		status = HAL_STATUS_SUCCESS;
 		goto failed;
 	}
 
-	if (device.state == HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTING) {
+	if (device.state == HAL_EV_HANDSFREE_CONN_STATE_CONNECTING) {
 		device_cleanup();
 	} else {
-		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING);
+		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING);
 		hfp_gw_disconnect(device.gw);
 	}
 
-- 
1.8.3.2

