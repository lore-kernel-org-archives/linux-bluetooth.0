Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 11/12] unit/gatt: Add /TP/GAR/SR/BV-01-C test
Date: Mon,  5 Jan 2015 13:32:53 -0800
Message-Id: <1420493574-37305-12-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
References: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support reading a
Characteristic Value selected by handle.
---
 unit/test-gatt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 44a10e8..582cee9 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1736,6 +1736,24 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x08));
 
+	define_test_server("/TP/GAR/SR/BV-01-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x0b, 0x42, 0x6c, 0x75, 0x65, 0x5a));
+
+	define_test_server("/TP/GAR/SR/BV-01-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0xc4, 0x00),
+			raw_pdu(0x0b, '1', '1', '1', '1', '1', '2', '2', '2',
+				'2', '2', '3', '3', '3', '3', '3', '4', '4',
+				'4', '4', '4', '5'),
+			raw_pdu(0x0a, 0xca, 0x00),
+			raw_pdu(0x0b, '3', '3', '3', '3', '3', '4', '4', '4',
+				'4', '4', '5', '5', '5', '5', '5', '6', '6',
+				'6', '6', '6', '7', '7'));
+
 	define_test_att("/TP/GAR/CL/BV-03-C-1", test_read_by_type,
 			&uuid_char_16, &test_read_by_type_1,
 			raw_pdu(0x02, 0x00, 0x02),
-- 
2.2.0.rc0.207.ga3a616c

