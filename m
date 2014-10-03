Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] android/hal-map-client-api: Add get remote MAS instance command and event
Date: Fri,  3 Oct 2014 16:04:00 +0200
Message-Id: <1412345044-30259-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412345044-30259-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412345044-30259-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 71969b5..b3ed28a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1072,6 +1072,13 @@ struct hal_cmd_hf_client_send_dtmf {
 
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
@@ -1916,3 +1923,19 @@ struct hal_ev_hf_client_last_void_call_tag_num {
 } __attribute__((packed));
 
 #define HAL_EV_CLIENT_RING_INDICATION			0x95
+
+#define HAL_EV_MAP_CLIENT_REMOTE_MAS_INSTANCES	0x81
+struct hal_map_client_mas_instance {
+	int32_t  id;
+	int32_t  scn;
+	int32_t  msg_types;
+	int32_t name_len;
+	uint8_t  name[0];
+} __attribute__((packed));
+
+struct hal_ev_map_client_remote_mas_instances {
+	int8_t status;
+	uint8_t bdaddr[6];
+	int32_t num_instances;
+	struct hal_map_client_mas_instance instances[0];
+} __attribute__((packed));
-- 
1.9.3

