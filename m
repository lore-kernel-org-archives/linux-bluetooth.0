Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH RFC] gdbus: Remove proxies when client disconnects
Date: Wed, 22 May 2013 18:54:16 -0300
Message-Id: <1369259656-19683-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove proxies and generate proxy_removed callbacks even when there are
no corresponding InterfaceRemoved signals.
---
 gdbus/client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index f700b7e..d80e252 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -1153,6 +1153,10 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 
 		if (*new == '\0' && client->unique_name != NULL &&
 				g_str_equal(old, client->unique_name) == TRUE) {
+
+			g_list_free_full(client->proxy_list, proxy_free);
+			client->proxy_list = NULL;
+
 			if (client->disconn_func)
 				client->disconn_func(client->dbus_conn,
 							client->disconn_data);
-- 
1.8.2.3

