Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 3/3] sco-tester: Test transparent data feature bit
Date: Fri,  9 Aug 2013 17:42:57 +0200
Message-Id: <1376062977-1497-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/sco-tester.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index e826d9c..e45956a 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -45,6 +45,7 @@
 
 struct adapter_features {
 	bool disable_esco;
+	bool enable_transp;
 };
 
 struct test_data {
@@ -145,6 +146,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
+	uint8_t *features;
 
 	tester_print("Read Index List callback");
 	tester_print("  Status: 0x%02x", status);
@@ -168,14 +170,16 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	tester_print("New hciemu instance created");
 
-	if (data->features.disable_esco) {
-		uint8_t *features;
+	features = hciemu_get_features(data->hciemu);
 
+	if (data->features.disable_esco) {
 		tester_print("Disabling eSCO packet type support");
+		features[3] &= ~0x80;
+	}
 
-		features = hciemu_get_features(data->hciemu);
-		if (features)
-			features[3] &= ~0x80;
+	if (data->features.enable_transp) {
+		tester_print("Enabling transparent data support");
+		features[2] |= 0x08;
 	}
 }
 
@@ -579,6 +583,7 @@ int main(int argc, char *argv[])
 	tester_init(&argc, &argv);
 
 	features.disable_esco = 0;
+	features.enable_transp = 1;
 
 	test_sco("Basic Framework - Success", NULL, setup_powered,
 						test_framework, features);
@@ -598,6 +603,11 @@ int main(int argc, char *argv[])
 	test_sco("eSCO MSBC - Success", &connect_success, setup_powered,
 						test_connect_transp, features);
 
+	features.enable_transp = 0;
+
+	test_sco("eSCO MSBC - Failure", &connect_failure, setup_powered,
+						test_connect_transp, features);
+
 	features.disable_esco = 1;
 
 	test_sco("SCO CVSD 1.1 - Success", &connect_success, setup_powered,
-- 
1.7.9.5

