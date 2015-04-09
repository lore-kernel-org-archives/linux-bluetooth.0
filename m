Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/6] unit/test-gatt: Add TP/GAW/CL/BI-25-C test
Date: Thu, 09 Apr 2015 16:41:27 +0530
Message-id: <1428577891-3885-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1428577891-3885-1-git-send-email-gowtham.ab@samsung.com>
References: <1428577891-3885-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Write
Long Characteristic Descriptor procedure fails due to invalid
handle.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index b3e9eb9..fff8c3d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1098,6 +1098,14 @@ static const struct test_step test_long_write_7 = {
 	.length = sizeof(long_data_2)
 };
 
+static const struct test_step test_long_write_8 = {
+	.handle = 0x0000,
+	.func = test_long_write,
+	.expected_att_ecode = 0x01,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -4096,6 +4104,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x18, 0x01),
 			raw_pdu(0x19));
 
+	define_test_client("/TP/GAW/CL/BI-25-C", test_client, service_db_1,
+			&test_long_write_8,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x16, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x16, 0x00, 0x00, 0x01),
+			raw_pdu(0x18, 0x00),
+			raw_pdu(0x19));
+
 	define_test_server("/TP/GAW/SR/BV-09-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
1.9.1

