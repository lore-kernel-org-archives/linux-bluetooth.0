Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/3] android/client: Add av audio config callback
Date: Wed, 19 Nov 2014 14:10:06 +0100
Message-Id: <1416402606-31762-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416402606-31762-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416402606-31762-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is Android 5 API callback.
---
 android/client/if-av.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/android/client/if-av.c b/android/client/if-av.c
index 8d1f69b..85c641b 100644
--- a/android/client/if-av.c
+++ b/android/client/if-av.c
@@ -50,10 +50,22 @@ static void audio_state(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
 					bt_bdaddr_t2str(bd_addr, last_addr));
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void audio_config(bt_bdaddr_t *bd_addr, uint32_t sample_rate,
+							uint8_t channel_count) {
+	haltest_info("%s: remote_addr=%s\n sample_rate=%d\n channel_count=%d\n",
+				__func__, bt_bdaddr_t2str(bd_addr, last_addr),
+				sample_rate, channel_count);
+}
+#endif
+
 static btav_callbacks_t av_cbacks = {
 	.size = sizeof(av_cbacks),
 	.connection_state_cb = connection_state,
-	.audio_state_cb = audio_state
+	.audio_state_cb = audio_state,
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	.audio_config_cb = audio_config,
+#endif
 };
 
 /* init */
-- 
1.9.1

