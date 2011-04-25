Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Fix segfault when removing device
Date: Mon, 25 Apr 2011 14:48:10 -0400
Message-Id: <1303757290-4147-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The device_register_services() function uses g_slist_concat(), therefore
the passed list should not be freed. The primary_cb() function from GATT
library was freeing the services list using discover_primary_free(). To
fix this, the device_register_services() function receives a copy of
services list if called from inside a gatt_discover_primary() callback.
---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 44bf76f..72774bf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1600,7 +1600,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	device_probe_drivers(device, uuids);
 
-	device_register_services(req->conn, device, services, -1);
+	device_register_services(req->conn, device, g_slist_copy(services), -1);
 
 	g_slist_free(uuids);
 
-- 
1.7.0.4

