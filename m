Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/7] unit/test-gatt: Add TP/GAW/CL/BV-08-C test
Date: Thu, 05 Mar 2015 14:43:32 +0530
Message-id: <1425546818-23258-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425546818-23258-1-git-send-email-gowtham.ab@samsung.com>
References: <1425546818-23258-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can write a
characteristic descriptor selected by handle.
---
 unit/test-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 06f9193..8aec60b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -829,6 +829,14 @@ static const struct test_step test_write_6 = {
 	.length = 0x03
 };
 
+static const struct test_step test_write_7 = {
+	.handle = 0x0008,
+	.func = test_write,
+	.expected_att_ecode = 0,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void test_write_without_response(struct context *context)
 {
 	const struct test_step *step = context->data->step;
@@ -3087,5 +3095,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x04, 0x00, 0x03));
 
+	define_test_client("/TP/GAW/CL/BV-08-C", test_client, service_db_1,
+			&test_write_7,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x12, 0x08, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
 	return tester_run();
 }
-- 
1.9.1

