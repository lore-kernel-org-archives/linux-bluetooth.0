Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 24/35] tools/mgmt-tester: Split test_command_generic()
Date: Wed, 12 Jun 2013 08:57:10 -0400
Message-Id: <1371041841-21793-25-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The test_command_generic() was split in two parts to use the new
setup_test_command_generic() function in next tests.
---
 tools/mgmt-tester.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4bf3235..313feff 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2618,7 +2618,7 @@ static bool command_hci_callback(uint16_t opcode, const void *param,
 	return true;
 }
 
-static void test_command_generic(const void *test_data)
+static void setup_test_command_generic(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
@@ -2655,6 +2655,17 @@ static void test_command_generic(const void *test_data)
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
+}
+
+static void test_command_generic(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	uint16_t index;
+
+	index = test->send_index_none ? MGMT_INDEX_NONE : data->mgmt_index;
+
+	setup_test_command_generic(test_data);
 
 	tester_print("Sending command 0x%04x", test->send_opcode);
 
-- 
1.7.9.5

