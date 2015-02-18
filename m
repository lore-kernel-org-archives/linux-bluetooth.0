Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 05/11] unit/test-gatt: Add TP/GAR/CL/BI-29-C test
Date: Wed, 18 Feb 2015 16:40:00 +0530
Message-id: <1424257806-25815-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read Long
Characteristic Descriptor procedure fails due to invalid offset.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 47692b8..36565bd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1638,6 +1638,12 @@ static const struct test_step test_long_read_11 = {
 	.expected_att_ecode = 0x02
 };
 
+static const struct test_step test_long_read_12 = {
+	.handle = 0x0004,
+	.func = test_long_read,
+	.expected_att_ecode = 0x07
+};
+
 static void notification_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
@@ -2807,5 +2813,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
 			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x02));
 
+	define_test_client("/TP/GAR/CL/BI-29-C", test_client, service_db_1,
+			&test_long_read_12,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x07));
+
 	return g_test_run();
 }
-- 
1.9.1

