Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android-tester: Add possibility to debug mgmt
Date: Fri, 10 Jan 2014 14:23:34 +0100
Message-Id: <1389360214-31932-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Print mgmt debug info if debug flag is set in android-tester.
---
 android/android-tester.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0185f99..ce1cedf 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -95,6 +95,13 @@ struct test_data {
 
 static char exec_dir[PATH_MAX + 1];
 
+static void mgmt_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	tester_print("%s%s", prefix, str);
+}
+
 static void test_update_state(void)
 {
 	struct test_data *data = tester_get_data();
@@ -334,9 +341,6 @@ static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	if (!tester_use_debug())
-		fclose(stderr);
-
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
 		tester_warn("Failed to setup management interface");
@@ -344,6 +348,11 @@ static void test_pre_setup(const void *test_data)
 		return;
 	}
 
+	if (!tester_use_debug())
+		fclose(stderr);
+	else
+		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
+
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
 				NULL, read_index_list_callback, NULL, NULL);
 }
-- 
1.8.3.1

