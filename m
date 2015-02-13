Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, gowtham.ab@samsung.com
Subject: [PATCH  3/6] unit/gatt: Add TP/GAR/CL/BI-24-C test
Date: Fri, 13 Feb 2015 20:18:17 +0530
Message-id: <1423838900-18110-4-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
References: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gowtham Anandha Babu <gowtham.ab@samsung.com>

Verify Generic Attribute Profile client behavior when the Read
Characteristic Descriptor procedure fails due to invalid handle.
---
 unit/test-gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6fc4212..2594b0f 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2618,5 +2618,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x04, 0x00),
 			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x02));
 
+	define_test_client("/TP/GAR/CL/BI-24-C", test_client, service_db_1,
+			&test_read_2,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x00, 0x00),
+			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x01));
+
 	return g_test_run();
 }
-- 
1.9.1

