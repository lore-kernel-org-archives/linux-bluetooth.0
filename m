Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 1/5] android/client/health: Introduce close_channel API.
Date: Fri, 27 Jun 2014 00:30:42 +0300
Message-Id: <1403818246-20205-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to run PTS MDL disconnect and reconnect, HAL api does
not support it. This close simply shutdown the fd, remote device
will be notified like data channel is closed not deleted. So ready
for reconnection.
---
 android/client/if-hl.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 34e8b27..949c574 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -275,6 +275,34 @@ static void destroy_channel_p(int argc, const char **argv)
 	EXEC(if_hl->destroy_channel, channel_id);
 }
 
+/* close_channel */
+
+static void close_channel_p(int argc, const char **argv)
+{
+	uint32_t app_id;
+	uint8_t mdep_cfg_index;
+
+	RETURN_IF_NULL(if_hl);
+
+	if (argc <= 2) {
+		haltest_error("No app id is specified");
+		return;
+	}
+
+	if (argc <= 3) {
+		haltest_error("No mdep_cfg_index is specified");
+		return;
+	}
+
+	app_id = (uint32_t) atoi(argv[2]);
+	mdep_cfg_index = (uint8_t) atoi(argv[3]);
+
+	if (app_info[app_id][mdep_cfg_index][2] >= 0) {
+		shutdown(app_info[app_id][mdep_cfg_index][2], SHUT_RDWR);
+		app_info[app_id][mdep_cfg_index][2] = -1;
+	}
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -295,6 +323,7 @@ static struct method methods[] = {
 	STD_METHODH(unregister_application, "<app_id>"),
 	STD_METHODH(connect_channel, "<app_id> <bd_addr> <mdep_cfg_index>"),
 	STD_METHODH(destroy_channel, "<channel_id>"),
+	STD_METHODH(close_channel, "<app_id> <mdep_cfg_index>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.9.1

