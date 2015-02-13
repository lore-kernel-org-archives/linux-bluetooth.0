Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, gowtham.ab@samsung.com
Subject: [PATCH  2/6] unit/gatt: Add TP/GAR/CL/BI-23-C test
Date: Fri, 13 Feb 2015 20:18:16 +0530
Message-id: <1423838900-18110-3-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
References: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gowtham Anandha Babu <gowtham.ab@samsung.com>

Verify Generic Attribute Profile client behavior when the Read
Characteristic Descriptor procedure fails due to read not permitted.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5f07d2d..6fc4212 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -746,6 +746,13 @@ static const struct test_step test_read_7 = {
 	.value = read_data_1,
 	.length = 0x03
 };
+
+static const struct test_step test_read_8 = {
+	.handle = 0x0004,
+	.func = test_read,
+	.expected_att_ecode = 0x02,
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2605,5 +2612,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x04, 0x00),
 			raw_pdu(0x0b, 0x01, 0x02, 0x03));
 
+	define_test_client("/TP/GAR/CL/BI-23-C", test_client, service_db_1,
+			&test_read_8,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x02));
+
 	return g_test_run();
 }
-- 
1.9.1

