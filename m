Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, gowtham.ab@samsung.com
Subject: [PATCH  1/6] unit/gatt: Add /TP/GAR/CL/BV-06-C test
Date: Fri, 13 Feb 2015 20:18:15 +0530
Message-id: <1423838900-18110-2-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
References: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gowtham Anandha Babu <gowtham.ab@samsung.com>

Verify that a Generic Attribute Profile client can read a
characteristic descriptor selected by handle.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6c98cfa..5f07d2d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -739,6 +739,13 @@ static const struct test_step test_read_6 = {
 	.expected_att_ecode = 0x0c,
 };
 
+static const struct test_step test_read_7 = {
+	.handle = 0x0004,
+	.func = test_read,
+	.expected_att_ecode = 0x00,
+	.value = read_data_1,
+	.length = 0x03
+};
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2592,5 +2599,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x1D, 0x03, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x1E));
 
+	define_test_client("/TP/GAR/CL/BV-06-C", test_client, service_db_1,
+			&test_read_7,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
+
 	return g_test_run();
 }
-- 
1.9.1

