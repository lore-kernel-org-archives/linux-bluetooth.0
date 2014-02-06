Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client-av: Close audio output stream on a2dp disconnection
Date: Thu,  6 Feb 2014 10:06:01 +0100
Message-Id: <1391677561-5522-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes haltest's audio part aware of a2dp disconnection and
closes audio output stream. This fixes the issue with CPU cycles being
eaten up by playback thread still trying to send audio data after
disconnection.
---
 android/client/if-av.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/client/if-av.c b/android/client/if-av.c
index 8d1f69b..ef1d997 100644
--- a/android/client/if-av.c
+++ b/android/client/if-av.c
@@ -41,6 +41,13 @@ static void connection_state(btav_connection_state_t state,
 	haltest_info("%s: connection_state=%s remote_bd_addr=%s\n", __func__,
 					btav_connection_state_t2str(state),
 					bt_bdaddr_t2str(bd_addr, last_addr));
+
+	if (state == BTAV_CONNECTION_STATE_DISCONNECTED) {
+		const struct method *m = get_interface_method("audio",
+							"close_output_stream");
+		if (m)
+			m->func(0, NULL);
+	}
 }
 
 static void audio_state(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
-- 
1.8.5.2

