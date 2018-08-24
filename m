Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: <mingli.yu@windriver.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] unit/test-gatt: Fix hung issue
Date: Thu, 23 Aug 2018 22:33:31 -0700
Message-ID: <20180824053331.103927-1-mingli.yu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mingli Yu <mingli.yu@windriver.com>

The below test hangs infinitely
$ unit/test-gatt -p  /robustness/unkown-request -d
/robustness/unkown-request - init
/robustness/unkown-request - setup
/robustness/unkown-request - setup complete
/robustness/unkown-request - run
  GATT: < 02 17 00                                         ...
  bt_gatt_server:MTU exchange complete, with MTU: 23
  GATT: > 03 00 02                                         ...
  PDU: = 03 00 02                                         ...
  GATT: < bf 00

Actually, the /robustness/unkown-request test does
no action.
---
 unit/test-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c7e28f865..b57373b07 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -4463,7 +4463,7 @@ int main(int argc, char *argv[])
 			test_server, service_db_1, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0xbf, 0x00),
-			raw_pdu(0x01, 0xbf, 0x00, 0x00, 0x06));
+			raw_pdu());
 
 	define_test_server("/robustness/unkown-command",
 			test_server, service_db_1, NULL,
-- 
2.17.1
