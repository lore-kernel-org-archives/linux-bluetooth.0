Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH  5/6] unit/test-gatt: Add TP/GAW/CL/BI-30-C test
Date: Thu, 09 Apr 2015 16:41:30 +0530
Message-id: <1428577891-3885-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1428577891-3885-1-git-send-email-gowtham.ab@samsung.com>
References: <1428577891-3885-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify Generic Attribute Profile client behavior when the Write
Long Characteristic Descriptor procedure fails due to insufficient
authentication.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 8458a5c..e29721e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1122,6 +1122,14 @@ static const struct test_step test_long_write_10 = {
 	.length = 0x03
 };
 
+static const struct test_step test_long_write_11 = {
+	.handle = 0x0008,
+	.func = test_long_write,
+	.expected_att_ecode = 0x05,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -4144,6 +4152,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x18, 0x00),
 			raw_pdu(0x19));
 
+	define_test_client("/TP/GAW/CL/BI-30-C", test_client, service_db_1,
+			&test_long_write_11,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x16, 0x08, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x16, 0x08, 0x00, 0x05),
+			raw_pdu(0x18, 0x00),
+			raw_pdu(0x19));
+
 	define_test_server("/TP/GAW/SR/BV-09-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
1.9.1

