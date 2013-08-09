Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/3] sco-tester: Introduce adapter features
Date: Fri,  9 Aug 2013 17:42:56 +0200
Message-Id: <1376062977-1497-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/sco-tester.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 1e8351f..e826d9c 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -43,6 +43,10 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+struct adapter_features {
+	bool disable_esco;
+};
+
 struct test_data {
 	const void *test_data;
 	struct mgmt *mgmt;
@@ -50,7 +54,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	unsigned int io_id;
-	bool disable_esco;
+	struct adapter_features features;
 };
 
 struct sco_client_data {
@@ -164,7 +168,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	tester_print("New hciemu instance created");
 
-	if (data->disable_esco) {
+	if (data->features.disable_esco) {
 		uint8_t *features;
 
 		tester_print("Disabling eSCO packet type support");
@@ -211,7 +215,7 @@ static void test_data_free(void *test_data)
 	free(data);
 }
 
-#define test_sco_full(name, data, setup, func, _disable_esco) \
+#define test_sco(name, data, setup, func, feat) \
 	do { \
 		struct test_data *user; \
 		user = malloc(sizeof(struct test_data)); \
@@ -220,17 +224,12 @@ static void test_data_free(void *test_data)
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
 		user->io_id = 0; \
 		user->test_data = data; \
-		user->disable_esco = _disable_esco; \
+		user->features = feat; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
 	} while (0)
 
-#define test_sco(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, false)
-
-#define test_sco_11(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, true)
 
 static const struct sco_client_data connect_success = {
 	.expect_err = 0
@@ -575,31 +574,37 @@ end:
 
 int main(int argc, char *argv[])
 {
+	static struct adapter_features features;
+
 	tester_init(&argc, &argv);
 
+	features.disable_esco = 0;
+
 	test_sco("Basic Framework - Success", NULL, setup_powered,
-							test_framework);
+						test_framework, features);
 
 	test_sco("Basic SCO Socket - Success", NULL, setup_powered,
-							test_socket);
+						test_socket, features);
 
 	test_sco("Basic SCO Get Socket Option - Success", NULL, setup_powered,
-							test_getsockopt);
+						test_getsockopt, features);
 
 	test_sco("Basic SCO Set Socket Option - Success", NULL, setup_powered,
-							test_setsockopt);
+						test_setsockopt, features);
 
 	test_sco("eSCO CVSD - Success", &connect_success, setup_powered,
-							test_connect);
+						test_connect, features);
 
 	test_sco("eSCO MSBC - Success", &connect_success, setup_powered,
-							test_connect_transp);
+						test_connect_transp, features);
+
+	features.disable_esco = 1;
 
-	test_sco_11("SCO CVSD 1.1 - Success", &connect_success, setup_powered,
-							test_connect);
+	test_sco("SCO CVSD 1.1 - Success", &connect_success, setup_powered,
+						test_connect, features);
 
-	test_sco_11("SCO MSBC 1.1 - Failure", &connect_failure, setup_powered,
-							test_connect_transp);
+	test_sco("SCO MSBC 1.1 - Failure", &connect_failure, setup_powered,
+						test_connect_transp, features);
 
 	return tester_run();
 }
-- 
1.7.9.5

