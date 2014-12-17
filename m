Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/7] android/map-client: Don't check if interface is ready on init
Date: Wed, 17 Dec 2014 15:01:31 +0100
Message-Id: <1418824897-25342-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Map client don't have possibility to clean up its interface, only way to
change it is to overwrite. Service also can be unregistered but
interface doesn't change. This situation cause call to unregistered
service with set interface.
---
 android/hal-map-client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/hal-map-client.c b/android/hal-map-client.c
index 6c927d4..adf04fc 100644
--- a/android/hal-map-client.c
+++ b/android/hal-map-client.c
@@ -119,8 +119,14 @@ static bt_status_t init(btmce_callbacks_t *callbacks)
 
 	DBG("");
 
-	if (interface_ready())
-		return BT_STATUS_DONE;
+	/*
+	 * Interface ready check was removed because there is no cleanup
+	 * function to unregister and clear callbacks. MAP client testers may
+	 * restart bluetooth, unregister this profile and try to reuse it.
+	 * This situation make service unregistered but callbacks are still
+	 * set - interface is ready. On android devices there is no need to
+	 * re-init MAP client profile while bluetooth is loaded.
+	 */
 
 	cbs = callbacks;
 
-- 
1.9.3

