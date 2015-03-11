Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/3] unit/test-gatt: Add TP/GAW/SR/BV-08-C test
Date: Wed, 11 Mar 2015 18:26:27 +0530
Message-id: <1426078589-26354-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426078589-26354-1-git-send-email-gowtham.ab@samsung.com>
References: <1426078589-26354-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support writing
a characteristic descriptor selected by handle.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 7668e93..b867eef 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3179,5 +3179,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x08, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x08, 0x00, 0x0c));
 
+	define_test_server("/TP/GAW/SR/BV-08-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
+	define_test_server("/TP/GAW/SR/BV-08-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x83, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
 	return tester_run();
 }
-- 
1.9.1

