Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] tester: Refactor Read Local Public Key command
Date: Mon, 18 May 2015 12:41:35 +0300
Message-Id: <1431942097-21927-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Save Local Public Key to calculate DHKey for later tests. Also verify
that Command Status and Meta Event are generated.
---
 tools/hci-tester.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 460c9a9..9093129 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -46,6 +46,11 @@ struct user_data {
 	uint16_t handle_ut;
 };
 
+struct le_keys {
+	uint8_t remote_sk[32];
+	uint8_t local_pk[64];
+} key_test_data;
+
 static void swap_buf(const uint8_t *src, uint8_t *dst, uint16_t len)
 {
 	int i;
@@ -412,9 +417,61 @@ static void test_le_rand(const void *test_data)
 	test_command(BT_HCI_CMD_LE_RAND);
 }
 
+static void test_le_read_local_pk_complete(const void *data, uint8_t size,
+								void *user_data)
+{
+	const uint8_t *event = data;
+	const struct bt_hci_evt_le_read_local_pk256_complete *evt;
+	struct le_keys *keys = user_data;
+
+	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
+		tester_warn("Failed Read Local PK256 command");
+		tester_test_failed();
+		return;
+	}
+
+	evt = (void *)(event + 1);
+	if (evt->status) {
+		tester_warn("HCI Read Local PK complete failed (0x%02x)",
+								evt->status);
+		tester_test_failed();
+		return;
+	}
+
+	memcpy(keys->local_pk, evt->local_pk256, 64);
+
+	util_hexdump('>', evt->local_pk256, 64, test_debug, NULL);
+
+	tester_test_passed();
+}
+
+static void test_le_read_local_pk_status(const void *data, uint8_t size,
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
 static void test_le_read_local_pk(const void *test_data)
 {
-	test_command(BT_HCI_CMD_LE_READ_LOCAL_PK256);
+	struct user_data *user = tester_get_data();
+
+	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
+				test_le_read_local_pk_complete,
+				(void *)test_data, NULL);
+
+	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_READ_LOCAL_PK256, NULL,
+				0, test_le_read_local_pk_status,
+				NULL, NULL)) {
+		tester_warn("Failed to send HCI LE Read Local PK256 command");
+		tester_test_failed();
+		return;
+	}
 }
 
 static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
@@ -790,7 +847,7 @@ int main(int argc, char *argv[])
 				test_le_encrypt);
 	test_hci_local("LE Rand", NULL, NULL,
 				test_le_rand);
-	test_hci_local("LE Read Local PK", NULL, NULL,
+	test_hci_local("LE Read Local PK", &key_test_data, NULL,
 				test_le_read_local_pk);
 	test_hci_local("LE Generate DHKey", NULL, NULL,
 				test_le_generate_dhkey);
-- 
2.1.4

