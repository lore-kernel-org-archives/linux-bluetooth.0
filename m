Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] unit/gatt: Add TP/GAR/CL/BI-15-C test
Date: Tue, 27 Jan 2015 14:03:30 +0200
Message-Id: <1422360212-19812-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1422360212-19812-1-git-send-email-luiz.dentz@gmail.com>
References: <1422360212-19812-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify Generic Attribute Profile client behavior when the Read Long
Characteristic Value procedure fails due to insufficient authorization.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 2415c4b..c9eb5c3 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1478,6 +1478,12 @@ static const struct test_step test_long_read_5 = {
 	.expected_att_ecode = 0x01
 };
 
+static const struct test_step test_long_read_6 = {
+	.handle = 0x0003,
+	.func = test_long_read,
+	.expected_att_ecode = 0x08
+};
+
 int main(int argc, char *argv[])
 {
 	struct gatt_db *service_db_1, *ts_small_db, *ts_large_db_1;
@@ -2154,6 +2160,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
 			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x01));
 
+	define_test_client("/TP/GAR/CL/BI-15-C", test_client, service_db_1,
+			&test_long_read_6,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x08));
+
 	define_test_client("/TP/GAR/CL/BI-18-C", test_client, service_db_1,
 			&test_multiple_read_2,
 			SERVICE_DATA_1_PDUS,
-- 
2.1.0

