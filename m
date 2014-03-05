Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/5] android/hal-gatt-api: Use proper type for length
Date: Wed,  5 Mar 2014 09:59:50 +0100
Message-Id: <1394009990-5795-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Length can be up to 600 thus 16bit value should be used.
---
 android/hal-msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 677f450..8ac26ab 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -781,7 +781,7 @@ struct hal_cmd_gatt_server_send_response {
 	int32_t conn_id;
 	int32_t trans_id;
 	int32_t status;
-	uint8_t len;
+	uint16_t len;
 	uint8_t data[0];
 } __attribute__((packed));
 
-- 
1.9.0

