Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Fix Send Pass Through command
Date: Tue, 23 Dec 2014 15:29:23 +0100
Message-Id: <1419344963-25331-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parameter should be checked if it's given with (argc is lower than
expected). Third parameter can be auto completed with cached bluetooth
addresses.
---
 android/client/if-rc-ctrl.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/android/client/if-rc-ctrl.c b/android/client/if-rc-ctrl.c
index 52573a0..3980764 100644
--- a/android/client/if-rc-ctrl.c
+++ b/android/client/if-rc-ctrl.c
@@ -67,10 +67,13 @@ static void cleanup_p(int argc, const char **argv)
 }
 
 /* send_pass_through_cmd */
-
 static void send_pass_through_cmd_c(int argc, const char **argv,
 					enum_func *enum_func, void **user)
 {
+	if (argc == 3) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
 }
 
 static void send_pass_through_cmd_p(int argc, const char **argv)
@@ -81,15 +84,15 @@ static void send_pass_through_cmd_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_rc);
 	VERIFY_ADDR_ARG(2, &addr);
 
-	if (argc <= 4) {
-		haltest_error("No key code specified");
+	if (argc < 4) {
+		haltest_error("No key code specified\n");
 		return;
 	}
 
 	key_code = (uint8_t) atoi(argv[3]);
 
-	if (argc <= 5) {
-		haltest_error("No key state specified");
+	if (argc < 5) {
+		haltest_error("No key state specified\n");
 		return;
 	}
 
@@ -100,8 +103,7 @@ static void send_pass_through_cmd_p(int argc, const char **argv)
 
 static struct method methods[] = {
 	STD_METHOD(init),
-	STD_METHODCH(send_pass_through_cmd,
-					"<bd_addr> <key_code> <key_state>"),
+	STD_METHODCH(send_pass_through_cmd, "<bd_addr> <key_code> <key_state>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.9.3

