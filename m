Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 03/23] unit/gatt: Add /TP/GAR/SR/BV-03-C test
Date: Wed, 21 Jan 2015 12:28:40 -0800
Message-Id: <1421872140-7581-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support the Read
using Characteristic UUID procedure, using a 16-bit UUID and using a
128-bit UUID if supported.
---
 unit/test-gatt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index aa612dc..f2a4dcb 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1868,6 +1868,30 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0c));
 
+	define_test_server("/TP/GAR/SR/BV-03-C/small", test_server, ts_small_db,
+			NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xFF, 0xFF, 0xef, 0xcd, 0xab,
+					0x89, 0x67, 0x45, 0x23, 0x01, 0x00,
+					0x00, 0x00, 0x00, 0x09, 0xB0, 0x00,
+					0x00),
+			raw_pdu(0x09, 0x03, 0x15, 0xF0, 0x09),
+			raw_pdu(0x08, 0x01, 0x00, 0xFF, 0xFF, 0x01, 0x2a),
+			raw_pdu(0x09, 0x04, 0x17, 0xF0, 0x00, 0x00));
+
+	define_test_server("/TP/GAR/SR/BV-03-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xFF, 0xFF, 0xef, 0xcd, 0xab,
+					0x89, 0x67, 0x45, 0x23, 0x01, 0x00,
+					0x00, 0x00, 0x00, 0xd4, 0xd5, 0x00,
+					0x00),
+			raw_pdu(0x09, 0x03, 0x76, 0x00, 0x44),
+			raw_pdu(0x08, 0x01, 0x00, 0xFF, 0xFF, 0x02, 0xB0),
+			raw_pdu(0x09, 0x15, 0x25, 0x00, '1', '1', '1', '1', '1',
+				'2', '2', '2', '2', '2', '3', '3', '3', '3',
+				'3', '4', '4', '4', '4'));
+
 	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_db_1,
 			&test_multiple_read_1,
 			SERVICE_DATA_1_PDUS,
-- 
2.2.0.rc0.207.ga3a616c

