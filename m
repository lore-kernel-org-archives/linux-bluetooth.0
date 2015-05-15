Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/8] tester: Add HCI LE Encrypt command test
Date: Fri, 15 May 2015 16:46:21 +0300
Message-Id: <1431697586-20611-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use RFC 4493 "The AES-CMAC Algorithm" sample test vectors to test HCI
controller encryption.
---
 tools/hci-tester.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index a5dbde2..903921d 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -45,6 +45,19 @@ struct user_data {
 	uint16_t handle_ut;
 };
 
+static void swap_buf(const uint8_t *src, uint8_t *dst, uint16_t len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		dst[len - 1 - i] = src[i];
+}
+
+static void test_debug(const char *str, void *user_data)
+{
+	tester_debug("%s", str);
+}
+
 static void test_pre_setup_lt_address(const void *data, uint8_t size,
 							void *user_data)
 {
@@ -339,6 +352,60 @@ static void test_le_clear_white_list(const void *test_data)
 	test_command(BT_HCI_CMD_LE_CLEAR_WHITE_LIST);
 }
 
+static void test_le_encrypt_complete(const void *data, uint8_t size,
+								void *user_data)
+{
+	const struct bt_hci_rsp_le_encrypt *rsp = data;
+	uint8_t sample[16] = {
+		0x7d, 0xf7, 0x6b, 0x0c, 0x1a, 0xb8, 0x99, 0xb3,
+		0x3e, 0x42, 0xf0, 0x47, 0xb9, 0x1b, 0x54, 0x6f
+	};
+	uint8_t enc_data[16];
+
+	if (rsp->status) {
+		tester_warn("Failed HCI LE Encrypt (0x%02x)", rsp->status);
+		tester_test_failed();
+		return;
+	}
+
+	swap_buf(rsp->data, enc_data, 16);
+	util_hexdump('>', enc_data, 16, test_debug, NULL);
+
+	if (!memcmp(sample, enc_data, 16))
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+/* Data are taken from RFC 4493 Test Vectors */
+static void test_le_encrypt(const void *test_data)
+{
+	struct user_data *user = tester_get_data();
+	struct bt_hci_cmd_le_encrypt cmd;
+	uint8_t key[16] = {
+		0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
+		0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c
+	};
+	uint8_t plaintext[16] = { 0 };
+
+	/* Swap bytes since our interface has LE interface, opposed to
+	 * common crypto interface
+	 */
+	swap_buf(key, cmd.key, 16);
+	swap_buf(plaintext, cmd.plaintext, 16);
+
+	util_hexdump('<', cmd.key, 16, test_debug, NULL);
+	util_hexdump('<', cmd.plaintext, 16, test_debug, NULL);
+
+	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_ENCRYPT, &cmd, sizeof(cmd),
+					test_le_encrypt_complete, NULL, NULL)) {
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
@@ -657,6 +724,8 @@ int main(int argc, char *argv[])
 				test_le_read_white_list_size);
 	test_hci_local("LE Clear White List", NULL, NULL,
 				test_le_clear_white_list);
+	test_hci_local("LE Encrypt", NULL, NULL,
+				test_le_encrypt);
 
 	test_hci_local("Inquiry (LIAC)", NULL, NULL, test_inquiry_liac);
 
-- 
2.1.4

