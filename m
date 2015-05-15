Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/8] tester: Add test for LE Read Local PK
Date: Fri, 15 May 2015 16:46:24 +0300
Message-Id: <1431697586-20611-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test that public/private key pair is generated.
---
 tools/hci-tester.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 4b27038..620832d 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -411,6 +411,11 @@ static void test_le_rand(const void *test_data)
 	test_command(BT_HCI_CMD_LE_RAND);
 }
 
+static void test_le_read_local_pk(const void *test_data)
+{
+	test_command(BT_HCI_CMD_LE_READ_LOCAL_PK256);
+}
+
 static void test_inquiry_complete(const void *data, uint8_t size,
 							void *user_data)
 {
@@ -733,6 +738,8 @@ int main(int argc, char *argv[])
 				test_le_encrypt);
 	test_hci_local("LE Rand", NULL, NULL,
 				test_le_rand);
+	test_hci_local("LE Read Local PK", NULL, NULL,
+				test_le_read_local_pk);
 
 	test_hci_local("Inquiry (LIAC)", NULL, NULL, test_inquiry_liac);
 
-- 
2.1.4

