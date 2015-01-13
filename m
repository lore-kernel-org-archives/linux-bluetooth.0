Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/gatt: Fix dead code warnings
Date: Tue, 13 Jan 2015 12:09:18 +0200
Message-Id: <1421143759-32586-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <2133713.7aeGTCSDGs@uw000953>
References: <2133713.7aeGTCSDGs@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

gatt_db_attribute_get_permissions() used everywhere without check since
those conditions are checked already.
---
 android/gatt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b749705..8542f45 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6355,8 +6355,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	if (!gatt_db_attribute_get_permissions(attrib, &permissions))
-		return;
+	gatt_db_attribute_get_permissions(attrib, &permissions);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
-- 
2.1.0

