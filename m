Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v5 1/7] core: device: Don't disconnect if attios not set
Date: Thu, 18 Dec 2014 17:24:33 -0800
Message-Id: <1418952279-16452-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1418952279-16452-1-git-send-email-armansito@chromium.org>
References: <1418952279-16452-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no way for external applications to claim ownership
on a GATT connection and as profiles move away from attio.h it doesn't
make much sense to immediately disconnect if no attio callbacks have
been set after probing the profiles (as this will always immediately
disconnect the device). This patch removes this logic from btd_device.
---
 src/device.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index e8bdc18..64591d0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3642,9 +3642,6 @@ static void register_gatt_services(struct browse_req *req)
 
 	device_probe_profiles(device, req->profiles_added);
 
-	if (device->attios == NULL && device->attios_offline == NULL)
-		attio_cleanup(device);
-
 	device_svc_resolved(device, device->bdaddr_type, 0);
 
 	store_services(device);
@@ -5069,11 +5066,6 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	g_free(attio);
 
-	if (device->attios != NULL || device->attios_offline != NULL)
-		return TRUE;
-
-	attio_cleanup(device);
-
 	return TRUE;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

