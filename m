Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 8/8] unit/gatt: Add /TP/GAD/SR/BV-02-C test
Date: Tue,  9 Dec 2014 15:08:40 -0800
Message-Id: <1418166520-32993-9-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support discovery of
all particular Primary Services selected by service UUID, using 16-bit
UUIDs, and using 128-bit UUIDs where supported.

128-bit tests will be added once the larger databases with 128-bit UUIDs
are added.
---
 unit/test-gatt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5f5ad1b..6f29647 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1147,6 +1147,23 @@ int main(int argc, char *argv[])
 					0x18, 0x00, 0x00),
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
+	define_test_server("/TP/GAD/SR/BV-02-C/exists-16/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
+				0x18),
+			raw_pdu(0x07, 0x10, 0xf0, 0x15, 0xf0),
+			raw_pdu(0x06, 0x16, 0xf0, 0xff, 0xff, 0x00, 0x28, 0x00,
+				0x18),
+			raw_pdu(0x01, 0x06, 0x16, 0xf0, 0x0a));
+
+	define_test_server("/TP/GAD/SR/BV-02-C/missing-16/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x01,
+				0x18),
+			raw_pdu(0x01, 0x06, 0x01, 0x00, 0x0a));
+
 	define_test_att("/TP/GAD/CL/BV-03-C", test_search_included, NULL,
 			NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
-- 
2.2.0.rc0.207.ga3a616c

