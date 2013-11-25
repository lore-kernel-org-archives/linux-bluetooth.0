Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 12/13] device: Add device_discover_services function
Date: Mon, 25 Nov 2013 22:15:51 +0000
Message-Id: <1385417752-25664-13-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to query remote services from plugins for not yet
discovered devices.
---
 src/device.c | 17 +++++++++++++++++
 src/device.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/src/device.c b/src/device.c
index 4e952c5..847ffad 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3524,6 +3524,23 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 	return err;
 }
 
+int device_discover_services(struct btd_device *device)
+{
+	int err;
+
+	if (device_is_bredr(device))
+		err = device_browse_sdp(device, NULL);
+	else
+		err = device_browse_primary(device, NULL);
+
+	if (err == 0 && device->discov_timer) {
+		g_source_remove(device->discov_timer);
+		device->discov_timer = 0;
+	}
+
+	return err;
+}
+
 struct btd_adapter *device_get_adapter(struct btd_device *device)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index a0d25fe..c3fea4a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -131,5 +131,7 @@ bool device_remove_svc_complete_callback(struct btd_device *dev,
 struct btd_service *btd_device_get_service(struct btd_device *dev,
 						const char *remote_uuid);
 
+int device_discover_services(struct btd_device *device);
+
 void btd_device_init(void);
 void btd_device_cleanup(void);
-- 
1.8.4.4

