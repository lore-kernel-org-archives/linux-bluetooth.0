Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/client: Fix missing new line character
Date: Wed, 29 Apr 2015 11:15:50 +0200
Message-Id: <1430298953-31018-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New line character is missing for haltest_info. Without this logs are
distorted after receiving configure mtu callback log.
---
 android/client/if-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 70287fc..e66cc20 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -679,7 +679,7 @@ static void gattc_listen_cb(int status, int client_if)
 /* Callback invoked when the MTU for a given connection changes */
 static void gattc_configure_mtu_cb(int conn_id, int status, int mtu)
 {
-	haltest_info("%s: conn_id=%d, status=%d, mtu=%d", __func__, conn_id,
+	haltest_info("%s: conn_id=%d, status=%d, mtu=%d\n", __func__, conn_id,
 								status, mtu);
 }
 
-- 
2.1.0

