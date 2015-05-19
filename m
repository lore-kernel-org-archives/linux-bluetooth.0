Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  4/5] unit/test-lib: Use tester framework
Date: Tue, 19 May 2015 20:31:03 +0530
Message-id: <1432047664-23655-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
References: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am     |   3 +-
 unit/test-lib.c | 106 ++++++++++++++++++++++++++++++++------------------------
 2 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6aa8410..f14539d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -382,7 +382,8 @@ unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
 unit_tests += unit/test-lib
 
 unit_test_lib_SOURCES = unit/test-lib.c
-unit_test_lib_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+unit_test_lib_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la @GLIB_LIBS@
 
 unit_tests += unit/test-gatt
 
diff --git a/unit/test-lib.c b/unit/test-lib.c
index ef0cffc..bd4c5ee 100644
--- a/unit/test-lib.c
+++ b/unit/test-lib.c
@@ -31,27 +31,30 @@
 #include <errno.h>
 
 #include "src/shared/util.h"
+#include "src/shared/tester.h"
 
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 
-static void test_ntoh64(void)
+static void test_ntoh64(const void *data)
 {
 	uint64_t test = 0x123456789abcdef;
 
 	g_assert(ntoh64(test) == be64toh(test));
 	g_assert(ntoh64(test) == be64_to_cpu(test));
+	tester_test_passed();
 }
 
-static void test_hton64(void)
+static void test_hton64(const void *data)
 {
 	uint64_t test = 0x123456789abcdef;
 
 	g_assert(hton64(test) == htobe64(test));
 	g_assert(hton64(test) == cpu_to_be64(test));
+	tester_test_passed();
 }
 
