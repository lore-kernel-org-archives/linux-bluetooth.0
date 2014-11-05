Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/client: Print number on query current calls in hf-client
Date: Wed,  5 Nov 2014 15:39:14 +0100
Message-Id: <1415198354-3470-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hf-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index c383cab..3f6f7c2 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -312,6 +312,9 @@ static void hf_client_current_calls_callback(int index,
 					bthf_client_call_direction_t2str(dir),
 					bthf_client_call_state_t2str(state),
 					bthf_client_call_mpty_type_t2str(mpty));
+
+	if (number)
+		haltest_info("%s: number=%s\n", __func__, number);
 }
 
 /* Callback for audio volume change */
-- 
1.8.4

