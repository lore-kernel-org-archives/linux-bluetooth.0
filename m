Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] device: Add btd_device_get_storage_path()
Date: Fri, 14 Dec 2012 17:45:18 +0100
Message-Id: <1355503519-26573-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   15 +++++++++++++++
 src/device.h |    2 ++
 2 files changed, 17 insertions(+)

diff --git a/src/device.c b/src/device.c
index d6a6f04..0bc8a09 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2049,6 +2049,21 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	return btd_device_ref(device);
 }
 
+char *btd_device_get_storage_path(struct btd_device *device,
+				const char *filename)
+{
+	char srcaddr[18], dstaddr[18];
+
+	ba2str(adapter_get_address(device->adapter), srcaddr);
+	ba2str(&device->bdaddr, dstaddr);
+
+	if (!filename)
+		return g_strdup_printf(STORAGEDIR "/%s/%s", srcaddr, dstaddr);
+
+	return g_strdup_printf(STORAGEDIR "/%s/%s/%s", srcaddr, dstaddr,
+							filename);
+}
+
 void device_set_name(struct btd_device *device, const char *name)
 {
 	if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
diff --git a/src/device.h b/src/device.h
index 8534117..7707bce 100644
--- a/src/device.h
+++ b/src/device.h
@@ -30,6 +30,8 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 				const char *address, uint8_t bdaddr_type);
 struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 				const char *address, GKeyFile *key_file);
+char *btd_device_get_storage_path(struct btd_device *device,
+				const char *filename);
 
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
-- 
1.7.9.5

