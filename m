Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 09/10] android/gatt: Remove redundant matching function
Date: Wed, 11 Feb 2015 15:34:07 +0100
Message-Id: <1423665248-5121-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If NULL is passed as matching function, queue uses its internal
'direct_match()' thus there is no need to duplicate this function.
---
 android/gatt.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index c518d27..cd0825a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -347,11 +347,6 @@ static struct gatt_app *find_app_by_id(int32_t id)
 	return queue_find(gatt_apps, match_app_by_id, INT_TO_PTR(id));
 }
 
-static bool match_by_value(const void *data, const void *user_data)
-{
-	return data == user_data;
-}
-
 static bool match_device_by_bdaddr(const void *data, const void *user_data)
 {
 	const struct gatt_device *dev = data;
@@ -564,7 +559,7 @@ static void unregister_notification(void *data)
 	 * triggered afterwards, but once client unregisters, device stays if
 	 * used by others. Then just unregister single handle.
 	 */
-	if (!queue_find(gatt_devices, match_by_value, dev))
+	if (!queue_find(gatt_devices, NULL, dev))
 		return;
 
 	if (notification->notif_id && dev)
@@ -2072,7 +2067,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 
 	DBG("");
 
-	listening_client = queue_find(listen_apps, match_by_value,
+	listening_client = queue_find(listen_apps, NULL,
 						INT_TO_PTR(cmd->client_if));
 
 	if (listening_client) {
@@ -2199,7 +2194,7 @@ static void handle_client_listen(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	listening_client = queue_find(listen_apps, match_by_value,
+	listening_client = queue_find(listen_apps, NULL,
 						INT_TO_PTR(cmd->client_if));
 	/* Start listening */
 	if (cmd->start) {
@@ -7331,7 +7326,7 @@ bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr)
 	if (queue_isempty(dev->autoconnect_apps))
 		device_ref(dev);
 
-	if (!queue_find(dev->autoconnect_apps, match_by_value, INT_TO_PTR(id)))
+	if (!queue_find(dev->autoconnect_apps, NULL, INT_TO_PTR(id)))
 		return queue_push_head(dev->autoconnect_apps, INT_TO_PTR(id));
 
 	return true;
-- 
1.9.1

