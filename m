Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/main: Remove timeout source on exit
Date: Wed, 27 Nov 2013 18:19:11 +0200
Message-Id: <1385569154-11579-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385569154-11579-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385569154-11579-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes memory leak types of warnings from some tools.
---
 android/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index 830eef2..dd5c622 100644
--- a/android/main.c
+++ b/android/main.c
@@ -575,8 +575,10 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (!bt_bluetooth_start(option_index, adapter_ready))
+	if (!bt_bluetooth_start(option_index, adapter_ready)) {
+		g_source_remove(bluetooth_start_timeout);
 		return EXIT_FAILURE;
+	}
 
 	/* Use params: mtu = 0, flags = 0 */
 	start_sdp_server(0, 0);
@@ -589,6 +591,9 @@ int main(int argc, char *argv[])
 
 	g_source_remove(signal);
 
+	if (bluetooth_start_timeout > 0)
+		g_source_remove(bluetooth_start_timeout);
+
 	cleanup_hal_connection();
 	stop_sdp_server();
 	bt_bluetooth_cleanup();
-- 
1.8.3.2

