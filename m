Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v1 08/18] gatt: Add server unix socket
Date: Mon, 20 Jan 2014 15:04:53 -0300
Message-Id: <1390241103-808-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a server unix socket to handle local ATT traffic. This
is a development purpose feature used to allow local testing without
breaking the current attribute server.
---
 src/gatt.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index ee045b1..4806205 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -25,6 +25,11 @@
 #include <config.h>
 #endif
 
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
 #include <glib.h>
 
 #include "adapter.h"
@@ -50,6 +55,7 @@ struct btd_attribute {
 
 static GList *local_attribute_db;
 static uint16_t next_handle = 0x0001;
+static guint unix_watch;
 
 static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 {
@@ -94,11 +100,71 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	return attr;
 }
 
+static gboolean unix_accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct sockaddr_un uaddr;
+	socklen_t len = sizeof(uaddr);
+	GIOChannel *nio;
+	int err, nsk, sk;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	nsk = accept(sk, (struct sockaddr *) &uaddr, &len);
+	if (nsk < 0) {
+		err = errno;
+		error("ATT UNIX socket accept: %s(%d)", strerror(err), err);
+		return TRUE;
+	}
+
+	nio = g_io_channel_unix_new(nsk);
+	g_io_channel_set_close_on_unref(nio, TRUE);
+	DBG("ATT UNIX socket: %p new client", nio);
+	g_io_channel_unref(nio);
+
+	return TRUE;
+}
+
 void gatt_init(void)
 {
+	struct sockaddr_un uaddr  = {
+		.sun_family     = AF_UNIX,
+		.sun_path       = "\0/bluetooth/unix_att",
+	};
+	GIOChannel *io;
+	int sk, err;
+
 	DBG("Starting GATT server");
 
 	gatt_dbus_manager_register();
+
+	sk = socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC , 0);
+	if (sk < 0) {
+		err = errno;
+		error("ATT UNIX socket: %s(%d)", strerror(err), err);
+		return;
+	}
+
+	if (bind(sk, (struct sockaddr *) &uaddr, sizeof(uaddr)) < 0) {
+		err = errno;
+		error("binding ATT UNIX socket: %s(%d)", strerror(err), err);
+		close(sk);
+		return;
+	}
+
+	if (listen(sk, 5) < 0) {
+		err = errno;
+		error("listen ATT UNIX socket: %s(%d)", strerror(err), err);
+		close(sk);
+		return;
+	}
+
+	io = g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+	unix_watch = g_io_add_watch(io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				unix_accept_cb, NULL);
+	g_io_channel_unref(io);
 }
 
 void gatt_cleanup(void)
@@ -106,4 +172,5 @@ void gatt_cleanup(void)
 	DBG("Stopping GATT server");
 
 	gatt_dbus_manager_unregister();
+	g_source_remove(unix_watch);
 }
-- 
1.8.3.1

