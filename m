Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/7] unit/test-gatt: Add TP/GAW/SR/BV-06-C test
Date: Wed, 18 Mar 2015 15:35:35 +0530
Message-id: <1426673141-17700-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
References: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support reliable
writing to a Characteristic Value selected by handle.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 93ee2c7..65bdc52 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3203,6 +3203,22 @@ int main(int argc, char *argv[])
 				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
 			raw_pdu(0x01, 0x16, 0x73, 0x00, 0x03));
 
+	define_test_server("/TP/GAW/SR/BV-06-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x03, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x03, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x18, 0x01),
+			raw_pdu(0x19));
+
+	define_test_server("/TP/GAW/SR/BV-06-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x82, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x82, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x18, 0x01),
+			raw_pdu(0x19));
+
 	define_test_client("/TP/GAW/CL/BV-08-C", test_client, service_db_1,
 			&test_write_7,
 			SERVICE_DATA_1_PDUS,
-- 
1.9.1

