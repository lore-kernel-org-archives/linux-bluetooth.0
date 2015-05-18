Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] tester: Verify DHKey generation
Date: Mon, 18 May 2015 12:41:36 +0300
Message-Id: <1431942097-21927-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431942097-21927-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431942097-21927-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Verify that HCI controller correctly generate Diffie-Hellman key.
---
 tools/hci-tester.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 7 deletions(-)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 9093129..75d09f0 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -474,10 +474,70 @@ static void test_le_read_local_pk(const void *test_data)
 	}
 }
 
+static void setup_le_read_local_pk_complete(const void *data, uint8_t size,
+								void *user_data)
+{
+	const uint8_t *event = data;
+	const struct bt_hci_evt_le_read_local_pk256_complete *evt;
+	struct le_keys *keys = user_data;
+
+	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
+		tester_warn("Failed Read Local PK256 command");
+		tester_setup_failed();
+		return;
+	}
+
+	evt = (void *)(event + 1);
+	if (evt->status) {
+		tester_warn("HCI Read Local PK complete failed (0x%02x)",
+								evt->status);
+		tester_setup_failed();
+		return;
+	}
+
+	memcpy(keys->local_pk, evt->local_pk256, 64);
+
+	util_hexdump('>', evt->local_pk256, 64, test_debug, NULL);
+
+	tester_setup_complete();
+}
+
+static void setup_le_read_local_pk_status(const void *data, uint8_t size,
+							void *user_data)
+{
+	uint8_t status = *((uint8_t *) data);
+
+	if (status) {
+		tester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
+		tester_setup_failed();
+		return;
+	}
+}
+
+static void setup_le_generate_dhkey(const void *test_data)
+{
+	struct user_data *user = tester_get_data();
+
+	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
+				setup_le_read_local_pk_complete,
+				(void *)test_data, NULL);
+
+	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_READ_LOCAL_PK256, NULL,
+				0, setup_le_read_local_pk_status,
+				NULL, NULL)) {
+		tester_warn("Failed to send HCI LE Read Local PK256 command");
+		tester_setup_failed();
+		return;
+	}
+}
+
 static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
 								void *user_data)
 {
 	const uint8_t *event = data;
+	const struct bt_hci_evt_le_generate_dhkey_complete *evt;
+	struct le_keys *keys = user_data;
+	uint8_t dhkey[32];
 
 	if (*event != BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE) {
 		tester_warn("Failed DHKey generation command");
@@ -485,11 +545,32 @@ static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
 		return;
 	}
 
-	/* TODO: We have remote secret key and local public key, calculate
-	 * DHKey and compare
+	evt = (void *)(event + 1);
+	if (evt->status) {
+		tester_warn("HCI Generate DHKey complete failed (0x%02x)",
+								evt->status);
+		tester_test_failed();
+		return;
+	}
+
+	util_hexdump('>', evt->dhkey, 32, test_debug, NULL);
+
+
+	util_hexdump('S', keys->remote_sk, 32, test_debug, NULL);
+	util_hexdump('P', keys->local_pk, 64, test_debug, NULL);
+
+	/* Generate DHKey ourself with local public key and remote
+	 * private key we got when generated public / private key
+	 * pair for BT_HCI_CMD_LE_GENERATE_DHKEY argument.
 	 */
+	ecdh_shared_secret(keys->local_pk, keys->remote_sk, dhkey);
 
-	tester_test_passed();
+	util_hexdump('D', dhkey, 32, test_debug, NULL);
+
+	if (!memcmp(dhkey, evt->dhkey, 32))
+		tester_test_passed();
+	else
+		tester_test_failed();
 }
 
 static void test_le_generate_dhkey_status(const void *data, uint8_t size,
@@ -508,12 +589,16 @@ static void test_le_generate_dhkey(const void *test_data)
 {
 	struct user_data *user = tester_get_data();
 	struct bt_hci_cmd_le_generate_dhkey cmd;
-	uint8_t remote_sk[32];
+	struct le_keys *keys = (void *)test_data;
+
+	ecc_make_key(cmd.remote_pk256, keys->remote_sk);
 
-	ecc_make_key(cmd.remote_pk256, remote_sk);
+	/* Unregister handler for META event */
+	bt_hci_unregister(user->hci_ut, 1);
 
 	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
-				test_le_generate_dhkey_complete, NULL, NULL);
+				test_le_generate_dhkey_complete, keys,
+				NULL);
 
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_GENERATE_DHKEY, &cmd,
 				sizeof(cmd), test_le_generate_dhkey_status,
@@ -849,7 +934,8 @@ int main(int argc, char *argv[])
 				test_le_rand);
 	test_hci_local("LE Read Local PK", &key_test_data, NULL,
 				test_le_read_local_pk);
-	test_hci_local("LE Generate DHKey", NULL, NULL,
+	test_hci_local("LE Generate DHKey", &key_test_data,
+				setup_le_generate_dhkey,
 				test_le_generate_dhkey);
 
 	test_hci_local("Inquiry (LIAC)", NULL, NULL, test_inquiry_liac);
-- 
2.1.4

