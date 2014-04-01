Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] android/gatt: Remove redundant hal cmd check
Date: Tue,  1 Apr 2014 14:54:27 +0200
Message-Id: <1396356869-21053-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes redundant hal cmd check (is received in cmd UUID == NULL).
---
 android/gatt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 941582a..ee77a4e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -350,12 +350,6 @@ static void handle_client_register(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (!cmd->uuid) {
-		error("gatt: no uuid received");
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
 	if (queue_find(gatt_clients, match_client_by_uuid, &cmd->uuid)) {
 		error("gatt: client uuid is already on list");
 		status = HAL_STATUS_FAILED;
-- 
1.9.1

