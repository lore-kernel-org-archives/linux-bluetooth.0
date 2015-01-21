Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 22/23] unit/gatt: Add /TP/GAR/SR/BI-29-C test
Date: Wed, 21 Jan 2015 12:28:59 -0800
Message-Id: <1421872140-7581-23-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect and reject a
Read Long Characteristic Descriptor Request with an invalid offset and
issue an Invalid Offset Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d31a157..e09b055 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2103,5 +2103,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0C, 0x96, 0x00, 0x00, 0x00),
 			raw_pdu(0x01, 0x0C, 0x96, 0x00, 0x02));
 
+	define_test_server("/TP/GAR/SR/BI-29-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0C, 0x05, 0x00, 0xF0, 0x00),
+			raw_pdu(0x01, 0x0C, 0x05, 0x00, 0x07));
+
+	define_test_server("/TP/GAR/SR/BI-29-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0C, 0xCE, 0x00, 0xF0, 0x00),
+			raw_pdu(0x01, 0x0C, 0xCE, 0x00, 0x07));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

