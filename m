Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/3] android/hal: Add av callbacks for Android 5 API
Date: Wed, 19 Nov 2014 14:10:05 +0100
Message-Id: <1416402606-31762-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416402606-31762-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416402606-31762-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android 5 adds audio configuration callback.
---
 android/hal-a2dp.c | 13 +++++++++++++
 android/hal-msg.h  |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index 3556218..ca92b0e 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -48,6 +48,17 @@ static void handle_audio_state(void *buf, uint16_t len, int fd)
 		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *)(ev->bdaddr));
 }
 
+static void handle_audio_config(void *buf, uint16_t len, int fd)
+{
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	struct hal_ev_a2dp_audio_config *ev = buf;
+
+	if (cbs->audio_config_cb)
+		cbs->audio_config_cb((bt_bdaddr_t *)(ev->bdaddr),
+					ev->sample_rate, ev->channel_count);
+#endif
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -57,6 +68,8 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	{ handle_conn_state, false, sizeof(struct hal_ev_a2dp_conn_state) },
 	/* HAL_EV_A2DP_AUDIO_STATE */
 	{ handle_audio_state, false, sizeof(struct hal_ev_a2dp_audio_state) },
+	/* HAL_EV_A2DP_AUDIO_CONFIG */
+	{ handle_audio_config, false, sizeof(struct hal_ev_a2dp_audio_config) },
 };
 
 static bt_status_t a2dp_connect(bt_bdaddr_t *bd_addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9087571..402fc3c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1468,6 +1468,13 @@ struct hal_ev_a2dp_audio_state {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_EV_A2DP_AUDIO_CONFIG		0x83
+struct hal_ev_a2dp_audio_config {
+	uint8_t  bdaddr[6];
+	uint32_t sample_rate;
+	uint8_t  channel_count;
+} __attribute__((packed));
+
 #define HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED	0x00
 #define HAL_EV_HANDSFREE_CONN_STATE_CONNECTING		0x01
 #define HAL_EV_HANDSFREE_CONN_STATE_CONNECTED		0x02
-- 
1.9.1

