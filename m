Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] android/gatt: Remove unused uuid variable
Date: Fri,  4 Apr 2014 09:31:58 +0200
Message-Id: <1396596720-13779-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unused uuid string variable.
---
 android/gatt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7a6a2a2..68e2112 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2215,7 +2215,6 @@ static void handle_client_register_for_notification(const void *buf,
 {
 	const struct hal_cmd_gatt_client_register_for_notification *cmd = buf;
 	struct notification_data *notification;
-	char uuid[MAX_LEN_UUID_STR];
 	struct gatt_client *client;
 	struct characteristic *c;
 	struct element_id match_id;
@@ -2247,7 +2246,6 @@ static void handle_client_register_for_notification(const void *buf,
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
 	service = queue_find(dev->services, match_srvc_by_element_id,
 								&match_id);
-	bt_uuid_to_string(&match_id.uuid, uuid, MAX_LEN_UUID_STR);
 	if (!service) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
-- 
1.9.1

