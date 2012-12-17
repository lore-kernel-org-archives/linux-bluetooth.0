Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] obex-client: Enable ObjectManager
Date: Mon, 17 Dec 2012 13:50:06 +0200
Message-Id: <1355745007-1493-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
References: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 obexd/client/manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index 7a7c33f..4929383 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -269,6 +269,8 @@ int manager_init(void)
 		return -1;
 	}
 
+	g_dbus_attach_object_manager(conn);
+
 	if (g_dbus_register_interface(conn, CLIENT_PATH, CLIENT_INTERFACE,
 						client_methods, NULL, NULL,
 							NULL, NULL) == FALSE) {
@@ -299,5 +301,6 @@ void manager_exit(void)
 		module->exit();
 
 	g_dbus_unregister_interface(conn, CLIENT_PATH, CLIENT_INTERFACE);
+	g_dbus_detach_object_manager(conn);
 	dbus_connection_unref(conn);
 }
-- 
1.7.11.7

