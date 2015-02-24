Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  5/6] unit/test-gatt: Add TP/GAW/CL/BI-05-C test
Date: Tue, 24 Feb 2015 16:47:39 +0530
Message-id: <1424776660-27719-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424776660-27719-1-git-send-email-gowtham.ab@samsung.com>
References: <1424776660-27719-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the
Write Characteristic Value procedure fails due to insufficient
authentication.
---
 unit/test-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 7a0c686..effd149 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -811,6 +811,14 @@ static const struct test_step test_write_4 = {
 	.length = 0x03
 };
 
+static const struct test_step test_write_5 = {
+	.handle = 0x0007,
+	.func = test_write,
+	.expected_att_ecode = 0x05,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2921,5 +2929,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x08));
 
+	define_test_client("/TP/GAW/CL/BI-05-C", test_client, service_db_1,
+			&test_write_5,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x05));
+
 	return tester_run();
 }
-- 
1.9.1

