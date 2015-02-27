Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH  3/3] unit/test-gatt: Add TP/GAW/SR/BI-03-C test
Date: Fri, 27 Feb 2015 14:43:35 +0530
Message-id: <1425028415-1190-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425028415-1190-1-git-send-email-gowtham.ab@samsung.com>
References: <1425028415-1190-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify that a Generic Attribute Profile server can detect and
reject a Write Characteristic Value Request to a non-writeable
Characteristic Value and issue a Write Not Permitted Response.
---
 unit/test-gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c7ca417..5b6cfbb 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3019,5 +3019,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x00, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x00, 0x00, 0x01));
 
+	define_test_server("/TP/GAW/SR/BI-03-C", test_server,
+			service_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x03, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x03, 0x00, 0x03));
+
 	return tester_run();
 }
-- 
1.9.1

