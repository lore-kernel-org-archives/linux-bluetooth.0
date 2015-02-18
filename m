Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH 06/11] unit/test-gatt: Add TP/GAR/CL/BI-30-C test
Date: Wed, 18 Feb 2015 16:40:01 +0530
Message-id: <1424257806-25815-7-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify Generic Attribute Profile client behavior when the Read Long
Characteristic Descriptor procedure fails due to invalid handle.
---
 unit/test-gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 36565bd..9a657eb 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2819,5 +2819,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
 			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x07));
 
+	define_test_client("/TP/GAR/CL/BI-30-C", test_client, service_db_1,
+			&test_long_read_5,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0c, 0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x00, 0x00, 0x01));
+
 	return g_test_run();
 }
-- 
1.9.1

