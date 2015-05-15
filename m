Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/8] tester: Add HCI LE Rand command
Date: Fri, 15 May 2015 16:46:22 +0300
Message-Id: <1431697586-20611-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check status only
---
 tools/hci-tester.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 903921d..4b27038 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -406,6 +406,11 @@ static void test_le_encrypt(const void *test_data)
 
 }
 
+static void test_le_rand(const void *test_data)
+{
+	test_command(BT_HCI_CMD_LE_RAND);
+}
+
 static void test_inquiry_complete(const void *data, uint8_t size,
 							void *user_data)
 {
@@ -726,6 +731,8 @@ int main(int argc, char *argv[])
 				test_le_clear_white_list);
 	test_hci_local("LE Encrypt", NULL, NULL,
 				test_le_encrypt);
+	test_hci_local("LE Rand", NULL, NULL,
+				test_le_rand);
 
 	test_hci_local("Inquiry (LIAC)", NULL, NULL, test_inquiry_liac);
 
-- 
2.1.4

