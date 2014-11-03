Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] mgmt-tester: Fix expected response for invalid start discovery tests
Date: Mon,  3 Nov 2014 14:21:24 +0100
Message-Id: <1415020884-9069-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Management Interface API 'Start Discovery' command should
generate a Command Complete event on failure.
---
 tools/mgmt-tester.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7d34ffb..7d14fe4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1679,6 +1679,8 @@ static const struct generic_data start_discovery_not_powered_test_1 = {
 	.send_param = start_discovery_bredr_param,
 	.send_len = sizeof(start_discovery_bredr_param),
 	.expect_status = MGMT_STATUS_NOT_POWERED,
+	.expect_param = start_discovery_bredr_param,
+	.expect_len = sizeof(start_discovery_bredr_param),
 };
 
 static const struct generic_data start_discovery_invalid_param_test_1 = {
@@ -1687,6 +1689,8 @@ static const struct generic_data start_discovery_invalid_param_test_1 = {
 	.send_param = start_discovery_invalid_param,
 	.send_len = sizeof(start_discovery_invalid_param),
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = start_discovery_invalid_param,
+	.expect_len = sizeof(start_discovery_invalid_param),
 };
 
 static const struct generic_data start_discovery_not_supported_test_1 = {
@@ -1695,6 +1699,8 @@ static const struct generic_data start_discovery_not_supported_test_1 = {
 	.send_param = start_discovery_le_param,
 	.send_len = sizeof(start_discovery_le_param),
 	.expect_status = MGMT_STATUS_REJECTED,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
 };
 
 static const struct generic_data start_discovery_valid_param_test_1 = {
-- 
1.9.3

