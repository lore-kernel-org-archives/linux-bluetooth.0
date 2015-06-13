Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 11/15] tools/mgmt-tester: allow for event-only tests
Date: Sat, 13 Jun 2015 05:42:55 +0200
Message-Id: <1434166979-21824-12-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The generic test runner previously expected the test action to always be
a mgmt command. A "no-op" operation is introduced to support tests where
the test scenario is triggered by a timeout rather than a command.
---
 tools/mgmt-tester.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 91d154c..f612836 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -437,6 +437,8 @@ struct generic_data {
 	uint8_t adv_data_len;
 };
 
+# define TESTER_NOOP_OPCODE 0x0000
+
 static const char dummy_data[] = { 0x00 };
 
 static const struct generic_data invalid_command_test = {
@@ -5591,6 +5593,11 @@ static void test_command_generic(const void *test_data)
 		test_add_condition(data);
 	}
 
+	if (test->send_opcode == 0x0000) {
+		tester_print("Executing no-op test");
+		return;
+	}
+
 	tester_print("Sending command 0x%04x", test->send_opcode);
 
 	if (test->send_func)
-- 
1.9.1

