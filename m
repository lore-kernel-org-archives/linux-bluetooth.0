Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] gdbus: Fix not calling dbus_connection_close for private connections
Date: Mon, 19 Nov 2012 10:46:25 +0200
Message-Id: <1353314786-11427-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
References: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

dbus_bus_get_private documentation says:

  "Unlike dbus_bus_get(), always creates a new connection. This
  connection will not be saved or recycled by libdbus. Caller owns a
  reference to the bus and must either close it or know it to be closed
  prior to releasing this reference."
---
 gdbus/mainloop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 49e6538..4771f20 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -328,6 +328,7 @@ DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
 	if (g_dbus_connect(conn, name, error))
 		return conn;
 
+	dbus_connection_close(conn);
 	dbus_connection_unref(conn);
 	return NULL;
 }
-- 
1.7.11.7

