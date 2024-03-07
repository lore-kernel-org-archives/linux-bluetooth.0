Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE024B33
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845539; cv=pass; b=uc9dv8zFLybQQXPpcOTPnHcj+KFLx6PRdCetydusx9DZU95bTcyQRlRG9TQf2/3EHNY0z9f9QU5bbAySS+hpriVyIuEFy+W2IFPfwlp4t7/bOJqVkkNGahfoD2ObqkAAxogfYXsLE18nneNVXVCWXYJCGYqGukMbHtT2n42uOEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845539; c=relaxed/simple;
	bh=OFh5/kqYpFbcslc126LjT/xNLyVqeEinMMXZRKve3Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDVOmeEjcB1ioOjG4LnoJuaiaHrY6EabhePmI7pBWZ4PgbkmKV2ONEfWNBGYxl/yJOzthXVDPYyoUScpuV0Hq3n8foGPYVK+fApvl6nUDWiZjbJHnzOw2Oeb14F6QIwd0lV6HdAo6cUt/GmhWlt9qW0h/xVzv2fLRKRtMJUNjek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZNz+qx2o; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZNz+qx2o"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TrMJk0854z49Pyq;
	Thu,  7 Mar 2024 23:05:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709845528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bVbqdx4P1TCo/RfWrMvaMxcyABmEXbfExsJ7iknfHKM=;
	b=ZNz+qx2oI/dOBUSDOjqAJ87tCsA1bGNN6VCum/toiD83aI3LxwK/4E4uKc/hkGK2Yp7jlB
	vTcPhqm7mztogHmFjHUJNnUakzx2WPiaoYDk0fX932JnQtyFYOl8ovT7HKpgCd9lybG7Wz
	sCedr5YB8KOLv4ZMYk3UQRHXNtAGxgZN0jHB2OPuvfvkAhCexxVkujHig8ZT1Cemr0ghfl
	rqNSKoQ7phOQHi0JV74+QIaAFDumX1wRN8zm8jMNX1JcpM6SmuuP0JBj5VPRX/UU3mVC3B
	ZMGu5F4taXorTCFMlD/HGSWzqG6ju4Egn3A+dEftd5jJ3aRdsNIqX5zlwq+a2w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709845528; a=rsa-sha256;
	cv=none;
	b=suuS/ZHrXrwkgvRvwCdZ8kR8B/eUpykhqywl3NvuNuYJUTMlhuv98IGzWNFytCex9LiLgJ
	wGItvEPCeL8lOIsuDcm9sUdXble5VSpkh6vAV1pS4d6i84evXRuNGN1Bp371rm/1schW4G
	E1R/7nZVMfN4Xisfd1D2vnUVUj/PozmUoGcM8i+JQwGfbku/EQrUd5V1axFdb/3KyHsfrB
	YFRgqXVbnv4ESlG8nxx+J3+t/Yc8QQaNMxrXh+bCa+10gJiNtt+57LBq8pTMhMZQbCYz+r
	6nhbkv036BV2IiMvKta1f8xC6j/0uXpI0PMJabRCzN0JF3J7wKvJgmqphLHkTg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709845528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bVbqdx4P1TCo/RfWrMvaMxcyABmEXbfExsJ7iknfHKM=;
	b=G3jAi79WKF4sG1y9St/yQj9esnzBG52RbwLcL5oxNRfhjGqc8bbQMl7oTt9CQ9XCY70GOG
	9Fe2BaprVnXQhjc97Pt3qTLog9waqNZ67WgbAFIrh1Y7uKeEJvQY2nBgrNC6fpHv510Igq
	uFNfX07UtKXmuWWtYbWWknvu8EGmDtw+SrYa6ZPNgt+1wab0Mv3taj3aszKCdj9cLylzQg
	DrdZZIvOkMR3D1E3fH+TGmtHTVm77Xajo5frWtsgyh9x2YFG9ME5nyw8MZCVcvkbPrvOWF
	SukcZzoG//1jRHszjxUeeKEtSyBZos/fGd5WGCakv9df8uh5KCtJUun8Q7zhyA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with TX timestamping
Date: Thu,  7 Mar 2024 23:05:17 +0200
Message-ID: <31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add special implementation of fd watcher GSource for audio use.

