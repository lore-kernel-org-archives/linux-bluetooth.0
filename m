Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 14/23] unit/gatt: Add /TP/GAR/SR/BI-18-C test
Date: Wed, 21 Jan 2015 12:28:51 -0800
Message-Id: <1421872140-7581-15-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect and reject a
Read Multiple Characteristic Values Request including any non-readable
Characteristic Value and issue a Read Not Permitted Response.
---
 unit/test-gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5856630..29387f0 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2018,5 +2018,11 @@ int main(int argc, char *argv[])
 				'2', '2', '2', '2', '3', '3', '3', '3', '3',
 				'4', '4', '4', '4', '4'));
 
+	define_test_server("/TP/GAR/SR/BI-18-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0e, 0x44, 0x00, 0x06, 0x00, 0x27, 0x00),
+			raw_pdu(0x01, 0x0e, 0x27, 0x00, 0x02));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

