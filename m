Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/11] unit/test-gatt: Add /TP/GAR/CL/BI-04-C/auto test
Date: Tue, 23 Jun 2015 15:53:30 +0300
Message-Id: <1435064017-8178-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
References: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

/TP/GAR/CL/BI-04-C/auto is similar to TP/GAR/CL/BI-04-C but automatically
elevates the security level and retry.
---
 unit/test-gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9a9fa60..2d9128e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2691,6 +2691,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x05));
 
+	define_test_client("/TP/GAR/CL/BI-04-C/auto", test_client, service_db_1,
+			&test_read_1,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x05),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
+
 	define_test_client("/TP/GAR/CL/BI-05-C", test_client, service_db_1,
 			&test_read_6,
 			SERVICE_DATA_1_PDUS,
-- 
2.1.0

