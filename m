Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/6] android/gatt: Minor debug message change
Date: Tue, 10 Feb 2015 13:48:11 +0100
Message-Id: <1423572494-32037-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's easier to have opcode in hex.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 210a877..0a6e6e9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4748,7 +4748,7 @@ static uint8_t check_device_permissions(struct gatt_device *device,
 							BT_IO_OPT_INVALID))
 		return ATT_ECODE_UNLIKELY;
 
-	DBG("opcode %u permissions %u sec_level %u", opcode, permissions,
+	DBG("opcode 0x%02x permissions %u sec_level %u", opcode, permissions,
 								sec_level);
 
 	switch (opcode) {
-- 
1.9.1

