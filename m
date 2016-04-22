Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] core/device: Fix not storing GATT attributes
Date: Fri, 22 Apr 2016 14:42:36 +0300
Message-Id: <1461325357-4013-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
References: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If services has been refreshed the attributes shall be stored so they can
be reloaded properly the next time.
---
 src/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/device.c b/src/device.c
index 62a42d5..ed8fcdf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4576,6 +4576,8 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 	btd_gatt_client_ready(device->client_dbus);
 
 	device_svc_resolved(device, device->bdaddr_type, 0);
+
+	store_gatt_db(device);
 }
 
 static void gatt_client_service_changed(uint16_t start_handle,
-- 
2.5.5

