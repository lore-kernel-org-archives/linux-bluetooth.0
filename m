Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH Bluez 2/7] Add unit tests for uuid2strn func in lib/sdp
Date: Wed,  8 Feb 2012 12:40:50 +0100
Message-Id: <1328701255-24245-3-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
References: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

3 new tests for uuid2strn function from lib/sdp.c code.
---
 unit/test-sdp.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index ea2521b..ee7e9b4 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -32,6 +32,65 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/sdp.h>
 
+#include "sdp_lib.h"
+
+#define BUF_SIZE 30
+
+/* uuid2strn testcases */
+START_TEST(tc_uuid2strn_null)
+{
+	char buf[BUF_SIZE];
+	int err;
+
+	err = sdp_uuid2strn(NULL, buf, BUF_SIZE);
+	ck_assert(err == -2);
+	ck_assert_str_eq(buf, "NULL");
+}
+END_TEST
+
+START_TEST(tc_uuid2strn_sdp_uuid_32)
+{
+	char buf[BUF_SIZE];
+	int err;
+	uuid_t *test_uuid;
+
+	test_uuid = g_new0(uuid_t, 1);
+	test_uuid->type = SDP_UUID32;
+
+	err = sdp_uuid2strn(test_uuid, buf, BUF_SIZE);
+	ck_assert(err == 0);
+	ck_assert_str_eq(buf, "00000000");
+
+	g_free(test_uuid);
+}
+END_TEST
+
+START_TEST(tc_uuid2strn_undefined)
+{
+	char buf[BUF_SIZE];
+	int err;
+	uuid_t *test_uuid;
+
+	test_uuid = g_new0(uuid_t, 1);
+	test_uuid->type = SDP_UUID_UNSPEC;
+
+	err = sdp_uuid2strn(test_uuid, buf, BUF_SIZE);
+	ck_assert(err == -1);
+	ck_assert_str_eq(buf, "Type of UUID (18) unknown.");
+
+	g_free(test_uuid);
+}
+END_TEST
+
+static void add_test(Suite *s, const char *name, TFun func)
+{
+	TCase *t;
+
+	t = tcase_create(name);
+	tcase_add_test(t, func);
+	suite_add_tcase(s, t);
+}
+
 int main(int argc, char *argv[])
 {
 	int fails;
@@ -40,6 +99,11 @@ int main(int argc, char *argv[])
 
 	s = suite_create("SDP");
 
+	/* uuid2strn testcases */
+	add_test(s, "uuid2strn:NULL param", tc_uuid2strn_null);
+	add_test(s, "uuid2strn:SDP_UUID32 param", tc_uuid2strn_sdp_uuid_32);
+	add_test(s, "uuid2strn:undefined param", tc_uuid2strn_undefined);
+
 	sr = srunner_create(s);
 
 	srunner_run_all(sr, CK_NORMAL);
-- 
1.7.0.4

