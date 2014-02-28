Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/6] android/client: Add AVRCP get_play_status_rsp support
Date: Fri, 28 Feb 2014 20:58:43 +0200
Message-Id: <1393613928-22264-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 58fb892..7da26e6 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -15,11 +15,27 @@
  *
  */
 
+#include<stdio.h>
+#include<ctype.h>
+
+#include<hardware/bluetooth.h>
+#include<hardware/bt_hh.h>
+
 #include "if-main.h"
+#include "pollhandler.h"
 #include "../hal-utils.h"
 
 const btrc_interface_t *if_rc = NULL;
 
+SINTMAP(btrc_play_status_t, -1, "(unknown)")
+	DELEMENT(BTRC_PLAYSTATE_STOPPED),
+	DELEMENT(BTRC_PLAYSTATE_PLAYING),
+	DELEMENT(BTRC_PLAYSTATE_PAUSED),
+	DELEMENT(BTRC_PLAYSTATE_FWD_SEEK),
+	DELEMENT(BTRC_PLAYSTATE_REV_SEEK),
+	DELEMENT(BTRC_PLAYSTATE_ERROR),
+ENDMAP
+
 static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 };
@@ -33,6 +49,46 @@ static void init_p(int argc, const char **argv)
 	EXEC(if_rc->init, &rc_cbacks);
 }
 
+/* get_play_status_rsp */
+
+static void get_play_status_rsp_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = TYPE_ENUM(btrc_play_status_t);
+		*enum_func = enum_defines;
+	}
+}
+
+static void get_play_status_rsp_p(int argc, const char **argv)
+{
+	btrc_play_status_t play_status;
+	uint32_t song_len, song_pos;
+
+	RETURN_IF_NULL(if_rc);
+
+	if (argc <= 2) {
+		haltest_error("No play status specified");
+		return;
+	}
+
+	if (argc <= 3) {
+		haltest_error("No song length specified");
+		return;
+	}
+
+	if (argc <= 4) {
+		haltest_error("No song position specified");
+		return;
+	}
+
+	play_status = str2btrc_play_status_t(argv[2]);
+	song_len = (uint32_t) atoi(argv[3]);
+	song_pos = (uint32_t) atoi(argv[4]);
+
+	EXEC(if_rc->get_play_status_rsp, play_status, song_len, song_pos);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -45,6 +101,8 @@ static void cleanup_p(int argc, const char **argv)
 
 static struct method methods[] = {
 	STD_METHOD(init),
+	STD_METHODCH(get_play_status_rsp,
+					"<play_status> <song_len> <song_pos>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

