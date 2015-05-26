Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v6 3/4] tools/mgmt-tester: rename add adv tests
Date: Tue, 26 May 2015 02:35:54 +0200
Message-Id: <1432600555-8008-4-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600555-8008-1-git-send-email-fgrandel@gmail.com>
References: <1432600555-8008-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507209-23081-1-git-send-email-fgrandel@gmail.com>
References: <1432507209-23081-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The add advertisement tests were named a bit inconsistently and the test
intent was not always clear from the naming of the test. This has been
improved by introducing a somewhat more consistent naming scheme and
adding additional hints wrt the test intent.
---
 tools/mgmt-tester.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 62bea80..72ed224 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6577,67 +6577,67 @@ int main(int argc, char *argv[])
 	test_le("Add Advertising - Invalid Params 10 (ScRsp too long)",
 					&add_advertising_fail_11,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Timeout Not Powered",
+	test_bredrle("Add Advertising - Rejected (Timeout, Not Powered)",
 					&add_advertising_fail_12,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Timeout Power off",
+	test_bredrle("Add Advertising - Success 1 (Timeout, Power off)",
 					&add_advertising_timeout_power_off,
 					setup_add_advertising_timeout,
 					test_command_generic);
-	test_bredrle("Add Advertising - Success 1",
+	test_bredrle("Add Advertising - Success 2 (Powered, Added, Adv Data)",
 					&add_advertising_success_1,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 2",
+	test_bredrle("Add Advertising - Success 3 (Not Powered, Adv Data)",
 					&add_advertising_success_2,
 					setup_add_advertising_not_powered,
 					test_command_generic);
-	test_bredrle("Add Advertising - Success 3",
+	test_bredrle("Add Advertising - Success 4 (Not Powered, Adv Enable)",
 					&add_advertising_success_3,
 					setup_add_advertising_not_powered,
 					test_command_generic);
-	test_bredrle("Add Advertising - Set Advertising on override 1",
+	test_bredrle("Add Advertising - Success 5 (Set Adv on override)",
 					&add_advertising_success_4,
 					setup_add_advertising,
 					test_command_generic);
-	test_bredrle("Add Advertising - Set Advertising off override 2",
+	test_bredrle("Add Advertising - Success 6 (Set Adv off override)",
 					&add_advertising_success_5,
 					setup_set_and_add_advertising,
 					test_command_generic);
-	test_bredrle("Add Advertising - Success 4",
+	test_bredrle("Add Advertising - Success 7 (Scan Rsp Data, Adv ok)",
 					&add_advertising_success_6,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 5",
+	test_bredrle("Add Advertising - Success 8 (Scan Rsp Data, Scan ok) ",
 					&add_advertising_success_7,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 6 - Flag 0",
+	test_bredrle("Add Advertising - Success 9 (Connectable Flag)",
 					&add_advertising_success_8,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 7 - Flag 1",
+	test_bredrle("Add Advertising - Success 10 (General Discov Flag)",
 					&add_advertising_success_9,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 8 - Flag 2",
+	test_bredrle("Add Advertising - Success 11 (Limited Discov Flag)",
 					&add_advertising_success_10,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 8 - Flag 3",
+	test_bredrle("Add Advertising - Success 12 (Managed Flags)",
 					&add_advertising_success_11,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 9 - Flag 4",
+	test_bredrle("Add Advertising - Success 13 (TX Power Flag)",
 					&add_advertising_success_12,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 10 - ADV_SCAN_IND",
+	test_bredrle("Add Advertising - Success 14 (ADV_SCAN_IND)",
 					&add_advertising_success_13,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 11 - ADV_NONCONN_IND",
+	test_bredrle("Add Advertising - Success 15 (ADV_NONCONN_IND)",
 					&add_advertising_success_14,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 12 - ADV_IND",
+	test_bredrle("Add Advertising - Success 16 (ADV_IND)",
 					&add_advertising_success_15,
 					NULL, test_command_generic);
-	test_bredrle("Add Advertising - Success 13 - connectable -> on",
+	test_bredrle("Add Advertising - Success 17 (connectable -> on)",
 					&add_advertising_success_16,
 					setup_add_advertising,
 					test_command_generic);
-	test_bredrle("Add Advertising - Success 14 - connectable -> off",
+	test_bredrle("Add Advertising - Success 18 (connectable -> off)",
 					&add_advertising_success_17,
 					setup_add_advertising_connectable,
 					test_command_generic);
-- 
1.9.1

