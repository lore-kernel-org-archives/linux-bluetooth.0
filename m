Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, gowtham.ab@samsung.com,
	Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  4/6] unit/gatt: Add TP/GAR/CL/BI-25-C test
Date: Fri, 13 Feb 2015 20:18:18 +0530
Message-id: <1423838900-18110-5-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
References: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read
Characteristic Descriptor procedure fails due to insufficient
authorization.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 2594b0f..55b06f6 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -753,6 +753,12 @@ static const struct test_step test_read_8 = {
 	.expected_att_ecode = 0x02,
 };
 
+static const struct test_step test_read_9 = {
+	.handle = 0x0004,
+	.func = test_read,
+	.expected_att_ecode = 0x08,
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2624,5 +2630,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x00, 0x00),
 			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x01));
 
+	define_test_client("/TP/GAR/CL/BI-25-C", test_client, service_db_1,
+			&test_read_9,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x08));
+
 	return g_test_run();
 }
-- 
1.9.1

