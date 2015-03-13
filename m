Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH  3/7] unit/test-gatt: Add TP/GAW/SR/BI-08-C test
Date: Fri, 13 Mar 2015 12:04:42 +0530
Message-id: <1426228486-5124-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426228486-5124-1-git-send-email-gowtham.ab@samsung.com>
References: <1426228486-5124-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify that a Generic Attribute Profile server can detect and reject
a Write Long Characteristic Value Request to a non-writeable long
Characteristic Value and issue a Write Not Permitted Response.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5e79293..22bfe44 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3187,6 +3187,22 @@ int main(int argc, char *argv[])
 				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
 			raw_pdu(0x01, 0x16, 0x0f, 0xf0, 0x01));
 
+	define_test_server("/TP/GAW/SR/BI-08-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x05, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
+			raw_pdu(0x01, 0x16, 0x05, 0x00, 0x03));
+
+	define_test_server("/TP/GAW/SR/BI-08-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x73, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
+			raw_pdu(0x01, 0x16, 0x73, 0x00, 0x03));
+
 	define_test_client("/TP/GAW/CL/BV-08-C", test_client, service_db_1,
 			&test_write_7,
 			SERVICE_DATA_1_PDUS,
-- 
1.9.1

