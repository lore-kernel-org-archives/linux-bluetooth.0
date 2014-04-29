Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH v2 02/40] android/gatt: Remove redundant find function parameter
Date: Tue, 29 Apr 2014 18:46:51 +0200
Message-Id: <1398790049-30303-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

As client and server apps id is guaranteed to be unique, there is no
need for this search function parameter.
---
 android/gatt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f9eff30..0bb5a70 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1248,8 +1248,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
-static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id,
-							int32_t app_type)
+static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
 {
 	struct app_connection conn_match;
 	struct gatt_device *dev = NULL;
@@ -2891,7 +2890,7 @@ static void handle_client_register_for_notification(const void *buf,
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
+	conn = find_conn(&addr, cmd->client_if);
 	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -2997,7 +2996,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
+	conn = find_conn(&addr, cmd->client_if);
 	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
-- 
1.8.4

