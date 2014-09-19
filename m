Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 6/6] android/handsfree-client: Implement hf client events
Date: Fri, 19 Sep 2014 16:30:51 +0200
Message-Id: <1411137051-28904-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implemets skeleton for following events:
1. Volume Changed event
2. Command Complete event
3. Subscriber Info event
4. In Band Ringtone event
5. Last Voice Tag Number event
6. RING notification event
---
 android/hal-handsfree-client.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h              | 48 ++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 0987221..b2d072b 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -201,6 +201,74 @@ static void handle_current_calls(void *buf, uint16_t len, int fd)
 							ev->multiparty, number);
 }
 
+static void handle_volume_change(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_volume_changed *ev = buf;
+
+	if (cbs->volume_change_cb)
+		cbs->volume_change_cb(ev->type, ev->volume);
+}
+
+static void handle_command_cmp(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_command_complete *ev = buf;
+
+	if (cbs->cmd_complete_cb)
+		cbs->cmd_complete_cb(ev->type, ev->cme);
+}
+
+static void handle_subscriber_info(void *buf, uint16_t len, int fd)
+{
+	const struct hal_ev_hf_client_subscriber_service_info *ev = buf;
+	uint16_t name_len = ev->name_len;
+	char *name = NULL;
+
+	if (len != sizeof(*ev) + name_len ||
+		(name_len != 0 && ev->name[name_len - 1] != '\0')) {
+		error("invalid sunscriber info, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (name_len)
+		name = (char *) ev->name;
+
+	if (cbs->subscriber_info_cb)
+		cbs->subscriber_info_cb(name, ev->type);
+}
+
+static void handle_in_band_ringtone(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_inband_settings *ev = buf;
+
+	if (cbs->in_band_ring_tone_cb)
+		cbs->in_band_ring_tone_cb(ev->state);
+}
+
+static void handle_last_voice_tag_number(void *buf, uint16_t len, int fd)
+{
+	const struct hal_ev_hf_client_last_void_call_tag_num *ev = buf;
+	char *number = NULL;
+	uint16_t num_len = ev->number_len;
+
+	if (len != sizeof(*ev) + num_len ||
+		(num_len != 0 && ev->number[num_len - 1] != '\0')) {
+		error("invalid voice tag, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (num_len)
+		number = (char *) ev->number;
+
+	if (cbs->last_voice_tag_number_callback)
+		cbs->last_voice_tag_number_callback(number);
+}
+
+static void handle_ring_indication(void *buf, uint16_t len, int fd)
+{
+	if (cbs->ring_indication_cb)
+		cbs->ring_indication_cb();
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -250,6 +318,23 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_CURRENT_CALL */
 	{ handle_current_calls, true,
 			sizeof(struct hal_ev_hf_client_current_call) },
+	/* HAL_EV_CLIENT_VOLUME_CHANGED */
+	{ handle_volume_change, false,
+			sizeof(struct hal_ev_hf_client_volume_changed) },
+	/* HAL_EV_CLIENT_COMMAND_COMPLETE */
+	{ handle_command_cmp, false,
+			sizeof(struct hal_ev_hf_client_command_complete) },
+	/* HAL_EV_CLIENT_SUBSCRIBER_SERVICE_INFO */
+	{ handle_subscriber_info, true,
+		sizeof(struct hal_ev_hf_client_subscriber_service_info) },
+	/* HAL_EV_CLIENT_INBAND_SETTINGS */
+	{ handle_in_band_ringtone, false,
+		sizeof(struct hal_ev_hf_client_inband_settings) },
+	/* HAL_EV_CLIENT_LAST_VOICE_CALL_TAG_NUM */
+	{ handle_last_voice_tag_number, true,
+		sizeof(struct hal_ev_hf_client_last_void_call_tag_num) },
+	/* HAL_EV_CLIENT_RING_INDICATION */
+	{ handle_ring_indication, false, 0 },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 6cd6713..46c2e2b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1847,3 +1847,51 @@ struct hal_ev_hf_client_current_call {
 	uint16_t number_len;
 	uint8_t number[0];
 } __attribute__((packed));
+
+#define HAL_EV_CLIENT_VOLUME_CHANGED			0x90
+struct hal_ev_hf_client_volume_changed {
+	uint8_t type;
+	uint8_t volume;
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_CMD_COMP_OK			0x00
+#define HAL_HF_CLIENT_CMD_COMP_ERR			0x01
+#define HAL_HF_CLIENT_CMD_COMP_ERR_NO_CARRIER		0x02
+#define HAL_HF_CLIENT_CMD_COMP_ERR_BUSY			0x03
+#define HAL_HF_CLIENT_CMD_COMP_ERR_NO_ANSWER		0x04
+#define HAL_HF_CLIENT_CMD_COMP_ERR_DELAYED		0x05
+#define HAL_HF_CLIENT_CMD_COMP_ERR_BACKLISTED		0x06
+#define HAL_HF_CLIENT_CMD_COMP_ERR_CME			0x07
+
+#define HAL_EV_CLIENT_COMMAND_COMPLETE			0x91
+struct hal_ev_hf_client_command_complete {
+	uint8_t type;
+	uint8_t cme;
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_SUBSCR_TYPE_UNKNOWN	0x00
+#define HAL_HF_CLIENT_SUBSCR_TYPE_VOICE		0x01
+#define HAL_HF_CLIENT_SUBSCR_TYPE_FAX		0x02
+
+#define HAL_EV_CLIENT_SUBSCRIBER_SERVICE_INFO		0x92
+struct hal_ev_hf_client_subscriber_service_info {
+	uint8_t type;
+	uint16_t name_len;
+	uint8_t name[0];
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_INBAND_RINGTONE_NOT_PROVIDED	0x00
+#define HAL_HF_CLIENT_INBAND_RINGTONE_PROVIDED		0x01
+
+#define HAL_EV_CLIENT_INBAND_SETTINGS			0x93
+struct hal_ev_hf_client_inband_settings {
+	uint8_t state;
+} __attribute__((packed));
+
+#define HAL_EV_CLIENT_LAST_VOICE_CALL_TAG_NUM		0x94
+struct hal_ev_hf_client_last_void_call_tag_num {
+	uint16_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
+
+#define HAL_EV_CLIENT_RING_INDICATION			0x95
-- 
1.8.4

