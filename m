Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/7] unit/test-gatt: Add TP/GAW/CL/BI-20-C test
Date: Thu, 05 Mar 2015 14:43:33 +0530
Message-id: <1425546818-23258-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425546818-23258-1-git-send-email-gowtham.ab@samsung.com>
References: <1425546818-23258-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Write
Characteristic Descriptor procedure fails due to invalid handle.
---
 unit/test-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 8aec60b..3c664fe 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -837,6 +837,14 @@ static const struct test_step test_write_7 = {
 	.length = 0x03
 };
 
+static const struct test_step test_write_8 = {
+	.handle = 0x0000,
+	.func = test_write,
+	.expected_att_ecode = 0x01,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void test_write_without_response(struct context *context)
 {
 	const struct test_step *step = context->data->step;
@@ -3101,5 +3109,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x08, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x13));
 
+	define_test_client("/TP/GAW/CL/BI-20-C", test_client, service_db_1,
+			&test_write_8,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x12, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x00, 0x00, 0x01));
+
 	return tester_run();
 }
-- 
1.9.1

