Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 2/8] android/gatt: Change name of match functions
Date: Thu, 13 Mar 2014 19:46:09 +0100
Message-ID: <1394736375-22599-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

---
 android/gatt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9ac89fb..54325a0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -48,7 +48,7 @@ static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static struct queue *gatt_clients = NULL;
 
-static bool find_client_by_uuid(const void *data, const void *user_data)
+static bool match_client_by_uuid(const void *data, const void *user_data)
 {
 	const uint8_t *exp_uuid = user_data;
 	const struct gatt_client *client = data;
@@ -56,7 +56,7 @@ static bool find_client_by_uuid(const void *data, const void *user_data)
 	return !memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
 }
 
-static bool find_client_by_id(const void *data, const void *user_data)
+static bool match_client_by_id(const void *data, const void *user_data)
 {
 	int32_t exp_id = PTR_TO_INT(user_data);
 	const struct gatt_client *client = data;
@@ -80,7 +80,7 @@ static void handle_client_register(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (queue_find(gatt_clients, find_client_by_uuid, &cmd->uuid)) {
+	if (queue_find(gatt_clients, match_client_by_uuid, &cmd->uuid)) {
 		error("gatt: client uuid is already on list");
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -116,7 +116,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 
 	DBG("");
 
-	cl = queue_remove_if(gatt_clients, find_client_by_id,
+	cl = queue_remove_if(gatt_clients, match_client_by_id,
 						INT_TO_PTR(cmd->client_if));
 	if (!cl) {
 		error("gatt: client_if=%d not found", cmd->client_if);
-- 
1.8.4

