Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 4/4] tools: Add basic invalid parameters test for stop discovery
Date: Mon, 18 Mar 2013 16:53:06 -0400
Message-Id: <1363639986-16231-5-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
References: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 804191e..ac7c01a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1098,6 +1098,7 @@ static const struct generic_data start_discovery_valid_param_test_1 = {
 };
 
 static const char stop_discovery_bredrle_param[] = { 0x07 };
+static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
 
 static const struct generic_data stop_discovery_success_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
@@ -1117,6 +1118,15 @@ static const struct generic_data stop_discovery_rejected_test_1 = {
 	.expect_len = sizeof(stop_discovery_bredrle_param),
 };
 
+static const struct generic_data stop_discovery_invalid_param_test_1 = {
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredrle_invalid_param,
+	.send_len = sizeof(stop_discovery_bredrle_invalid_param),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = stop_discovery_bredrle_invalid_param,
+	.expect_len = sizeof(stop_discovery_bredrle_invalid_param),
+};
+
 static const char set_dev_class_valid_param[] = { 0x01, 0x0c };
 static const char set_dev_class_zero_rsp[] = { 0x00, 0x00, 0x00 };
 static const char set_dev_class_valid_rsp[] = { 0x0c, 0x01, 0x00 };
@@ -2611,6 +2621,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
+	test_bredrle("Stop Discovery - Invalid parameters 1",
+				&stop_discovery_invalid_param_test_1,
+				setup_start_discovery, test_command_generic);
 
 	test_bredrle("Set Device Class - Success 1",
 				&set_dev_class_valid_param_test_1,
-- 
1.7.9.5

