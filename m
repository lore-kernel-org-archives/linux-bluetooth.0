Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v4 08/18] gatt: Add server unix socket
Date: Mon, 27 Jan 2014 15:00:46 -0300
Message-Id: <1390845656-29880-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a server unix socket to handle local ATT traffic. This
is a development purpose feature used to allow local testing without
breaking the current attribute server.
---
 src/gatt.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index f7b74d6..2f0466a 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -25,11 +25,17 @@
 #include <config.h>
 #endif
 
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
 #include <glib.h>
 
 #include "log.h"
 #include "lib/uuid.h"
 #include "attrib/att.h"
+#include "src/shared/io.h"
 
 #include "gatt-dbus.h"
 #include "gatt.h"
@@ -47,6 +53,7 @@ struct btd_attribute {
 
 static GList *local_attribute_db;
 static uint16_t next_handle = 0x0001;
+static guint unix_watch;
 
 static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 {
@@ -91,11 +98,69 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	return attr;
 }
 
+static bool unix_accept_cb(struct io *io, void *user_data)
+{
+	struct sockaddr_un uaddr;
+	socklen_t len = sizeof(uaddr);
+	int err, nsk, sk;
+
+	sk = io_get_fd(io);
+
+	nsk = accept(sk, (struct sockaddr *) &uaddr, &len);
+	if (nsk < 0) {
+		err = errno;
+		error("ATT UNIX socket accept: %s(%d)", strerror(err), err);
+		return TRUE;
+	}
+
+	DBG("ATT UNIX socket: %d", nsk);
+
+	return TRUE;
+}
+
+static void accept_watch_destroy(void *user_data)
+{
+	struct io *io = user_data;
+
+	io_destroy(io);
+}
+
 void gatt_init(void)
 {
+	struct sockaddr_un uaddr  = {
+		.sun_family     = AF_UNIX,
+		.sun_path       = "\0/bluetooth/unix_att",
+	};
+	struct io *io;
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
+	io = io_new(sk);
+	io_set_read_handler(io, unix_accept_cb, io, accept_watch_destroy);
 }
 
 void gatt_cleanup(void)
@@ -103,4 +168,5 @@ void gatt_cleanup(void)
 	DBG("Stopping GATT server");
 
 	gatt_dbus_manager_unregister();
+	g_source_remove(unix_watch);
 }
-- 
1.8.3.1

