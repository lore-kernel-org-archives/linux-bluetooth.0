Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/8] android/gatt: Add find_server_by_id helper
Date: Fri, 11 Apr 2014 15:15:12 +0200
Message-Id: <1397222119-31158-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds helper function analogously to find_client_by_id.
---
 android/gatt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 13ae340..7b7b399 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -256,6 +256,11 @@ static struct gatt_client *find_client_by_id(int32_t id)
 	return queue_find(gatt_clients, match_client_by_id, INT_TO_PTR(id));
 }
 
+static struct gatt_server *find_server_by_id(int32_t id)
+{
+	return queue_find(gatt_servers, match_server_by_id, INT_TO_PTR(id));
+}
+
 static bool match_by_value(const void *data, const void *user_data)
 {
 	return data == user_data;
@@ -2709,8 +2714,8 @@ static void handle_server_unregister(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = queue_remove_if(gatt_servers, match_server_by_id,
-						INT_TO_PTR(cmd->server_if));
+	server = find_server_by_id(cmd->server_if);
+
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
-- 
1.9.1

