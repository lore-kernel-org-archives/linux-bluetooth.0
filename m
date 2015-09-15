Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] shared/gatt-client: enable notifications right after connecting
Date: Tue, 15 Sep 2015 13:25:19 -0700
Message-Id: <1442348719-3435-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Right now, if you re-connect to device that was previously registered
in DBus, you can read and write it's characteristic without any error.
Trying to register for notifications would however fail. This patch
fixes that by making sure you can register for notifications before
gatt_client is ready. It also re-register exising clients right after
connection, not when gatt_client is ready.
---
 src/gatt-client.c        | 12 ++++++------
 src/shared/gatt-client.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 225aa42..399133a 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1838,12 +1838,6 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
 	DBG("GATT client ready");
 
 	create_services(client);
-
-	/*
-	 * Services have already been created before. Re-enable notifications
-	 * for any pre-registered notification sessions.
-	 */
-	queue_foreach(client->all_notify_clients, register_notify, client);
 }
 
 void btd_gatt_client_connected(struct btd_gatt_client *client)
@@ -1860,6 +1854,12 @@ void btd_gatt_client_connected(struct btd_gatt_client *client)
 
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = bt_gatt_client_ref(gatt);
+
+	/*
+	 * Services have already been created before. Re-enable notifications
+	 * for any pre-registered notification sessions.
+	 */
+	queue_foreach(client->all_notify_clients, register_notify, client);
 }
 
 void btd_gatt_client_service_added(struct btd_gatt_client *client,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 0983852..d3e17e1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2989,7 +2989,7 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 	if (!client || !client->db || !chrc_value_handle || !callback)
 		return 0;
 
-	if (!bt_gatt_client_is_ready(client) || client->in_svc_chngd)
+	if (client->in_svc_chngd)
 		return 0;
 
 	return register_notify(client, chrc_value_handle, callback, notify,
-- 
2.5.0

