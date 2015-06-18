Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] unit/test-gatt: Fix /TP/GAR/CL/BV-07-C test
Date: Thu, 18 Jun 2015 18:01:52 +0300
Message-Id: <1434639713-32167-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1434639713-32167-1-git-send-email-luiz.dentz@gmail.com>
References: <1434639713-32167-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The response should be Read Blob Reponse 0x0d not 0x0b which is Read
Response.
---
 unit/test-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index f6448d5..bb6a270 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3264,7 +3264,7 @@ int main(int argc, char *argv[])
 			&test_long_read_9,
 			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x0b, 0x01, 0x02, 0x03));
+			raw_pdu(0x0d, 0x01, 0x02, 0x03));
 
 	define_test_client("/TP/GAR/CL/BV-07-C/512B", test_client, service_db_1,
 			&test_long_read_10,
-- 
2.1.0

