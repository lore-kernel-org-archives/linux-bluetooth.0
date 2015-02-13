Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, gowtham.ab@samsung.com,
	Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  6/6] unit/gatt: Add TP/GAR/CL/BI-27-C test
Date: Fri, 13 Feb 2015 20:18:20 +0530
Message-id: <1423838900-18110-7-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
References: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read
Characteristic Descriptor procedure fails due to insufficient
encryption key size.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 89c9f23..f6a44bd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -765,6 +765,12 @@ static const struct test_step test_read_10 = {
 	.expected_att_ecode = 0x05,
 };
 
+static const struct test_step test_read_11 = {
+	.handle = 0x0004,
+	.func = test_read,
+	.expected_att_ecode = 0x0c,
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2648,5 +2654,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x04, 0x00),
 			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x05));
 
+	define_test_client("/TP/GAR/CL/BI-27-C", test_client, service_db_1,
+			&test_read_11,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x0c));
+
 	return g_test_run();
 }
-- 
1.9.1

