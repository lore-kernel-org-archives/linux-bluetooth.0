Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] core/gatt-client: unregister DBus services on disconnect
Date: Thu,  3 Sep 2015 15:39:56 -0700
Message-Id: <1441319996-8675-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently when LE device is disconnected, all services and characteristics
are still registered and visible through DBus. Those objects aren't
usable, reading properties or calling methods on them is not usable at
all. However those services cause issues for clients re-connecting to
device that try to read/write characteristic right after connecting.
Read/write operation right after reconnecting ends with "Not connected"
error, due to dev->client not being ready. Workaround is to wait a fixed
time, around 1 second after connecting before issuing read/write commands.
Unregistering services and characteristic from  DBus after disconnect
fixes this issue.

This patch also fixes bug:
1. Connect to unpaired LE device, or paired LE device that have
   "Service Changed" notifications broken (i.e. all Android phones
   including version L).
2. Disconnect from device, add more services to its GATT database.
3. Re-connect to the device. Discovery of primary services will find
   newly added services, and bluetoothd will keep them in its internal
   structures.
4. Newly addes services will never be exported to DBus due to check
   in btd_gatt_client_ready if (queue_isempty(client->services))

Having client->services cleared when disconnecting fixes this bug.
---
 src/gatt-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 3356ee4..abcec7c 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1951,6 +1951,8 @@ void btd_gatt_client_disconnected(struct btd_gatt_client *client)
 	queue_foreach(client->all_notify_clients, clear_notify_id, NULL);
 	queue_foreach(client->services, cancel_ops, client->gatt);
 
+	queue_remove_all(client->services, NULL, NULL, unregister_service);
+
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = NULL;
 }
-- 
2.1.4

