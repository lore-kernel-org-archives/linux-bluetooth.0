Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 12/14] unit/gatt: Add /TP/GAD/SR/BV-06-C test
Date: Tue, 30 Dec 2014 16:32:30 -0800
Message-Id: <1419985952-18334-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support a search for
all descriptors of a specified characteristic.
---
 unit/test-gatt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9981afe..5740322 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1678,6 +1678,25 @@ int main(int argc, char *argv[])
 			raw_pdu(0x05, 0x01, 0x15, 0x00, 0x04, 0x29, 0x16, 0x00,
 					0x05, 0x29));
 
+	define_test_server("/TP/GAD/SR/BV-06-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x04, 0x04, 0x00, 0x05, 0x00),
+			raw_pdu(0x05, 0x01, 0x04, 0x00, 0x02, 0x29, 0x05, 0x00,
+					0x01, 0x29));
+
+	define_test_server("/TP/GAD/SR/BV-06-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x04, 0x73, 0x00, 0x76, 0x00),
+			raw_pdu(0x05, 0x01, 0x73, 0x00, 0x00, 0x29, 0x74, 0x00,
+				0x01, 0x29, 0x75, 0x00, 0x04, 0x29),
+			raw_pdu(0x04, 0x76, 0x00, 0x76, 0x00),
+			raw_pdu(0x05, 0x02, 0x76, 0x00, 0xef, 0xcd, 0xab, 0x89,
+				0x67, 0x45, 0x23, 0x01, 0x00, 0x00, 0x00, 0x00,
+				0xd4, 0xd5, 0x00, 0x00));
+
+
 	define_test_client("/TP/GAR/CL/BV-01-C", test_client, service_db_1,
 			&test_read_1,
 			SERVICE_DATA_1_PDUS,
-- 
2.2.0.rc0.207.ga3a616c

