Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/11] unit/test-gatt: Add /TP/GAW/CL/BI-05-C/auto test
Date: Tue, 23 Jun 2015 15:53:35 +0300
Message-Id: <1435064017-8178-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
References: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

/TP/GAW/CL/BI-05-C/auto is similar to /TP/GAW/CL/BI-05-C but
automatically elevates the security level and retry.
---
 unit/test-gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 2737bd4..6df6342 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3515,6 +3515,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x05));
 
+	define_test_client("/TP/GAW/CL/BI-05-C/auto", test_client, service_db_1,
+			&test_write_1,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x05),
+			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
 	define_test_client("/TP/GAW/CL/BI-06-C", test_client, service_db_1,
 			&test_write_6,
 			SERVICE_DATA_1_PDUS,
-- 
2.1.0

