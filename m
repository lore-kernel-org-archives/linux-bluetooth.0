Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 10/18] Add the btd_ prefix to device_add_service
Date: Tue, 21 Dec 2010 19:26:32 -0200
Message-Id: <1292966800-6264-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to keep consistency, as device_add_service would be used
from outside the core bluetoothd.
---
 attrib/client.c |    2 +-
 src/device.c    |    2 +-
 src/device.h    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 00d0bbc..dbfe5d3 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -606,7 +606,7 @@ static void register_primary(struct gatt_service *gatt)
 				NULL, NULL, prim, NULL);
 		DBG("Registered: %s", prim->path);
 
-		device_add_service(gatt->dev, prim->path);
+		btd_device_add_service(gatt->dev, prim->path);
 	}
 }
 
diff --git a/src/device.c b/src/device.c
index f123288..9d98bf8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2382,7 +2382,7 @@ void device_set_renewed_key(struct btd_device *device, gboolean renewed)
 	device->renewed_key = renewed;
 }
 
-void device_add_service(struct btd_device *device, const char *path)
+void btd_device_add_service(struct btd_device *device, const char *path)
 {
 	if (g_slist_find_custom(device->services, path, (GCompareFunc) strcmp))
 		return;
diff --git a/src/device.h b/src/device.h
index 0bd6fff..86721bf 100644
--- a/src/device.h
+++ b/src/device.h
@@ -55,7 +55,7 @@ void device_probe_drivers(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
-void device_add_service(struct btd_device *device, const char *path);
+void btd_device_add_service(struct btd_device *device, const char *path);
 void device_add_primary(struct btd_device *device, struct att_primary *prim);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-- 
1.7.3.4

