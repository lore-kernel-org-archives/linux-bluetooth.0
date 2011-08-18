Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/5] serial: fix unref of dbus message
Date: Thu, 18 Aug 2011 17:10:00 -0300
Message-Id: <1313698203-13201-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

port->msg needs unref when the reply is sent.
---
 serial/port.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index e359716..3f041a6 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -204,6 +204,11 @@ static void serial_port_free(void *data)
 
 	port_release(port);
 
+	if (port->msg) {
+		dbus_message_unref(port->msg);
+		port->msg = NULL;
+	}
+
 	g_free(port->uuid);
 	g_free(port);
 }
@@ -224,6 +229,11 @@ static void port_owner_exited(DBusConnection *conn, void *user_data)
 
 	port_release(port);
 
+	if (port->msg) {
+		dbus_message_unref(port->msg);
+		port->msg = NULL;
+	}
+
 	port->listener_id = 0;
 }
 
@@ -261,6 +271,8 @@ static void open_notify(int fd, int err, struct serial_port *port)
 
 	/* Reply to the requestor */
 	g_dbus_send_message(device->conn, reply);
+	dbus_message_unref(port->msg);
+	port->msg = NULL;
 }
 
 static gboolean open_continue(gpointer user_data)
@@ -339,6 +351,8 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 				DBUS_TYPE_UNIX_FD, &sk,
 				DBUS_TYPE_INVALID);
 		g_dbus_send_message(device->conn, reply);
+		dbus_message_unref(port->msg);
+		port->msg = NULL;
 		return;
 	}
 
@@ -368,6 +382,8 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 
 fail:
 	g_dbus_send_message(device->conn, reply);
+	dbus_message_unref(port->msg);
+	port->msg = NULL;
 	g_dbus_remove_watch(device->conn, port->listener_id);
 	port->listener_id = 0;
 }
@@ -431,6 +447,8 @@ failed:
 	g_dbus_remove_watch(device->conn, port->listener_id);
 	port->listener_id = 0;
 	g_dbus_send_message(device->conn, reply);
+	dbus_message_unref(port->msg);
+	port->msg = NULL;
 }
 
 static int connect_port(struct serial_port *port)
-- 
1.7.6

