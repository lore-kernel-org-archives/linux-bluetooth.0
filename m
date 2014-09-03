Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/5] android/hidhost: Fix indentation
Date: Wed,  3 Sep 2014 10:56:38 +0200
Message-Id: <1409734601-8078-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hidhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 3dc3c25..ebed56d 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -110,7 +110,7 @@ struct hid_device {
 	uint8_t		last_hid_msg;
 	struct bt_hog	*hog;
 	guint		reconnect_id;
-	int sec_level;
+	int		sec_level;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
-- 
1.9.1