-static void test_sdp_get_access_protos_valid(void)
+static void test_sdp_get_access_protos_valid(const void *data)
 {
 	sdp_record_t *rec;
 	sdp_list_t *aproto, *apseq, *proto[2];
@@ -91,9 +94,10 @@ static void test_sdp_get_access_protos_valid(void)
 	sdp_list_free(aproto, NULL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_access_protos_nodata(void)
+static void test_sdp_get_access_protos_nodata(const void *data)
 {
 	sdp_record_t *rec;
 	sdp_list_t *aproto;
@@ -108,9 +112,10 @@ static void test_sdp_get_access_protos_nodata(void)
 	g_assert(err == -1 && errno == ENODATA);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_access_protos_invalid_dtd1(void)
+static void test_sdp_get_access_protos_invalid_dtd1(const void *tdata)
 {
 	const uint32_t u32 = 0xdeadbeeb;
 	sdp_record_t *rec;
@@ -135,9 +140,10 @@ static void test_sdp_get_access_protos_invalid_dtd1(void)
 	g_assert(err == -1 && errno == EINVAL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_access_protos_invalid_dtd2(void)
+static void test_sdp_get_access_protos_invalid_dtd2(const void *tdata)
 {
 	uint8_t dtd = SDP_UINT8, u8 = 0xff;
 	void *dtds = &dtd, *values = &u8;
@@ -163,9 +169,10 @@ static void test_sdp_get_access_protos_invalid_dtd2(void)
 	g_assert(err == -1 && errno == EINVAL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_lang_attr_valid(void)
+static void test_sdp_get_lang_attr_valid(const void *data)
 {
 	sdp_record_t *rec;
 	sdp_list_t *list;
@@ -179,9 +186,10 @@ static void test_sdp_get_lang_attr_valid(void)
 
 	sdp_list_free(list, free);
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_lang_attr_nodata(void)
+static void test_sdp_get_lang_attr_nodata(const void *data)
 {
 	sdp_record_t *rec;
 	sdp_list_t *list;
@@ -193,9 +201,10 @@ static void test_sdp_get_lang_attr_nodata(void)
 	g_assert(err == -1 && errno == ENODATA);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_lang_attr_invalid_dtd(void)
+static void test_sdp_get_lang_attr_invalid_dtd(const void *tdata)
 {
 	uint8_t dtd1 = SDP_UINT16, dtd2 = SDP_UINT32;
 	uint32_t u32 = 0xdeadbeeb;
@@ -243,9 +252,10 @@ static void test_sdp_get_lang_attr_invalid_dtd(void)
 	g_assert(err == -1 && errno == EINVAL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_profile_descs_valid(void)
+static void test_sdp_get_profile_descs_valid(const void *data)
 {
 	sdp_profile_desc_t profile;
 	sdp_record_t *rec;
@@ -267,9 +277,10 @@ static void test_sdp_get_profile_descs_valid(void)
 	g_assert(err == 0 && list != NULL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_profile_descs_nodata(void)
+static void test_sdp_get_profile_descs_nodata(const void *data)
 {
 	sdp_record_t *rec;
 	sdp_list_t *list;
@@ -281,9 +292,10 @@ static void test_sdp_get_profile_descs_nodata(void)
 	g_assert(err == -1 && errno == ENODATA);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_profile_descs_invalid_dtd(void)
+static void test_sdp_get_profile_descs_invalid_dtd(const void *tdata)
 {
 	uint8_t dtd1 = SDP_UUID16, dtd2 = SDP_UINT32;
 	uint32_t u32 = 0xdeadbeeb;
@@ -354,9 +366,10 @@ static void test_sdp_get_profile_descs_invalid_dtd(void)
 	g_assert(err == -1 && errno == EINVAL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_profile_descs_workaround(void)
+static void test_sdp_get_profile_descs_workaround(const void *tdata)
 {
 	uint8_t dtd1 = SDP_UUID16, dtd2 = SDP_UINT16, dtd3 = SDP_UINT32;
 	uint16_t u16 = 0x1234;
@@ -404,9 +417,10 @@ static void test_sdp_get_profile_descs_workaround(void)
 	g_assert(err == -1 && errno == EINVAL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
-static void test_sdp_get_server_ver(void)
+static void test_sdp_get_server_ver(const void *tdata)
 {
 	uint16_t u16 = 0x1234;
 	uint32_t u32 = 0xdeadbeeb;
@@ -451,42 +465,44 @@ static void test_sdp_get_server_ver(void)
 	g_assert(err == -1 && errno == EINVAL);
 
 	sdp_record_free(rec);
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
-
-	g_test_add_func("/lib/ntoh64", test_ntoh64);
-	g_test_add_func("/lib/hton64", test_hton64);
-
-	g_test_add_func("/lib/sdp_get_access_protos/valid",
-					test_sdp_get_access_protos_valid);
-	g_test_add_func("/lib/sdp_get_access_protos/nodata",
-					test_sdp_get_access_protos_nodata);
-	g_test_add_func("/lib/sdp_get_access_protos/invalid_dtd1",
-				test_sdp_get_access_protos_invalid_dtd1);
-	g_test_add_func("/lib/sdp_get_access_protos/invalid_dtd2",
-				test_sdp_get_access_protos_invalid_dtd2);
-
-	g_test_add_func("/lib/sdp_get_lang_attr/valid",
-						test_sdp_get_lang_attr_valid);
-	g_test_add_func("/lib/sdp_get_lang_attr/nodata",
-						test_sdp_get_lang_attr_nodata);
-	g_test_add_func("/lib/sdp_get_lang_attr/invalid_dtd",
-					test_sdp_get_lang_attr_invalid_dtd);
-
-	g_test_add_func("/lib/sdp_get_profile_descs/valid",
-					test_sdp_get_profile_descs_valid);
-	g_test_add_func("/lib/sdp_get_profile_descs/nodata",
-					test_sdp_get_profile_descs_nodata);
-	g_test_add_func("/lib/sdp_get_profile_descs/invalid_dtd",
-					test_sdp_get_profile_descs_invalid_dtd);
+	tester_init(&argc, &argv);
+
+	tester_add("/lib/ntoh64", NULL, NULL, test_ntoh64, NULL);
+	tester_add("/lib/hton64", NULL, NULL, test_hton64, NULL);
+
+	tester_add("/lib/sdp_get_access_protos/valid", NULL, NULL,
+				test_sdp_get_access_protos_valid, NULL);
+	tester_add("/lib/sdp_get_access_protos/nodata", NULL, NULL,
+				test_sdp_get_access_protos_nodata, NULL);
+	tester_add("/lib/sdp_get_access_protos/invalid_dtd1", NULL, NULL,
+				test_sdp_get_access_protos_invalid_dtd1, NULL);
+	tester_add("/lib/sdp_get_access_protos/invalid_dtd2", NULL, NULL,
+				test_sdp_get_access_protos_invalid_dtd2, NULL);
+
+	tester_add("/lib/sdp_get_lang_attr/valid", NULL, NULL,
+					test_sdp_get_lang_attr_valid, NULL);
+	tester_add("/lib/sdp_get_lang_attr/nodata", NULL, NULL,
+					test_sdp_get_lang_attr_nodata, NULL);
+	tester_add("/lib/sdp_get_lang_attr/invalid_dtd", NULL, NULL,
+				test_sdp_get_lang_attr_invalid_dtd, NULL);
+
+	tester_add("/lib/sdp_get_profile_descs/valid", NULL, NULL,
+					test_sdp_get_profile_descs_valid, NULL);
+	tester_add("/lib/sdp_get_profile_descs/nodata", NULL, NULL,
+				test_sdp_get_profile_descs_nodata, NULL);
+	tester_add("/lib/sdp_get_profile_descs/invalid_dtd", NULL, NULL,
+				test_sdp_get_profile_descs_invalid_dtd, NULL);
 	/* Test for workaround commented on sdp_get_profile_descs() */
-	g_test_add_func("/lib/sdp_get_profile_descs/workaround",
-					test_sdp_get_profile_descs_workaround);
+	tester_add("/lib/sdp_get_profile_descs/workaround", NULL, NULL,
+				test_sdp_get_profile_descs_workaround, NULL);
 
-	g_test_add_func("/lib/sdp_get_server_ver", test_sdp_get_server_ver);
+	tester_add("/lib/sdp_get_server_ver", NULL, NULL,
+					test_sdp_get_server_ver, NULL);
 
-	return g_test_run();
+	return tester_run();
 }
-- 
1.9.1

