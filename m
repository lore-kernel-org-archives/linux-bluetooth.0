Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 05/13] Rename device_device_set_name to btd_device_device_set_name
Date: Mon, 25 Nov 2013 22:15:44 +0000
Message-Id: <1385417752-25664-6-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 plugins/neard.c | 2 +-
 src/adapter.c   | 4 ++--
 src/device.c    | 2 +-
 src/device.h    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 073abec..58689e6 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -640,7 +640,7 @@ static void store_params(struct btd_adapter *adapter, struct btd_device *device,
 
 	if (params->name) {
 		device_store_cached_name(device, params->name);
-		device_set_name(device, params->name);
+		btd_device_device_set_name(device, params->name);
 	}
 
 	/* TODO handle UUIDs? */
diff --git a/src/adapter.c b/src/adapter.c
index ccd3c43..9600803 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4152,7 +4152,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	name_known = device_name_known(dev);
 
 	if (eir_data.name && (eir_data.name_complete || !name_known))
-		device_set_name(dev, eir_data.name);
+		btd_device_device_set_name(dev, eir_data.name);
 
 	if (eir_data.class != 0)
 		device_set_class(dev, eir_data.class);
@@ -5743,7 +5743,7 @@ static void connected_callback(uint16_t index, uint16_t length,
 
 	if (eir_data.name != NULL) {
 		device_store_cached_name(device, eir_data.name);
-		device_set_name(device, eir_data.name);
+		btd_device_device_set_name(device, eir_data.name);
 	}
 
 	eir_data_free(&eir_data);
diff --git a/src/device.c b/src/device.c
index e652329..58f24bf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2241,7 +2241,7 @@ char *btd_device_get_storage_path(struct btd_device *device,
 							filename);
 }
 
-void device_set_name(struct btd_device *device, const char *name)
+void btd_device_device_set_name(struct btd_device *device, const char *name)
 {
 	if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
 		return;
diff --git a/src/device.h b/src/device.h
index f7e7bdc..44bee3e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -33,7 +33,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 char *btd_device_get_storage_path(struct btd_device *device,
 				const char *filename);
 
-void device_set_name(struct btd_device *device, const char *name);
+void btd_device_device_set_name(struct btd_device *device, const char *name);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
-- 
1.8.4.4

