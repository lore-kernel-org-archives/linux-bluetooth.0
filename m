Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] device: Device_remove_stored removes device directory
Date: Thu, 15 Nov 2012 18:31:35 +0100
Message-Id: <1353000701-16605-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a device is removed we should remove the device info
file and storage directory.
---
 src/device.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/device.c b/src/device.c
index e3570cb..5969f15 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1873,6 +1873,9 @@ static void device_remove_stored(struct btd_device *device)
 {
 	const bdaddr_t *src = adapter_get_address(device->adapter);
 	uint8_t dst_type = device->bdaddr_type;
+	char adapter_addr[18];
+	char device_addr[18];
+	char filename[PATH_MAX + 1];
 
 	delete_entry(src, "profiles", &device->bdaddr, dst_type);
 	delete_entry(src, "trusts", &device->bdaddr, dst_type);
@@ -1893,6 +1896,19 @@ static void device_remove_stored(struct btd_device *device)
 
 	if (device->blocked)
 		device_unblock(device, TRUE, FALSE);
+
+	ba2str(src, adapter_addr);
+	ba2str(&device->bdaddr, device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+			device_addr);
+	filename[PATH_MAX] = '\0';
+	remove(filename);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", adapter_addr,
+			device_addr);
+	filename[PATH_MAX] = '\0';
+	remove(filename);
 }
 
 void device_remove(struct btd_device *device, gboolean remove_stored)
-- 
1.7.9.5

