Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 09/11] android/client: Add connect_channel support to haltest
Date: Tue, 22 Apr 2014 15:06:08 +0300
Message-Id: <1398168371-29685-10-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 557d27a..16a3d16 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -191,6 +191,35 @@ static void unregister_application_p(int argc, const char **argv)
 	EXEC(if_hl->unregister_application, app_id);
 }
 
+/* connect_channel */
+
+static void connect_channel_p(int argc, const char **argv)
+{
+	uint32_t app_id, mdep_cfg_index;
+	int channel_id = -1;
+	bt_bdaddr_t bd_addr;
+
+	RETURN_IF_NULL(if_hl);
+
+	if (argc <= 2) {
+		haltest_error("No app id is specified");
+		return;
+	}
+
+	VERIFY_ADDR_ARG(3, &bd_addr);
+
+	if (argc <= 4) {
+		haltest_error("No mdep cfg index is specified");
+		return;
+	}
+
+	app_id = (uint32_t) atoi(argv[2]);
+	mdep_cfg_index = (uint32_t) atoi(argv[4]);
+
+	EXEC(if_hl->connect_channel, app_id, &bd_addr, mdep_cfg_index,
+								&channel_id);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -209,6 +238,7 @@ static struct method methods[] = {
 		"<num_of_mdeps>\n"
 		"[<mdep_role> <data_type> <channel_type> <mdep_descr>] ..."),
 	STD_METHODH(unregister_application, "<app_id>"),
+	STD_METHODH(connect_channel, "<app_id> <bd_addr> <mdep_cfg_index>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

