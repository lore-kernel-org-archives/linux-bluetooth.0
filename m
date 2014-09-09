Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 36/39] android/hf-client: Add Last Voice Tag Number event
Date: Tue,  9 Sep 2014 21:57:21 +0200
Message-Id: <1410292644-23497-37-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 22 ++++++++++++++++++++++
 android/hal-msg.h       |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index b0726d0..ff3c050 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -244,6 +244,25 @@ static void handle_in_band_ringtone(void *buf, uint16_t len, int fd)
 		cbs->in_band_ring_tone_cb(ev->state);
 }
 
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
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -305,6 +324,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_CLIENT_INBAND_SETTINGS */
 	{ handle_in_band_ringtone, false,
 		sizeof(struct hal_ev_hf_client_inband_settings) },
+	/* HAL_EV_CLIENT_LAST_VOICE_CALL_TAG_NUM */
+	{ handle_last_voice_tag_number, true,
+		sizeof(struct hal_ev_hf_client_last_void_call_tag_num) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bb4620b..f09dcf0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1864,3 +1864,9 @@ struct hal_ev_hf_client_subscriber_service_info {
 struct hal_ev_hf_client_inband_settings {
 	uint8_t state;
 } __attribute__((packed));
+
+#define HAL_EV_CLIENT_LAST_VOICE_CALL_TAG_NUM		0x94
+struct hal_ev_hf_client_last_void_call_tag_num {
+	uint16_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
-- 
1.8.4

