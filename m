Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/tester-hidhost: Make cid_data static
Date: Thu,  7 Aug 2014 17:28:59 +0300
Message-Id: <1407421739-18124-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-hidhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index c6296aa..c7e3a67 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -57,7 +57,7 @@ struct emu_cid_data {
 	uint16_t intr_cid;
 };
 
-struct emu_cid_data cid_data;
+static struct emu_cid_data cid_data;
 
 static const uint8_t did_req_pdu[] = { 0x06, /* PDU id */
 			0x00, 0x00, /* Transaction id */
-- 
1.9.3

