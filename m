Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 9/9] device: Remove not used device_set_class function
Date: Tue, 9 Oct 2012 14:12:02 +0200
Message-ID: <1349784722-14578-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With mgmt interface CoD cannot change as it is only received in EIR when
device is discovered or connected. Was only used in
btd_event_remote_class which is now removed.

---
 src/device.c |   12 ------------
 src/device.h |    1 -
 2 files changed, 13 deletions(-)

diff --git a/src/device.c b/src/device.c
index e94b222..71bfea5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3475,18 +3475,6 @@ void btd_device_unref(struct btd_device *device)
 	g_free(path);
 }
 
-void device_set_class(struct btd_device *device, uint32_t value)
-{
-	const char *icon = class_to_icon(value);
-
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
-						DEVICE_INTERFACE, "Class");
-
-	if (icon)
-		g_dbus_emit_property_changed(btd_get_dbus_connection(),
-				device->path, DEVICE_INTERFACE, "Icon");
-}
-
 int device_get_appearance(struct btd_device *device, uint16_t *value)
 {
 	uint16_t app;
diff --git a/src/device.h b/src/device.h
index d23f40d..46cecb4 100644
--- a/src/device.h
+++ b/src/device.h
@@ -102,7 +102,6 @@ guint device_add_disconnect_watch(struct btd_device *device,
 				disconnect_watch watch, void *user_data,
 				GDestroyNotify destroy);
 void device_remove_disconnect_watch(struct btd_device *device, guint id);
-void device_set_class(struct btd_device *device, uint32_t value);
 int device_get_appearance(struct btd_device *device, uint16_t *value);
 void device_set_appearance(struct btd_device *device, uint16_t value);
 
-- 
1.7.9.5

