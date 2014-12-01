Return-Path: <cyrus@holtmann.org>
From: Biman Paul <biman.paul@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Biman Paul <biman.paul@samsung.com>
Subject: [PATCH 1/1] core: Store Device information immediately after saving
 LinkKey information
Date: Mon, 01 Dec 2014 18:04:17 +0530
Message-id: <1417437257-13368-1-git-send-email-biman.paul@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If bluetooth is turned off while pairing is in progress, sometimes
Linkey information is present but device (Class of Device) information is missing.

This patch stores the device information immediately after Linkkey
information is saved so that Class of Device information is stored.
---
 src/adapter.c |    2 ++
 src/device.c  |    2 +-
 src/device.h  |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3f0ee86..83132c2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5989,6 +5989,8 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 
 		if (device_is_temporary(device))
 			btd_device_set_temporary(device, FALSE);
+
+		store_device_info(device);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
diff --git a/src/device.c b/src/device.c
index 025743f..fe2fd83 100644
--- a/src/device.c
+++ b/src/device.c
@@ -402,7 +402,7 @@ static bool device_address_is_private(struct btd_device *dev)
 	}
 }
 
-static void store_device_info(struct btd_device *device)
+void store_device_info(struct btd_device *device)
 {
 	if (device->temporary || device->store_id > 0)
 		return;
diff --git a/src/device.h b/src/device.h
index 2e0473e..e8cfd8b 100644
--- a/src/device.h
+++ b/src/device.h
@@ -33,6 +33,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 char *btd_device_get_storage_path(struct btd_device *device,
 				const char *filename);
 
+void store_device_info(struct btd_device *device);
 void btd_device_device_set_name(struct btd_device *device, const char *name);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
-- 
1.7.9.5

