Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Matt Schulte <schultetwin1@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Matt Schulte <schultetwin1@gmail.com>
Subject: [PATCH BlueZ] gdbus: properly init client connected state
Date: Tue,  6 Feb 2018 00:51:51 -0800
Message-Id: <20180206085151.15515-1-schultetwin1@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GDBusClient struct's connected member was being initialize to false for
all new clients even if the connection was connected. This changes the
GDBusClient connected field to be initialized from the state of the dbus
connection
---
 gdbus/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index eaab7d50b..a41ce1a7f 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -1316,7 +1316,7 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
 	client->service_name = g_strdup(service);
 	client->base_path = g_strdup(path);
 	client->root_path = g_strdup(root_path);
-	client->connected = FALSE;
+	client->connected = dbus_connection_get_is_connected(connection);
 
 	client->match_rules = g_ptr_array_sized_new(1);
 	g_ptr_array_set_free_func(client->match_rules, g_free);
-- 
2.16.1

