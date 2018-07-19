Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v1 7/7] mgmt-tester: Update Supported_settings to reflect PHY_CONFIGURATION
Date: Thu, 19 Jul 2018 16:54:07 +0530
Message-Id: <1531999447-3479-8-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1531999447-3479-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1531999447-3479-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 45281fb..855e2b2 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -401,7 +401,7 @@ static void test_condition_complete(struct test_data *data)
 		user->test_data = data; \
 		user->expected_version = 0x09; \
 		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x0000bfff; \
+		user->expected_supported_settings = 0x0001bfff; \
 		user->initial_settings = 0x00000080; \
 		tester_add_full(name, data, \
 				test_pre_setup, test_setup, func, NULL, \
@@ -420,7 +420,7 @@ static void test_condition_complete(struct test_data *data)
 		user->test_data = data; \
 		user->expected_version = 0x03; \
 		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x000010bf; \
+		user->expected_supported_settings = 0x000110bf; \
 		user->initial_settings = 0x00000080; \
 		tester_add_full(name, data, \
 				test_pre_setup, test_setup, func, NULL, \
@@ -436,7 +436,7 @@ static void test_condition_complete(struct test_data *data)
 		user->test_data = data; \
 		user->expected_version = 0x05; \
 		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x000011ff; \
+		user->expected_supported_settings = 0x000111ff; \
 		user->initial_settings = 0x00000080; \
 		tester_add_full(name, data, \
 				test_pre_setup, test_setup, func, NULL, \
@@ -452,7 +452,7 @@ static void test_condition_complete(struct test_data *data)
 		user->test_data = data; \
 		user->expected_version = 0x09; \
 		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x0000be1b; \
+		user->expected_supported_settings = 0x0001be1b; \
 		user->initial_settings = 0x00000200; \
 		tester_add_full(name, data, \
 				test_pre_setup, test_setup, func, NULL, \
@@ -5079,7 +5079,7 @@ static const char ext_ctrl_info1[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x00, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x00, 0x00, 0x00, /* current settings */
 	0x09, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5124,7 +5124,7 @@ static const char ext_ctrl_info2[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x00, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x0D, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5155,7 +5155,7 @@ static const char ext_ctrl_info3[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x00, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x16, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5190,7 +5190,7 @@ static const char ext_ctrl_info4[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x00, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5249,7 +5249,7 @@ static const char ext_ctrl_info5[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x00, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir len */
 	0x04, /* dev class len */
-- 
2.7.4
