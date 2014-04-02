Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] android: Fix minor typo
Date: Wed,  2 Apr 2014 18:06:57 -0300
Message-Id: <1396472817-7314-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396472817-7314-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396472817-7314-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hardware/bt_gatt_server.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hardware/bt_gatt_server.h b/android/hardware/bt_gatt_server.h
index 1a5a400..751d852 100644
--- a/android/hardware/bt_gatt_server.h
+++ b/android/hardware/bt_gatt_server.h
@@ -172,4 +172,4 @@ typedef struct {
 
 __END_DECLS
 
-#endif /* ANDROID_INCLUDE_BT_GATT_CLIENT_H */
+#endif /* ANDROID_INCLUDE_BT_GATT_SERVER_H */
-- 
1.8.3.1

