Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 11/23] unit/gatt: Add /TP/GAR/SR/BI-14-C test
Date: Wed, 21 Jan 2015 12:28:48 -0800
Message-Id: <1421872140-7581-12-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect and reject a
Read Long Characteristic Value Request to an invalid handle and issue an
Invalid Handle Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5741918..fc98558 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1956,6 +1956,18 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0C, 0xD3, 0x00, 0xF0, 0x00),
 			raw_pdu(0x01, 0x0C, 0xD3, 0x00, 0x07));
 
+	define_test_server("/TP/GAR/SR/BI-14-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0C, 0xF0, 0x0F, 0x00, 0x00),
+			raw_pdu(0x01, 0x0C, 0xF0, 0x0F, 0x01));
+
+	define_test_server("/TP/GAR/SR/BI-14-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0C, 0xF0, 0x0F, 0x00, 0x00),
+			raw_pdu(0x01, 0x0C, 0xF0, 0x0F, 0x01));
+
 	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_db_1,
 			&test_multiple_read_1,
 			SERVICE_DATA_1_PDUS,
-- 
2.2.0.rc0.207.ga3a616c

