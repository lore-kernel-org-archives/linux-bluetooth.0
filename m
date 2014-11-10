Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix dead code warnings
Date: Mon, 10 Nov 2014 15:25:18 +0200
Message-Id: <1415625918-10189-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

gatt_db_attribute_get_permissions() used everywhere without check since
those conditions are checked already.
---
 android/gatt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 086bb94..04101f6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5992,8 +5992,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	if (!gatt_db_attribute_get_permissions(attrib, &permissions))
-		return;
+	gatt_db_attribute_get_permissions(attrib, &permissions);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
-- 
1.9.1

