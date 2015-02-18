Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 04/11] unit/test-gatt: Add TP/GAR/CL/BI-28-C test
Date: Wed, 18 Feb 2015 16:39:59 +0530
Message-id: <1424257806-25815-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read Long
Characteristic Descriptor procedure fails due to read not permitted.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 276fa57..47692b8 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1632,6 +1632,12 @@ static const struct test_step test_long_read_10 = {
 	.length = sizeof(long_data_2)
 };
 
+static const struct test_step test_long_read_11 = {
+	.handle = 0x0004,
+	.func = test_long_read,
+	.expected_att_ecode = 0x02
+};
+
 static void notification_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
@@ -2795,5 +2801,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0c, 0x04, 0x00, 0xff, 0x01),
 			raw_pdu(0x0d, 0xff));
 
+	define_test_client("/TP/GAR/CL/BI-28-C", test_client, service_db_1,
+			&test_long_read_11,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x02));
+
 	return g_test_run();
 }
-- 
1.9.1

