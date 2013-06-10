Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/15] obexd: Fix not checking for valid fd on NewConnection
Date: Mon, 10 Jun 2013 13:37:10 +0300
Message-Id: <1370860630-30359-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The fd needs to be checked as it may not be valid anymore which cause the
following warnings:

==8162== Warning: invalid file descriptor 1031 in syscall fcntl(DUPFD_CLOEXEC)()

(obexd:8162): GLib-WARNING **: giounix.c:412Error while getting flags for FD: Bad file descriptor (9)
---
 obexd/plugins/bluetooth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 07baf90..4e65923 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -30,6 +30,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 
 #include <glib.h>
@@ -132,6 +133,9 @@ static DBusMessage *profile_new_connection(DBusConnection *conn,
 
 	dbus_message_iter_get_basic(&args, &fd);
 
+	if (fcntl(fd, F_GETFD) < 0)
+		return invalid_args(msg);
+
 	io = g_io_channel_unix_new(fd);
 	if (io == NULL)
 		return invalid_args(msg);
-- 
1.8.1.4

