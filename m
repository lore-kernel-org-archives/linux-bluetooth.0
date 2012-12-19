Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] core: Print profile name in device_profile_connected
Date: Wed, 19 Dec 2012 13:26:58 +0200
Message-Id: <1355916421-29304-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 6a98645..ba8790e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1112,7 +1112,7 @@ static int connect_next(struct btd_device *dev)
 void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
-	DBG("%s (%d)", strerror(-err), -err);
+	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
 
 	dev->pending = g_slist_remove(dev->pending, profile);
 
-- 
1.7.11.7

