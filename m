Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v6 08/18] gatt: Add server unix socket
Date: Tue,  4 Feb 2014 14:53:39 -0300
Message-Id: <1391536429-8345-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
 <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a server unix socket to handle local ATT traffic. This
is a development purpose feature used to allow local testing without
breaking the current attribute server.
---
 src/gatt.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index f7b74d6..7a595c6 100644
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
@@ -45,6 +51,7 @@ struct btd_attribute {
 	uint8_t value[0];
 };
 
+static struct io *server_io;
 static GList *local_attribute_db;
 static uint16_t next_handle = 0x0001;
 
@@ -91,11 +98,62 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
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
 void gatt_init(void)
 {
+	struct sockaddr_un uaddr  = {
+		.sun_family     = AF_UNIX,
+		.sun_path       = "\0/bluetooth/unix_att",
+	};
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
+	server_io = io_new(sk);
+	io_set_close_on_destroy(server_io, true);
+	io_set_read_handler(server_io, unix_accept_cb, NULL, NULL);
 }
 
 void gatt_cleanup(void)
@@ -103,4 +161,5 @@ void gatt_cleanup(void)
 	DBG("Stopping GATT server");
 
 	gatt_dbus_manager_unregister();
+	io_destroy(server_io);
 }
-- 
1.8.3.1

