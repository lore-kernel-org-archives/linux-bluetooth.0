Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] android/handsfree: Fix possible g_io_channel_shutdown() on NULL channel
Date: Fri,  7 Mar 2014 21:23:16 +0100
Message-Id: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return false if listen failed.
---
 android/handsfree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index dc5c73d..fa27f10 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1192,7 +1192,7 @@ static bool enable_hfp_ag(void)
 	if (!hfp_server) {
 		error("Failed to listen on Handsfree rfcomm: %s", err->message);
 		g_error_free(err);
-		goto failed;
+		return false;
 	}
 
 	rec = hfp_ag_record();
-- 
1.8.3.1

