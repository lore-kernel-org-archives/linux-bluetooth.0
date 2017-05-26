Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt: Don't return an error if notification is already enabled
Date: Fri, 26 May 2017 11:58:37 +0300
Message-Id: <20170526085837.14705-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the client is already subscribed and attempt to register again
just return success as the handling should be the same as success.
---
 src/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index b86bfe6..6c67841 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1173,7 +1173,7 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	client = queue_find(chrc->notify_clients, match_notify_sender, sender);
 	if (client)
 		return client->notify_id ?
-				btd_error_failed(msg, "Already notifying") :
+				g_dbus_create_reply(msg, DBUS_TYPE_INVALID) :
 				btd_error_in_progress(msg);
 
 	client = notify_client_create(chrc, sender);
-- 
2.9.4

