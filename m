Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 09/14] unit/gatt: Add /TP/GAD/SR/BV-03-C test
Date: Tue, 30 Dec 2014 16:32:27 -0800
Message-Id: <1419985952-18334-10-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support a search for
all Included Services in a specified handle range.
---
 unit/test-gatt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index fbccb18..4412219 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1589,6 +1589,28 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x06, 0x00, 0xff, 0xff, 0x02, 0x28),
 			raw_pdu(0x01, 0x08, 0x06, 0x00, 0x0a));
 
+	define_test_server("/TP/GAD/SR/BV-03-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x09, 0x08, 0x11, 0xf0, 0x01, 0x00, 0x10, 0x00,
+					0x0a, 0x18),
+			raw_pdu(0x08, 0x12, 0xf0, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x01, 0x08, 0x12, 0xf0, 0x0a));
+
+	define_test_server("/TP/GAD/SR/BV-03-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x09, 0x08, 0x02, 0x00, 0x80, 0x00, 0x85, 0x00,
+				0x0b, 0xa0, 0x21, 0x00, 0x01, 0x00, 0x06, 0x00,
+				0x0d, 0xa0),
+			raw_pdu(0x08, 0x22, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x09, 0x08, 0x91, 0x00, 0x01, 0x00, 0x06, 0x00,
+				0x0d, 0xa0),
+			raw_pdu(0x08, 0x92, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x01, 0x08, 0x92, 0x00, 0x0a));
+
 	define_test_att("/TP/GAD/CL/BV-04-C", test_search_chars, NULL,
 			NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
-- 
2.2.0.rc0.207.ga3a616c

