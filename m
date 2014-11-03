Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/client: Allow empty string for dial command
Date: Mon,  3 Nov 2014 13:36:18 +0100
Message-Id: <1415018178-32132-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Empty string is used for redial command
---
 android/client/if-hf-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index 1108639..a837401 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -533,7 +533,8 @@ static void dial_p(int argc, const char **argv)
 
 	/* number string */
 	if (argc <= 2) {
-		haltest_error("No number specified\n");
+		haltest_info("Number not specified. Redial\n");
+		EXEC(if_hf_client->dial, NULL);
 		return;
 	}
 
-- 
1.8.4

