Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 07/23] unit/gatt: Add /TP/GAR/SR/BV-04-C test
Date: Wed, 21 Jan 2015 12:28:44 -0800
Message-Id: <1421872140-7581-8-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support reading a
long Characteristic Value selected by handle.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index f9c7e27..b96adb5 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1922,6 +1922,22 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x02, 0x00, 0x01, 0x00, 0x00, 0x28),
 			raw_pdu(0x01, 0x08, 0x02, 0x00, 0x01));
 
+	define_test_server("/TP/GAR/SR/BV-04-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0C, 0xD3, 0x00, 0x00, 0x00),
+			raw_pdu(0x0D, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+				0x88, 0x99, 0x00, 0x11, 0x22, 0x33, 0x44, 0x55,
+				0x66, 0x77, 0x88, 0x99, 0x00, 0x11, 0x22),
+			raw_pdu(0x0C, 0xD3, 0x00, 0x16, 0x00),
+			raw_pdu(0x0D, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99,
+				0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+				0x88, 0x99, 0x00, 0x11, 0x22, 0x33, 0x44),
+			raw_pdu(0x0C, 0xD3, 0x00, 0x2C, 0x00),
+			raw_pdu(0x0D, 0x55),
+			raw_pdu(0x0C, 0xD3, 0x00, 0x2D, 0x00),
+			raw_pdu(0x0D));
+
 	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_db_1,
 			&test_multiple_read_1,
 			SERVICE_DATA_1_PDUS,
-- 
2.2.0.rc0.207.ga3a616c

