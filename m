Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] gdbus/client: Always call ready callback
Date: Tue,  5 Jan 2016 14:54:38 -0300
Message-Id: <1452016478-17221-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1452016478-17221-1-git-send-email-luiz.dentz@gmail.com>
References: <1452016478-17221-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Call ready callback regardless of the reply to GetManagedObjects
since otherwise the user code will be left waiting forever when in fact
no proxy will be created.
---
 gdbus/client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 48711ae..068e778 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -1073,9 +1073,6 @@ static void parse_managed_objects(GDBusClient *client, DBusMessage *msg)
 
 		dbus_message_iter_next(&dict);
 	}
-
-	if (client->ready)
-		client->ready(client, client->ready_data);
 }
 
 static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
@@ -1096,6 +1093,9 @@ static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
 	parse_managed_objects(client, reply);
 
 done:
+	if (client->ready)
+		client->ready(client, client->ready_data);
+
 	dbus_message_unref(reply);
 
 	dbus_pending_call_unref(client->get_objects_call);
-- 
2.4.3

