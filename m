Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] android/main: Remove signal source on exit
Date: Thu, 28 Nov 2013 16:37:59 +0200
Message-Id: <1385649486-19978-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove signal source on exit and move check capability function in order
to avoid extra check.
---
 android/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index dd5c622..4dc3061 100644
--- a/android/main.c
+++ b/android/main.c
@@ -565,18 +565,22 @@ int main(int argc, char *argv[])
 
 	__btd_log_init("*", 0);
 
-	if (!set_capabilities())
+	if (!set_capabilities()) {
+		g_source_remove(signal);
 		return EXIT_FAILURE;
+	}
 
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

