Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v2 4/4] tools/mgmt-tester: Fix set local name tests
Date: Tue, 18 Oct 2016 15:12:08 +0200
Message-Id: <1476796328-14808-4-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1476796328-14808-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1476796328-14808-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 12e1f50..a4f85c3 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1902,7 +1902,11 @@ static const struct mgmt_cp_set_local_name set_local_name_cp = {
 
 static const struct mgmt_cp_set_local_name set_local_name_longer_cp = {
 	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1', '2', '3'},
-	.short_name = {'T', 'e', 's', 't'},
+};
+
+static const struct mgmt_cp_set_local_name set_local_name_longer_rp = {
+	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1', '2', '3'},
+	.short_name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1'},
 };
 
 static const struct generic_data set_local_name_test_1 = {
@@ -1949,6 +1953,32 @@ static const struct generic_data set_local_name_test_3 = {
 	.expect_alt_ev_len = sizeof(set_local_name_param),
 };
 
+static const struct generic_data set_local_name_test_4 = {
+	.setup_settings = settings_powered,
+	.send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.send_param = &set_local_name_cp,
+	.send_len = sizeof(set_local_name_cp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = &set_local_name_cp,
+	.expect_len = sizeof(set_local_name_cp),
+	.expect_alt_ev = MGMT_EV_LOCAL_NAME_CHANGED,
+	.expect_alt_ev_param = &set_local_name_cp,
+	.expect_alt_ev_len = sizeof(set_local_name_cp),
+};
+
+static const struct generic_data set_local_name_test_5 = {
+	.setup_settings = settings_powered,
+	.send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.send_param = &set_local_name_longer_cp,
+	.send_len = sizeof(set_local_name_longer_cp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = &set_local_name_longer_cp,
+	.expect_len = sizeof(set_local_name_longer_cp),
+	.expect_alt_ev = MGMT_EV_LOCAL_NAME_CHANGED,
+	.expect_alt_ev_param = &set_local_name_longer_rp,
+	.expect_alt_ev_len = sizeof(set_local_name_longer_rp),
+};
+
 static const char start_discovery_invalid_param[] = { 0x00 };
 static const char start_discovery_bredr_param[] = { 0x01 };
 static const char start_discovery_le_param[] = { 0x06 };
@@ -7370,6 +7400,12 @@ int main(int argc, char *argv[])
 	test_bredr("Set Local Name - Success 3",
 				&set_local_name_test_3,
 				NULL, test_command_generic);
+	test_bredr("Set Local Name - Success 4",
+				&set_local_name_test_4,
+				NULL, test_command_generic);
+	test_bredr("Set Local Name - Success 5",
+				&set_local_name_test_5,
+				NULL, test_command_generic);
 
 	test_bredrle("Start Discovery - Not powered 1",
 				&start_discovery_not_powered_test_1,
-- 
2.7.4

