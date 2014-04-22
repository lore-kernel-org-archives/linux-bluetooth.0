Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 10/11] android/client: Add destroy_channel support to haltest
Date: Tue, 22 Apr 2014 15:06:09 +0300
Message-Id: <1398168371-29685-11-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 16a3d16..6b3e341 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -220,6 +220,24 @@ static void connect_channel_p(int argc, const char **argv)
 								&channel_id);
 }
 
+/* destroy_channel */
+
+static void destroy_channel_p(int argc, const char **argv)
+{
+	uint32_t channel_id;
+
+	RETURN_IF_NULL(if_hl);
+
+	if (argc <= 2) {
+		haltest_error("No channel id is specified");
+		return;
+	}
+
+	channel_id = (uint32_t) atoi(argv[2]);
+
+	EXEC(if_hl->destroy_channel, channel_id);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -239,6 +257,7 @@ static struct method methods[] = {
 		"[<mdep_role> <data_type> <channel_type> <mdep_descr>] ..."),
 	STD_METHODH(unregister_application, "<app_id>"),
 	STD_METHODH(connect_channel, "<app_id> <bd_addr> <mdep_cfg_index>"),
+	STD_METHODH(destroy_channel, "<channel_id>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

