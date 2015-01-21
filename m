Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 19/23] unit/gatt: Add /TP/GAR/SR/BV-07-C test
Date: Wed, 21 Jan 2015 12:28:56 -0800
Message-Id: <1421872140-7581-20-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support reading a
Long Characteristic Descriptor selected by handle.
---
 unit/test-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d8efb5d..ca4ea45 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2069,5 +2069,19 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0A, 0xF0, 0x0F),
 			raw_pdu(0x01, 0x0A, 0xF0, 0x0F, 0x01));
 
+	define_test_server("/TP/GAR/SR/BV-07-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0C, 0xD1, 0x00, 0x00, 0x00),
+			raw_pdu(0x0D, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+				0x88, 0x99, 0x00, 0x12, 0x34, 0x56, 0x78, 0x90,
+				0x12, 0x34, 0x56, 0x78, 0x90, 0x12, 0x34),
+			raw_pdu(0x0C, 0xD1, 0x00, 0x16, 0x00),
+			raw_pdu(0x0D, 0x56, 0x78, 0x90, 0x12, 0x34, 0x56, 0x78,
+				0x90, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+				0x88, 0x99, 0x00, 0x11, 0x22, 0x33, 0x44),
+			raw_pdu(0x0C, 0xD1, 0x00, 0x2C, 0x00),
+			raw_pdu(0x0D));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

