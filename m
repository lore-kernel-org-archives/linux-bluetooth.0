Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/5] unit/test-textfile: Use tester framework
Date: Tue, 19 May 2015 20:31:01 +0530
Message-id: <1432047664-23655-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
References: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am          |  2 +-
 unit/test-textfile.c | 49 +++++++++++++++++++++++--------------------------
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9e94648..6aa8410 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -278,7 +278,7 @@ unit_test_uuid_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 unit_tests += unit/test-textfile
 
 unit_test_textfile_SOURCES = unit/test-textfile.c src/textfile.h src/textfile.c
-unit_test_textfile_LDADD = @GLIB_LIBS@
+unit_test_textfile_LDADD = src/libshared-glib.la @GLIB_LIBS@
 
 unit_tests += unit/test-crc
 
diff --git a/unit/test-textfile.c b/unit/test-textfile.c
index d873df4..5250f98 100644
--- a/unit/test-textfile.c
+++ b/unit/test-textfile.c
@@ -34,6 +34,7 @@
 #include <glib.h>
 
 #include "src/textfile.h"
+#include "src/shared/tester.h"
 
 static const char test_pathname[] = "/tmp/textfile";
 
@@ -79,7 +80,7 @@ done:
 	close(fd);
 }
 
-static void test_pagesize(void)
+static void test_pagesize(const void *data)
 {
 	char key[18], *str;
 	int size;
@@ -87,21 +88,20 @@ static void test_pagesize(void)
 	size = getpagesize();
 	g_assert(size >= 4096);
 
-	if (g_test_verbose())
-		g_print("System uses a page size of %d bytes\n", size);
+	tester_debug("System uses a page size of %d bytes\n", size);
 
 	util_create_pagesize();
 
 	sprintf(key, "11:11:11:11:11:11");
 	str = textfile_get(test_pathname, key);
 
-	if (g_test_verbose())
-		g_print("%s\n", str);
+	tester_debug("%s\n", str);
 
 	g_assert(str == NULL);
+	tester_test_passed();
 }
 
-static void test_delete(void)
+static void test_delete(const void *data)
 {
 	char key[18], value[512], *str;
 
@@ -116,13 +116,13 @@ static void test_delete(void)
 	str = textfile_get(test_pathname, key);
 	g_assert(str != NULL);
 
-	if (g_test_verbose())
-		g_print("%s\n", str);
+	tester_debug("%s\n", str);
 
 	g_free(str);
+	tester_test_passed();
 }
 
-static void test_overwrite(void)
+static void test_overwrite(const void *data)
 {
 	char key[18], value[512], *str;
 
@@ -143,10 +143,10 @@ static void test_overwrite(void)
 
 	str = textfile_get(test_pathname, key);
 
-	if (g_test_verbose())
-		g_print("%s\n", str);
+	tester_debug("%s\n", str);
 
 	g_assert(str == NULL);
+	tester_test_passed();
 }
 
 static void check_entry(char *key, char *value, void *data)
@@ -164,7 +164,7 @@ static void check_entry(char *key, char *value, void *data)
 	g_assert(strlen(value) == len);
 }
 
-static void test_multiple(void)
+static void test_multiple(const void *data)
 {
 	char key[18], value[512], *str;
 	unsigned int i, j, max = 10;
@@ -182,8 +182,7 @@ static void test_multiple(void)
 
 		str = textfile_get(test_pathname, key);
 
-		if (g_test_verbose())
-			g_print("%s %s\n", key, str);
+		tester_debug("%s %s\n", key, str);
 
 		g_assert(str != NULL);
 		g_assert(strcmp(str, value) == 0);
@@ -201,8 +200,7 @@ static void test_multiple(void)
 
 	str = textfile_get(test_pathname, key);
 
-	if (g_test_verbose())
-		g_print("%s %s\n", key, str);
+	tester_debug("%s %s\n", key, str);
 
 	g_assert(str != NULL);
 	g_assert(strcmp(str, value) == 0);
@@ -219,8 +217,7 @@ static void test_multiple(void)
 
 	str = textfile_get(test_pathname, key);
 
-	if (g_test_verbose())
-		g_print("%s %s\n", key, str);
+	tester_debug("%s %s\n", key, str);
 
 	g_assert(str != NULL);
 	g_assert(strcmp(str, value) == 0);
@@ -231,8 +228,7 @@ static void test_multiple(void)
 		sprintf(key, "00:00:00:00:00:%02X", i);
 		str = textfile_get(test_pathname, key);
 
-		if (g_test_verbose())
-			g_print("%s %s\n", key, str);
+		tester_debug("%s %s\n", key, str);
 
 		g_assert(str != NULL);
 
@@ -262,16 +258,17 @@ static void test_multiple(void)
 	g_assert(textfile_del(test_pathname, key) == 0);
 
 	textfile_foreach(test_pathname, check_entry, GUINT_TO_POINTER(max));
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	g_test_add_func("/textfile/pagesize", test_pagesize);
-	g_test_add_func("/textfile/delete", test_delete);
-	g_test_add_func("/textfile/overwrite", test_overwrite);
-	g_test_add_func("/textfile/multiple", test_multiple);
+	tester_add("/textfile/pagesize", NULL, NULL, test_pagesize, NULL);
+	tester_add("/textfile/delete", NULL, NULL, test_delete, NULL);
+	tester_add("/textfile/overwrite", NULL, NULL, test_overwrite, NULL);
+	tester_add("/textfile/multiple", NULL, NULL, test_multiple, NULL);
 
-	return g_test_run();
+	return tester_run();
 }
-- 
1.9.1

