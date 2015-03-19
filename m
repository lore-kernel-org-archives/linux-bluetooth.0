Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/7] unit/test-gatt: Add /TP/GAD/CL/BV-06-C/client-1 test
Date: Thu, 19 Mar 2015 16:21:22 +0200
Message-Id: <1426774887-25646-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426774887-25646-1-git-send-email-luiz.dentz@gmail.com>
References: <1426774887-25646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is similar to TP/GAD/CL/BV-06-C but using bt_gatt_client to
discover everything.
---
 unit/test-gatt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 93ee2c7..33d4b9f 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2269,6 +2269,10 @@ int main(int argc, char *argv[])
 			raw_pdu(0x05, 0x01, 0x15, 0x00, 0x04, 0x29, 0x16, 0x00,
 					0x05, 0x29));
 
+	define_test_client("/TP/GAD/CL/BV-06-C/client-1", test_client,
+			service_db_1, NULL,
+			SERVICE_DATA_1_PDUS);
+
 	define_test_server("/TP/GAD/SR/BV-06-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.1.0

