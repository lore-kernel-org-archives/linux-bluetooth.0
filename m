Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Avoid memory leak warnings for event_loop
Date: Wed, 27 Nov 2013 17:17:44 +0200
Message-Id: <1385565464-3539-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move creation of event_loop closer to g_main_loop_run. This avoids
calling g_main_loop_unref too many times in initialization error paths.
This is safe since g_main_loop_quit eval to NOOP if parameter == NULL.
---
 android/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index c9733f3..9eaef7f 100644
--- a/android/main.c
+++ b/android/main.c
@@ -558,7 +558,6 @@ int main(int argc, char *argv[])
 		exit(EXIT_SUCCESS);
 	}
 
-	event_loop = g_main_loop_new(NULL, FALSE);
 	signal = setup_signalfd();
 	if (!signal)
 		return EXIT_FAILURE;
@@ -583,6 +582,8 @@ int main(int argc, char *argv[])
 
 	DBG("Entering main loop");
 
+	event_loop = g_main_loop_new(NULL, FALSE);
+
 	g_main_loop_run(event_loop);
 
 	g_source_remove(signal);
-- 
1.8.3.2

