Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v2 5/8] core: Add device_get_class to the public interface.
Date: Fri, 12 Apr 2013 16:28:35 -0700
Message-Id: <1365809318-17775-6-git-send-email-deymo@chromium.org>
In-Reply-To: <1365809318-17775-1-git-send-email-deymo@chromium.org>
References: <1365809318-17775-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Exports the device class to plugins.
---
 src/device.c | 5 +++++
 src/device.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 032fc68..4ce7b8c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2127,6 +2127,11 @@ void device_set_class(struct btd_device *device, uint32_t class)
 						DEVICE_INTERFACE, "Class");
 }
 
+uint32_t btd_device_get_class(struct btd_device *device)
+{
+	return device->class;
+}
+
 uint16_t btd_device_get_vendor(struct btd_device *device)
 {
 	return device->vendor;
diff --git a/src/device.h b/src/device.h
index f81721a..ab243f9 100644
--- a/src/device.h
+++ b/src/device.h
@@ -37,6 +37,7 @@ void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
 void device_set_class(struct btd_device *device, uint32_t class);
+uint32_t btd_device_get_class(struct btd_device *device);
 uint16_t btd_device_get_vendor(struct btd_device *device);
 uint16_t btd_device_get_vendor_src(struct btd_device *device);
 uint16_t btd_device_get_product(struct btd_device *device);
-- 
1.8.1.3
