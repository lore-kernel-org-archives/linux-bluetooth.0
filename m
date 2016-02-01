Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] core/gatt-client: Fix not being able to cancel notifications
Date: Mon,  1 Feb 2016 16:13:20 +0200
Message-Id: <1454336002-4954-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
References: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While the notification is still in process notifying flag wont be set but
it shall still be possible to cancel it otherwise the client has to wait
until the remote respond which can take a lot of time (up to 30 seconds).
---
 src/gatt-client.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 39f6646..b4ca3b6 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1205,9 +1205,6 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 	const char *sender = dbus_message_get_sender(msg);
 	struct notify_client *client;
 
-	if (!chrc->notifying)
-		return btd_error_failed(msg, "Not notifying");
-
 	client = queue_remove_if(chrc->notify_clients, match_notify_sender,
 							(void *) sender);
 	if (!client)
-- 
2.5.0

