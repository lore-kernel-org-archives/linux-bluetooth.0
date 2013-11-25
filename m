Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 06/13] Rename device_get_uuids to btd_device_get_uuids
Date: Mon, 25 Nov 2013 22:15:45 +0000
Message-Id: <1385417752-25664-7-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 src/adapter.c | 2 +-
 src/device.c  | 2 +-
 src/device.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9600803..ec15715 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2537,7 +2537,7 @@ static void load_devices(struct btd_adapter *adapter)
 
 		/* TODO: register services from pre-loaded list of primaries */
 
-		list = device_get_uuids(device);
+		list = btd_device_get_uuids(device);
 		if (list)
 			device_probe_profiles(device, list);
 
diff --git a/src/device.c b/src/device.c
index 58f24bf..4ff8a14 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2474,7 +2474,7 @@ static gboolean record_has_uuid(const sdp_record_t *rec,
 	return FALSE;
 }
 
-GSList *device_get_uuids(struct btd_device *device)
+GSList *btd_device_get_uuids(struct btd_device *device)
 {
 	return device->uuids;
 }
diff --git a/src/device.h b/src/device.h
index 44bee3e..a0d25fe 100644
--- a/src/device.h
+++ b/src/device.h
@@ -46,7 +46,7 @@ uint16_t btd_device_get_version(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 int device_address_cmp(gconstpointer a, gconstpointer b);
 int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
-GSList *device_get_uuids(struct btd_device *device);
+GSList *btd_device_get_uuids(struct btd_device *device);
 void device_probe_profiles(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
-- 
1.8.4.4

