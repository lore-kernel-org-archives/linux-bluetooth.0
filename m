Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/3] unit/gatt: Add TP/GAR/CL/BI-05-C test
Date: Mon, 09 Feb 2015 17:53:23 +0530
Message-id: <1423484604-24982-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1423484604-24982-1-git-send-email-gowtham.ab@samsung.com>
References: <1423484604-24982-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read
Characteristic Value procedure fails due to insufficient encryption
key size.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5952026..22c9823 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -662,6 +662,12 @@ static const struct test_step test_read_5 = {
 	.expected_att_ecode = 0x05,
 };
 
+static const struct test_step test_read_6 = {
+	.handle = 0x0003,
+	.func = test_read,
+	.expected_att_ecode = 0x0c,
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -1860,6 +1866,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x05));
 
+	define_test_client("/TP/GAR/CL/BI-05-C", test_client, service_db_1,
+			&test_read_6,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x0c));
+
 	define_test_server("/TP/GAR/SR/BV-01-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
1.9.1

