Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/map-client: Don't check if interface is ready on init
Date: Wed, 17 Dec 2014 11:58:15 +0100
Message-Id: <1418813900-29056-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Map client don't have possibility to clean up its interface, only way to
change it is to overwrite. Service also can be unregistered but
interface doesn't change. This situation cause call to unregistered
service with set interface.
---
 android/hal-map-client.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/hal-map-client.c b/android/hal-map-client.c
index 6c927d4..6fbf894 100644
--- a/android/hal-map-client.c
+++ b/android/hal-map-client.c
@@ -119,9 +119,6 @@ static bt_status_t init(btmce_callbacks_t *callbacks)
 
 	DBG("");
 
-	if (interface_ready())
-		return BT_STATUS_DONE;
-
 	cbs = callbacks;
 
 	hal_ipc_register(HAL_SERVICE_ID_MAP_CLIENT, ev_handlers,
-- 
1.9.3

