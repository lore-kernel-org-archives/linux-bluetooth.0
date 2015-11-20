Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] core: Fix replying with an error for connected profile
Date: Fri, 20 Nov 2015 14:37:41 +0200
Message-Id: <1448023061-19246-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the profile(s) is already connected don't reply with an error, if the
profile is in fact connecting already just wait until it completes.
---
 src/device.c  | 8 ++++++--
 src/service.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index e76b8bb..9021914 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1477,7 +1477,8 @@ static int connect_next(struct btd_device *dev)
 	while (dev->pending) {
 		service = dev->pending->data;
 
-		if (btd_service_connect(service) == 0)
+		err = btd_service_connect(service);
+		if (!err)
 			return 0;
 
 		dev->pending = g_slist_delete_link(dev->pending, dev->pending);
@@ -1732,8 +1733,11 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	}
 
 	err = connect_next(dev);
-	if (err < 0)
+	if (err < 0) {
+		if (err == -EALREADY)
+			return dbus_message_new_method_return(msg);
 		return btd_error_failed(msg, strerror(-err));
+	}
 
 	dev->connect = dbus_message_ref(msg);
 
diff --git a/src/service.c b/src/service.c
index 3d07744..f7912f5 100644
--- a/src/service.c
+++ b/src/service.c
@@ -228,6 +228,7 @@ int btd_service_connect(struct btd_service *service)
 	case BTD_SERVICE_STATE_DISCONNECTED:
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
+		return 0;
 	case BTD_SERVICE_STATE_CONNECTED:
 		return -EALREADY;
 	case BTD_SERVICE_STATE_DISCONNECTING:
-- 
2.4.3

