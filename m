Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 04/13] Rename device_set_trusted to btd_device_set_trusted
Date: Mon, 25 Nov 2013 22:15:43 +0000
Message-Id: <1385417752-25664-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 src/device.c | 4 ++--
 src/device.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 59e65b9..e652329 100644
--- a/src/device.c
+++ b/src/device.c
@@ -809,7 +809,7 @@ static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
 
-	device_set_trusted(device, value);
+	btd_device_set_trusted(device, value);
 
 	g_dbus_pending_property_success(id);
 }
@@ -3565,7 +3565,7 @@ void btd_device_set_temporary(struct btd_device *device, gboolean temporary)
 	device->temporary = temporary;
 }
 
-void device_set_trusted(struct btd_device *device, gboolean trusted)
+void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
 {
 	if (!device)
 		return;
diff --git a/src/device.h b/src/device.h
index 35d2a75..f7e7bdc 100644
--- a/src/device.h
+++ b/src/device.h
@@ -70,7 +70,7 @@ gboolean device_is_bonded(struct btd_device *device);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *device, gboolean paired);
 void btd_device_set_temporary(struct btd_device *device, gboolean temporary);
-void device_set_trusted(struct btd_device *device, gboolean trusted);
+void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
-- 
1.8.4.4

