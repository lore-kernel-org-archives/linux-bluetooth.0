Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/client: Fix help for handsfree haltest tool
Date: Wed, 12 Nov 2014 17:14:28 +0200
Message-Id: <1415805269-6838-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-hf.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index b0dd13a..c64d412 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -976,25 +976,44 @@ static void cleanup_p(int argc, const char **argv)
 }
 
 static struct method methods[] = {
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	STD_METHODH(init, "[<max_hf_clients>]"),
+	STD_METHODH(start_voice_recognition, "<addr>"),
+	STD_METHODH(stop_voice_recognition, "<addr>"),
+	STD_METHODCH(volume_control, "<vol_type> <volume> <addr>"),
+	STD_METHODH(cops_response, "<cops string> <addr>"),
+	STD_METHODCH(cind_response,
+			"<svc> <num_active> <num_held> <setup_state> <signal> "
+			"<roam> <batt_chg> <addr>"),
+	STD_METHODH(formatted_at_response, "<at_response> <addr>"),
+	STD_METHODCH(at_response, "<response_code> [<error_code> <bdaddr>]"),
+	STD_METHODCH(clcc_response,
+			"<index> <direction> <state> <mode> <mpty> <number> "
+			"<type> <addr>"),
+#else
 	STD_METHOD(init),
-	STD_METHODCH(connect, "<addr>"),
-	STD_METHODCH(disconnect, "<addr>"),
-	STD_METHODCH(connect_audio, "<addr>"),
-	STD_METHODCH(disconnect_audio, "<addr>"),
 	STD_METHOD(start_voice_recognition),
 	STD_METHOD(stop_voice_recognition),
 	STD_METHODCH(volume_control, "<vol_type> <volume>"),
-	STD_METHODCH(device_status_notification,
-			"<ntk_state> <svt_type> <signal> <batt_chg>"),
 	STD_METHODH(cops_response, "<cops string>"),
 	STD_METHODCH(cind_response,
-			"<svc> <num_active> <num_held> <setup_state> <signal> <roam> <batt_chg>"),
+			"<svc> <num_active> <num_held> <setup_state> <signal> "
+			"<roam> <batt_chg>"),
 	STD_METHODH(formatted_at_response, "<at_response>"),
 	STD_METHODCH(at_response, "<response_code> [<error_code>]"),
 	STD_METHODCH(clcc_response,
-			"<index> <direction> <state> <mode> <mpty> <number> <type>"),
+			"<index> <direction> <state> <mode> <mpty> <number> "
+			"<type>"),
+#endif
+	STD_METHODCH(connect, "<addr>"),
+	STD_METHODCH(disconnect, "<addr>"),
+	STD_METHODCH(connect_audio, "<addr>"),
+	STD_METHODCH(disconnect_audio, "<addr>"),
+	STD_METHODCH(device_status_notification,
+			"<ntk_state> <svt_type> <signal> <batt_chg>"),
 	STD_METHODCH(phone_state_change,
-			"<num_active> <num_held> <setup_state> <number> <type>"),
+			"<num_active> <num_held> <setup_state> <number> "
+			"<type>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.9.1

