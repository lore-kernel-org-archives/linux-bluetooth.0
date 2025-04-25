Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AE2192E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608742; cv=none; b=oP52jTu9cXR24oiWBmdrZLk+tej1Pa/cp6aDiDEVkc212DO9WY0fHZ9XoueD+GFIDIpZDrweU+fP7pkTDL5eXoYdzGmR9J6pDM9+x6A9CirUUke4WQVwvbxg8rSzo/AduSd09M8tncu7SD3zxCk53sXjuBmX3XScHpQPs+319U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608742; c=relaxed/simple;
	bh=Ehyp300jR1YHWeGnA5/57hkc/8NfX9HVj8p+9ebaWLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfJ2KU8Cxc4mkG01I/yHFMaRsqyUJeS3IDKFNrWRNkRGhxxMW+DyQBhiqqlFtHozJzNTp/i0dEHbhow8Nn9fA08qmiZbHHcHpuhwKqkhrWlXla5cRKTMVNP1fBw5eKuASaMeE92x2CAWOGMUWKRnSyh3tT62+3PLMH2rq73QKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.e.3.8.2.2.5.b.8.9.9.0.4.5.1.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6154:998:b522:83ef] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u8OZd-000GhX-1p;
	Fri, 25 Apr 2025 20:18:57 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v3 4/5] obexd: Unregister profiles when the user is inactive
Date: Fri, 25 Apr 2025 20:17:53 +0100
Message-ID: <20250425191846.639039-5-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425191846.639039-1-kernel.org@pileofstuff.org>
References: <20250425191846.639039-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obexd is usually run as a user service, and can exhibit surprising
behaviour if two users are logged in at the same time.

Unregister profiles when the user is detected to be off-seat.

It may be impossible to detect whether a user is on-seat in some cases.
For example, a version of obexd compiled with systemd support might be
run outside of a systemd environment.  Warn and leave services
registered if that happens.

Obexd can be run as a system service, in which case this check makes no
sense.  Disable this check when called with `--system-bus`.

Obexd can also be run by a user that does not have an active session.
For example, someone could use `ssh` to access the system.  There might
be a use case where someone needs Bluetooth access but can't log in with
a keyboard, or there might be a security issue with doing so.  This isn't
handled explicitly by this patch, but a future patch could add support
by calling `logind_set(FALSE)` in the same way as is currently done
with `--system-bus`.

Unregister profiles by closing private connections instead of sending
UnregisterProfile on the shared connection.  Pipewire has apparently
found the latter to cause long shutdown delays, because bluetoothd
may be shutting down and unable to handle this message.

Based in large part on the wireplumber code mentioned by Pauli Virtanen:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/module-logind.c#L52

Other services are likely to need similar functionality,
so I have created a gist to demonstrate the basic technique:
https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e

Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 Makefile.obexd            |  10 ++
 obexd/client/pbap.c       |  17 ++-
 obexd/plugins/bluetooth.c |  14 ++-
 obexd/src/logind.c        | 257 ++++++++++++++++++++++++++++++++++++++
 obexd/src/logind.h        |  26 ++++
 obexd/src/main.c          |   4 +
 6 files changed, 323 insertions(+), 5 deletions(-)
 create mode 100644 obexd/src/logind.c
 create mode 100644 obexd/src/logind.h

diff --git a/Makefile.obexd b/Makefile.obexd
index 74dd977a0..b59cfaf8f 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -67,6 +67,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/src/main.c obexd/src/obexd.h \
 			obexd/src/plugin.h obexd/src/plugin.c \
 			obexd/src/log.h obexd/src/log.c \
+			obexd/src/logind.h obexd/src/logind.c \
 			obexd/src/manager.h obexd/src/manager.c \
 			obexd/src/obex.h obexd/src/obex.c obexd/src/obex-priv.h \
 			obexd/src/mimetype.h obexd/src/mimetype.c \
@@ -96,6 +97,8 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 
 if EXTERNAL_PLUGINS
 obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
+else
+obexd_src_obexd_LDFLAGS =
 endif
 
 obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
@@ -109,6 +112,13 @@ obexd-add-service-symlink:
 obexd-remove-service-symlink:
 endif
 
+if OBEX
+if SYSTEMD
+obexd_src_obexd_CPPFLAGS += -DSYSTEMD
+obexd_src_obexd_LDFLAGS += -lsystemd
+endif
+endif
+
 obexd_src_obexd_SHORTNAME = obexd
 
 obexd_builtin_files = obexd/src/builtin.h $(obexd_builtin_nodist)
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 90f8bdc02..51b523592 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -27,6 +27,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/logind.h"
 #include "obexd/src/obexd.h"
 
 #include "transfer.h"
@@ -1454,13 +1455,13 @@ static struct obc_driver pbap = {
 	.remove = pbap_remove
 };
 
