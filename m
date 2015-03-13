Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  5/7] unit/test-gatt: Add TP/GAW/SR/BI-25-C test
Date: Fri, 13 Mar 2015 12:04:44 +0530
Message-id: <1426228486-5124-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426228486-5124-1-git-send-email-gowtham.ab@samsung.com>
References: <1426228486-5124-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect a Write
long characteristic descriptor Request with an invalid characteristic
handle and issue an Invalid Handle Response.
---
 unit/test-gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 2b9039a..f1d7011 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3303,5 +3303,21 @@ int main(int argc, char *argv[])
 			raw_pdu(0x18, 0x01),
 			raw_pdu(0x19));
 
+	define_test_server("/TP/GAW/SR/BI-25-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
+			raw_pdu(0x01, 0x16, 0x00, 0x00, 0x01));
+
+	define_test_server("/TP/GAW/SR/BI-25-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x0f, 0xf0, 0x00, 0x00, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
+			raw_pdu(0x01, 0x16, 0x0f, 0xf0, 0x01));
+
 	return tester_run();
 }
-- 
1.9.1

