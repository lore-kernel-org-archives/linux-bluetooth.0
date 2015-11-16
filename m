Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] emulator/hciemu: Fix return value
Date: Mon, 16 Nov 2015 18:42:40 +0530
Message-id: <1447679560-19712-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

make throws out the following errors.

emulator/hciemu.c: In function ‘hciemu_get_master_scan_enable’:
emulator/hciemu.c:433:3: error: return makes integer from pointer without a cast [-Werror]
   return NULL;
   ^
emulator/hciemu.c: In function ‘hciemu_get_master_le_scan_enable’:
emulator/hciemu.c:441:3: error: return makes integer from pointer without a cast [-Werror]
   return NULL;
   ^
cc1: all warnings being treated as errors

Fixed by returning zero.
---
 emulator/hciemu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index c8d9db5..6a53499 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -430,7 +430,7 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
 uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->master_dev)
-		return NULL;
+		return 0;
 
 	return btdev_get_scan_enable(hciemu->master_dev);
 }
@@ -438,7 +438,7 @@ uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu)
 uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->master_dev)
-		return NULL;
+		return 0;
 
 	return btdev_get_le_scan_enable(hciemu->master_dev);
 }
-- 
1.9.1

