Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH BlueZ 2/2] device: use device_set_trusted() in set_trust()
Date: Sun,  3 Feb 2013 17:14:31 +0100
Message-Id: <1359908071-15024-3-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index 87e5eff..9e4c41f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -724,17 +724,7 @@ static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
 
-	if (device->trusted == value) {
-		g_dbus_pending_property_success(id);
-		return;
-	}
-
-	device->trusted = value;
-
-	store_device_info(device);
-
-	g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "Trusted");
+	device_set_trusted(device, value);
 
 	g_dbus_pending_property_success(id);
 }
-- 
1.7.10.4

