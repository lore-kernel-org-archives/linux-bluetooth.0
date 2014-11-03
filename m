Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/client: Fix copy paste issue in stop recognition function
Date: Mon,  3 Nov 2014 14:49:53 +0100
Message-Id: <1415022593-25530-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hf-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index a837401..3f6f7c2 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -489,7 +489,7 @@ static void stop_voice_recognition_p(int argc, const char **argv)
 {
 	RETURN_IF_NULL(if_hf_client);
 
-	EXEC(if_hf_client->start_voice_recognition);
+	EXEC(if_hf_client->stop_voice_recognition);
 }
 
 static void volume_control_c(int argc, const char **argv, enum_func *enum_func,
-- 
1.8.4

