Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 3/3] core: Attach and detach object manager
Date: Thu, 29 Nov 2012 11:19:33 -0200
Message-Id: <1354195173-12750-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 src/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/main.c b/src/main.c
index 414849a..ccb5fa5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -381,6 +381,7 @@ static void disconnect_dbus(void)
 	if (!conn || !dbus_connection_get_is_connected(conn))
 		return;
 
+	g_dbus_detach_object_manager(conn);
 	set_dbus_connection(NULL);
 
 	dbus_connection_unref(conn);
@@ -412,6 +413,7 @@ static int connect_dbus(void)
 	set_dbus_connection(conn);
 
 	g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
+	g_dbus_attach_object_manager(conn);
 
 	return 0;
 }
-- 
1.8.0.1

