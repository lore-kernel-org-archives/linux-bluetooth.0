Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] test: Use proper test data in unblock device test
Date: Fri, 18 Jan 2013 20:28:12 +0100
Message-Id: <1358537292-3572-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Copy and paste error. Although both data values are same use proper
one for clarity.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 273401c..bf61f9d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1714,7 +1714,7 @@ int main(int argc, char *argv[])
 			test_command_generic);
 
 	test_bredr("Unblock Device - Invalid Parameters 1",
-			&block_device_invalid_param_test_1, NULL,
+			&unblock_device_invalid_param_test_1, NULL,
 			test_command_generic);
 
 	return tester_run();
-- 
1.8.1

