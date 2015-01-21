Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 01/23] unit/gatt: Add /TP/GAD/CL/BV-05-C test
Date: Wed, 21 Jan 2015 12:28:38 -0800
Message-Id: <1421872140-7581-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can discover
characteristics of a specified service, using 16-bit and 128-bit
characteristic UUIDs.
---
 unit/test-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index b6be716..2f8750d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1680,6 +1680,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x29, 0x00, 0x29, 0x00, 0x03, 0x28),
 			raw_pdu(0x01, 0x08, 0x29, 0x00, 0x0a));
 
+	define_test_att("/TP/GAD/CL/BV-05-C", test_search_chars, NULL,
+			NULL,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x07, 0x11, 0x00, 02, 0x12, 0x00, 0x25,
+					0x2a),
+			raw_pdu(0x08, 0x12, 0x00, 0x20, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x15, 0x13, 0x00, 0x02, 0x14, 0x00, 0x85,
+					0x00, 0xef, 0xcd, 0xab, 0x89, 0x67,
+					0x45, 0x23, 0x01, 0x00, 0x00, 0x00,
+					0x00, 0x00, 0x00),
+			raw_pdu(0x08, 0x14, 0x00, 0x20, 0x00, 0x03, 0x28),
+			raw_pdu(0x01, 0x08, 0x12, 0x00, 0x0a));
+
 	define_test_att("/TP/GAD/CL/BV-06-C", test_search_descs, NULL, NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x04, 0x13, 0x00, 0x16, 0x00),
-- 
2.2.0.rc0.207.ga3a616c

