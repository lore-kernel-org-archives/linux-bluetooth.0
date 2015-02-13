Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, gowtham.ab@samsung.com,
	Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  5/6] unit/gatt: Add TP/GAR/CL/BI-26-C test
Date: Fri, 13 Feb 2015 20:18:19 +0530
Message-id: <1423838900-18110-6-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
References: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read
Characteristic Descriptor procedure fails due to insufficient
authentication.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 55b06f6..89c9f23 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -759,6 +759,12 @@ static const struct test_step test_read_9 = {
 	.expected_att_ecode = 0x08,
 };
 
+static const struct test_step test_read_10 = {
+	.handle = 0x0004,
+	.func = test_read,
+	.expected_att_ecode = 0x05,
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2636,5 +2642,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x04, 0x00),
 			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x08));
 
+	define_test_client("/TP/GAR/CL/BI-26-C", test_client, service_db_1,
+			&test_read_10,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x05));
+
 	return g_test_run();
 }
-- 
1.9.1

