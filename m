Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 8/8] tester: Test DHKey generation in controller
Date: Fri, 15 May 2015 16:46:26 +0300
Message-Id: <1431697586-20611-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test that appropriate command status event and LE Meta events are
generated.
---
 tools/hci-tester.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 620832d..460c9a9 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -31,6 +31,7 @@
 #include "monitor/bt.h"
 #include "src/shared/hci.h"
 #include "src/shared/util.h"
+#include "src/shared/ecc.h"
 #include "src/shared/tester.h"
 
 struct user_data {
@@ -416,6 +417,57 @@ static void test_le_read_local_pk(const void *test_data)
 	test_command(BT_HCI_CMD_LE_READ_LOCAL_PK256);
 }
 
+static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
+								void *user_data)
+{
+	const uint8_t *event = data;
+
+	if (*event != BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE) {
+		tester_warn("Failed DHKey generation command");
+		tester_test_failed();
+		return;
+	}
+
+	/* TODO: We have remote secret key and local public key, calculate
+	 * DHKey and compare
+	 */
+
+	tester_test_passed();
+}
+
+static void test_le_generate_dhkey_status(const void *data, uint8_t size,
+							void *user_data)
+{
+	uint8_t status = *((uint8_t *) data);
+
+	if (status) {
+		tester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
+		tester_test_failed();
+		return;
+	}
+}
+
+static void test_le_generate_dhkey(const void *test_data)
+{
+	struct user_data *user = tester_get_data();
+	struct bt_hci_cmd_le_generate_dhkey cmd;
+	uint8_t remote_sk[32];
+
+	ecc_make_key(cmd.remote_pk256, remote_sk);
+
+	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
+				test_le_generate_dhkey_complete, NULL, NULL);
+
+	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_GENERATE_DHKEY, &cmd,
+				sizeof(cmd), test_le_generate_dhkey_status,
+				NULL, NULL)) {
+		tester_warn("Failed to send HCI LE Encrypt command");
+		tester_test_failed();
+		return;
+	}
+
+}
+
 static void test_inquiry_complete(const void *data, uint8_t size,
 							void *user_data)
 {
@@ -740,6 +792,8 @@ int main(int argc, char *argv[])
 				test_le_rand);
 	test_hci_local("LE Read Local PK", NULL, NULL,
 				test_le_read_local_pk);
+	test_hci_local("LE Generate DHKey", NULL, NULL,
+				test_le_generate_dhkey);
 
 	test_hci_local("Inquiry (LIAC)", NULL, NULL, test_inquiry_liac);
 
-- 
2.1.4

