Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/11] unit/test-gatt: Add /TP/GAW/CL/BI-23-C/auto test
Date: Tue, 23 Jun 2015 15:53:37 +0300
Message-Id: <1435064017-8178-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
References: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

/TP/GAW/CL/BI-23-C/auto is similar to /TP/GAW/CL/BI-23-C but
automatically elevates the security level and retry.
---
 unit/test-gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 82b6576..326a32c 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -4059,6 +4059,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x08, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x08, 0x00, 0x05));
 
+	define_test_client("/TP/GAW/CL/BI-23-C/auto", test_client, service_db_1,
+			&test_write_7,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x12, 0x08, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x08, 0x00, 0x05),
+			raw_pdu(0x12, 0x08, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
 	define_test_client("/TP/GAW/CL/BI-24-C", test_client, service_db_1,
 			&test_write_12,
 			SERVICE_DATA_1_PDUS,
-- 
2.1.0

