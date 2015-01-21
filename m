Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 18/23] unit/gatt: Add /TP/GAR/SR/BI-24-C test
Date: Wed, 21 Jan 2015 12:28:55 -0800
Message-Id: <1421872140-7581-19-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect and reject a
Read Characteristic Descriptor Request with an unsupported
characteristic descriptor handle and issue an Invalid Handle Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index ecbebe9..d8efb5d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2057,5 +2057,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0A, 0x96, 0x00),
 			raw_pdu(0x01, 0x0A, 0x96, 0x00, 0x02));
 
+	define_test_server("/TP/GAR/SR/BI-24-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0A, 0xF0, 0x0F),
+			raw_pdu(0x01, 0x0A, 0xF0, 0x0F, 0x01));
+
+	define_test_server("/TP/GAR/SR/BI-24-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0A, 0xF0, 0x0F),
+			raw_pdu(0x01, 0x0A, 0xF0, 0x0F, 0x01));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

