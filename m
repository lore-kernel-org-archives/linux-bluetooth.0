Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] emulator: Fix possible NULL dereference
Date: Wed,  8 Jan 2014 17:10:54 +0200
Message-Id: <1389193854-25769-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move test dereference after it is checked for NULL.
---
 tools/mgmt-tester.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index c518e47..325def1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2646,6 +2646,14 @@ static void test_setup(const void *test_data)
 	const struct generic_data *test = data->test_data;
 	const uint16_t *cmd;
 
+	if (!test || !test->setup_settings) {
+		if (data->test_setup)
+			data->test_setup(data);
+		else
+			tester_setup_complete();
+		return;
+	}
+
 	if (test->pin) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
@@ -2655,14 +2663,6 @@ static void test_setup(const void *test_data)
 				data, NULL);
 	}
 
-	if (!test || !test->setup_settings) {
-		if (data->test_setup)
-			data->test_setup(data);
-		else
-			tester_setup_complete();
-		return;
-	}
-
 	for (cmd = test->setup_settings; *cmd; cmd++) {
 		unsigned char simple_param[] = { 0x01 };
 		unsigned char discov_param[] = { 0x01, 0x00, 0x00 };
-- 
1.8.3.2

