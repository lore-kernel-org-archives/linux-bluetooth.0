Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  5/7] unit/test-gatt: Add TP/GAW/SR/BV-07-C test
Date: Wed, 18 Mar 2015 15:35:39 +0530
Message-id: <1426673141-17700-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
References: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support cancel
of a reliable write.
---
 unit/test-gatt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index fd5752f..3e4353f 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3107,6 +3107,28 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x0c));
 
+	define_test_server("/TP/GAW/SR/BV-07-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x03, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x03, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x18, 0x00),
+			raw_pdu(0x19),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x0b, 0x42, 0x6c, 0x75, 0x65, 0x5a));
+
+	define_test_server("/TP/GAW/SR/BV-07-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0xc4, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0xc4, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x18, 0x00),
+			raw_pdu(0x19),
+			raw_pdu(0x0a, 0xc4, 0x00),
+			raw_pdu(0x0b, '1', '1', '1', '1', '1', '2', '2', '2',
+				'2', '2', '3', '3', '3', '3', '3', '4', '4',
+				'4', '4', '4', '5'));
+
 	define_test_server("/TP/GAW/SR/BV-03-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
1.9.1

