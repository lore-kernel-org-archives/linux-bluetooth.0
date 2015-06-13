Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 04/15] tools/mgmt-tester: error message when unexp params
Date: Sat, 13 Jun 2015 05:42:48 +0200
Message-Id: <1434166979-21824-5-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The tester already issues debug messages for unexpected HCI commands but
not for unexpected mgmt command return values. To facilitate test
debugging this patch adds a debug message for unexpected mgmt command
return values, too.
---
 tools/mgmt-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 3ecddab..083586a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5389,12 +5389,14 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 			expect_param = test->expect_func(&expect_len);
 
 		if (length != expect_len) {
+			tester_warn("Invalid cmd response parameter size");
 			tester_test_failed();
 			return;
 		}
 
 		if (expect_param && expect_len > 0 &&
 					memcmp(param, expect_param, length)) {
+			tester_warn("Unexpected cmd response parameter value");
 			tester_test_failed();
 			return;
 		}
-- 
1.9.1

