Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Fix segfault (invalid argv) for gatt scan
Date: Fri, 14 Mar 2014 13:46:06 +0100
Message-Id: <1394801166-5860-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix segfault driven by lack of 4 element in avrg array.
If user put only two arguments, reading of lacking (auto set to start=1)
third argument, will trigger segfault.
---
 android/client/if-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index e8837ff..17a491e 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -854,7 +854,7 @@ static void scan_p(int argc, const char **argv)
 	VERIFY_CLIENT_IF(2, client_if);
 
 	/* start */
-	if (argc >= 3)
+	if (argc >= 4)
 		start = atoi(argv[3]);
 
 	EXEC(if_gatt->client->scan, client_if, start);
-- 
1.8.5.2

