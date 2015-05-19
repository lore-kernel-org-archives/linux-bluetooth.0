Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  5/5] unit/test-uuid: Use tester framework
Date: Tue, 19 May 2015 20:31:04 +0530
Message-id: <1432047664-23655-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
References: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am      |  3 ++-
 unit/test-uuid.c | 52 ++++++++++++++++++++++++++++++----------------------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f14539d..44d7893 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -273,7 +273,8 @@ unit_test_eir_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
 unit_tests += unit/test-uuid
 
 unit_test_uuid_SOURCES = unit/test-uuid.c
-unit_test_uuid_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+unit_test_uuid_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
+								@GLIB_LIBS@
 
 unit_tests += unit/test-textfile
 
diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 60c4791..5f45b0c 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -29,6 +29,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "src/shared/tester.h"
 
 struct uuid_test_data {
 	const char *str;
@@ -128,8 +129,11 @@ static void test_uuid(gconstpointer data)
 		break;
 	case BT_UUID_UNSPEC:
 	default:
+		tester_test_passed();
 		return;
         }
+
+	tester_test_passed();
 }
 
 static void test_str(gconstpointer data)
@@ -157,11 +161,13 @@ static void test_str(gconstpointer data)
 		bt_uuid32_create(&uuid, test_data->val32);
 		break;
 	default:
+		tester_test_passed();
 		return;
 	}
 
 	bt_uuid_to_string(&uuid, buf, sizeof(buf));
 	g_assert(strcasecmp(buf, str) == 0);
+	tester_test_passed();
 }
 
 static void test_cmp(gconstpointer data)
@@ -173,6 +179,7 @@ static void test_cmp(gconstpointer data)
 	g_assert(bt_string_to_uuid(&uuid2, test_data->str128) == 0);
 
 	g_assert(bt_uuid_cmp(&uuid1, &uuid2) == 0);
+	tester_test_passed();
 }
 
 static const struct uuid_test_data compress[] = {
@@ -220,43 +227,44 @@ static void test_malformed(gconstpointer data)
 	bt_uuid_t uuid;
 
 	g_assert(bt_string_to_uuid(&uuid, str) != 0);
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
 	size_t i;
 
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	g_test_add_data_func("/uuid/base", &uuid_base, test_uuid);
-	g_test_add_data_func("/uuid/base/str", &uuid_base, test_str);
-	g_test_add_data_func("/uuid/base/cmp", &uuid_base, test_cmp);
+	tester_add("/uuid/base", &uuid_base, NULL, test_uuid, NULL);
+	tester_add("/uuid/base/str", &uuid_base, NULL, test_str, NULL);
+	tester_add("/uuid/base/cmp", &uuid_base, NULL, test_cmp, NULL);
 
-	g_test_add_data_func("/uuid/sixteen1", &uuid_sixteen1, test_uuid);
-	g_test_add_data_func("/uuid/sixteen1/str", &uuid_sixteen1, test_str);
-	g_test_add_data_func("/uuid/sixteen1/cmp", &uuid_sixteen1, test_cmp);
+	tester_add("/uuid/sixteen1", &uuid_sixteen1, NULL, test_uuid, NULL);
+	tester_add("/uuid/sixteen1/str", &uuid_sixteen1, NULL, test_str, NULL);
+	tester_add("/uuid/sixteen1/cmp", &uuid_sixteen1, NULL, test_cmp, NULL);
 
-	g_test_add_data_func("/uuid/sixteen2", &uuid_sixteen2, test_uuid);
-	g_test_add_data_func("/uuid/sixteen2/str", &uuid_sixteen2, test_str);
-	g_test_add_data_func("/uuid/sixteen2/cmp", &uuid_sixteen2, test_cmp);
+	tester_add("/uuid/sixteen2", &uuid_sixteen2, NULL, test_uuid, NULL);
+	tester_add("/uuid/sixteen2/str", &uuid_sixteen2, NULL, test_str, NULL);
+	tester_add("/uuid/sixteen2/cmp", &uuid_sixteen2, NULL, test_cmp, NULL);
 
-	g_test_add_data_func("/uuid/thirtytwo1", &uuid_32_1, test_uuid);
-	g_test_add_data_func("/uuid/thirtytwo1/str", &uuid_32_1, test_str);
-	g_test_add_data_func("/uuid/thirtytwo1/cmp", &uuid_32_1, test_cmp);
+	tester_add("/uuid/thirtytwo1", &uuid_32_1, NULL, test_uuid, NULL);
+	tester_add("/uuid/thirtytwo1/str", &uuid_32_1, NULL, test_str, NULL);
+	tester_add("/uuid/thirtytwo1/cmp", &uuid_32_1, NULL, test_cmp, NULL);
 
-	g_test_add_data_func("/uuid/thirtytwo2", &uuid_32_2, test_uuid);
-	g_test_add_data_func("/uuid/thritytwo2/str", &uuid_32_2, test_str);
-	g_test_add_data_func("/uuid/thirtytwo2/cmp", &uuid_32_2, test_cmp);
+	tester_add("/uuid/thirtytwo2", &uuid_32_2, NULL, test_uuid, NULL);
+	tester_add("/uuid/thritytwo2/str", &uuid_32_2, NULL, test_str, NULL);
+	tester_add("/uuid/thirtytwo2/cmp", &uuid_32_2, NULL, test_cmp, NULL);
 
-	g_test_add_data_func("/uuid/onetwentyeight", &uuid_128, test_uuid);
-	g_test_add_data_func("/uuid/onetwentyeight/str", &uuid_128, test_str);
-	g_test_add_data_func("/uuid/onetwentyeight/cmp", &uuid_128, test_cmp);
+	tester_add("/uuid/onetwentyeight", &uuid_128, NULL, test_uuid, NULL);
+	tester_add("/uuid/onetwentyeight/str", &uuid_128, NULL, test_str, NULL);
+	tester_add("/uuid/onetwentyeight/cmp", &uuid_128, NULL, test_cmp, NULL);
 
 	for (i = 0; malformed[i]; i++) {
 		char *testpath;
 
 		testpath = g_strdup_printf("/uuid/malformed/%s", malformed[i]);
-		g_test_add_data_func(testpath, malformed[i], test_malformed);
+		tester_add(testpath, malformed[i], NULL, test_malformed, NULL);
 		g_free(testpath);
 	}
 
@@ -265,9 +273,9 @@ int main(int argc, char *argv[])
 
 		testpath = g_strdup_printf("/uuid/compress/%s",
 							compress[i].str);
-		g_test_add_data_func(testpath, compress + i, test_uuid);
+		tester_add(testpath, compress + i, NULL, test_uuid, NULL);
 		g_free(testpath);
 	}
 
-	return g_test_run();
+	return tester_run();
 }
-- 
1.9.1