For audio use cases, sound server may turn on TX timestamping on a
socket that we are watching.  In this case, we shall not consider the TX
timestamping POLLERR as a socket error condition, nor read the TX
timestamps.

When TX timestamps appear in errqueue, switch from fd poll wait to
polling the fd at regular intervals.  This is because unread errqueue
causes poll() to wake up immediately, so the mainloop cannot block on
that, and we have to use a timer instead with some reasonable timeout
for the use case.

This avoids consuming CPU waking up on timestamps we aren't going to
read, and also avoids busy looping if timestamping was left on but
errqueue is not flushed.

Implement this only for io-glib; it is only needed for audio use cases
that anyway are using glib.  Uses features from GLib 2.36 (from 2013) so
update configure.ac also.
---

Notes:
    This was the remaining BlueZ part of the TX timestamping additions.
    Couldn't find a better way to do it, but it has to be done, so that the
    TX timestamping can be used for the purpose it would be added.
    
    I'll probably send v2 for the others in a few days.

 acinclude.m4         |   3 +-
 configure.ac         |   2 +-
 src/shared/io-glib.c | 153 ++++++++++++++++++++++++++++++++++++++++++-
 src/shared/io-glib.h |  20 ++++++
 4 files changed, 174 insertions(+), 4 deletions(-)
 create mode 100644 src/shared/io-glib.h

diff --git a/acinclude.m4 b/acinclude.m4
index 4b73a5bfc..6c36c177e 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -62,8 +62,7 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wswitch-enum"
 		with_cflags="$with_cflags -Wformat -Wformat-security"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
-		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
-		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
+		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_36"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
diff --git a/configure.ac b/configure.ac
index 9ebc250cf..959a27b4d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -72,7 +72,7 @@ AC_CHECK_LIB(dl, dlopen, dummy=yes,
 
 AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
 
-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28)
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.36)
 
 if (test "${enable_threads}" = "yes"); then
 	AC_DEFINE(NEED_THREADS, 1, [Define if threading support is required])
diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 754043db1..8b76348dd 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -13,10 +13,12 @@
 #endif
 
 #include <errno.h>
+#include <sys/socket.h>
 
 #include <glib.h>
 
 #include "src/shared/io.h"
