Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 02/15] shared: Add a mainloop implementation using soletta
Date: Tue, 21 Jul 2015 20:16:35 -0300
Message-Id: <1437520608-22444-3-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow apps willing to integrate directly with the solleta
mainloop, with no need to implement custom ways (threads and pipes) to
communicate via Bluetooth and send/receive soletta flow packets.
---
 Makefile.am                  |   8 +-
 src/shared/io-soletta.c      | 317 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/timeout-soletta.c | 111 +++++++++++++++
 3 files changed, 435 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/io-soletta.c
 create mode 100644 src/shared/timeout-soletta.c

diff --git a/Makefile.am b/Makefile.am
index 41ace22..7779c1b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -95,7 +95,7 @@ gdbus_libgdbus_internal_la_SOURCES = gdbus/gdbus.h \
 				gdbus/mainloop.c gdbus/watch.c \
 				gdbus/object.c gdbus/client.c gdbus/polkit.c
 
-noinst_LTLIBRARIES += src/libshared-glib.la src/libshared-mainloop.la
+noinst_LTLIBRARIES += src/libshared-glib.la src/libshared-mainloop.la src/libshared-soletta.la
 
 shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/queue.h src/shared/queue.c \
@@ -128,6 +128,12 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/io-mainloop.c \
 				src/shared/timeout-mainloop.c \
 				src/shared/mainloop.h src/shared/mainloop.c
+if SOLETTA
+src_libshared_soletta_la_SOURCES = $(shared_sources) \
+				src/shared/io-soletta.c \
+				src/shared/timeout-soletta.c
+src_libshared_soletta_la_CFLAGS = $(AM_CFLAGS) @SOLETTA_CFLAGS@
+endif
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
 		attrib/gatt.h attrib/gatt.c \
