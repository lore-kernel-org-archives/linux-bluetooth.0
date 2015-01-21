Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 13/23] unit/gatt: Add /TP/GAR/SR/BV-05-C test
Date: Wed, 21 Jan 2015 12:28:50 -0800
Message-Id: <1421872140-7581-14-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support reading
multiple Characteristic Values selected by a set of handles.
---
 unit/test-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index fc98558..5856630 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2004,5 +2004,19 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x0c));
 
+	define_test_server("/TP/GAR/SR/BV-05-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0e, 0x15, 0xF0, 0x03, 0x00),
+			raw_pdu(0x0f, 0x09, 'B', 'l', 'u', 'e', 'Z'));
+
+	define_test_server("/TP/GAR/SR/BV-05-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0e, 0x44, 0x00, 0x06, 0x00, 0xC4, 0x00),
+			raw_pdu(0x0f, 0x11, 0x0B, '1', '1', '1', '1', '1', '2',
+				'2', '2', '2', '2', '3', '3', '3', '3', '3',
+				'4', '4', '4', '4', '4'));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