+#include "src/shared/io-glib.h"
 
 struct io_watch {
 	struct io *io;
@@ -29,11 +31,19 @@ struct io_watch {
 struct io {
 	int ref_count;
 	GIOChannel *channel;
+	bool err_watch;
 	struct io_watch *read_watch;
 	struct io_watch *write_watch;
 	struct io_watch *disconnect_watch;
 };
 
+struct io_err_watch {
+	GSource			source;
+	GIOChannel		*io;
+	GIOCondition		events;
+	gpointer		tag;
+};
+
 static struct io *io_ref(struct io *io)
 {
 	if (!io)
@@ -179,10 +189,17 @@ static struct io_watch *watch_new(struct io *io, GIOCondition cond,
 
 	prio = cond == G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_PRIORITY_DEFAULT;
 
-	watch->id = g_io_add_watch_full(io->channel, prio,
+	if (!io->err_watch)
+		watch->id = g_io_add_watch_full(io->channel, prio,
 						cond | G_IO_ERR | G_IO_NVAL,
 						watch_callback, watch,
 						watch_destroy);
+	else
+		watch->id = io_glib_add_err_watch_full(io->channel, prio,
+						cond | G_IO_ERR | G_IO_NVAL,
+						watch_callback, watch,
+						watch_destroy);
+
 	if (watch->id == 0) {
 		watch_destroy(watch);
 		return NULL;
@@ -250,6 +267,15 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 	return io_set_handler(io, G_IO_HUP, callback, user_data, destroy);
 }
 
+bool io_set_use_err_watch(struct io *io, bool err_watch)
+{
+	if (!io)
+		return false;
+
+	io->err_watch = err_watch;
+	return true;
+}
+
 ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
 {
 	int fd;
@@ -278,3 +304,128 @@ bool io_shutdown(struct io *io)
 	return g_io_channel_shutdown(io->channel, TRUE, NULL)
 							== G_IO_STATUS_NORMAL;
 }
+
+/*
+ * GSource implementation that tolerates non-empty MSG_ERRQUEUE, without
+ * attempting to flush it. This is intended for use with TX timestamping in
+ * cases where someone else is reading the timestamps and we are only interested
+ * in POLLHUP or socket errors.
+ */
+
+static gint64 io_err_watch_wakeup;
+
+static gboolean io_err_watch_dispatch(GSource *source,
+				GSourceFunc callback, gpointer user_data)
+{
+	struct io_err_watch *watch = (void *)source;
+	GIOFunc func = (void *)callback;
+	gint64 timeout = 500 * G_TIME_SPAN_MILLISECOND;
+	GIOCondition cond;
+	int fd;
+
+	if (!func)
+		return FALSE;
+
+	fd = g_io_channel_unix_get_fd(watch->io);
+
+	/*
+	 * If woken up by POLLERR only, and SO_ERROR is not set, ignore this
+	 * event. Also disable polling for some time so that we don't busy loop
+	 * if nobody is reading from the errqueue.
+	 */
+
+	if (watch->tag)
+		cond = g_source_query_unix_fd(&watch->source, watch->tag);
+	else
+		cond = 0;
+
+	if (cond == G_IO_ERR) {
+		int err, ret;
+		socklen_t len = sizeof(err);
+
+		ret = getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &len);
+		if (ret == 0 && err == 0) {
+			g_source_remove_unix_fd(&watch->source, watch->tag);
+			watch->tag = NULL;
+
+			/* io_err watches all wake up at the same time */
+			if (!io_err_watch_wakeup)
+				io_err_watch_wakeup = g_get_monotonic_time()
+								+ timeout;
+
+			g_source_set_ready_time(&watch->source,
+							io_err_watch_wakeup);
+			return TRUE;
+		}
+	}
+
+	if (g_source_get_ready_time(&watch->source) != -1) {
+		g_assert(!watch->tag);
+		io_err_watch_wakeup = 0;
+		watch->tag = g_source_add_unix_fd(&watch->source, fd,
+							watch->events);
+		g_source_set_ready_time(&watch->source, -1);
+	}
+
+	cond &= watch->events;
+
+	if (cond)
+		return func(watch->io, cond, user_data);
+	else
+		return TRUE;
+}
+
+static void io_err_watch_finalize(GSource *source)
+{
+	struct io_err_watch *watch = (void *)source;
+
+	if (watch->tag)
+		g_source_remove_unix_fd(&watch->source, watch->tag);
+
+	g_io_channel_unref(watch->io);
+}
+
+guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
+					GIOCondition events,
+					GIOFunc func, gpointer user_data,
+					GDestroyNotify notify)
+{
+	static GSourceFuncs source_funcs = {
+		.dispatch = io_err_watch_dispatch,
+		.finalize = io_err_watch_finalize,
+	};
+	GSourceFunc callback = (void *)func;
+	struct io_err_watch *watch;
+	gint fd;
+	guint id;
+
+	g_return_val_if_fail(!(events & (G_IO_IN | G_IO_OUT)), 0);
+	g_return_val_if_fail(func, 0);
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	watch = (void *)g_source_new(&source_funcs,
+					sizeof(struct io_err_watch));
+
+	watch->io = g_io_channel_ref(io);
+	watch->events = events;
+	watch->tag = g_source_add_unix_fd(&watch->source, fd, events);
+
+	g_source_set_static_name((void *)watch, "io_glib_err_watch");
+	g_source_set_callback(&watch->source, callback, user_data, notify);
+
+	if (priority != G_PRIORITY_DEFAULT)
+		g_source_set_priority(&watch->source, priority);
+
+	id = g_source_attach(&watch->source, NULL);
+	g_source_unref(&watch->source);
+
+	return id;
+}
+
+guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events, GIOFunc func,
+							gpointer user_data)
+{
+	return io_glib_add_err_watch_full(io, G_PRIORITY_DEFAULT, events,
+							func, user_data, NULL);
+}
diff --git a/src/shared/io-glib.h b/src/shared/io-glib.h
new file mode 100644
index 000000000..1db6fd468
--- /dev/null
+++ b/src/shared/io-glib.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#include <glib.h>
+
+guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events,
+				GIOFunc func, gpointer user_data);
+guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
+				GIOCondition events, GIOFunc func,
+				gpointer user_data,
+				GDestroyNotify notify);
+
+bool io_set_use_err_watch(struct io *io, bool err_watch);
-- 
2.44.0

