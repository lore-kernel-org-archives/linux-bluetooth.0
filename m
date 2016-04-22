Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] core/device: Remove code related to GattServices
Date: Fri, 22 Apr 2016 14:42:35 +0300
Message-Id: <1461325357-4013-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
References: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GattService has been removed so there shouldn't be any code related to it
---
 src/device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5269ee8..62a42d5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3366,9 +3366,6 @@ static gboolean gatt_services_changed(gpointer user_data)
 
 	store_gatt_db(device);
 
-	g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
-								"GattServices");
-
 	return FALSE;
 }
 
-- 
2.5.5