-int pbap_init(void)
+static int pbap_init_cb(void)
 {
 	int err;
 
 	DBG("");
 
-	conn = obex_get_dbus_connection();
+	conn = obex_setup_dbus_connection_private(NULL, NULL);
 	if (!conn)
 		return -EIO;
 
@@ -1481,7 +1482,7 @@ int pbap_init(void)
 	return 0;
 }
 
-void pbap_exit(void)
+static void pbap_exit_cb(void)
 {
 	DBG("");
 
@@ -1496,9 +1497,19 @@ void pbap_exit(void)
 	}
 
 	if (conn) {
+		dbus_connection_close(conn);
 		dbus_connection_unref(conn);
 		conn = NULL;
 	}
 
 	obc_driver_unregister(&pbap);
 }
+
+int pbap_init(void)
+{
+	return logind_register(pbap_init_cb, pbap_exit_cb);
+}
+void pbap_exit(void)
+{
+	return logind_unregister(pbap_init_cb, pbap_exit_cb);
+}
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 8cf718922..7ff27a8a8 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -35,6 +35,7 @@
 #include "obexd/src/transport.h"
 #include "obexd/src/service.h"
 #include "obexd/src/log.h"
+#include "obexd/src/logind.h"
 
 #define BT_RX_MTU 32767
 #define BT_TX_MTU 32767
