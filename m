Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 12/12] unit/gatt: Add /TP/GAR/SR/BI-02-C test
Date: Mon,  5 Jan 2015 13:32:54 -0800
Message-Id: <1420493574-37305-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
References: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect and reject a
Read Characteristic Value Request with an unsupported Characteristic
Value handle and issue an Invalid Handle Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 582cee9..684c1c8 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1754,6 +1754,18 @@ int main(int argc, char *argv[])
 				'4', '4', '5', '5', '5', '5', '5', '6', '6',
 				'6', '6', '6', '7', '7'));
 
+	define_test_server("/TP/GAR/SR/BI-02-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x00, 0x00),
+			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x01));
+
+	define_test_server("/TP/GAR/SR/BI-02-C/large", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x0f, 0xf0),
+			raw_pdu(0x01, 0x0a, 0x0f, 0xf0, 0x01));
+
 	define_test_att("/TP/GAR/CL/BV-03-C-1", test_read_by_type,
 			&uuid_char_16, &test_read_by_type_1,
 			raw_pdu(0x02, 0x00, 0x02),
-- 
2.2.0.rc0.207.ga3a616c

