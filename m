Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/hal: Add missing a2dp handler introduced in Android 5
Date: Fri, 21 Nov 2014 16:13:55 +0100
Message-Id: <1416582835-7712-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is added just to be fair with the IPC mechanism and this callback
should never be called by A2DP Source. It is valid for Sink role only.
---
 android/hal-a2dp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

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
-- 
1.9.1

