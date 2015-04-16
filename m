Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  5/7] unit/gatt: Add TP/GAW/CL/BI-18-C test
Date: Thu, 16 Apr 2015 18:18:39 +0530
Message-id: <1429188521-30894-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1429188521-30894-1-git-send-email-gowtham.ab@samsung.com>
References: <1429188521-30894-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Characteristic
Value Reliable Write procedure fails due to insufficient authentication.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d97290e..40e17fd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1193,6 +1193,14 @@ static const struct test_step test_reliable_write_4 = {
 	.length = 0x03
 };
 
+static const struct test_step test_reliable_write_5 = {
+	.handle = 0x0007,
+	.func = test_reliable_write,
+	.expected_att_ecode = 0x05,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -3867,6 +3875,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x18, 0x00),
 			raw_pdu(0x19));
 
+	define_test_client("/TP/GAW/CL/BI-18-C", test_client, service_db_1,
+			&test_reliable_write_5,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x16, 0x07, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x16, 0x07, 0x00, 0x05),
+			raw_pdu(0x18, 0x00),
+			raw_pdu(0x19));
+
 	define_test_server("/TP/GAW/SR/BV-06-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
1.9.1

