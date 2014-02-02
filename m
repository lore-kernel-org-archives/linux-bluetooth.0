Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/13] android/handsfree: Add commands and events definition to IPC header
Date: Sun,  2 Feb 2014 22:09:13 +0100
Message-Id: <1391375364-27106-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index d46b428..56e1116 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -389,6 +389,130 @@ struct hal_cmd_pan_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+/* Handsfree HAL API */
+
+#define HAL_OP_HANDSFREE_CONNECT		0x01
+struct hal_cmd_handsfree_connect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_OP_HANDSFREE_DISCONNECT		0x02
+struct hal_cmd_handsfree_disconnect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_OP_HANDSFREE_CONNECT_AUDIO		0x03
+struct hal_cmd_handsfree_connect_audio {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_OP_HANDSFREE_DISCONNECT_AUDIO	0x04
+struct hal_cmd_handsfree_disconnect_audio {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_OP_HANDSFREE_START_VR		0x05
+
+#define HAL_OP_HANDSFREE_STOP_VR		0x06
+
+#define HAL_HANDSFREE_VOLUME_TYPE_SPEAKER	0x00
+#define HAL_HANDSFREE_VOLUME_TYPE_MIC		0x01
+
+#define HAL_OP_HANDSFREE_VOLUME_CONTROL		0x07
+struct hal_cmd_handsfree_volume_control {
+	uint8_t type;
+	uint32_t volume;
+} __attribute__((packed));
+
+#define HAL_HANDSFREE_NETWORK_STATE_NOT_AVAILABLE	0x00
+#define HAL_HANDSFREE_NETWORK_STATE_AVAILABLE		0x01
+
+#define HAL_HANDSFREE_SERVICE_TYPE_HOME		0x00
+#define HAL_HANDSFREE_SERVICE_TYPE_ROAMING	0x01
+
+#define HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF	0x08
+struct hal_cmd_handsfree_device_status_notif {
+	uint8_t state;
+	uint8_t type;
+	uint32_t signal;
+	uint32_t battery;
+} __attribute__((packed));
+
+#define HAL_OP_HANDSFREE_COPS_RESPONSE		0x09
+struct hal_cmd_handsfree_cops_response {
+	uint32_t len;
+	uint8_t buf[0];
+} __attribute__((packed));
+
+#define HAL_HANDSFREE_CALL_STATE_ACTIVE		0x00
+#define HAL_HANDSFREE_CALL_STATE_HELD		0x01
+#define HAL_HANDSFREE_CALL_STATE_DIALING	0x02
+#define HAL_HANDSFREE_CALL_STATE_ALERTING	0x03
+#define HAL_HANDSFREE_CALL_STATE_INCOMING	0x04
+#define HAL_HANDSFREE_CALL_STATE_WAITING	0x05
+#define HAL_HANDSFREE_CALL_STATE_IDLE		0x06
+
+#define HAL_OP_HANDSFREE_CIND_RESPONSE		0x0A
+struct hal_cmd_handsfree_cind_response {
+	uint32_t svc;
+	uint32_t num_active;
+	uint32_t num_held;
+	uint8_t state;
+	uint32_t signal;
+	uint32_t roam;
+	uint32_t batt_chg;
+} __attribute__((packed));
+
+#define HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE	0x0B
+struct hal_cmd_handsfree_formatted_at_response {
+	uint32_t len;
+	uint8_t buf[0];
+} __attribute__((packed));
+
+#define HAL_HANDSFREE_AT_RESPONSE_ERROR		0x00
+#define HAL_HANDSFREE_AT_RESPONSE_OK		0x01
+
+#define HAL_OP_HANDSFREE_AT_RESPONSE		0x0C
+struct hal_cmd_handsfree_at_response {
+	uint8_t response;
+	uint32_t error;
+} __attribute__((packed));
+
+#define HAL_HANDSFREE_CALL_DIRECTION_OUTGOING	0x00
+#define HAL_HANDSFREE_CALL_DIRECTION_INCOMING	0x01
+
+#define HAL_HANDSFREE_CALL_TYPE_VOICE		0x00
+#define HAL_HANDSFREE_CALL_TYPE_DATA		0x01
+#define HAL_HANDSFREE_CALL_TYPE_FAX		0x02
+
+#define HAL_HANDSFREE_CALL_MPTY_TYPE_SINGLE	0x00
+#define HAL_HANDSFREE_CALL_MPTY_TYPE_MULTI	0x01
+
+#define HAL_HANDSFREE_CALL_ADDRTYPE_UNKNOWN	0x81
+#define HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL	0x91
+
+#define HAL_OP_HANDSFREE_CLCC_RESPONSE		0x0D
+struct hal_cmd_handsfree_clcc_response {
+	uint32_t index;
+	uint8_t dir;
+	uint8_t state;
+	uint8_t mode;
+	uint8_t mpty;
+	uint8_t type;
+	uint32_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
+
+#define HAL_OP_HANDSFREE_PHONE_STATE_CHANGE	0x0E
+struct hal_cmd_handsfree_phone_state_change {
+	uint32_t num_active;
+	uint32_t num_held;
+	uint8_t state;
+	uint8_t type;
+	uint32_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
@@ -572,3 +696,87 @@ struct hal_ev_a2dp_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED	0x00
+#define HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTING	0x01
+#define HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED	0x02
+#define HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED	0x03
+#define HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING	0x04
+
+#define HAL_EV_HANDSFREE_CONN_STATE		0x81
+struct hal_ev_handsfree_conn_state {
+	uint8_t state;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED	0x00
+#define HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING		0x01
+#define HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED		0x02
+#define HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING	0x03
+
+#define HAL_EV_HANDSFREE_AUDIO_STATE		0x82
+struct hal_ev_handsfree_audio_state {
+	uint8_t state;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_EV_HANDSFREE_VR		0x83
+struct hal_ev_handsfree_vr_state {
+	uint8_t state;
+} __attribute__((packed));
+
+#define HAL_EV_HANDSFREE_ANSWER		0x84
+
+#define HAL_EV_HANDSFREE_HANGUP		0x85
+
+#define HAL_EV_HANDSFREE_VOLUME		0x86
+struct hal_ev_handsfree_volume {
+	uint8_t type;
+	uint32_t volume;
+} __attribute__((packed));
+
+#define HAL_EV_HANDSFREE_DIAL		0x87
+struct hal_ev_handsfree_dial {
+	uint32_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
+
+#define HAL_EV_HANDSFREE_DTMF		0x88
+struct hal_ev_handsfree_dtmf {
+	uint8_t tone;
+} __attribute__((packed));
+
+#define HAL_HANDSFREE_NREC_STOP		0x00
+#define HAL_HANDSFREE_NREC_STart	0x01
+
+#define HAL_EV_HANDSFREE_NREC		0x89
+struct hal_ev_handsfree_nrec {
+	uint8_t nrec;
+} __attribute__((packed));
+
+#define HAL_HANDSFREE_CHLD_TYPE_RELEASEHELD			0x00
+#define HAL_HANDSFREE_CHLD_TYPE_RELEASEACTIVE_ACCEPTHELD	0x01
+#define HAL_HANDSFREE_CHLD_TYPE_HOLDACTIVE_ACCEPTHELD		0x02
+#define HAL_HANDSFREE_CHLD_TYPE_ADDHELDTOCONF			0x03
+
+#define HAL_EV_HANDSFREE_CHLD		0x8A
+struct hal_ev_handsfree_chld {
+	uint8_t chld;
+} __attribute__((packed));
+
+
+#define HAL_EV_HANDSFREE_CNUM		0x8B
+
+#define HAL_EV_HANDSFREE_CIND		0x8C
+
+#define HAL_EV_HANDSFREE_COPS		0x8D
+
+#define HAL_EV_HANDSFREE_CLCC		0x8E
+
+#define HAL_EV_HANDSFREE_UNKNOWN_AT	0x8F
+struct hal_ev_handsfree_unknown_at {
+	uint32_t len;
+	uint8_t buf[0];
+} __attribute__((packed));
+
+#define HAL_EV_HANDSFREE_HSP_KEY_PRESS	0x90
-- 
1.8.5.3

