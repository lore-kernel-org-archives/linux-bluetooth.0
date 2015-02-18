Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH 11/11] unit/test-gatt: Add TP/GAR/CL/BI-35-C test
Date: Wed, 18 Feb 2015 16:40:06 +0530
Message-id: <1424257806-25815-12-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify Generic Attribute Profile client behavior when an attempt to use
LE transport to execute the Read Characteristic Value procedure on a
characteristic contained within a service defined for use only over
BR/EDR transport.
---
 unit/test-gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 51f2179..2be4c87 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2873,5 +2873,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x80));
 
+	define_test_client("/TP/GAR/CL/BI-35-C", test_client, service_db_1,
+			&test_read_12,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x80));
+
 	return g_test_run();
 }
-- 
1.9.1

