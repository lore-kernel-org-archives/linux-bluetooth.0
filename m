Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH 10/11] unit/test-gatt: Add TP/GAR/CL/BI-34-C test
Date: Wed, 18 Feb 2015 16:40:05 +0530
Message-id: <1424257806-25815-11-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify Generic Attribute Profile client behavior when an attempt to use
BR/EDR transport to execute the Read Characteristic Value procedure on a
characteristic contained within a service defined for use only over
LE transport.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 082527c..51f2179 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -772,6 +772,12 @@ static const struct test_step test_read_11 = {
 	.expected_att_ecode = 0x0c,
 };
 
+static const struct test_step test_read_12 = {
+	.handle = 0x0003,
+	.func = test_read,
+	.expected_att_ecode = 0x80,
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2861,5 +2867,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
 			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x0c));
 
+	define_test_client("/TP/GAR/CL/BI-34-C", test_client, service_db_1,
+			&test_read_12,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x80));
+
 	return g_test_run();
 }
-- 
1.9.1

