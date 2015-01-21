Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 16/23] unit/gatt: Add /TP/GAR/SR/BV-06-C test
Date: Wed, 21 Jan 2015 12:28:53 -0800
Message-Id: <1421872140-7581-17-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support reading a
characteristic descriptor selected by handle.
---
 unit/test-gatt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 8f5b076..dbbd504 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2036,5 +2036,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x44, 0x00, 0xF0, 0x0F),
 			raw_pdu(0x01, 0x0e, 0xF0, 0x0F, 0x01));
 
+	define_test_server("/TP/GAR/SR/BV-06-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0A, 0x05, 0x00),
+			raw_pdu(0x0B, 'M', 'a', 'n', 'u', 'f', 'a', 'c', 't',
+				'u', 'r', 'e', 'r', ' ', 'N', 'a', 'm', 'e'));
+
+	define_test_server("/TP/GAR/SR/BV-06-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0A, 0xD4, 0x00),
+			raw_pdu(0x0B, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+				0x88, 0x99, 0x00, 0x12, 0x34, 0x56, 0x78, 0x90,
+				0x12, 0x34, 0x56, 0x78, 0x90, 0x12, 0x34));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

