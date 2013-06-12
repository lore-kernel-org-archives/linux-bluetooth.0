Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 28/35] tools/mgmt-tester: Move command_generic_callback()
Date: Wed, 12 Jun 2013 08:57:14 -0400
Message-Id: <1371041841-21793-29-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rearrange command_generic_callback() position to avoid fast forward
declaration in next patch.
---
 tools/mgmt-tester.c |   56 +++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d53f94e..64f18c1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2565,34 +2565,6 @@ done:
 	test_condition_complete(data);
 }
 
-static void command_generic_event_alt(uint16_t index, uint16_t length,
-							const void *param,
-							void *user_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-
-	if (length != test->expect_alt_ev_len) {
-		tester_warn("Invalid length %s event",
-					mgmt_evstr(test->expect_alt_ev));
-		tester_test_failed();
-		return;
-	}
-
-	tester_print("New %s event received", mgmt_evstr(test->expect_alt_ev));
-
-	if (memcmp(param, test->expect_alt_ev_param,
-						test->expect_alt_ev_len) != 0)
-		return;
-
-	tester_print("Unregistering %s notification",
-					mgmt_evstr(test->expect_alt_ev));
-
-	mgmt_unregister(data->mgmt_alt, data->mgmt_alt_ev_id);
-
-	test_condition_complete(data);
-}
-
 static void command_generic_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -2621,6 +2593,34 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 	test_condition_complete(data);
 }
 
+static void command_generic_event_alt(uint16_t index, uint16_t length,
+							const void *param,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (length != test->expect_alt_ev_len) {
+		tester_warn("Invalid length %s event",
+					mgmt_evstr(test->expect_alt_ev));
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("New %s event received", mgmt_evstr(test->expect_alt_ev));
+
+	if (memcmp(param, test->expect_alt_ev_param,
+						test->expect_alt_ev_len) != 0)
+		return;
+
+	tester_print("Unregistering %s notification",
+					mgmt_evstr(test->expect_alt_ev));
+
+	mgmt_unregister(data->mgmt_alt, data->mgmt_alt_ev_id);
+
+	test_condition_complete(data);
+}
+
 static bool command_hci_callback(uint16_t opcode, const void *param,
 					uint8_t length, void *user_data)
 {
-- 
1.7.9.5

