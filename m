Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 02/10] android/gatt: Destroy app connections before destroying apps
Date: Wed, 11 Feb 2015 15:34:00 +0100
Message-Id: <1423665248-5121-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the right destruction order to avoid dangling pointers.
And it will actually matter when we make app connection destructor
automatically notify apps about disconnection.
---
 android/gatt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b0ce1a8..f9cef4f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -7284,12 +7284,12 @@ void bt_gatt_unregister(void)
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_GATT);
 	hal_ipc = NULL;
 
-	queue_destroy(gatt_apps, destroy_gatt_app);
-	gatt_apps = NULL;
-
 	queue_destroy(app_connections, destroy_connection);
 	app_connections = NULL;
 
+	queue_destroy(gatt_apps, destroy_gatt_app);
+	gatt_apps = NULL;
+
 	queue_destroy(gatt_devices, destroy_device);
 	gatt_devices = NULL;
 
-- 
1.9.1

