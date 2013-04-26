Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v4 5/8] core: Add device_get_class to the public interface.
Date: Fri, 26 Apr 2013 13:05:38 -0700
Message-Id: <1367006741-28907-6-git-send-email-deymo@chromium.org>
In-Reply-To: <1367006741-28907-1-git-send-email-deymo@chromium.org>
References: <1367006741-28907-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Exports the device class to plugins.
---
 src/device.c | 5 +++++
 src/device.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index f260d47..8b8efc2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2149,6 +2149,11 @@ void device_set_class(struct btd_device *device, uint32_t class)
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
index d19793c..bc5c84b 100644
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
1.8.2.1

