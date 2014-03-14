Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/client: Minor fix in print status
Date: Fri, 14 Mar 2014 15:07:31 +0100
Message-ID: <1394806051-8160-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394806051-8160-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394806051-8160-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index d58fc4b..80fd0f0 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -429,7 +429,7 @@ static void gattc_disconnect_cb(int conn_id, int status, int client_if,
  */
 static void gattc_search_complete_cb(int conn_id, int status)
 {
-	haltest_info("%s: conn_id=%d status=%s\n", __func__, conn_id, status);
+	haltest_info("%s: conn_id=%d status=%d\n", __func__, conn_id, status);
 }
 
 /* Reports GATT services on a remote device */
-- 
1.8.4