@@ -426,7 +427,7 @@ static const struct obex_transport_driver driver = {
 
 static unsigned int listener_id = 0;
 
-static int bluetooth_init(void)
+static int bluetooth_init_cb(void)
 {
 	connection = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (connection == NULL)
@@ -438,7 +439,7 @@ static int bluetooth_init(void)
 	return obex_transport_driver_register(&driver);
 }
 
-static void bluetooth_exit(void)
+static void bluetooth_exit_cb(void)
 {
 	GSList *l;
 
@@ -462,4 +463,13 @@ static void bluetooth_exit(void)
 	obex_transport_driver_unregister(&driver);
 }
 
+static int bluetooth_init(void)
+{
+	return logind_register(bluetooth_init_cb, bluetooth_exit_cb);
+}
+static void bluetooth_exit(void)
+{
+	return logind_unregister(bluetooth_init_cb, bluetooth_exit_cb);
+}
+
 OBEX_PLUGIN_DEFINE(bluetooth, bluetooth_init, bluetooth_exit)
diff --git a/obexd/src/logind.c b/obexd/src/logind.c
new file mode 100644
index 000000000..2630aa361
--- /dev/null
+++ b/obexd/src/logind.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  Enable functionality only when the user is active
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ */
+
+#ifdef SYSTEMD
+
+#include <assert.h>
+#include <errno.h>
+#include <poll.h>
+#include <stddef.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <glib.h>
+
+#include <systemd/sd-login.h>
+
+#include "obexd/src/log.h"
+#include "obexd/src/logind.h"
+
+static sd_login_monitor * monitor;
+static int uid;
+static gboolean active = FALSE;
+static gboolean monitoring_enabled = TRUE;
+static guint source;
+
+struct callback_pair {
+	logind_init_cb init_cb;
+	logind_exit_cb exit_cb;
+};
+
+GSList *callbacks;
+
+static void call_init_cb(gpointer data, gpointer user_data)
+{
+	int res;
+
+	res = ((struct callback_pair *)data)->init_cb();
+	if (res)
+		*(int *)user_data = res;
+}
+static void call_exit_cb(gpointer data, gpointer user_data)
+{
+	((struct callback_pair *)data)->exit_cb();
+}
+
+static int update(void)
+{
+	char *state;
+	int res;
+
+	res = sd_login_monitor_flush(monitor);
+	if (res < 0)
+		return res;
+	res = sd_uid_get_state(uid, &state);
+	if (res < 0)
+		return res;
+
+	if (g_strcmp0(state, "active")) {
+		if (!active)
+			return 0;
+	} else {
+		res = sd_uid_get_seats(uid, 1, NULL);
+		if (res < 0)
+			return res;
+		if (active == !!res)
+			return 0;
+	}
+	active ^= TRUE;
+	res = 0;
+	g_slist_foreach(callbacks, active ? call_init_cb : call_exit_cb, &res);
+	return res;
+}
+
+static gboolean event_handler(GIOChannel *source, GIOCondition condition,
+				gpointer data)
+{
+	int res;
+
+	res = sd_login_monitor_flush(monitor);
+	if (res < 0) {
+		error("sd_login_monitor_flush(): %s", strerror(-res));
+		return FALSE;
+	}
+	if (!monitoring_enabled)
+		return TRUE;
+	res = update();
+	if (res < 0) {
+		error("update(): %s", strerror(-res));
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static gboolean timeout_handler(gpointer user_data)
+{
+	uint64_t timeout_usec;
+	int res;
+
+	if (!event_handler(NULL, 0, NULL))
+		return FALSE;
+
+	res = sd_login_monitor_get_timeout(monitor, &timeout_usec);
+	if (res < 0) {
+		error("sd_login_monitor_get_timeout(): %s", strerror(-res));
+		return FALSE;
+	}
+
+	if (timeout_usec > (uint64_t)-1) {
+		uint64_t time_usec;
+		struct timespec ts;
+
+		res = clock_gettime(CLOCK_MONOTONIC, &ts);
+		if (res < 0)
+			return -errno;
+		time_usec = (uint64_t) ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
+		if (time_usec > timeout_usec)
+			return timeout_handler(user_data);
+		g_timeout_add((timeout_usec - time_usec + 999) / 1000,
+				timeout_handler, user_data);
+	}
+
+	return FALSE;
+}
+
+static int logind_init(void)
+{
+	GIOChannel *channel;
+	int events;
+	int fd;
+	int res;
+
+	monitor = NULL;
+
+	DBG("");
+
+	if (!monitoring_enabled)
+		return 0;
+
+	uid = getuid();
+
+	res = sd_login_monitor_new("uid", &monitor);
+	if (res < 0) {
+		monitor = NULL;
+		goto FAIL;
+	}
+
+	// Check this after creating the monitor, in case of race conditions:
+	res = update();
+	if (res < 0)
+		goto FAIL;
+
+	events = res = sd_login_monitor_get_events(monitor);
+	if (res < 0)
+		goto FAIL;
+
+	fd = res = sd_login_monitor_get_fd(monitor);
+	if (res < 0)
+		goto FAIL;
+
+	channel = g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	source = g_io_add_watch(channel, events, event_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	timeout_handler(NULL);
+
+	return 0;
+
+FAIL:
+	sd_login_monitor_unref(monitor);
+	monitoring_enabled = FALSE;
+	active = TRUE;
+	return res;
+}
+
+static void logind_exit(void)
+{
+	if (source) {
+		g_source_remove(source);
+		source = 0;
+	}
+	sd_login_monitor_unref(monitor);
+}
+
+static gint find_cb(gconstpointer a, gconstpointer b)
+{
+	return ((struct callback_pair *)a)->init_cb - (logind_init_cb)b;
+}
+
+int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
+{
+	struct callback_pair *cbs;
+
+	if (!monitoring_enabled)
+		return init_cb();
+	if (callbacks == NULL) {
+		int res;
+
+		res = logind_init();
+		if (res) {
+			error("logind_init(): %s - login detection disabled",
+				strerror(-res));
+			return init_cb();
+		}
+	}
+	cbs = g_new(struct callback_pair, 1);
+	cbs->init_cb = init_cb;
+	cbs->exit_cb = exit_cb;
+	callbacks = g_slist_prepend(callbacks, cbs);
+	return active ? init_cb() : 0;
+}
+void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
+{
+	GSList *cb_node;
+
+	if (!monitoring_enabled)
+		return exit_cb();
+	if (active)
+		exit_cb();
+	cb_node = g_slist_find_custom(callbacks, init_cb, find_cb);
+	if (cb_node != NULL)
+		callbacks = g_slist_delete_link(callbacks, cb_node);
+	if (callbacks == NULL)
+		logind_exit();
+}
+
+int logind_set(gboolean enabled)
+{
+	int res = 0;
+
+	if (monitoring_enabled == enabled)
+		return 0;
+
+	monitoring_enabled = enabled;
+	if (enabled) {
+		active = FALSE;
+		return update();
+	}
+
+	active = TRUE;
+	g_slist_foreach(callbacks, call_exit_cb, &res);
+	return res;
+}
+
+#endif
diff --git a/obexd/src/logind.h b/obexd/src/logind.h
new file mode 100644
index 000000000..1a92a8b87
--- /dev/null
+++ b/obexd/src/logind.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  Enable functionality only when the user is active
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ */
+
+#ifdef SYSTEMD
+
+typedef int (*logind_init_cb)(void);
+typedef void (*logind_exit_cb)(void);
+
+int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb);
+void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb);
+int logind_set(gboolean enabled);
+
+#else
+
+#define logind_register(init_cb, exit_cb) init_cb()
+#define logind_unregister(init_cb, exit_cb) exit_cb()
+#define logind_set(enabled) 0
+
+#endif
diff --git a/obexd/src/main.c b/obexd/src/main.c
index ca95a70de..df150973e 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -35,6 +35,7 @@
 #include "../client/manager.h"
 
 #include "log.h"
+#include "logind.h"
 #include "obexd.h"
 #include "server.h"
 
@@ -283,6 +284,9 @@ int main(int argc, char *argv[])
 
 	__obex_log_init(option_debug, option_detach);
 
+	if (option_system_bus)
+		logind_set(FALSE);
+
 	DBG("Entering main loop");
 
 	main_loop = g_main_loop_new(NULL, FALSE);
-- 
2.49.0