diff --git a/src/shared/io-soletta.c b/src/shared/io-soletta.c
new file mode 100644
index 0000000..3ad66f0
--- /dev/null
+++ b/src/shared/io-soletta.c
@@ -0,0 +1,317 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h> /* FIXME: REMOVE ME */
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+
+#include <sol-mainloop.h>
+
+#include "io.h"
+#include "mainloop.h"
+#include "util.h"
+
+struct io {
+	int fd;
+	int refcount;
+	unsigned int events;
+
+	bool close_on_destroy;
+
+	struct sol_fd *watch;
+
+	io_callback_func_t read_cb;
+	void *read_data;
+
+	io_callback_func_t write_cb;
+	void *write_data;
+
+	io_callback_func_t disconnect_cb;
+	void *disconnect_data;
+
+	io_destroy_func_t read_destroy;
+	io_destroy_func_t write_destroy;
+	io_destroy_func_t disconnect_destroy;
+};
+
+static bool io_event_cb(void *data, int fd, unsigned int events);
+
+static struct io *io_ref(struct io *io)
+{
+	if (!io)
+		return NULL;
+
+	__sync_fetch_and_add(&io->refcount, 1);
+
+	return io;
+}
+
+static void io_unref(struct io *io)
+{
+	if (!io)
+		return;
+
+	if (__sync_sub_and_fetch(&io->refcount, 1))
+		return;
+
+	free(io);
+}
+
+static void reset_io_watch(struct io *io, unsigned int events)
+{
+	if (!io)
+		return;
+
+	if (io->watch) {
+		sol_fd_del(io->watch);
+		io->watch = NULL;
+	}
+
+	if (events)
+		io->watch = sol_fd_add(io->fd, events, io_event_cb, io);
+
+	io->events = events;
+}
+
+static bool io_event_cb(void *data, int fd, unsigned int events)
+{
+	struct io *io = io_ref(data);
+	unsigned int old_events = io->events;
+	bool r = true;
+
+	if ((events & (SOL_FD_FLAGS_HUP | SOL_FD_FLAGS_ERR))) {
+		io->read_cb = NULL;
+		io->write_cb = NULL;
+
+		if (!io->disconnect_cb) {
+			io_destroy(io);
+			return false;
+		}
+
+		if (!io->disconnect_cb(io, io->disconnect_data)) {
+			if (io->disconnect_destroy)
+				io->disconnect_destroy(io->disconnect_data);
+
+			io->disconnect_cb = NULL;
+			io->disconnect_destroy = NULL;
+			io->disconnect_data = NULL;
+
+			io->events &= ~SOL_FD_FLAGS_HUP;
+		}
+
+		io_unref(io);
+		return false;
+	}
+
+	if ((events & SOL_FD_FLAGS_IN) && io->read_cb) {
+		if (!io->read_cb(io, io->read_data)) {
+			if (io->read_destroy)
+				io->read_destroy(io->read_data);
+
+			io->read_cb = NULL;
+			io->read_destroy = NULL;
+			io->read_data = NULL;
+
+			io->events &= ~SOL_FD_FLAGS_IN;
+		}
+	}
+
+	if ((events & SOL_FD_FLAGS_OUT) && io->write_cb) {
+		if (!io->write_cb(io, io->write_data)) {
+			if (io->write_destroy)
+				io->write_destroy(io->write_data);
+
+			io->write_cb = NULL;
+			io->write_destroy = NULL;
+			io->write_data = NULL;
+
+			io->events &= ~SOL_FD_FLAGS_OUT;
+		}
+	}
+
+	if (old_events != io->events)
+		reset_io_watch(io, io->events);
+
+	if (!io->events) {
+		io->watch = NULL;
+		r = false;
+	}
+
+	io_unref(io);
+
+	return r;
+}
+
+struct io *io_new(int fd)
+{
+	struct io *io;
+
+	if (fd < 0)
+		return NULL;
+
+	io = new0(struct io, 1);
+	if (!io)
+		return NULL;
+
+	io->fd = fd;
+
+	return io_ref(io);
+}
+
+void io_destroy(struct io *io)
+{
+	if (!io)
+		return;
+
+	io->read_cb = NULL;
+	io->write_cb = NULL;
+	io->disconnect_cb = NULL;
+
+	sol_fd_del(io->watch);
+	io->watch = NULL;
+
+	io_unref(io);
+}
+
+int io_get_fd(struct io *io)
+{
+	if (!io)
+		return -ENOTCONN;
+
+	return io->fd;
+}
+
+bool io_set_close_on_destroy(struct io *io, bool do_close)
+{
+	if (!io)
+		return false;
+
+	io->close_on_destroy = do_close;
+
+	return true;
+}
+
+ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
+{
+	ssize_t ret;
+
+	if (!io || io->fd < 0)
+		return -ENOTCONN;
+
+	do {
+		ret = writev(io->fd, iov, iovcnt);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
+bool io_shutdown(struct io *io)
+{
+	if (!io || io->fd < 0)
+		return false;
+
+	return shutdown(io->fd, SHUT_RDWR) == 0;
+}
+
+bool io_set_read_handler(struct io *io, io_callback_func_t callback,
+		void *user_data, io_destroy_func_t destroy)
+{
+	unsigned int events;
+
+	if (!io || io->fd < 0)
+		return false;
+
+	if (io->read_destroy)
+		io->read_destroy(io->read_data);
+
+	if (callback)
+		events = io->events | SOL_FD_FLAGS_IN;
+	else
+		events = io->events & ~SOL_FD_FLAGS_IN;
+
+	reset_io_watch(io, events);
+
+	io->read_cb = callback;
+	io->read_destroy = destroy;
+	io->read_data = user_data;
+
+	return true;
+}
+
+bool io_set_write_handler(struct io *io, io_callback_func_t callback,
+		void *user_data, io_destroy_func_t destroy)
+{
+	unsigned int events;
+
+	if (!io || io->fd < 0)
+		return false;
+
+	if (io->write_destroy)
+		io->write_destroy(io->write_data);
+
+	if (callback)
+		events = io->events | SOL_FD_FLAGS_OUT;
+	else
+		events = io->events & ~SOL_FD_FLAGS_OUT;
+
+	reset_io_watch(io, events);
+
+	io->write_cb = callback;
+	io->write_destroy = destroy;
+	io->write_data = user_data;
+
+	return true;
+}
+
+bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
+		void *user_data, io_destroy_func_t destroy)
+{
+	unsigned int events;
+
+	if (!io || io->fd < 0)
+		return false;
+
+	if (io->disconnect_destroy)
+		io->disconnect_destroy(io->disconnect_data);
+
+	if (callback)
+		events = io->events | SOL_FD_FLAGS_HUP;
+	else
+		events = io->events & ~SOL_FD_FLAGS_HUP;
+
+	reset_io_watch(io, events);
+
+	io->disconnect_cb = callback;
+	io->disconnect_destroy = destroy;
+	io->disconnect_data = user_data;
+
+	return true;
+}
diff --git a/src/shared/timeout-soletta.c b/src/shared/timeout-soletta.c
new file mode 100644
index 0000000..f7e2a23
--- /dev/null
+++ b/src/shared/timeout-soletta.c
@@ -0,0 +1,111 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h> /* FIXME: remove me */
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/socket.h>
+
+#include <sol-mainloop.h>
+
+#include "timeout.h"
+#include "util.h"
+
+struct timeout_data {
+	struct sol_timeout *timeout;
+	timeout_func_t func;
+	timeout_destroy_func_t destroy;
+	void *user_data;
+};
+
+#define MAX_TIMEOUTS 32
+
+static struct timeout_data timeouts[MAX_TIMEOUTS];
+
+static bool timeout_callback(void *user_data)
+{
+	struct timeout_data *data = user_data;
+
+	if (data->func(data->user_data))
+		return true;
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	data->timeout = NULL;
+
+	return false;
+}
+
+unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy)
+{
+	struct timeout_data *data;
+	int i;
+
+	if (!func)
+		return 0;
+
+	for (i = 0; i < MAX_TIMEOUTS; i++)
+		if (!timeouts[i].timeout)
+			break;
+
+	if (i == MAX_TIMEOUTS)
+		return 0;
+
+	data = &timeouts[i];
+
+	data->timeout = sol_timeout_add(timeout, timeout_callback, data);
+	if (!data->timeout)
+		return 0;
+
+	data->func = func;
+	data->destroy = destroy;
+	data->user_data = user_data;
+
+	return i + 1;
+}
+
+void timeout_remove(unsigned int id)
+{
+	struct timeout_data *data;
+
+	if (!id)
+		return;
+
+	if ((id - 1) >= MAX_TIMEOUTS)
+		return;
+
+	data = &timeouts[id - 1];
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	sol_timeout_del(data->timeout);
+	data->timeout = NULL;
+}
-- 
2.4.6

