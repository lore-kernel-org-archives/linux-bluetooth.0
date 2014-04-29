Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/gatt: Remove redundant find function parameter
Date: Tue, 29 Apr 2014 12:31:08 +0200
Message-Id: <1398767468-15966-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As client and server apps id is guaranteed to be unique, there is no
need for this search function parameter.
---
 android/gatt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0e81e7d..b2c1a02 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1242,8 +1242,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
-static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id,
-							int32_t app_type)
+static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
 {
 	struct app_connection conn_match;
 	struct gatt_device *dev = NULL;
@@ -2875,7 +2874,7 @@ static void handle_client_register_for_notification(const void *buf,
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
+	conn = find_conn(&addr, cmd->client_if);
 	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -2980,7 +2979,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
+	conn = find_conn(&addr, cmd->client_if);
 	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
-- 
1.9.1

