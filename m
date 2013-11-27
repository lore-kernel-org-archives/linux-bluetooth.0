Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/main: Remove signal source on exit
Date: Wed, 27 Nov 2013 16:54:16 +0200
Message-Id: <1385564056-2289-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove signal source on exit and move check capability function in order
to avoid extra check.
---
 android/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/android/main.c b/android/main.c
index 79e17fe..0f478c7 100644
--- a/android/main.c
+++ b/android/main.c
@@ -535,6 +535,9 @@ int main(int argc, char *argv[])
 	GError *err = NULL;
 	guint signal;
 
+	if (!set_capabilities())
+		return EXIT_FAILURE;
+
 	/* Core Service (ID=0) should always be considered registered */
 	services[0] = true;
 
@@ -564,18 +567,17 @@ int main(int argc, char *argv[])
 
 	__btd_log_init("*", 0);
 
-	if (!set_capabilities())
-		return EXIT_FAILURE;
-
 	bluetooth_start_timeout = g_timeout_add_seconds(STARTUP_GRACE_SECONDS,
 							quit_eventloop, NULL);
 	if (bluetooth_start_timeout == 0) {
 		error("Failed to init startup timeout");
+		g_source_remove(signal);
 		return EXIT_FAILURE;
 	}
 
 	if (!bt_bluetooth_start(option_index, adapter_ready)) {
 		g_source_remove(bluetooth_start_timeout);
+		g_source_remove(signal);
 		return EXIT_FAILURE;
 	}
 
-- 
1.8.3.2

