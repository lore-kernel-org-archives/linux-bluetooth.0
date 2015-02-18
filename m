Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH 07/11] unit/test-gatt: Add TP/GAR/CL/BI-31-C test
Date: Wed, 18 Feb 2015 16:40:02 +0530
Message-id: <1424257806-25815-8-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify Generic Attribute Profile client behavior when the Read Long
Characteristic Descriptor procedure fails due to insufficient authorization.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9a657eb..39c3966 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1644,6 +1644,12 @@ static const struct test_step test_long_read_12 = {
 	.expected_att_ecode = 0x07
 };
 
+static const struct test_step test_long_read_13 = {
+	.handle = 0x0004,
+	.func = test_long_read,
+	.expected_att_ecode = 0x08
+};
+
 static void notification_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
@@ -2825,5 +2831,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0c, 0x00, 0x00, 0x00, 0x00),
 			raw_pdu(0x01, 0x0c, 0x00, 0x00, 0x01));
 
+	define_test_client("/TP/GAR/CL/BI-31-C", test_client, service_db_1,
+			&test_long_read_13,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x08));
+
 	return g_test_run();
 }
-- 
1.9.1

