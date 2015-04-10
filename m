Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] gdbus: Close private connection if setup fails
Date: Fri, 10 Apr 2015 17:05:58 +0300
Message-Id: <1428674761-24609-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Private connection should be properly closed with dbus_connection_close
otherwise libdbus exits with the following error:

  'The last reference on a connection was dropped without closing the
   connection. This is a bug in an application. See
   dbus_connection_unref() documentation for details. Most likely, the
   application was supposed to call dbus_connection_close(), since this
   is a private connection.'
---
 gdbus/mainloop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 3e88eac..b90a844 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -322,6 +322,7 @@ DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
 		return NULL;
 
 	if (setup_bus(conn, name, error) == FALSE) {
+		dbus_connection_close(conn);
 		dbus_connection_unref(conn);
 		return NULL;
 	}
-- 
2.1.0

