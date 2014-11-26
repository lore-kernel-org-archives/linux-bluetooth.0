Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/gatt: Fix improper signed write request decoding buffer size
Date: Wed, 26 Nov 2014 09:47:39 +0100
Message-Id: <1416991660-21828-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We shouldn't assume minimum le mtu for incomming message. For BR/EDR the
minimum mtu is larger than for LE transport layer. Its safer to use whole message
size like we do in other cases.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 84fdbe7..b9b3c7b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6212,7 +6212,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t value[cmd_len];
 	uint8_t s[ATT_SIGNATURE_LEN];
 	struct gatt_db_attribute *attrib;
 	uint32_t permissions;
-- 
1.9.1

