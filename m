Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/14] android/tester: Fix characteristic instance ID
Date: Thu, 11 Sep 2014 08:08:39 +0200
Message-Id: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Characteristics instance id starts from 1.
---
 android/tester-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 2067ec3..1507803 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -148,7 +148,7 @@ static btgatt_srvc_id_t service_2 = {
 };
 
 static btgatt_gatt_id_t characteristic_1 = {
-	.inst_id = 0,
+	.inst_id = 1,
 	.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
 			0x00, 0x10, 0x00, 0x00,  0x19, 0x00, 0x00, 0x00}
 };
-- 
1.9.3

