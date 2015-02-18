Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 02/11] unit/test-gatt: Add TP/GAR/CL/BV-07-C test
Date: Wed, 18 Feb 2015 16:39:57 +0530
Message-id: <1424257806-25815-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can read a characteristic descriptor
by selected handle. The Characteristic Descriptor length is unknown to the client and
might be long.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 2fc0595..295d10b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1614,6 +1614,16 @@ static const struct test_step test_long_read_8 = {
 	.expected_att_ecode = 0x0c
 };
 
+/* Descriptor test data's */
+
+static const struct test_step test_long_read_9 = {
+	.handle = 0x0004,
+	.func = test_long_read,
+	.expected_att_ecode = 0,
+	.value = read_data_1,
+	.length = 0x03
+};
+
 static void notification_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
@@ -2661,5 +2671,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x04, 0x00),
 			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x0c));
 
+	define_test_client("/TP/GAR/CL/BV-07-C", test_client, service_db_1,
+			&test_long_read_9,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
+
 	return g_test_run();
 }
-- 
1.9.1

