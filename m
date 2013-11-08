Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH] android: Fix pan service registration
Date: Fri, 8 Nov 2013 10:51:48 +0100
Message-ID: <1383904308-15141-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

A2dp service was registered instead of pan.
---
 android/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index 057c2f7..93870d0 100644
--- a/android/main.c
+++ b/android/main.c
@@ -107,7 +107,7 @@ static void service_register(void *buf, uint16_t len)
 
 		break;
 	case HAL_SERVICE_ID_PAN:
-		if (!bt_a2dp_register(sk, adapter_bdaddr))
+		if (!bt_pan_register(sk, adapter_bdaddr))
 			goto failed;
 
 		break;
-- 
1.8.4.2

