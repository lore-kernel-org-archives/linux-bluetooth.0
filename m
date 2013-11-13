Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/hidhost: Fix memory leak
Date: Wed, 13 Nov 2013 16:29:33 +0200
Message-Id: <1384352974-24036-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hidhost.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 910014f..ff3eae0 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1136,6 +1136,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	if (err) {
 		error("%s", gerr->message);
 		g_io_channel_shutdown(chan, TRUE, NULL);
+		g_error_free(gerr);
 		return;
 	}
 
-- 
1.7.10.4

