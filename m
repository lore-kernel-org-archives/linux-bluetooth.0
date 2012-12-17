Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] obexd: Enable ObjectManager
Date: Mon, 17 Dec 2012 13:50:04 +0200
Message-Id: <1355745007-1493-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
References: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 obexd/src/manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 85aa965..034f6ab 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -350,6 +350,8 @@ gboolean manager_init(void)
 		return FALSE;
 	}
 
+	g_dbus_attach_object_manager(connection);
+
 	return g_dbus_register_interface(connection, OBEX_MANAGER_PATH,
 					OBEX_MANAGER_INTERFACE,
 					manager_methods, manager_signals, NULL,
@@ -368,6 +370,8 @@ void manager_cleanup(void)
 	if (agent)
 		agent_free(agent);
 
+	g_dbus_detach_object_manager(connection);
+
 	dbus_connection_unref(connection);
 }
 
-- 
1.7.11.7

