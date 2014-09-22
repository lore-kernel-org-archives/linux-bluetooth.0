Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/hal-mce-api: Add get remote MAS instance command and event
Date: Mon, 22 Sep 2014 13:01:44 +0200
Message-Id: <1411383708-28621-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index ba213b7..ca5f5a1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1051,6 +1051,13 @@ struct hal_cmd_hf_client_send_dtmf {
 
 #define HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM	0x0f
 
+/* MAP CLIENT HAL API */
+
+#define HAL_OP_MAP_CLIENT_GET_INSTANCES	0x01
+struct hal_cmd_map_client_get_instances {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
@@ -1695,3 +1702,19 @@ struct hal_ev_gatt_server_rsp_confirmation {
 #define HAL_GATT_AUTHENTICATION_NONE		0
 #define HAL_GATT_AUTHENTICATION_NO_MITM		1
 #define HAL_GATT_AUTHENTICATION_MITM		2
+
+#define HAL_EV_MAP_CLIENT_REMOTE_MAS_INSTANCES	0x81
+struct hal_map_client_mas_instance {
+	uint8_t  id;
+	uint8_t  scn;
+	uint8_t  msg_types;
+	uint16_t name_len;
+	uint8_t  name[0];
+} __attribute__((packed));
+
+struct hal_ev_map_client_remote_mas_instances {
+	int32_t status;
+	uint8_t bdaddr[6];
+	int32_t num_instances;
+	struct hal_map_client_mas_instance instances[0];
+} __attribute__((packed));
-- 
1.9.3

