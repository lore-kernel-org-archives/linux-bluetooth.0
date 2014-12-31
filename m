Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 14/14] unit/gatt: Add /TP/GAR/SR/BI-02-C test
Date: Tue, 30 Dec 2014 16:32:32 -0800
Message-Id: <1419985952-18334-15-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect and reject a
Read Characteristic Value Request with an unsupported Characteristic
Value handle and issue an Invalid Handle Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 25a382b..8bdd2fd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1739,6 +1739,18 @@ int main(int argc, char *argv[])
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

