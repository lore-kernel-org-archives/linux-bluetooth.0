Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/5] android/client: Handle handsfree client audio state change callback
Date: Tue, 23 Sep 2014 08:49:38 +0200
Message-Id: <1411454980-27225-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hf-client.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index 528609d..df40112 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -30,6 +30,13 @@ SINTMAP(bthf_client_connection_state_t, -1, "(unknown)")
 	DELEMENT(BTHF_CLIENT_CONNECTION_STATE_DISCONNECTING),
 ENDMAP
 
+SINTMAP(bthf_client_audio_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_AUDIO_STATE_DISCONNECTED),
+	DELEMENT(BTHF_CLIENT_AUDIO_STATE_CONNECTING),
+	DELEMENT(BTHF_CLIENT_AUDIO_STATE_CONNECTED),
+	DELEMENT(BTHF_CLIENT_AUDIO_STATE_CONNECTED_MSBC),
+ENDMAP
+
 /* Callbacks */
 
 static char features_str[512];
@@ -103,7 +110,9 @@ static void hf_client_connection_state_callback(
 static void hf_client_audio_state_callback(bthf_client_audio_state_t state,
 							bt_bdaddr_t *bd_addr)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
+				bthf_client_audio_state_t2str(state),
+				bt_bdaddr_t2str(bd_addr, last_addr));
 }
 
 /* Callback for VR connection state change. */
-- 
1.9.1

