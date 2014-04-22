Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 08/11] android/client: Add unregister_application support to haltest
Date: Tue, 22 Apr 2014 15:06:07 +0300
Message-Id: <1398168371-29685-9-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 7c15a76..557d27a 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -173,6 +173,24 @@ static void register_application_p(int argc, const char **argv)
 	free(reg);
 }
 
+/* unregister_application */
+
+static void unregister_application_p(int argc, const char **argv)
+{
+	uint32_t app_id;
+
+	RETURN_IF_NULL(if_hl);
+
+	if (argc <= 2) {
+		haltest_error("No app id is specified");
+		return;
+	}
+
+	app_id = (uint32_t) atoi(argv[2]);
+
+	EXEC(if_hl->unregister_application, app_id);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -190,6 +208,7 @@ static struct method methods[] = {
 		"<app_name> <provider_name> <srv_name> <srv_descr>\n"
 		"<num_of_mdeps>\n"
 		"[<mdep_role> <data_type> <channel_type> <mdep_descr>] ..."),
+	STD_METHODH(unregister_application, "<app_id>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

