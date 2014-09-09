Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 35/39] android/hf-client: Add In Band Ringtone event
Date: Tue,  9 Sep 2014 21:57:20 +0200
Message-Id: <1410292644-23497-36-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 82d9b56..b0726d0 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -236,6 +236,14 @@ static void handle_subscriber_info(void *buf, uint16_t len, int fd)
 		cbs->subscriber_info_cb(name, ev->type);
 }
 
+static void handle_in_band_ringtone(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_inband_settings *ev = buf;
+
+	if (cbs->in_band_ring_tone_cb)
+		cbs->in_band_ring_tone_cb(ev->state);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -294,6 +302,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_CLIENT_SUBSCRIBER_SERVICE_INFO */
 	{ handle_subscriber_info, true,
 		sizeof(struct hal_ev_hf_client_subscriber_service_info) },
+	/* HAL_EV_CLIENT_INBAND_SETTINGS */
+	{ handle_in_band_ringtone, false,
+		sizeof(struct hal_ev_hf_client_inband_settings) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 85671a5..bb4620b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1856,3 +1856,11 @@ struct hal_ev_hf_client_subscriber_service_info {
 	uint16_t name_len;
 	uint8_t name[0];
 } __attribute__((packed));
+
+#define HF_CLIENT_INBAND_RINGTONE_NOT_PROVIDED	0x00
+#define HF_CLIENT_INBAND_RINGTONE_PROVIDED	0x01
+
+#define HAL_EV_CLIENT_INBAND_SETTINGS			0x93
+struct hal_ev_hf_client_inband_settings {
+	uint8_t state;
+} __attribute__((packed));
-- 
1.8.4

